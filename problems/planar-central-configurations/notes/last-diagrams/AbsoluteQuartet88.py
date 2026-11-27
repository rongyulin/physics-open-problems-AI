"""Exact inverse-triangle obstruction for a signed spatial four-body absolute equilibrium.

Test prime 65521 and the positive characteristic-zero consequences are separate.
"""
from itertools import combinations_with_replacement
from sympy import symbols, groebner, Poly, QQ, Rational, resultant

P=65521
a,b,c,w,t=symbols('a b c w t')
U=(a,b,c)
CUBES = sum(z**3 for z in U)

POLYS = (
    t*(3*t**2-1)*(3*t**6-106*t**4-97*t**2-25),
    t*(9*t**12-33*t**10+3724*t**8+14825*t**6+11487*t**4-5500*t**2+625)
      *(243*t**16-85860*t**14+14424304*t**12+13781204*t**10+17197074*t**8+
        484271*t**6+345418*t**4-25725*t**2+1875),
    t*(3*t**2+1)**2*(t**4+118*t**2+25),
)


def rows(edges,parameter):
    x,y,z=edges
    E=((0,x,y),(x,0,z),(y,z,0))
    return [sum(U)*u**2-parameter-sum(U[i]*E[i][j] for i in range(3)) for j,u in enumerate(U)]


def rational_proof():
    for i,eta in enumerate(((1,1,1),(1,1,w),(1,w,-1-w))):
        # Use a block-lexicographic basis instead of expanding the final power of the cubic CUBES.
        F=rows(eta,t)+[CUBES+t,w*w+w+1]
        G=groebner(F,a,b,c,w,t,order='grevlex',domain=QQ)
        assert not G.reduce(POLYS[i].expand())[1]
        pos=Poly(POLYS[i],t).sqf_part().exquo(Poly(t,t,domain=QQ))
        print('Edge pattern',i,'positive roots:',pos.count_roots(0,float('inf')),flush=True)
        assert pos.count_roots(0,float('inf'))==[2,0,0][i]
        assert POLYS[i].subs(t,2)!=0

def realization_test():
    u = a
    cubic = u**3 + 2*u**2 + 3*u + 3
    left, right = Rational(-7,5), Rational(-4,3)
    assert cubic.subs(u,left) < 0 < cubic.subs(u,right)
    assert (u**4+u**3+u**2-3-(u-1)*cubic).expand() == 0
    witness = t**2*(2+u)**6 - (1+u+u**2)**3*(2+u**3)**2
    assert resultant(cubic,witness,u) == 243*(3*t**6-106*t**4-97*t**2-25)
    print("Explicit equilateral inversions realize both positive mass ratios.")


def residue_test():
    roots=[i for i in range(1,P) if pow(i,3,P)==1]
    for eta in combinations_with_replacement(roots,3):
        G=groebner(rows(eta,2)+[CUBES+2],a,b,c,modulus=P,order='grevlex')
        assert G.contains(1+0*a)
    print('At t=2 every noncollinear absolute-equilibrium residue is excluded.')
if __name__=='__main__':
    rational_proof()
    realization_test()
    residue_test()
