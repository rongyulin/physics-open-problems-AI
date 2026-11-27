"""Numerators of the three necessary equations when the zero projection is unmarked.
The masses are (1,t,1,1), with the projection vanishing at the first of these.
Requires SymPy. This symbolic reduction does not decide generic emptiness.
"""
from itertools import combinations
from sympy.polys.domains import ZZ
from sympy.polys.rings import ring


def equations():
    ring3, r, s, t = ring('r,s,t', ZZ)
    one = ring3.one
    cubes = (one, r**3, s**3)
    yn = (r**3 - s**3, s**3 - 1, 1 - r**3)
    yd = (t, one, one)
    dn = (t, one, one)
    dd = (yn[0], r**2 * yn[1], s**2 * yn[2])

    # k is the ratio of the two center X equations. The three terms
    # below have already been multiplied by a common nonzero denominator.
    terms = (t**2 * dd[1] * dd[2], dd[0] * dd[2], dd[0] * dd[1])
    kd = sum(terms)
    kn = sum(a * b for a, b in zip(cubes, terms))
    A = [cube * kd - kn for cube in cubes]
    W = t * A[0] + A[1] + A[2]
    polys = []
    for i, j in combinations(range(3), 2):
        # The square of the inverse distance is en/ed.
        en = yd[i] * yd[j] * dd[i] * dd[j]
        ed = ((yn[i] * yd[j] - yn[j] * yd[i]) *
              (dn[i] * dd[j] - dn[j] * dd[i]))
        common = en.gcd(ed)
        en, ed = en.exquo(common), ed.exquo(common)
        # The inverse cube predicted by the stress is bn/bd.
        bn = kn * W - A[i] * A[j]
        bd = kd * W
        common = bn.gcd(bd)
        bn, bd = bn.exquo(common), bd.exquo(common)
        lhs, rhs = bn**2 * ed**3, bd**2 * en**3
        common = lhs.gcd(rhs)
        polys.append((lhs.exquo(common) - rhs.exquo(common)).primitive()[1])
    return polys


if __name__ == '__main__':
    output = equations()
    degrees = [tuple(f.degree(axis) for axis in range(3)) for f in output]
    assert degrees == [(50, 54, 14), (54, 50, 14), (50, 50, 8)]
    print('Degrees in (r,s,t) for edges 12,13,23:', degrees)
