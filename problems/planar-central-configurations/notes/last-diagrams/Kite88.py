"""Reflection-symmetric four-body leading shapes of diagram 88, exact verifier."""
from itertools import product
from math import prod

from sympy import QQ
from sympy.polys.fields import field
from Collinear88 import PRIME, FINITE_RING, Y, X_RING, X


K, a, b = field("a,b", QQ)
I = pow(11, (PRIME - 1) // 4, PRIME)
assert I**2 % PRIME == PRIME - 1


def specialize(poly):
    """Map a to 2, b to Y, i to I in the prime field (here poly is rational)."""
    return sum(
        (FINITE_RING(int(c.numerator) * pow(int(c.denominator), -1, PRIME)
                     * pow(2, i, PRIME)) * Y**j for (i, j), c in poly.items()),
        FINITE_RING.zero,
    )


def check(diagonal_sign):
    D = (a-b)*(a*b+1)
    Z, W = b*(a**2-1), 2*a*b
    axial = Z/D
    mutual = (D/(2*diagonal_sign*W))**3
    left = (D/(b*(a**2+1)))**3
    right = (D/(a*(b**2+1)))**3
    constant = 2*mutual+left-1-2*(1-axial)*right-2*axial*left
    slope = right-1
    assert constant.numer.gcd(slope.numer) == 1
    mass = -constant/slope
    acceleration = 2*mutual+left+mass*right
    G = ((2*axial+mass)*acceleration-(3+mass)*(2*axial*left+mass)).numer
    assert (G.degree(0), G.degree(1)) == (10, 12)
    coeffs = {}
    for (i,j), c in G.items():
        assert c.denominator == 1
        coeffs[j] = coeffs.get(j, X_RING.zero) + int(c.numerator)*X**i
    content = X_RING.zero
    for poly in coeffs.values():
        content = content.gcd(poly)
    assert content == 1
    g = specialize(G)
    assert g.degree() == G.degree(1)
    tv, td = (specialize(poly) for poly in (mass.numer, mass.denom))

    # Four projected coordinates times D at a=2.
    Den, z, w = (2-Y)*(2*Y+1), 3*Y, 4*Y
    projections = [u*(3*td+tv)-(2*z*td+Den*tv)
                   for u in (z+I*w, z-I*w, 0, Den)]
    weights = [(tv**2 if j==3 else td**2)*prod(projections[:j]+projections[j+1:])
               for j in range(4)]
    for signs in product((1,-1), repeat=3):
        u,v,w,z = [(s*h).rem(g) for s,h in zip((1,*signs),weights)]
        torque = ((u+v-w-z)**2-4*u*v-4*w*z)**2-64*u*v*w*z
        assert torque.gcd(g) == 1
    print(f"Mutual sign {diagonal_sign}: degree (10,12), 8 coprime torque tests")


if __name__ == "__main__":
    for sign in (1,-1):
        check(sign)
