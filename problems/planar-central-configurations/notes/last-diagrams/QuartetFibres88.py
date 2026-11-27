"""Replay the r=2 and r=3 experiments in the general quartet chart over F_1009.

Requires python-flint 0.8.0. These two slices make no assertion about a
positive-dimensional characteristic-zero family, or about any particular mass.
"""
from itertools import combinations, product
from math import prod

from flint import fmpz_mod_poly_ctx, fq_default_ctx, fq_default_poly_ctx, nmod_mpoly_ctx

PRIME = 1009
RING = nmod_mpoly_ctx.get(["s", "k"], PRIME)
S, K = RING.gens()


class RationalFunction:
    """A reduced fraction in F_1009(s,k), using FLINT multivariate gcds."""

    def __init__(self, num, den=1):
        num = RING.constant(num) if isinstance(num, int) else num
        den = RING.constant(den) if isinstance(den, int) else den
        if not den:
            raise ZeroDivisionError
        common = num.gcd(den)
        self.num = num // common
        self.den = den // common

    @staticmethod
    def fraction(value):
        return value if isinstance(value, RationalFunction) else RationalFunction(value)

    def __add__(self, other):
        other = self.fraction(other)
        return RationalFunction(self.num*other.den + self.den*other.num, self.den*other.den)

    __radd__ = __add__

    def __neg__(self):
        return RationalFunction(-self.num, self.den)

    def __sub__(self, other):
        return self + (-self.fraction(other))

    def __rsub__(self, other):
        return other + (-self)

    def __mul__(self, other):
        other = self.fraction(other)
        return RationalFunction(self.num*other.num, self.den*other.den)

    __rmul__ = __mul__

    def __pow__(self, power):
        if power < 0:
            return RationalFunction(self.den**(-power), self.num**(-power))
        return RationalFunction(self.num**power, self.den**power)

    def __truediv__(self, other):
        return self * (self.fraction(other)**-1)


def chart(r):
    fixed = RationalFunction
    k = fixed(K)
    ratios = [fixed(1), fixed(r), fixed(S)]
    alpha = [value**3 - k for value in ratios]
    radial = [value**-2 for value in ratios]
    edges = []
    pairs = []
    for i, j in combinations(range(3), 2):
        last = 3-i-j
        pair = alpha[i]*alpha[j]
        squared = ((alpha[i]+alpha[j])*(alpha[i]*radial[i]+alpha[j]*radial[j])
                   -alpha[last]**2*radial[last])/pair
        edges.append(squared)
        pairs.append(pair)
    a, b, c = pairs
    e12, e13, e23 = [edge**-3 for edge in edges]
    scale = (b**2*(e12-k**2)-a**2*(e13-k**2))/(2*k*a*b*(b-a))
    mass = -scale*sum(alpha)
    constraints = [((k+scale*a)**2-e12).num, ((k+scale*c)**2-e23).num]
    return constraints, mass, alpha, edges


def univariate(poly):
    terms = poly.to_dict()
    assert all(j == 0 for i, j in terms)
    return [int(terms.get((i, 0), 0)) for i in range(poly.degrees()[0]+1)]


def remove_factors(poly, forbidden):
    common = poly.gcd(forbidden)
    while poly.degree() > 0 and common.degree() > 0:
        poly = poly//common
        common = poly.gcd(forbidden)
    return poly


def check_fibre(r):
    (f1, f2), mass, alpha, edges = chart(r)
    assert f1.gcd(f2).degrees() == (0, 0)
    resultant = f1.resultant(f2, "k")
    base = fmpz_mod_poly_ctx(PRIME)
    orbit_sizes = []
    for factor, _ in resultant.factor()[1]:
        modulus = base(univariate(factor))
        degree = modulus.degree()
        field = fq_default_ctx(modulus=modulus, var="v", check_modulus=False)
        s = field.gen() if degree > 1 else field(-int(modulus[0])*pow(int(modulus[1]), -1, PRIME))
        if any(x.is_zero() for x in (s, s**3-1, s**3-r**3)):
            continue
        uniring = fq_default_poly_ctx(field)
        powers = [field.one()]

        def specialize(poly):
            coeffs = [field.zero() for _ in range(poly.degrees()[1]+1)]
            while len(powers) <= poly.degrees()[0]:
                powers.append(powers[-1]*s)
            for (i, j), coefficient in poly.to_dict().items():
                coeffs[j] += int(coefficient)*powers[i]
            return uniring(coeffs)

        ks = specialize(f1).gcd(specialize(f2))
        assert ks
        # Both rational masses and all chart edges and star coefficients are nonzero.
        ks = remove_factors(ks, specialize(K))
        for value in [mass, *alpha, *edges]:
            ks = remove_factors(ks, specialize(value.num))
            ks = remove_factors(ks, specialize(value.den))
        ks = remove_factors(ks, specialize((3+mass).num))
        if ks.degree() == 0:
            continue
        assert ks.degree() == 1
        root = -ks[0]/ks[1]

        def evaluated(value):
            return specialize(value.num)(root)/specialize(value.den)(root)

        a1, a2, a3 = map(evaluated, alpha)
        t = evaluated(mass)
        radial2 = (field(r)**2).inverse()
        direction = uniring([radial2, -(1+radial2-evaluated(edges[0])), 1])
        h = uniring.gen()
        relative = [uniring.zero(), uniring.one(), h, -(a1+a2*h)/a3]
        coordinate_sum = sum(relative, uniring.zero())
        positions = [(value*(3+t)-coordinate_sum) % direction for value in relative]
        for value in positions:
            direction = remove_factors(direction, value)
        if direction.degree() == 0:
            continue
        for signs in product((1, -1), repeat=3):
            weights = [t**2, *map(field, signs)]
            squared = [(weight*prod(positions[:i]+positions[i+1:])) % direction
                       for i, weight in enumerate(weights)]
            a, b, c, d = squared
            torque = ((a+b-c-d)**2-4*a*b-4*c*d)**2-64*a*b*c*d
            assert direction.gcd(torque).degree() == 0
        orbit_sizes.append(degree)
    assert sorted(orbit_sizes) == ({2:[3,15,20,43,111,478], 3:[6,670]}[r])
    print(f"r={r}, resultant degree {resultant.degrees()[0]}, "
          f"admissible (s,k) orbit sizes {sorted(orbit_sizes)}, passing torque: 0")


if __name__ == "__main__":
    for fixed_ratio in (2, 3):
        check_fibre(fixed_ratio)
