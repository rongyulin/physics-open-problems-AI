"""Classify positive collinear mass parameters of a signed four-body absolute equilibrium.

All calculations are performed in characteristic zero with SymPy. A zero-dimensional
quotient is used for the 32 sign patterns. Positive mass roots have real witnesses.
"""

from itertools import product
from sympy import symbols, Poly, QQ, groebner, resultant, oo

v, x, y, t = symbols("v x y t")
A_POS = (
    t**8
    - 32 * t**7
    + 300 * t**6
    - 864 * t**5
    - 5098 * t**4
    - 4320 * t**3
    + 7500 * t**2
    - 4000 * t
    + 625
)
B_POS = t**8 - 116 * t**6 - 4810 * t**4 - 1044 * t**2 + 81
WANTED = {
    Poly(f, t, domain=QQ).monic()
    for f in (
        3 * t**2 + 1,
        t**4 + 118 * t**2 + 25,
        A_POS,
        B_POS,
        6561 * t**8 + 6156 * t**6 - 2698 * t**4 + 1900 * t**2 + 625,
        A_POS.subs(t, -t),
    )
}
POS = {Poly(f, t, domain=QQ).monic() for f in (A_POS, B_POS)}


def verify():
    seen = set()
    real = set()
    for A, B, C, D, E in product((1, -1), repeat=5):
        n0 = (x**2 + A) * y**2
        n1 = (C - (1 - x) ** 2) * (1 - y) ** 2
        n2 = (-A * (1 - x) ** 2 - C * x**2) * (x - y) ** 2
        G = n1 * B * x**2 - D * (1 - x) ** 2 * n0
        H = B * n2 - E * (1 - x) ** 2 * n0
        nonzero = x * y * (1 - x) * (1 - y) * (x - y)
        basis = groebner(
            [G, H, v * nonzero - 1], v, x, y, domain=QQ, order="grevlex"
        ).fglm("lex")
        assert len(basis.polys) == 3
        iv, ix, iy = (p.as_expr() for p in basis.polys)
        assert not (iv - v).has(v, x) and not (ix - x).has(v, x) and not iy.has(x, v)
        roots = Poly(iy, y, domain=QQ)
        roots = roots.sqf_part()
        assert roots.degree() <= 8
        X = Poly(x - ix, y, domain=QQ)
        xx = (X**2) % roots
        tt = (-Poly(y**2, y, domain=QQ) * (xx + A) * (B * xx).invert(roots)) % roots
        mass = Poly(resultant(iy, t - tt.as_expr(), y), t, domain=QQ).sqf_part().monic()
        factors = {g.monic() for g, k in mass.factor_list()[1]}
        assert len(factors) == 1
        seen.update(factors)
        if factors & POS:
            # t determines y and x uniquely since each of the eight roots has a different image.
            assert mass.degree() == 8
            real.update(factors)
    assert seen == WANTED and real == POS
    for f in WANTED:
        assert f.count_roots(0, oo) == (2 if f in POS else 0)
    for f in sorted(POS, key=lambda z: str(z)):
        print(
            f.as_expr(),
            [
                interval
                for interval, _ in f.intervals(eps=QQ(1, 10**6))
                if interval[0] > 0
            ],
        )
    print(
        "All four positive collinear masses have real position and signed-distance witnesses."
    )


if __name__ == "__main__":
    verify()
