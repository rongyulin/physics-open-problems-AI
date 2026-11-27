"""Exact Sturm and resultant checks for the marked opposing pair in diagram 94."""
from fractions import Fraction

from sympy import Poly, Rational, Symbol, resultant


def nonreal_ratio():
    r, h = Symbol("r"), Symbol("H3")
    polys = []
    # The primitive cube roots mod 7 are 2 and 4.
    for q in (2, 4):
        ratios = 2*(1+q)*r**2 - 1
        value = (6+5*r)**3*(1+q) - 64*h*(1+q+r)
        polys.append(Poly(resultant(ratios,value,r), h, modulus=7).monic())
    assert polys == [Poly(h**2+4,h,modulus=7),Poly(h**2-h+3,h,modulus=7)]
    assert polys[0].gcd(polys[1]).degree() == 0


def root_free_with_positive_value(polynomial, low, high):
    assert polynomial.eval(low) > 0
    assert high is None or polynomial.eval(high) > 0
    assert polynomial.count_roots(low,high) == 0


def physical_bounds(sign):
    s = Symbol("s")
    t = s**2
    d = 1+t
    n = 3*d**2 + sign*s*(2*d+1)
    ell = d**2 + sign*s**3
    # H^3 = n^3/(8*d^4*ell). Both numerator and denominator are positive.
    small = Poly(1953125*d**6*ell**2 - 64*n**6,s)
    root_free_with_positive_value(small,0,1)

    # For t>=1, angular rank bound gives E^3<a/b.
    a = 722*(t+2)**2*(55*t+50)
    b = 25*(t+5)
    regular = Poly(a-125*b*(t+5)**2,s)
    root_free_with_positive_value(regular,1,None)

    # Lower physical H^6 > 125^3*b/a.
    # Upper physical H^3 < (a/b)*[(15+2*t)/(2*t*(t+5))]^3.
    lower = Poly(125**3*b*64*d**8*ell**2 - n**6*a,s)
    upper = Poly(n**3*b*t**3*(t+5)**3 - a*(15+2*t)**3*d**4*ell,s)
    left = Rational(515,198)
    right = Rational(7153,320)
    assert left**2 > Rational(27,4) and right**2 < 500
    root_free_with_positive_value(lower,1,left)
    root_free_with_positive_value(upper,right,None)
    # Alternative trial distances to the marked rank: 1,1+g,... with g=1/12.
    # The inertia is <=5+20*g+30*g^2=55/8.
    # Mean inverse-distance coefficient is <17*t/8+228/5.
    a2 = 55*(85*t+1824)**2
    b2 = 1600
    tighter = Poly(n**3*b2*t**3*(t+5)**3-a2*(15+2*t)**3*d**4*ell,s)
    cut = Rational(4371,400)
    assert cut**2 < 120
    root_free_with_positive_value(tighter,cut,None)


def angular_constant():
    sin_upper = Fraction(147,250)
    pi_lower = Fraction(157,50)
    k = (Fraction(4,3)/pi_lower + 2*(sin_upper-sin_upper**3/3)/pi_lower)/2
    assert k < Fraction(19,50)
    # sin(pi/5)^2=(5-sqrt(5))/8.
    assert (5-8*sin_upper**2)**2 < 5


if __name__ == "__main__":
    nonreal_ratio()
    angular_constant()
    for sign in (-1,1):
        physical_bounds(sign)
    print("Verified both signs for 0<t<=27/4 and t>=120, and the nonreal-ratio resultant.")
