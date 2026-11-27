"""Verify feasible rational valuations for selected diagram-88 necessary conditions.

These witnesses do not supply leading coefficients or solutions to the equations.
They record where a test by minimum orders alone stops at t=infinity.
"""
from fractions import Fraction
from itertools import combinations

BODIES = range(4)
ORIGIN = 4
MASS = [-1, 0, 0, 0]  # valuation of the mass, with t at body 0
X_EDGES = list(combinations(range(5), 2))
WITNESSES = [
    (None, "-1 0 0 0 -1 -1 -1 20/9 20/9 20/9",
     "1/3 -20/9 -20/9 11/9 -20/9 -20/9 1/3 -20/9 -20/9 -20/9"),
    (0, "-1 0 0 0 -1 -1 -1 2/11 2/11 2", "1/3 -2/3 -2/3 -2/3 -2/3 -2/33"),
    (3, "-1 0 0 0 -1 -1 -1 1/2 2 1/2", "1/3 4/3 4/3 1/3 1/3 11/6"),
]


def tie(weights):
    finite = [w for w in weights if w is not None]
    assert not finite or finite.count(min(finite)) >= 2


def check(zero, xs, ys):
    x = dict(zip(X_EDGES, map(Fraction, xs.split()), strict=True))
    y_edges = X_EDGES if zero is None else combinations(BODIES, 2)
    y = dict(zip(y_edges, map(Fraction, ys.split()), strict=True))

    def diff(axis, i, j):
        if axis == "y" and zero is not None:
            i = zero if i == ORIGIN else i
            j = zero if j == ORIGIN else j
        if i == j:
            return None
        return (x if axis == "x" else y)[tuple(sorted((i, j)))]

    def force(axis, i, j, weight):
        a, b = diff("x", i, j), diff("y", i, j)
        return 2*weight - (a+3*b if axis == "x" else 3*a+b)

    for axis in ("x", "y"):
        for i, j, k in combinations(range(5), 3):
            tie([diff(axis,i,j), diff(axis,i,k), diff(axis,j,k)])
        pos = [None if (v := diff(axis,i,ORIGIN)) is None else 2*(MASS[i]+v) for i in BODIES]
        tie(pos)
        for n in (1, 2, 3):
            for group in combinations(BODIES, n):
                other = set(BODIES) - set(group)
                cross = [force(axis,i,j,MASS[i]+MASS[j]) for i in group for j in other]
                for side in [group, other]:
                    tie(cross + [pos[i] for i in side])
        for i, j in combinations(BODIES, 2):
            common = force(axis, i, j, min(MASS[i], MASS[j]))
            rest = [force(axis,a,b,MASS[b]) for a in (i,j) for b in set(BODIES)-{i,j}]
            tie([2*diff(axis,i,j), common] + rest)
    assert diff("x",0,ORIGIN) == 0
    tie([2*MASS[i]-diff("x",i,ORIGIN) for i in BODIES])


if __name__ == "__main__":
    for zero, x, y in WITNESSES:
        check(zero, x, y)
        print("Feasible necessary order tests, vanishing quartet ordinate:", zero)
