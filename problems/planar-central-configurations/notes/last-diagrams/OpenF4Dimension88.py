"""Independent exact dimension check, using OpenF4 at revision 7155c6ec4e5f776e0e12202716dc7da58469e77b.

Pass the path to a git checkout of https://github.com/nauotit/openf4.
Requires python-flint 0.8.0, a C++14 compiler with OpenMP and x86 SSE4.2. The checkout is read-only.
The driver is compiled in a temporary directory. Its only portability change
to upstream is declaring the lazily updated array-height cache mutable.
"""
import argparse
from pathlib import Path
import re
import shutil
import subprocess
from tempfile import TemporaryDirectory

from flint import nmod_mpoly_ctx
from RegularQuartet88 import PRIME, SIZE, ordered_equations, unordered_equations

REVISION = "7155c6ec4e5f776e0e12202716dc7da58469e77b"

DRIVER = r"""
#include <iostream>
#include <openf4.h>
#include <string>
#include <vector>

int F4::VERBOSE = 0;
int F4::NB_THREAD = 2;

int main(int argc, char** argv) {
    using Element = F4::ElementPrime<int32_t>;
    const int n = argc-1;
    Element::setModulo(65521);
    F4::Monomial::initMonomial(n);
    // OpenF4 takes ownership and calls delete[] in its destructor.
    auto* names = new std::string[n];
    std::copy(argv+1, argv+argc, names);
    F4::Monomial::setVariable(names);
    std::vector<F4::Polynomial<Element>> equations;
    std::string row;
    while (std::getline(std::cin,row))
        equations.emplace_back(row);
    F4::Ideal<Element> ideal(equations,n);
    ideal.f4();
    for (const std::string& poly : ideal.getReducedGroebnerBasis())
        std::cout << poly.substr(0,poly.find(')')+1) << "\n";
}
"""


def executable(checkout, folder, compiler):
    revision = subprocess.check_output(["git","-C",str(checkout),"rev-parse","HEAD"],text=True).strip()
    if revision != REVISION:
        raise ValueError(f"Expected OpenF4 {REVISION}, got {revision}")
    # Export pinned bytes without incorporating local patches and without writing the checkout.
    first = subprocess.Popen(["git","-C",str(checkout),"archive",REVISION,"openf4.h","openf4"],
                             stdout=subprocess.PIPE)
    subprocess.run(["tar","-x","-C",str(folder)],stdin=first.stdout,check=True)
    if first.wait() != 0:
        raise RuntimeError("Could not export the OpenF4 checkout")
    header = folder/"openf4/include/dynamic-array.h"
    old = "int _currentHeight;"
    text = header.read_text()
    assert text.count(old) == 1
    header.write_text(text.replace(old, "mutable int _currentHeight;"))
    (folder/"config.h").write_text("#define HAVE_SSE2 1\n#define HAVE_SSE4_1 1\n#define HAVE_SSE4_2 1\n#define USE_OPENMP 1\n")
    source = folder/"dimension.cpp"
    source.write_text(DRIVER)
    program = folder/"dimension"
    subprocess.run([compiler,"-std=c++14","-O3","-fopenmp","-msse4.2","-I",str(folder),str(source),"-o",str(program)],check=True)
    return program


def standard_monomials(names, rows, target):
    leads = []
    for row in rows:
        assert row.startswith("(1*") and row.endswith(")")
        value = [0]*len(names)
        for term in row[3:-1].split("*"):
            name, power = term.split("^")
            value[names.index(name)] = int(power)
        leads.append(tuple(value))
    origin = (0,)*len(names)
    todo = [origin]
    seen = {origin}
    while todo:
        current = todo.pop()
        for i in range(len(names)):
            next_point = tuple(v+(i==j) for j,v in enumerate(current))
            if next_point in seen:
                continue
            if any(all(a<=b for a,b in zip(lm,next_point)) for lm in leads):
                continue
            seen.add(next_point)
            todo.append(next_point)
            assert len(seen) <= target
    return len(leads),len(seen)


def run(checkout, compiler):
    with TemporaryDirectory() as tmp:
        program = executable(checkout,Path(tmp),compiler)
        for kind, target in SIZE.items():
            eqs, nonzero, variables = unordered_equations() if kind == "distinct" else ordered_equations(kind)
            names = ("v",*variables)
            ring = nmod_mpoly_ctx.get(names,PRIME)
            invert = ring.from_dict({(1,*m):c for m,c in nonzero.to_dict().items()})-1
            data = "\n".join(str(p).replace(" ","") for p in [*eqs,invert])+"\n"
            output = subprocess.check_output([str(program),*names],input=data,text=True)
            basis, size = standard_monomials(names,output.strip().splitlines(),target)
            assert size == target
            print(kind, "leading monomials",basis,"quotient dimension",size,flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("checkout",type=Path)
    parser.add_argument("--compiler",default="c++")
    args=parser.parse_args()
    run(args.checkout,args.compiler)
