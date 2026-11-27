"""Exact test of the constant-ratio quartet shapes, over number fields of degree <=4."""
from itertools import product
from sympy import Poly, QQ, Symbol, cancel, fraction
from sympy.polys.agca.extensions import MonogenicFiniteExtension


def check():
    s = Symbol("s")
    tests = 0
    for a, b in product((-1, 1), repeat=2):
        r = -a*s/(1+b*s)
        condition = r*(s**3-1)-a*s*(1-r**3)
        polynomial = Poly(fraction(cancel(condition))[0], s, domain=QQ)
        for irreducible, multiplicity in polynomial.factor_list()[1]:
            extension = MonogenicFiniteExtension(irreducible.monic())
            z = extension.generator
            if not z or not 1+b*z:
                continue
            ratios = (extension.one, -a*z/(1+b*z), z)
            cubes = [v**3 for v in ratios]
            if len(set(cubes)) < 3:
                continue
            radii = [1/v**2 for v in ratios]
            excluded = False
            for k in range(2, 16):
                alphas = [cube-k for cube in cubes]
                if not all(alphas):
                    continue
                distances, scales = [], []
                for i,j,l in ((0,1,2), (0,2,1), (1,2,0)):
                    ai, aj, al = alphas[i], alphas[j], alphas[l]
                    scale = ai*aj
                    dist = ((ai+aj)*(ai*radii[i]+aj*radii[j])-al**2*radii[l])/scale
                    distances.append(dist)
                    scales.append(scale)
                if not all(distances):
                    continue
                A, B, C = scales
                e, f, g = [1/d**3 for d in distances]
                L = (B**2*(e-k*k)-A**2*(f-k*k))/(2*k*A*B*(B-A))
                if (k+L*A)**2 != e or (k+L*C)**2 != g:
                    print("signs", a,b, "factor", irreducible.as_expr(), "test k", k)
                    tests += 1
                    excluded = True
                    break
            assert excluded
    assert tests == 3
    print("Every admissible constant pair fails the force equations identically.")


if __name__ == "__main__":
    check()
