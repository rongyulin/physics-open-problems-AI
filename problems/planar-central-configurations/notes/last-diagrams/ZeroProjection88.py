"""Exact plane-resultant witnesses for diagram 88, marked zero-projection body.

Run with Python 3 and SymPy. All two-variable polynomials are constructed over
Z. Only the final evaluations of the two Sylvester resultants are modular.
"""
from itertools import combinations
from sympy.polys.domains import GF, ZZ
from sympy.polys.rings import ring


R, r, s = ring('r,s', ZZ)
K, z = ring('z', GF(1009))


def cancel_triple(x, y, z):
    """At an admissible shape x and y cannot both vanish; see the proof."""
    common = x.gcd(y).gcd(z)
    return x.exquo(common), y.exquo(common), z.exquo(common)


def shape_polynomials():
    cubes = (R.one, r**3, s**3)
    y = (r**3 - s**3, s**3 - 1, 1 - r**3)
    v = (y[0], r**2 * y[1], s**2 * y[2])
    cofactors = (v[1] * v[2], v[0] * v[2], v[0] * v[1])
    den = sum(cofactors)
    num = sum(a * b for a, b in zip(cubes, cofactors))
    alpha = [a * den - num for a in cubes]

    # E_ij is the square of (p_ij / p_o1)^3. Its numerator and
    # denominator are nonzero at every admissible shape.
    edge = {}
    for i, j in combinations(range(3), 2):
        top = v[i] * v[j]
        bottom = (y[i] - y[j]) * (v[j] - v[i])
        common = top.gcd(bottom)
        edge[i, j] = top.exquo(common)**3, bottom.exquo(common)**3

    output = []
    for i, j, k in ((0, 1, 2), (1, 0, 2)):
        b, c = edge[tuple(sorted((i, j)))]
        f, g = edge[tuple(sorted((i, k)))]
        u, vj, w = cancel_triple(den * alpha[k], den * alpha[j],
                                  num * (alpha[k] - alpha[j]))
        common = c.gcd(g)
        c1, g1 = c.exquo(common), g.exquo(common)
        a1, a2, a3 = cancel_triple(u**2 * b * g1, vj**2 * f * c1,
                                     w**2 * c * g1)
        polynomial = (a1 + a2 - a3)**2 - 4 * a1 * a2
        output.append(polynomial.primitive()[1])
    return output


def certify():
    polynomials = shape_polynomials()
    for axis, value in ((r, 2), (s, 2)):
        remaining = s if axis == r else r
        degrees = [poly.degree(remaining) for poly in polynomials]
        reduced = []
        for poly in polynomials:
            evaluated = poly.evaluate(axis, value)
            reduced.append(K.from_dict({e: int(coefficient) % 1009
                                        for e, coefficient in evaluated.items()}))
        mod_degrees = [f.degree() for f in reduced]
        common = reduced[0].gcd(reduced[1]).monic()
        print(f'{axis}={value}, mod 1009: integer generic degrees {degrees}, '
              f'specialized degrees {mod_degrees}, monic gcd {common}')
        assert degrees == mod_degrees == [100, 100] and common == K.one


if __name__ == '__main__':
    certify()
