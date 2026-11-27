"""Universal cleared force equations for the chart in RepeatedStar88.md."""
from itertools import combinations

from flint import fmpz_mpoly_ctx

RING = fmpz_mpoly_ctx.get(["r", "s", "k"])
R, S, K = RING.gens()


class Fraction:
    """A reduced rational function over the integer polynomial ring."""

    def __init__(self, a, b=1):
        if isinstance(a, Fraction):
            self.num, self.den = a.num, a.den
            return
        a = RING.constant(a) if isinstance(a, int) else a
        b = RING.constant(b) if isinstance(b, int) else b
        if not b:
            raise ZeroDivisionError()
        g = a.gcd(b)
        self.num, self.den = a // g, b // g

    def __add__(self, other):
        other = Fraction(other)
        return Fraction(self.num * other.den + self.den * other.num, self.den * other.den)

    __radd__ = __add__

    def __neg__(self):
        return Fraction(-self.num, self.den)

    def __sub__(self, other):
        return self + (-Fraction(other))

    def __rsub__(self, other):
        return Fraction(other) - self

    def __mul__(self, other):
        other = Fraction(other)
        return Fraction(self.num * other.num, self.den * other.den)

    __rmul__ = __mul__

    def __truediv__(self, other):
        other = Fraction(other)
        return Fraction(self.num * other.den, self.den * other.num)

    def __rtruediv__(self, other):
        return Fraction(other) / self

    def __pow__(self, n):
        if n < 0:
            return Fraction(self.den**(-n), self.num**(-n))
        return Fraction(self.num**n, self.den**n)


def force_polynomials():
    ratios = list(map(Fraction, (1, R, S)))
    k = Fraction(K)
    alpha = [r**3-k for r in ratios]
    rho = [r**(-2) for r in ratios]
    e, pairs = [], []
    for i,j in combinations(range(3), 2):
        u = 3-i-j
        pairs.append(alpha[i]*alpha[j])
        distance = ((alpha[i]+alpha[j])*(alpha[i]*rho[i]+alpha[j]*rho[j])
                    - alpha[u]**2*rho[u]) / pairs[-1]
        e.append(distance**(-3))
    a,b,c = pairs
    l = (b**2*(e[0]-k**2)-a**2*(e[1]-k**2))/(2*k*a*b*(b-a))
    f = (k+l*a)**2-e[0]
    g = (k+l*c)**2-e[2]
    # h = c² f - a² g, with l² eliminated before expansion.
    h = k**2*(c**2-a**2)+2*k*a*c*(c-a)*l-c**2*e[0]+a**2*e[2]
    u = Fraction(g.den,h.den)/a**2
    for denominator in (f.den, g.den, h.den, a.num, a.den, c.den, u.den):
        assert f.num.gcd(denominator).degrees()[2] == 0
    return f.num, g.num, h.num, u.num, u.den
