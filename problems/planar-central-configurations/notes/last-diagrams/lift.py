"""Exact finite-field Taylor test of the single surviving initial system."""
from itertools import product,combinations
from collections import Counter
from math import prod
E=list(combinations(range(4),2))
xp=[0,-2,4,None];mp=[-2,0,0,0];vp=[1,0,4,0,5,2];yp=[0,0,-8,2,-8,-8]
def idx(i,j):return E.index(tuple(sorted((i,j))))
def sign(i,j):return 1 if i<j else -1
def xo(i,j):return min(a for a in (xp[i],xp[j]) if a is not None)
class Ring:
 def __init__(self,p,N):self.p=p;self.N=N
 def c(self,a):return [a%self.p]+[0]*self.N
 def add(self,a,b):return [(u+v)%self.p for u,v in zip(a,b)]
 def scale(self,a,k):return [u*k%self.p for u in a]
 def neg(self,a):return self.scale(a,-1)
 def sh(self,a,k):
  assert k>=0
  return ([0]*k+a)[:self.N+1]
 def mul(self,a,b):return [sum(a[i]*b[j-i] for i in range(j+1))%self.p for j in range(self.N+1)]
 def rec(self,a):
  t=pow(a[0],-1,self.p);out=[t]
  for j in range(1,self.N+1):out.append(-sum(a[i]*out[j-i] for i in range(1,j+1))*t%self.p)
  return out
 def invsqrt(self,a):
  assert a[0]==1
  a=a[:];a[0]=0;out=self.c(1);term=self.c(1);c=1
  for j in range(1,self.N+1):
   c=c*(1-2*j)*pow(2*j,-1,self.p)%self.p;term=self.mul(term,a);out=self.add(out,self.scale(term,c))
  return out
 def sumwt(self,terms):
  w=min(n for n,a in terms);out=self.c(0)
  for n,a in terms:out=self.add(out,self.sh(a,n-w))
  return out
 def xdata(self,lam):
  one=self.c(1); small=one
  for j in range(self.N//3+2):
   x=self.scale(self.sh(self.invsqrt(self.add(one,self.sh(small,6))),3),lam)
   small=self.invsqrt(one) if self.N==0 else self.rec(self.mul(self.add(one,x),self.add(one,x)))
  far=self.neg(self.add(one,self.sh(small,6)))
  return [one,far,small,None]
 def evaluate(self,P,X):
  xs=[];ys=[];P3=[]
  for a,(i,j) in enumerate(E):
   d=self.sumwt(([(xp[i],X[i])] if X[i]!=None else [])+([(xp[j],self.neg(X[j]))] if X[j]!=None else []))
   xs.append(d);r=self.mul(P[a],P[a]);ys.append(self.rec(self.mul(d,r)));P3.append(self.mul(r,P[a]))
  out={}
  for i,j,k in combinations(range(4),3):
   ix=[idx(i,j),idx(i,k),idx(j,k)]
   out[f't{i}{j}{k}']=self.sumwt([(yp[a],self.scale(ys[a],b)) for a,b in zip(ix,(1,-1,1))])
  for i in range(4):
   terms=[] if X[i] is None else [(xp[i],X[i])]
   for j in range(4):
    if i==j:continue
    a=idx(i,j)
    terms.append((mp[j]+3*vp[a]+xo(i,j),self.scale(self.mul(xs[a],P3[a]),-sign(i,j))))
   out['x'+str(i)]=self.sumwt(terms)
  for i,j in combinations(range(3),2):
   a=idx(i,j)
   terms=[(yp[a],ys[a])]
   for mp0 in (mp[i],mp[j]):
    terms.append((mp0+3*vp[a]+yp[a],self.neg(self.mul(ys[a],P3[a]))))
   for f,sg in [(i,-1),(j,1)]:
    for k in sorted(set(range(4))-{i,j}):
     z=idx(f,k)
     terms.append((mp[k]+3*vp[z]+yp[z],self.scale(self.mul(ys[z],P3[z]),sg*sign(f,k))))
   out[f'y{i}{j}']=self.sumwt(terms)
  return out
def solve(H,b,p):
 a=[row[:]+[v] for row,v in zip(H,b)]
 for j in range(len(b)):
  k=next(i for i in range(j,len(b)) if a[i][j]%p)
  a[j],a[k]=a[k],a[j];a[j]=[v*pow(a[j][j],-1,p)%p for v in a[j]]
  for i in range(len(b)):
   if i!=j:a[i]=[(v-a[i][j]*w)%p for v,w in zip(a[i],a[j])]
 return [row[-1] for row in a]
def check(p=97,N=9):
 I=next(i for i in range(p) if i*i%p==p-1);roots=[a for a in range(p) if a**3%p==1]
 labels=['t012','t013','t023','x0','x1','y02'];out=Counter();detail=Counter()
 for a,b,sg,z,lam in product(roots,roots,(1,-1),(I,-I),(1,-1,I,-I)):
  v=[sg*a,a,-a,b,z*a,a]
  R=Ring(p,N);X=R.xdata(lam);P=[R.c(u) for u in v];G=R.evaluate(P,X)
  assert all(g[0]==0 for g in G.values())
  # Derive the leading shape Jacobian with a square-zero dual variable.
  J=Ring(p,1);Y=J.xdata(lam);base=[J.c(u) for u in v];base_eq=J.evaluate(base,Y)
  H=[[] for lab in labels]
  for k in range(6):
   base[k][1]=1;gs=J.evaluate(base,Y);base[k][1]=0
   for row,lab in zip(H,labels):row.append((gs[lab][1]-base_eq[lab][1])%p)
  for n in range(1,N+1):
   delta=solve(H,[-G[l][n] for l in labels],p)
   for k,d in enumerate(delta):P[k][n]=d
   G=R.evaluate(P,X);assert all(G[l][n]==0 for l in labels)
   errs=[(k,g[n]) for k,g in G.items() if g[n]]
   if errs:
    out[n]+=1;detail[n,errs[0][0],errs[0][1]]+=1;break
  else:out['undecided']+=1
 return out,detail
if __name__=='__main__':
 a,b=check();print(a);print(b)
