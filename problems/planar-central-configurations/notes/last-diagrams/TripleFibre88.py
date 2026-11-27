"""The two scale/shaping equations for exactly three collinear quartet bodies.

For t=2, check in characteristic zero (over Q(sqrt(-3))) and over F_65521.
A unit gcd excludes points of each admissible chart over the algebraic closure.
"""
from itertools import product
from sympy import GF, QQ, sqrt
from sympy.polys.fields import field


def check(base, omega):
    ring, x = field("x", base)
    one = ring.one
    root = ring(omega)
    roots = (one,root,root**2)
    assert root**2+root+1 == 0
    tests = 0
    for mass in (1,2):
        for b,c in product((1,-1), repeat=2):
            f0 = 1+mass*b/x**2
            f1 = -1+mass*c/(1-x)**2
            f2 = -b/x**2-c/(1-x)**2
            shape = (f2-f0-x*(f1-f0)).numer
            for a,z in product(roots, repeat=2):
                if a == z == one:
                    continue
                denominator = (z-1)-x*(a-1)
                radius_squared = x*(x-1)/denominator
                scale = ((f1-f0)**2*radius_squared**3-(2+mass)**2).numer
                common = shape.gcd(scale)
                for forbidden in (x,x-1,denominator,f1-f0):
                    divisor = common.gcd(forbidden.numer)
                    while divisor.degree()>0:
                        common = common.exquo(divisor)
                        divisor = common.gcd(forbidden.numer)
                assert common.degree()==0
                tests += 1
    assert tests == 64
    print(base, tests, "cases; no admissible three-collinear force shape")


if __name__ == "__main__":
    prime = 65521
    check(GF(prime), 16673)
    number_field = QQ.algebraic_field(sqrt(-3))
    check(number_field, number_field.from_sympy((-1+sqrt(-3))/2))
