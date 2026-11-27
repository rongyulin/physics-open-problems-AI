"""Two exact diagram 94 certificates. Requires sympy and python-flint 0.8.0.

The first gcd bounds all projected shapes of the four unit masses in the KC
equations, on the noncollinear unequal-cubes chart. The second gcd handles
the specialization in which the projected X coordinates form a regular triple.
"""

from collections import Counter
from functools import lru_cache

from flint import fmpz_mpoly_ctx
import sympy as sp


def squared_difference(a, b, ell_squared):
    """Vanishing follows if x*x=a, y*y=b and (x-y)^2=ell_squared."""
    return (a - b)**2 - 2*(a + b)*ell_squared + ell_squared**2


def common_denominator_inputs(entries):
    """Rescale three rational functions by the same factored rational function."""
    forms = []
    for entry in entries:
        num, den = sp.fraction(sp.factor(entry))
        nc, nf = sp.factor_list(num)
        dc, df = sp.factor_list(den)
        powers = Counter(dict(nf))
        powers.subtract(dict(df))
        forms.append((nc / dc, powers))
    factors = set().union(*(powers for _, powers in forms))
    shared = {factor: min(p[factor] for _, p in forms) for factor in factors}
    return [coeff * sp.prod(f**(p[f]-shared[f]) for f in factors)
            for coeff, p in forms]


def check_finite_projection():
    v, w = sp.symbols('v w')
    x = (w**3 - 1)/(v**3 - w**3)
    X = [sp.Integer(1), x, -1-x]
    radii = [1, v, w]
    U = [1/(xi*ri**2) for xi, ri in zip(X, radii)]

    def minor(i, j):
        return sp.factor(X[i]*U[j] - X[j]*U[i])

    minors = [minor(1, 2), minor(2, 0), minor(0, 1)]
    weights = [sp.factor(m/sum(minors)) for m in minors]
    pairs = [(0, 1), (0, 2), (1, 2)]
    distances = [sp.factor((X[i]-X[j])*(U[i]-U[j])) for i, j in pairs]
    ring = fmpz_mpoly_ctx.get(('v', 'w'))

    @lru_cache(None)
    def to_flint(poly):
        coeffs = sp.Poly(poly, v, w, domain=sp.ZZ).terms()
        return ring.from_dict({key: int(c) for key, c in coeffs})

    def convert_product(expr):
        coeff, factors = expr.as_coeff_mul()
        assert coeff == int(coeff)
        result = ring.constant(int(coeff))
        for term in factors:
            base, exponent = term.as_base_exp()
            result *= to_flint(base)**int(exponent)
        return result

    def equation(i, j, ell):
        entries = [distances[i]**-3, distances[j]**-3, ell**2]
        a, b, d = map(convert_product, common_denominator_inputs(entries))
        return squared_difference(a, b, d)

    f = equation(0, 1, -weights[0]*(v**3 - w**3))
    g = equation(0, 2, -weights[1]*(1 - w**3))
    assert f.degrees() == (102, 102) and g.degrees() == (96, 102)
    assert len(f) == len(g) == 6827 and f.gcd(g) == 1
    print('General chart: degrees (102,102) and (96,102); integer bivariate gcd 1.')


def check_projected_equilateral():
    ring = fmpz_mpoly_ctx.get(('w', 'a', 'v'), 'lex')
    w, a, v = ring.gens()
    b = -a - 1
    cyclotomic = a**2 + a + 1
    fermat = w**3 + a + b*v**3

    def reduced(poly):
        # Both equations are monic in the successive tower variables.
        return (poly % fermat) % cyclotomic

    minors = [b*v**2-a*w**2, b*v**2*w**2-a*v**2, b*w**2-a*v**2*w**2]
    minor_sum = sum(minors)
    num = [(1-a)*(v**2-b), (1-b)*(w**2-a), (a-b)*(b*w**2-a*v**2)]
    den = [v**2, w**2, v**2*w**2]

    def elimination(i, j, k, force):
        a0 = reduced(den[i]**3 * num[j]**3 * minor_sum**2)
        b0 = reduced(den[j]**3 * num[i]**3 * minor_sum**2)
        d0 = reduced((force*minors[k])**2 * num[i]**3 * num[j]**3)
        relation = reduced(squared_difference(a0, b0, d0))
        first = relation.resultant(fermat, 'w') % cyclotomic
        return first.resultant(cyclotomic, 'a')

    f = elimination(0, 1, 0, v**3-w**3)
    g = elimination(0, 2, 1, 1-w**3)
    h = f.gcd(g)
    assert f.degrees() == (0, 0, 264) and g.degrees() == (0, 0, 312)
    assert h // h.content() == (v-1)**4 * (v**2+v+1)**21
    print('Regular projection: degrees 264 and 312; primitive gcd (v-1)^4 (v^2+v+1)^21.')


if __name__ == '__main__':
    check_finite_projection()
    check_projected_equilateral()
