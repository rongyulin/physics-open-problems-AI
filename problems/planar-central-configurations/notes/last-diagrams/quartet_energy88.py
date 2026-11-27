"""Rational energy separation for every t>0, proved by positivity of coefficients."""
from sympy import Poly, Rational, Symbol, cancel


def check():
    u = Symbol("u")
    for g, t, case in [(1, 2*u/(1+u), "0<=t<2"), (Rational(1,2), 2+u, "2<=t")]:
        end = 3+6*g+5*g**2 - 9*(1+g)**2/(3+t)
        inside = 2+(1+g)**2 - (1+g)**2/(3+t)
        for label, cost in [("endpoint",end),("interior",inside)]:
            # A bounds E4^3, B is the unit binary energy cubed, D bounds E6^3 below.
            a = 8*cost*Rational(32,25)**2*(t+1/Rational(g))**2
            b = Rational(1,2)
            d = (10+5*t)**3/(5+t)
            residual = cancel((d-a-b)**3 - 27*d*a*b)
            for numerator in residual.as_numer_denom():
                poly = Poly(numerator,u)
                assert poly.eval(0) > 0 and all(c >= 0 for c in poly.all_coeffs())
            print(f"{case}, {label}: numerator degree {Poly(residual.as_numer_denom()[0],u).degree()}, all coefficients nonnegative.")


if __name__ == "__main__":
    check()
