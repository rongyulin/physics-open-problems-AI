"""Exact arithmetic for Equilateral94.md, using only the Python standard library."""
from itertools import permutations, product

P = 73


def inverse(x):
    return pow(x % P, -1, P)


def determinant(matrix):
    """Compute the determinant of a matrix of size at most four over F_73."""
    result = 0
    for perm in permutations(range(len(matrix))):
        sign_changes = sum(
            perm[i] > perm[j] for i in range(len(perm)) for j in range(i + 1, len(perm))
        )
        term = (-1) ** sign_changes
        for row, col in enumerate(perm):
            term *= matrix[row][col]
        result += term
    return result % P


# Since P is 1 modulo 3, the noncube condition makes X^3 - NONCUBE irreducible.
NONCUBE = next(a for a in range(2, P) if pow(a, (P - 1) // 3, P) != 1)


class Element:
    """Coordinates in the basis 1, e, e^2 where e^3 = NONCUBE."""

    def __init__(self, coordinates):
        self.coordinates = tuple(x % P for x in coordinates)

    @staticmethod
    def coerce(value):
        return value if isinstance(value, Element) else Element([value, 0, 0])

    def __add__(self, other):
        pairs = zip(self.coordinates, self.coerce(other).coordinates)
        return Element(x + y for x, y in pairs)

    __radd__ = __add__

    def __neg__(self):
        return Element(-x for x in self.coordinates)

    def __sub__(self, other):
        return self + (-self.coerce(other))

    def __rsub__(self, other):
        return -self + other

    def __mul__(self, other):
        result = [0, 0, 0]
        for i, x in enumerate(self.coordinates):
            for j, y in enumerate(self.coerce(other).coordinates):
                quotient, remainder = divmod(i + j, 3)
                result[remainder] += x * y * NONCUBE**quotient
        return Element(result)

    __rmul__ = __mul__

    def __pow__(self, exponent):
        result = self.coerce(1)
        for _ in range(exponent):
            result = result * self
        return result

    def __bool__(self):
        return any(self.coordinates)


def cube_roots(value):
    """All three cube roots of a nonzero base-field constant in the cubic extension."""
    assert value % P
    roots = []
    for k in range(3):
        for r in range(1, P):
            if (r**3 * NONCUBE**k - value) % P == 0:
                coordinates = [0, 0, 0]
                coordinates[k] = r
                roots.append(Element(coordinates))
    assert len(roots) == 3
    return roots


def triangle_coefficients(omega, sqrt3):
    """Form the four-body Hessian, solve for the transverse tangent and sum cubic terms."""
    x = [1, omega, omega**2 % P, 0]
    y = [inverse(value) for value in x[:3]] + [0]
    x_variations = [[0, 1, -1, 0]] + [[0] * 4 for _ in range(3)]
    y_variations = [[0] * 4] + [[int(i == j) for i in range(4)] for j in range(3)]
    p0 = inverse(1 + inverse(sqrt3))

    hessian = []
    for k in range(4):
        row = []
        for ell in range(4):
            cross = sum(
                x_variations[k][i] * y_variations[ell][i]
                + x_variations[ell][i] * y_variations[k][i]
                for i in range(3)
            )
            row.append(cross * inverse(2) % P)
        hessian.append(row)

    edges = []
    for i in range(3):
        for j in range(i + 1, 4):
            weight = p0 if j == 3 else p0 * inverse(sqrt3) % P
            a = [(row[i] - row[j]) * inverse(x[i] - x[j]) % P for row in x_variations]
            b = [(row[i] - row[j]) * inverse(y[i] - y[j]) % P for row in y_variations]
            for k, ell in product(range(4), repeat=2):
                entry = 3 * (a[k] * a[ell] + b[k] * b[ell]) + a[k] * b[ell] + a[ell] * b[k]
                hessian[k][ell] = (hessian[k][ell] + weight * inverse(4) * entry) % P
            edges.append((i, j, weight))

    small_block = [row[1:] for row in hessian[1:]]
    block_det = determinant(small_block)
    assert block_det != 0
    dy = []
    for k in range(3):
        replaced = [row[:] for row in small_block]
        for j in range(3):
            replaced[j][k] = -hessian[j + 1][0]
        dy.append(determinant(replaced) * inverse(block_det) % P)
    dy.append(0)
    dx = x_variations[0]
    b1 = sum(dy) % P
    c1 = p0 * inverse(2) * sum(
        inverse(x[i]) * (-3 * dx[i] * inverse(x[i]) - dy[i] * inverse(y[i]))
        for i in range(3)
    ) % P
    cubic = 0
    for i, j, weight in edges:
        a = (dx[i] - dx[j]) * inverse(x[i] - x[j]) % P
        b = (dy[i] - dy[j]) * inverse(y[i] - y[j]) % P
        cubic -= weight * inverse(16) * (5 * (a**3 + b**3) + 3 * a * b * (a + b))
    return cubic % P, b1, c1


def verify():
    unity_roots = [q for q in range(P) if q**3 % P == 1]
    sqrt3_roots = [s for s in range(P) if s**2 % P == 3]
    ratio_roots = [l for l in range(P) if l**2 % P == P - 1]
    d_roots = [d for d in range(P) if d**2 % P == P - 2]
    assert tuple(map(len, (unity_roots, sqrt3_roots, ratio_roots, d_roots))) == (3, 2, 2, 2)

    checked = 0
    for omega, sqrt3 in product((q for q in unity_roots if q != 1), sqrt3_roots):
        cubic, b1, c1 = triangle_coefficients(omega, sqrt3)
        beta_roots = cube_roots((1 + inverse(sqrt3)) ** 2)
        for q in unity_roots:
            r_roots = [r for r in range(P) if 8 * (1 + q)**3 * r**2 % P == 1]
            assert len(r_roots) == 2
            for r, ratio in product(r_roots, ratio_roots):
                assert (1 + 2 * r) * inverse(q) % P != 0  # scaled A Hessian determinant
                u = inverse(1 + 2 * r)
                alpha_roots = cube_roots(8 * inverse(u**2))
                lam = (1 - q) * r * u % P
                a0 = (6 * lam - 1 + q) * inverse(3) % P
                e_factor = ((a0 - lam) * b1 - a0 * c1) * inverse(2) % P
                j_factor = (1 - ratio * q - (1 + ratio) * a0) % P
                for alpha, beta, d in product(alpha_roots, beta_roots, d_roots):
                    f = beta * cubic
                    g = -3 * d * (1 + ratio) * inverse(8) % P
                    e = alpha * beta * e_factor
                    j = 3 * d * inverse(2) * (j_factor * alpha + 2 * (1 - ratio) * beta)
                    discriminant = (
                        g**2 * e**2 - 4 * f * e**3 - 4 * g**3 * j
                        - 27 * f**2 * j**2 + 18 * f * g * e * j
                    )
                    assert f and j and discriminant
                    checked += 1
    assert checked == 864
    return checked


if __name__ == "__main__":
    print(f"Verified {verify()} tuples over the cubic extension of F_73.")
    print("Both Hessian blocks, f, j and the cubic discriminant are nonzero.")
