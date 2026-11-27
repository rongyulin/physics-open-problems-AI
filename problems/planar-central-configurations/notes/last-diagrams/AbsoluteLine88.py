"""The normalized absolute-equilibrium equations on a line, over Q and F_65521."""
from itertools import product
from sympy import symbols,Poly,resultant,QQ
p=65521
x,y,t=symbols('x y t')

def check():
 for A,B,C,D,E in product((1,-1),repeat=5):
    n0=(x**2+A)*y**2; d0=B*x**2
    n1=(-(1-x)**2+C)*(1-y)**2; d1=D*(1-x)**2
    n2=(-A*(1-x)**2-C*x**2)*(x-y)**2;d2=E*x**2*(1-x)**2
    g=(n1*d0-d1*n0).expand();h=(B*n2-E*(1-x)**2*n0).expand()
    assert Poly(g,x,y,domain=QQ).gcd(Poly(h,x,y,domain=QQ)).total_degree()==0
    pairs=[n0+2*d0,n1+2*d1,n2+2*d2]
    rs=[resultant(pairs[i],pairs[j],y) for i,j in ((0,1),(0,2),(1,2))]
    for kw in ({'domain':QQ},{'modulus':p}):
        r1,r2,r3=[Poly(z,x,**kw) for z in rs]
        common=r1.gcd(r2).gcd(r3).sqf_part()
        bad=Poly(x*(1-x),x,**kw)
        assert common.exquo(common.gcd(bad)).degree()==0
 print('32 sign cases: each allows only finitely many t, none at t=2 over Qbar or Fbar_65521.')
if __name__=='__main__':check()
