"""Exact mass classification for collinear signed absolute equilibria (1,1,1,t).

The factorization and modular inversions use Q[x]. No floating point or choice
of coordinates from a numerical solution enters the classification.
"""
from itertools import product
from sympy import Poly, QQ, Rational, oo, resultant, symbols

x, y, t = symbols("x y t")


def px(value):
    return Poly(value, x, domain=QQ)


def mass_factors():
    found = set()
    for a,b,c,d,e in product((1,-1), repeat=5):
        n0, d0 = (x*x+a)*y*y, b*x*x
        n1, d1 = (c-(1-x)**2)*(1-y)**2, d*(1-x)**2
        n2, d2 = (-a*(1-x)**2-c*x*x)*(x-y)**2, e*x*x*(1-x)**2
        # f_i=n_i+t*d_i; use d0!=0 and retain the smaller y-polynomials.
        g = Poly(n1*d0-d1*n0,y)
        h = Poly(b*n2-e*(1-x)**2*n0,y)
        linear = h*g.LC()-g*h.LC()
        assert linear.degree() <= 1
        elimination = px(resultant(g.as_expr(), h.as_expr(), y))
        assert elimination
        for irreducible, _ in elimination.factor_list()[1]:
            if px(x*(1-x)).rem(irreducible).is_zero:
                continue
            f = irreducible
            u, v = (px(linear.nth(i)).rem(f) for i in (0,1))
            assert v
            ordinate = (-u*v.invert(f)).rem(f)
            if any(px(value).rem(f).is_zero for value in
                   [ordinate.as_expr(), ordinate.as_expr()-1, ordinate.as_expr()-x]):
                continue
            marked_mass = (-px(x*x+a)*ordinate**2*px(d0).invert(f)).rem(f)
            if marked_mass.is_zero:
                continue
            for numerator, denominator in [(n0,d0),(n1,d1),(n2,d2)]:
                residual = px(numerator.subs(y,ordinate.as_expr()))+marked_mass*px(denominator)
                assert residual.rem(f).is_zero
            mass_poly = Poly(resultant(f.as_expr(),t-marked_mass.as_expr(),x), t, domain=QQ)
            mass_poly = mass_poly.sqf_part().monic()
            assert mass_poly.degree() == f.degree() and mass_poly.is_irreducible
            found.add(mass_poly.clear_denoms(convert=True)[1].as_expr())
    return found


def check():
    even = t**8-116*t**6-4810*t**4-1044*t*t+81
    asymmetric = t**8-32*t**7+300*t**6-864*t**5-5098*t**4-4320*t**3+7500*t*t-4000*t+625
    expected = {
        even: [(Rational(16,65),Rational(49,199)),(Rational(1060,87),Rational(1523,125))],
        asymmetric: [(Rational(16,63),Rational(63,248)),(Rational(1929,98),Rational(2303,117))],
        asymmetric.subs(t,-t): [],
        3*t*t+1: [],
        t**4+118*t*t+25: [],
        6561*t**8+6156*t**6-2698*t**4+1900*t*t+625: [],
    }
    assert mass_factors() == set(expected)
    for expression, isolating in expected.items():
        polynomial = Poly(expression,t,domain=QQ)
        assert polynomial.count_roots(0,oo) == len(isolating)
        for left,right in isolating:
            assert polynomial.eval(left)*polynomial.eval(right)<0
            assert polynomial.count_roots(left,right) == 1
        print(polynomial.as_expr(), "positive isolating intervals", isolating)


if __name__ == "__main__":
    check()
