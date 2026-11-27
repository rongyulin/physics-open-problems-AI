"""Eliminate signed collinear quartet shapes for generic marked mass t.

The collinear force rows are C+tD and E+tF.  Every row and resultant
is formed over the integers.  The last, degree-preserving gcd tests are
univariate computations over the prime field.
"""
from itertools import combinations, permutations, product
from math import prod

from sympy import GF, ZZ
from sympy.polys.rings import ring


INTEGER_RING, x, y = ring("x,y", ZZ)
X_RING, X = ring("X", ZZ)
PRIME = 1009
FINITE_RING, Y = ring("Y", GF(PRIME))
POSITIONS = [INTEGER_RING.zero, INTEGER_RING.one, x, y]
EDGES = tuple(combinations(range(4), 2))


def sign_orbit(signs):
    """Reverse every force sign or permute the three unit masses."""
    images = set()
    for triple in permutations(range(3)):
        perm = (*triple, 3)
        for overall in (1, -1):
            image = []
            for i, j in EDGES:
                a, b = perm[i], perm[j]
                sign = signs[EDGES.index(tuple(sorted((a, b))))]
                image.append(overall * sign * (1 if a < b else -1))
            images.add(tuple(image))
    return images


def force_rows(signs):
    common = prod((POSITIONS[i] - POSITIONS[j])**2 for i, j in EDGES)
    unit = [INTEGER_RING.zero] * 4
    marked = [INTEGER_RING.zero] * 4
    for (i, j), sign in zip(EDGES, signs):
        force = sign * common.exquo((POSITIONS[i] - POSITIONS[j])**2)
        # The force on i has mass of j as its coefficient, and conversely.
        if j == 3:
            marked[i] += force
        else:
            unit[i] += force
        unit[j] -= force

    def shape_row(forces, index):
        return (forces[index] - forces[0]
                - POSITIONS[index] * (forces[1] - forces[0]))

    return (shape_row(unit, 2), shape_row(marked, 2),
            shape_row(unit, 3), shape_row(marked, 3))


def at_x_three(poly):
    return sum((FINITE_RING(int(c)*pow(3, i, PRIME))*Y**j
                for (i,j), c in poly.items()), FINITE_RING.zero)


def x_content(poly):
    """Gcd in Z[x] of coefficients of all powers of y."""
    coeffs = {}
    for (i, j), c in poly.items():
        coeffs[j] = coeffs.get(j, X_RING.zero) + c*X**i
    result = X_RING.zero
    for coeff in coeffs.values():
        result = result.gcd(coeff)
    return result


def check(signs):
    C, D, E, F = force_rows(signs)
    assert C.gcd(D) == 1
    G = (C*F-E*D).exquo(x**2*(x-1)**2)
    assert x_content(G) == 1
    c, d, g = (at_x_three(poly) for poly in (C, D, G))
    assert g.degree() == G.degree(y)
    denominator = 3*d-c
    center_numerator = 4*d-c*Y
    Z = [q*denominator-center_numerator for q in (0, 1, 3, Y)]
    magnitudes = [(c**2 if j == 3 else d**2)*prod(Z[:j]+Z[j+1:])
                  for j in range(4)]
    for remaining_signs in product((1,-1), repeat=3):
        a,b,c2,d2 = [(sign*value).rem(g) for sign, value in
                     zip((1,*remaining_signs), magnitudes)]
        torque = ((a+b-c2-d2)**2-4*a*b-4*c2*d2)**2-64*a*b*c2*d2
        assert g.gcd(torque) == 1
    print(signs, f"bidegree ({G.degree(x)},{G.degree(y)}), 8 coprime torque tests")


def main():
    seen = set()
    representatives = 0
    for signs in product((1,-1), repeat=6):
        if signs not in seen:
            images = sign_orbit(signs)
            assert not (seen & images)
            seen.update(images)
            representatives += 1
            check(signs)
    assert representatives == 6 and len(seen) == 64


if __name__ == "__main__":
    main()
