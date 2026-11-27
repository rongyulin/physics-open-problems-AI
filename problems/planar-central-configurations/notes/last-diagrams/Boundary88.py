"""Albouy–Kaloshin four-body boundary tests and the equal-cube mixed chart in F_p.

Every radical needed for diagrams I and III splits at the test prime.
Diagram IV uses a ratio of cube roots only. The last test is in F_p[x].
"""
from itertools import permutations, product
from sympy import GF, isprime
from sympy.polys.rings import ring

PRIME = 65521


def roots_of(exponent, value):
    return [u for u in range(1, PRIME) if pow(u, exponent, PRIME) == value]


def boundary_tests():
    p = PRIME
    assert isprime(p)
    phases = roots_of(4, 1)
    three = roots_of(3, 1)
    assert len(phases) == 4 and len(three) == 3
    i = next(x for x in phases if x*x % p == p - 1)
    roots = {m: roots_of(2, m) for m in (1, 2)}
    assert all(len(items) == 2 for items in roots.values())
    counts = [0]*4
    for masses in sorted(set(permutations((1, 1, 1, 2)))):
        m1, m2, m3, m4 = masses
        a, b, c, d = [roots[m][0]**3 % p for m in masses]
        # Equations (12), (14), the unsimplified equation immediately before
        # (16), and elimination between (18) and (19), respectively.
        for e, f, g in product((1,-1), repeat=3):
            assert (a*c + e*i*b*c + f*i*a*d + g*b*d) % p
            counts[0] += 1
        assert (m1*m3-m2*m4) % p
        counts[1] += 1
        q1, q2, q3 = (pow(roots[m][0],-1,p) for m in masses[:3])
        for e, f in product(phases, repeat=2):
            assert (q1+e*q2+f*q3) % p
            counts[2] += 1
        for eta in three:
            assert (m1*m1*(m2+m3)*(eta*m2+m3)**3-(m2*m3)**3) % p
            counts[3] += 1
    print("Four-body boundary rejections in the four diagrams:", counts)


def equal_cube():
    # Relative high coordinates of the three bodies seen from zero-low body
    # are (1,u/x,v/(-2-x)); all four centered high coordinates are nonzero.
    p = PRIME
    ring1, x = ring('x', GF(p))
    ys = (ring1.one, x, -2-x)
    common = ys[1]*ys[2]
    for u, v in product(roots_of(3,1), repeat=2):
        ds = (common, u*ys[2], v*ys[1])
        weighted = 2*ds[0]+ds[1]+ds[2]
        xs = (-weighted, *(5*d-weighted for d in ds))
        invalid = common
        for xi in xs:
            invalid *= xi
        for a,b in ((0,1),(0,2),(1,2)):
            invalid *= (ys[a]-ys[b])*(ds[a]-ds[b])
        squarefree = invalid.sqf_part()
        # k=1 follows from the force at the origin and weighted!=0,
        # and in particular covers the collinear-test and zero-stress alternatives.
        at_zero_stress = ((ys[0]-ys[1])*(ds[0]-ds[1]))**3 - common**3
        at_rank_one = sum((ys[(i+1)%3]-ys[(i+2)%3])*ds[i] for i in range(3))
        seed = at_zero_stress*at_rank_one
        assert seed
        while (factor:=seed.gcd(squarefree)).degree() > 0:
            seed = seed.exquo(factor)
        for e,f,g in product((1,-1),repeat=3):
            nums=[]
            for idx, coefficient in enumerate((1,4*e,f,g)):
                prod_x=ring1.one*coefficient
                for j, value in enumerate(xs):
                    if j != idx:
                        prod_x *= value
                nums.append(prod_x)
            a,b,c,d=nums
            torque=((a+b-c-d)**2-4*a*b-4*c*d)**2-64*a*b*c*d
            assert seed.gcd(torque).degree()==0
    print("Equal-cube test over the algebraic closure: 9 distance and 8 torque patterns.")


if __name__ == '__main__':
    boundary_tests()
    equal_cube()
