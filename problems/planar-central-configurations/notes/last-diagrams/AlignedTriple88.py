"""Finite univariate elimination for the collinear triples of a spatial quartet.
Here 'noncollinear' refers to the whole complex planar quartet.  The residue u
of a primitive cube root satisfies u²+u+1=0 at the test prime.
"""
from itertools import product

from sympy import GF
from sympy.polys.fields import field

p=1009
K,x=field("x",GF(p))
omega=next(n for n in range(2,p) if (n*n+n+1)%p==0)
phases=(1,omega,pow(omega,2,p))

def force_rows(b,c):
    zero= -b/x**2-c/(x-1)**2-1+2*x
    slope= -b/x**2-x*(c/(1-x)**2-b/x**2)
    return zero,slope

def check():
    tests=0
    for b,c in product((1,-1),repeat=2):
        const,slope=force_rows(b,c)
        assert const and slope and const+slope
        mass=-const/slope
        rate=-2+mass*(c/(1-x)**2-b/x**2)
        for e1,e2 in product(phases,repeat=2):
            if e1==e2==1:continue
            radial=(x*x-x)/((e2-1)-x*(e1-1))
            obstruction=rate**2*radial**3-(2+mass)**2
            assert obstruction
            tests+=1
    print(f'{tests} nonzero scale obstructions over F_{p}, omega = {omega}')
if __name__=='__main__':check()
