"""Replay the diagram-94 outer-mass certificate (Python, SymPy, Z3)."""
from fractions import Fraction
from itertools import combinations
from pathlib import Path
import argparse
import ctypes
import ctypes.util
import shutil
import subprocess
import sympy as sp
from lift import check as lift_test

EDGES = list(combinations(range(4), 2))
ORD_X = [0, -1, 2, None]
ORD_M = [-1, 0, 0, 0]
CELLS = [
    (0, -2, 0, -2, 1, -2),
    (Fraction(1, 3), -2, -2, -2, -2, -2),
    (0, 0, -4, 1, -4, -4),
]
T = sp.symbols('y0:6')
P = sp.symbols('p0:6')


def oriented(i, j):
    return EDGES.index(tuple(sorted((i, j))))


def dx_order(i, j):
    return min(v for v in (ORD_X[i], ORD_X[j]) if v is not None)


def systems(delta):
    """Each term is (twice its order, exact nonzero leading coefficient)."""
    x = [1, -1, delta, 0]

    def pair(i, j):
        k = oriented(i, j)
        order = dx_order(i, j)
        lead = (x[i] if ORD_X[i] == order else 0) - (x[j] if ORD_X[j] == order else 0)
        return k, order, lead

    def y(i, j):
        k, _, lead = pair(i, j)
        return (2*T[k], 1/(lead*P[k]**2))

    def force(i, j, weight, color):
        k, order, lead = pair(i, j)
        if color == 'x':
            return 2*weight - order - 3*T[k], -lead*P[k]**3
        return 2*weight - 3*order - T[k], -P[k]/lead

    def minus(term):
        w, c = term
        return w, -c

    eq = {}
    for i, j, k in combinations(range(4), 3):
        eq[f't{i}{j}{k}'] = [y(i, j), minus(y(i, k)), y(j, k)]
    for i in range(4):
        eq[f'x{i}'] = ([] if ORD_X[i] is None else [(2*ORD_X[i], x[i])]) + [
            force(i, j, ORD_M[j], 'x') for j in range(4) if i != j]
    for i, j in combinations(range(3), 2):
        w, f = force(i, j, min(ORD_M[i], ORD_M[j]), 'y')
        # m_i + m_j has leading coefficient two only at two equal orders.
        terms = [y(i, j), (w, (1 + (ORD_M[i] == ORD_M[j])) * f)]
        for k in sorted(set(range(4)) - {i, j}):
            terms += [force(i, k, ORD_M[k], 'y'), minus(force(j, k, ORD_M[k], 'y'))]
        eq[f'y{i}{j}'] = terms
    return eq


def num(q):
    a, b = Fraction(q).as_integer_ratio()
    z = str(a) if a >= 0 else f'(- {-a})'
    return z if b == 1 else f'(/ {z} {b})'


def smt_weight(w):
    p = sp.Poly(w, *T)
    terms = [num(p.TC())]
    for t in T:
        coeff = p.coeff_monomial(t)
        if coeff:
            terms.append(f'(* {num(coeff)} {t})')
    return '(+ ' + ' '.join(terms) + ')' if len(terms) > 1 else terms[0]


def query():
    lines = ['(set-logic QF_LRA)'] + [f'(declare-fun {t} () Real)' for t in T]
    for terms in systems(1).values():
        ws = [smt_weight(w) for w, c in terms]
        for i, w in enumerate(ws):
            others = ' '.join(f'(<= {z} {w})' for j, z in enumerate(ws) if j != i)
            lines.append(f'(assert (or {others}))')
    for cell in CELLS:
        conjunction = ' '.join(f'(= {t} {num(a)})' for t, a in zip(T, cell))
        lines.append(f'(assert (not (and {conjunction})))')
    lines.append('(check-sat)')
    return '\n'.join(lines) + '\n'


def z3_result(program):
    executable = shutil.which('z3')
    if executable:
        return subprocess.run([executable, '-in'], input=program, text=True,
                              capture_output=True, check=True).stdout.strip()
    lib = ctypes.CDLL(ctypes.util.find_library('z3') or 'libz3.so.4')
    void, string = ctypes.c_void_p, ctypes.c_char_p

    def sig(name, result, *args):
        f = getattr(lib, name)
        f.restype, f.argtypes = result, list(args)
        return f

    config = sig('Z3_mk_config', void)()
    ctx = sig('Z3_mk_context', void, void)(config)
    run = sig('Z3_eval_smtlib2_string', string, void, string)
    return run(ctx, program.encode()).decode().strip()


def leading_ideal(cell, delta):
    eq = []
    for terms in systems(delta).values():
        weights = [sp.sympify(w).subs(dict(zip(T, cell))) for w, _ in terms]
        least = min(weights)
        assert weights.count(least) >= 2
        lead = sum(c for weight, (_, c) in zip(weights, terms) if weight == least)
        eq.append(sp.cancel(lead).as_numer_denom()[0])
    h = sp.Symbol('h')
    return sp.groebner(eq + [1 - h*sp.prod(P)], h, *P, order='grevlex', domain=sp.QQ)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--emit-smt', type=Path)
    args = parser.parse_args()
    smt = query()
    if args.emit_smt:
        args.emit_smt.write_text(smt)
    assert z3_result(smt) == 'unsat'
    print('All valuation vectors belong to the three displayed cells.')
    for j, cell in enumerate(CELLS):
        for delta in (1, -1):
            unit = list(leading_ideal(cell, delta)) == [1]
            assert unit == ((j, delta) != (2, 1))
            print(f'cell {j+1}, delta {delta:+}: unit initial ideal = {unit}')
    for prime in (97, 193):
        orders, residues = lift_test(prime, 8)
        assert orders == {3: 108, 8: 36}
        assert all(equation == 'x3' and residue for (_, equation, residue) in residues)
        print(f'p={prime}: 108 fail by order 3; 36 fail by order 8.')


if __name__ == '__main__':
    main()
