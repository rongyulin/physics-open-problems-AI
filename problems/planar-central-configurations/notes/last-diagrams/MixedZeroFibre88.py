"""Exact characteristic-zero fibre at (1,2,1,1) for distinct star cubes.

Run beside OuterZeroChart88.py with python-flint 0.8.0 and SymPy.
All polynomial and matrix arithmetic is exact. The only parallel work is
independent modular reduction of two integer resultants.
"""
import argparse
from concurrent.futures import ProcessPoolExecutor
from itertools import combinations, product
from math import prod

from flint import fmpq, fmpq_mat, fmpq_poly, fmpz_poly, nmod_mpoly_ctx
from sympy import nextprime
from OuterZeroChart88 import equations


def specialize(mass=2):
    polynomials = []
    for f in equations():
        terms = {}
        for (i, j, k), coeff in f.items():
            terms[i,j] = terms.get((i,j), 0) + int(coeff)*mass**k
        polynomials.append({ij:q for ij,q in terms.items() if q})

    def swap(terms):
        return {(j,i):q for (i,j),q in terms.items()}

    def sign_equal(a, b):
        return a == b or a == {ij:-q for ij,q in b.items()}

    assert sign_equal(swap(polynomials[0]), polynomials[1])
    assert sign_equal(swap(polynomials[2]), polynomials[2])
    return polynomials


def evaluate_prime(task):
    prime, polynomials, s_degrees = task
    ctx = nmod_mpoly_ctx.get(["s","r"], prime)
    rows = [ctx.from_dict({(j,i):c for (i,j),c in terms.items()}) for terms in polynomials]
    assert [f.degrees()[0] for f in rows] == s_degrees
    pair = []
    for f in rows[:2]:
        res = f.resultant(rows[2], "s")
        assert res.degrees()[0] == 0
        pair.append({j:int(v) for (_,j),v in res.to_dict().items()})
    return prime, pair


def integer_resultants(polynomials, workers, expected_degrees=(3892,3936)):
    r_degrees = [max(i for i,j in f) for f in polynomials]
    s_degrees = [max(j for i,j in f) for f in polynomials]
    weights = [sum(map(abs,f.values())) for f in polynomials]
    limit = max(weights[i]**s_degrees[2] * weights[2]**s_degrees[i] for i in (0,1))
    primes = []
    p = 2**58
    modulus = 1
    while modulus <= 2*limit:
        p = int(nextprime(p))
        primes.append(p)
        modulus *= p
    values = [[0]*(1+r_degrees[i]*s_degrees[2]+r_degrees[2]*s_degrees[i]) for i in (0,1)]
    modulus = 1
    with ProcessPoolExecutor(max_workers=workers) as pool:
        for p, residues in pool.map(evaluate_prime, ((p,polynomials,s_degrees) for p in primes)):
            inverse = pow(modulus, -1, p)
            for row, residues_i in zip(values, residues, strict=True):
                assert max(residues_i) < len(row)
                for j,v in enumerate(row):
                    row[j] += modulus * ((inverse*(residues_i.get(j,0)-v)) % p)
            modulus *= p
    assert modulus > 2*limit
    result = [fmpz_poly([v if 2*v < modulus else v-modulus for v in row]) for row in values]
    assert tuple(f.degree() for f in result) == expected_degrees
    print("Exact integer resultants", [f.degree() for f in result], "from", len(primes),
          "primes; absolute coefficient bound has",limit.bit_length(),"bits.")
    return result


class Quotient:
    """Rational tensor product Q[r,s]/(P(r),Q(s)) in its monomial basis."""

    def __init__(self, p, q, max_degree):
        self.n, self.m = p.degree(), q.degree()
        self.rpow = self.powers(p, max_degree)
        self.spow = self.powers(q, max_degree)

    @staticmethod
    def powers(modulus, n):
        modulus = fmpq_poly(modulus)
        x = fmpq_poly([0,1])
        cache = [fmpq_poly([1])]
        for _ in range(n):
            cache.append(x * cache[-1] % modulus)
        return [list(v)+[fmpq(0)]*(modulus.degree()-len(v)) for v in cache]

    def reduce(self, terms):
        out = [fmpq(0)]*(self.n*self.m)
        for (i,j), coeff in terms.items():
            if coeff:
                for u, a in enumerate(self.rpow[i]):
                    for v, b in enumerate(self.spow[j]):
                        out[u*self.m+v] += coeff*a*b
        return out

    def shift(self, a, i, j):
        return self.reduce({(k+i,l+j):a[k*self.m+l]
                            for k,l in product(range(self.n),range(self.m))})

    def multiply(self, a, b):
        out = self.reduce({})
        for i,j in product(range(self.n), range(self.m)):
            if b[i*self.m+j]:
                out = [v+b[i*self.m+j]*w for v,w in zip(out,self.shift(a,i,j))]
        return out

    def chart_discriminant(self, mass=2):
        def minus(a,b):
            return [i-j for i,j in zip(a,b)]
        def times(k,b):
            return [k*x for x in b]
        def product_of(items):
            result = self.reduce({(0,0):1})
            for x in items:
                result = self.multiply(result,x)
            return result

        r3 = self.reduce({(3,0):1})
        s3 = self.reduce({(0,3):1})
        one = self.reduce({(0,0):1})
        y = [times(fmpq(1,mass),minus(r3,s3)),minus(s3,one),minus(one,r3)]
        dd = [y[0],self.multiply(self.reduce({(2,0):1}),y[1]),
              self.multiply(self.reduce({(0,2):1}),y[2])]
        d = [product_of(dd[:i]+dd[i+1:]) for i in range(3)]
        total = [mass*x+y+z for x,y,z in zip(*d)]
        high = [times(-1,total)]+[minus(times(mass+3,x),total) for x in d]
        factors = dd + high
        for i,j in combinations(range(3),2):
            factors += [minus(y[i],y[j]),minus(d[i],d[j])]
        return product_of(factors)

    def check(self, polynomials, mass=2):
        delta = self.chart_discriminant(mass)
        if not any(delta):
            return
        rows = [self.shift(self.reduce(f),i,j) for f in polynomials
                for i,j in product(range(self.n),range(self.m))]
        rank = fmpq_mat(rows).rank()
        assert fmpq_mat(rows+[delta]).rank() == rank


def verify(workers):
    polys = specialize()
    first, second = integer_resultants(polys, workers)
    common = first.gcd(second)
    assert common.degree() == 3172
    radical = common // common.gcd(common.derivative())
    radical = radical // radical.content()
    if radical.leading_coefficient() < 0:
        radical = -radical
    assert radical.degree() == 26
    # Coefficients in increasing degree. The first three factors respectively
    # give r=0, r=1, and a primitive cube root, disallowed by the distinct cubes.
    factors = [fmpz_poly(a) for a in (
        [0,1],[-1,1],[1,1,1],[1,1],[-1,2,2],[-1,0,0,3],
        [-1,4,-4,-2,2],[1,4,4,2,2],[2,2,5,4,1],[1,4,5,2,2])]
    assert radical == prod(factors, start=fmpz_poly([1]))
    for p,q in product(factors[3:], repeat=2):
        Quotient(p,q,54).check(polys)
    print("Degree-26 squarefree eliminant; 49 rational quotient rings passed.",
          "The three force equations have no admissible distinct-cube solution at t=2.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--workers", type=int, default=3)
    verify(parser.parse_args().workers)
