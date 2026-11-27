from flint import fmpz_mpoly_ctx
from itertools import combinations
import sys,time
R=fmpz_mpoly_ctx.get(['r','s','k'])
z,s,k=R.gens()
def poly(a):return R.constant(a) if isinstance(a,int) else a
class Frac:
    def __init__(self,a,b=1):
        if isinstance(a,Frac):self.a,self.b=a.a,a.b;return
        a,b=poly(a),poly(b); g=a.gcd(b)
        self.a,self.b=a//g,b//g
    def __add__(self,o):
        o=Frac(o);return Frac(self.a*o.b+self.b*o.a,self.b*o.b)
    __radd__=__add__
    def __neg__(self):return Frac(-self.a,self.b)
    def __sub__(self,o):return self+-Frac(o)
    def __rsub__(self,o):return Frac(o)+-self
    def __mul__(self,o):
        o=Frac(o);return Frac(self.a*o.a,self.b*o.b)
    __rmul__=__mul__
    def __truediv__(self,o):
        o=Frac(o);return Frac(self.a*o.b,self.b*o.a)
    def __rtruediv__(self,o):return Frac(o)/self
    def __pow__(self,n):return Frac(self.a**n,self.b**n) if n>=0 else Frac(self.b**(-n),self.a**(-n))
def shapes(r0=z):
    ss,kk=Frac(s),Frac(k)
    r=list(map(Frac,(1,r0,s)));h=[z**3 for z in r];a=[hj-kk for hj in h];rr=[z**-2 for z in r]
    edges={};A={}
    for i,j in combinations(range(3),2):
        u=3-i-j
        edges[i,j]=((a[i]+a[j])*(a[i]*rr[i]+a[j]*rr[j])-a[u]**2*rr[u])/(a[i]*a[j])
        A[i,j]=a[i]*a[j]
    ea,eb,ec=[v**-3 for v in edges.values()];AA,BB,CC=A.values()
    L=(BB**2*(ea-kk**2)-AA**2*(eb-kk**2))/(2*kk*AA*BB*(BB-AA))
    t=-L*sum(a);F1=((kk+L*AA)**2-ea).a;F2=((kk+L*CC)**2-ec).a
    print('F1/F2 degrees terms',[(v.degrees(),len(v)) for v in (F1,F2)],flush=True)
    print('common curves',F1.gcd(F2),flush=True)
    return F1,F2,t,a,edges,rr
