"""Complete nonzero-stress, four-nonzero-entry quartet fibre at t=2, p=65521.

Requires python-flint 0.8.0. Dimension checks use an installed msolve or Singular.
Use --points-only to check the stored rational parametrizations and torque separately.
"""

import argparse
from itertools import combinations, product
import json
from pathlib import Path
import shutil
import subprocess
from tempfile import TemporaryDirectory
from flint import fmpz_mod_poly_ctx, fq_default_ctx, nmod_mpoly_ctx

PRIME = 65521
SIZE = {"distinct": 420, "zero_sum": 4, "repeat": 102}


def unordered_equations():
    # z represents the third root. The other two have sum 1-z and product z²-z+f.
    ring = nmod_mpoly_ctx.get(("z", "s", "f", "g"), PRIME)
    z, s, f, g = ring.gens()
    polynomial = z**3 - z**2 + f * z - g
    pair_sum = 1 - z
    pair_product = z**2 - z + f
    total = s * (1 - 3 * f + 3 * g) - 3
    third = (s * z**3 - 1) % polynomial
    pair = (
        s**2 * pair_product**3 - s * (pair_sum**3 - 3 * pair_sum * pair_product) + 1
    ) % polynomial
    num = (
        (total - third)
        * (s * pair_sum * g**2 - (pair_sum**2 - 2 * pair_product) * z**2)
        - third**2 * pair_product**2
    ) % polynomial
    residual = (
        (total - 2 * pair) ** 2 * num**3 - total**2 * s**2 * g**6 * pair**3
    ) % polynomial
    chart = nmod_mpoly_ctx.get(("s", "f", "g"), PRIME)

    def coefficient(poly, degree):
        terms = {mon[1:]: c for mon, c in poly.to_dict().items() if mon[0] == degree}
        return chart.from_dict(terms)

    equations = [coefficient(residual, j) for j in range(3)]
    nonzero = (
        s * g * total * polynomial.discriminant("z") * polynomial.resultant(third, "z")
    )
    assert nonzero.degrees()[0] == 0
    return equations, coefficient(nonzero, 0), ("s", "f", "g")


def ordered_equations(kind):
    ring = nmod_mpoly_ctx.get(("x", "s"), PRIME)
    x, s = ring.gens()
    u = (
        [ring.constant(1), x, -1 - x]
        if kind == "zero_sum"
        else [ring.constant(1), ring.constant(1), x]
    )
    a = [s * val**3 - 1 for val in u]
    total = sum(a)
    g = u[0] * u[1] * u[2]
    equations = []
    for i, j in combinations(range(3), 2):
        k = 3 - i - j
        n = (a[i] + a[j]) * (a[i] * u[j] ** 2 + a[j] * u[i] ** 2) * u[k] ** 2 - a[
            k
        ] ** 2 * (u[i] * u[j]) ** 2
        pair = a[i] * a[j]
        equations.append(
            (total - 2 * pair) ** 2 * n**3 - total**2 * s**2 * (g**2 * pair) ** 3
        )
    return equations, s * g * total * a[0] * a[1] * a[2], ("x", "s")


def verify_dimension(kind, equations, nonzero, variables, engine):
    names = ("v", *variables)
    combined = nmod_mpoly_ctx.get(names, PRIME)
    inverse = (
        combined.from_dict(
            {(1, *mon): coeff for mon, coeff in nonzero.to_dict().items()}
        )
        - 1
    )
    inputs = [str(poly).replace(" ", "") for poly in [*equations, inverse]]
    with TemporaryDirectory() as tmp:
        folder = Path(tmp)
        if engine == "singular":
            source = folder / "case.sing"
            source.write_text(
                f"ring r={PRIME},({','.join(names)}),dp;\n"
                + "ideal I="
                + ",\n".join(inputs)
                + ";\n"
                + "ideal G=slimgb(I); print(vdim(G)); quit;\n"
            )
            out = subprocess.check_output(["Singular", "-q", str(source)], text=True)
            assert out.strip().splitlines()[-1] == str(SIZE[kind]), out
        else:
            source, target = folder / "case.in", folder / "case.out"
            source.write_text(
                ",".join(names) + f"\n{PRIME}\n" + ",\n".join(inputs) + "\n"
            )
            # Deterministic sparse linear algebra. Independently count standard monomials.
            subprocess.run(
                [
                    "msolve",
                    "-g",
                    "1",
                    "-l",
                    "2",
                    "-t",
                    "2",
                    "-f",
                    str(source),
                    "-o",
                    str(target),
                ],
                check=True,
                stdout=subprocess.DEVNULL,
            )
            data = target.read_text().split("[", 1)[1].split("]", 1)[0]
            indices = {name: i for i, name in enumerate(names)}
            leading = []
            for raw in data.strip().split(","):
                powers = [0] * len(names)
                for power in raw.strip().split("*"):
                    name, _, degree = power.partition("^")
                    powers[indices[name]] = int(degree) if degree else 1
                leading.append(powers)
            # Each standard monomial is reachable from 1 by multiplying coordinates.
            origin = (0,) * len(names)
            seen, stage = {origin}, [origin]
            while stage:
                point = stage.pop()
                for i in range(len(names)):
                    next_point = tuple(e + (j == i) for j, e in enumerate(point))
                    if next_point in seen:
                        continue
                    if any(
                        all(a <= b for a, b in zip(lm, next_point)) for lm in leading
                    ):
                        continue
                    seen.add(next_point)
                    stage.append(next_point)
                    assert len(seen) <= SIZE[kind], (
                        "computed quotient exceeds the advertised dimension"
                    )
            assert len(seen) == SIZE[kind]
    print(kind, engine, "quotient dimension", SIZE[kind], flush=True)


class SimpleAlgebra:
    """Quotient by a monic quadratic or cubic. Coefficients are listed constant first."""

    def __init__(self, coefficients):
        self.coefficients = coefficients
        self.degree = len(coefficients)
        self.zero = coefficients[0] * 0
        self.one = self.zero + 1

    def constant(self, value):
        return Element(self, [value] + [self.zero] * (self.degree - 1))

    def generator(self):
        return Element(self, [self.zero, self.one] + [self.zero] * (self.degree - 2))


class Element:
    def __init__(self, ring, values):
        self.ring = ring
        self.values = values

    def coerce(self, value):
        if isinstance(value, Element) and value.ring is self.ring:
            return value
        return self.ring.constant(self.ring.one * value)

    def __add__(self, other):
        other = self.coerce(other)
        return Element(self.ring, [x + y for x, y in zip(self.values, other.values)])

    __radd__ = __add__

    def __neg__(self):
        return Element(self.ring, [-x for x in self.values])

    def __sub__(self, other):
        return self + (-self.coerce(other))

    def __rsub__(self, other):
        return self.coerce(other) + (-self)

    def __mul__(self, other):
        if isinstance(other, Element) and isinstance(other.ring.one, Element):
            if other.ring.one.ring is self.ring:
                return other * self
        other = self.coerce(other)
        degree = self.ring.degree
        coeffs = [self.ring.zero] * (2 * degree - 1)
        for i, left in enumerate(self.values):
            for j, right in enumerate(other.values):
                coeffs[i + j] += left * right
        for k in range(2 * degree - 2, degree - 1, -1):
            for j, value in enumerate(self.ring.coefficients):
                coeffs[k - degree + j] -= coeffs[k] * value
        return Element(self.ring, coeffs[:degree])

    __rmul__ = __mul__

    def __pow__(self, exponent):
        if exponent < 0:
            return self.inverse() ** (-exponent)
        value = self.ring.constant(self.ring.one)
        power = self
        while exponent:
            if exponent % 2:
                value *= power
            power *= power
            exponent //= 2
        return value

    def multiplication_columns(self):
        """Coordinates of this element times 1,z,...,z^(d-1)."""
        column = self.values
        columns = [column]
        for i in range(1, self.ring.degree):
            shifted = [self.ring.zero, *column[:-1]]
            column = [
                x - column[-1] * c for x, c in zip(shifted, self.ring.coefficients)
            ]
            columns.append(column)
        return columns

    def norm(self):
        columns = self.multiplication_columns()
        if len(columns) == 2:
            a, b = columns
            return a[0] * b[1] - a[1] * b[0]
        a, b, c = columns
        return (
            a[0] * (b[1] * c[2] - b[2] * c[1])
            - b[0] * (a[1] * c[2] - a[2] * c[1])
            + c[0] * (a[1] * b[2] - a[2] * b[1])
        )

    def inverse(self):
        columns = self.multiplication_columns()
        reciprocal = self.norm() ** (-1)
        if len(columns) == 2:
            a, b = columns
            first_column = [b[1], -a[1]]
        else:
            a, b, c = columns
            first_column = [
                b[1] * c[2] - b[2] * c[1],
                c[1] * a[2] - c[2] * a[1],
                a[1] * b[2] - a[2] * b[1],
            ]
        return Element(self.ring, [v * reciprocal for v in first_column])


def check_unordered(g, f, s):
    one = g**0
    first = SimpleAlgebra([-g, f, -one])
    x = first.generator()
    pair_sum = 1 - x
    pair_product = x * x - x + f
    second = SimpleAlgebra([pair_product, -pair_sum])
    y = second.generator()
    check_ordered([second.constant(x), y, second.constant(pair_sum) - y], s, 2)


def check_ordered(ratios, s, order_extensions):
    alpha = [u**3 * s - 1 for u in ratios]
    radii = [u ** (-2) for u in ratios]
    a, b, c = alpha
    u, v, w = radii
    distance = ((a + b) * (a * u + b * v) - c**2 * w) * ((a * b) ** (-1))
    projection = SimpleAlgebra([v * u ** (-1), -(u + v - distance) * u ** (-1)])
    h = projection.generator()
    high = [h * 0, h * 0 + 1, h, -(h * b + projection.constant(a)) * c ** (-1)]
    centroid_numerator = high[1] + high[2] + high[3]
    high = [5 * x - centroid_numerator for x in high]
    products = [
        high[(i + 1) % 4] * high[(i + 2) % 4] * high[(i + 3) % 4] for i in range(4)
    ]
    for e, f, g in product((1, -1), repeat=3):
        A, B, C, D = [u * coefficient for u, coefficient in zip(products, (4, e, f, g))]
        value = ((A + B - C - D) ** 2 - 4 * A * B - 4 * C * D) ** 2 - 64 * A * B * C * D
        for _ in range(1 + order_extensions):
            value = value.norm()
        assert not value.is_zero(), (e, f, g)


def verify_points(kind, record, equations, nonzero):
    poly = fmpz_mod_poly_ctx(PRIME)
    eliminant = poly(record["polynomial"])
    coords = [poly(c) for c in record["coordinates"]]
    assert (
        eliminant.degree() == SIZE[kind]
        and eliminant.gcd(eliminant.derivative()).degree() == 0
    )
    for irreducible, multiplicity in eliminant.factor()[1]:
        assert multiplicity == 1
        field = fq_default_ctx(modulus=irreducible, var="w", check_modulus=False)

        def evaluate(p):
            return field(list(map(int, (p % irreducible).coeffs())))

        param = evaluate(poly.gen())
        values = [evaluate(c) for c in coords]
        if kind == "zero_sum":
            assert -sum(values, field.zero()) == param
        else:
            values.append(param)
        inverse, *values = values

        def at_point(polynomial):
            result = field.zero()
            for mon, coef in polynomial.to_dict().items():
                term = field(int(coef))
                for x, degree in zip(values, mon):
                    term *= x**degree
                result += term
            return result

        assert inverse * at_point(nonzero) == 1 and all(
            at_point(q).is_zero() for q in equations
        )
        if kind == "distinct":
            s, f, g = values
            check_unordered(g, f, s)
        else:
            x, s = values
            u = (
                [field.one(), x, -1 - x]
                if kind == "zero_sum"
                else [field.one(), field.one(), x]
            )
            check_ordered(u, s, 0)
    print(
        kind,
        "all signed torque choices excluded at",
        SIZE[kind],
        "chart points",
        flush=True,
    )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group()
    group.add_argument("--engine", choices=["msolve", "singular", "both"])
    group.add_argument("--points-only", action="store_true")
    args = parser.parse_args()
    if not args.engine and not args.points_only:
        args.engine = "msolve" if shutil.which("msolve") else "singular"
    engines = (
        ["msolve", "singular"]
        if args.engine == "both"
        else ([args.engine] if args.engine else [])
    )
    records = json.loads(Path(__file__).with_suffix(".json").read_text())
    for kind in SIZE:
        equations, nonzero, names = (
            unordered_equations() if kind == "distinct" else ordered_equations(kind)
        )
        for engine in engines:
            verify_dimension(kind, equations, nonzero, names, engine)
        verify_points(kind, records[kind], equations, nonzero)


if __name__ == "__main__":
    main()
