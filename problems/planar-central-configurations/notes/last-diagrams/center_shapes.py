"""Exact fixed-X classification for diagram 94 with variable mass at the shared center."""
from itertools import combinations, product

P = 673
assert all(P % d for d in range(2, 26))


def inv(a):
    return pow(a % P, -1, P)


def projection_shapes():
    shapes = set()
    for e2, e3 in product((1, -1), repeat=2):
        roots = [
            v for v in range(P)
            if (v**2*(1+v)**2 + e2*(1+v)**2 + e3*v**2) % P == 0
        ]
        # All-equal signs give (v^2 + v + 1)^2. Other quartics are separable.
        assert len(roots) == (2 if e2 == e3 == 1 else 4)
        for v in roots:
            x = (1, e2*inv(v**2) % P, e3*inv((1+v)**2) % P)
            assert sum(x) % P == 0 and len(set(x)) == 3
            shapes.add(x)
    assert len(shapes) == 14
    return sorted(shapes)


# Every square root of a base-field constant is in F_p[e]/(e^2 - nonresidue).
# We need only addition and base-field scalar multiplication in this extension.
nonresidue = next(a for a in range(2, P) if pow(a, (P-1)//2, P) == P-1)
square_root = {}
for a in range(P):
    square_root[a*a % P] = (a, 0)
    square_root[nonresidue*a*a % P] = (0, a)
assert len(square_root) == P


def scale(k, v):
    return tuple(k*z % P for z in v)


def add(u, v):
    return tuple((a+b) % P for a, b in zip(u, v))


def check_signs(x, r):
    """Return the square-root sheets with common C, and whether each also has common a."""
    y = [inv(xi*ri**2) for xi, ri in zip(x, r)]
    if len(set(y)) < 3:
        raise ValueError("colliding conjugate projections")
    unsigned = []
    for i, j in combinations(range(3), 2):
        q2 = inv((x[i]-x[j])*(y[i]-y[j]))
        unsigned.append(scale(q2, square_root[q2]))
    surviving = []
    # Multiplying all three cubes by -1 preserves the two equality tests.
    for sign2, sign3 in product((1, -1), repeat=2):
        cubes = [scale(s, z) for s, z in zip((1, sign2, sign3), unsigned)]
        a = [(0, 0)]*3
        c = [(0, 0)]*3
        for (i, j), q in zip(combinations(range(3), 2), cubes):
            for s, t in ((i, j), (j, i)):
                a[s] = add(a[s], scale((x[s]-x[t])*inv(x[s]), q))
                c[s] = add(c[s], scale((x[t]*y[s]-x[s]*y[t])*inv(x[s]), q))
        if len(set(c)) == 1:
            surviving.append((len(set(a)) == 1, len(set(cubes)) == 1))
    return surviving


def verify():
    unity = [q for q in range(P) if q**3 % P == 1]
    cube_roots = {}
    for q in range(1, P):
        cube_roots.setdefault(q**3 % P, []).append(q)
    classified = set()
    for x in projection_shapes():
        witness = None
        for r2 in range(2, P):
            if r2**3 % P == 1:
                continue
            for r3 in cube_roots.get((-1-x[1]*r2**3)*inv(x[2]) % P, []):
                try:
                    good = check_signs(x, (1, r2, r3))
                except ValueError:
                    continue
                if not good:
                    witness = (r2, r3)
                    break
            if witness:
                break
        assert witness
        assert (1+x[1]*witness[0]**3+x[2]*witness[1]**3) % P == 0
        print(f"X2={x[1]:3}: regular Fermat-cubic witness r2,r3={witness}")
        for r2, r3 in product(unity, repeat=2):
            r = (1, r2, r3)
            try:
                good = check_signs(x, r)
            except ValueError:
                # Here r_i^3=1. A collision implies X_i/X_j is a cube root
                # of unity. With distinct X_i and sum X_i=0, x is equilateral.
                assert x[1:] in ((unity[1], unity[2]), (unity[2], unity[1]))
                continue
            for common_a, common_cube in good:
                if common_a:
                    assert common_cube
                    classified.add((x, r))
    expected = set()
    for q in unity:
        if q == 1:
            continue
        x = (1, q, q*q % P)
        expected.update([(x, (1, 1, 1)), (x, tuple(map(inv, x)))])
    assert classified == expected
    print("Persistent patterns: 2 geometries, each with both triangle orientations.")


if __name__ == "__main__":
    verify()
