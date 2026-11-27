"""Modular finite Taylor chart, t=1."""
from itertools import product
from collections import Counter
from sympy import primitive_root
from square_second_order import inv, block, solve

class Series:
    def __init__(self,p,N):
        self.p,self.N=p,N
        self.zero=[0]*(N+1); self.one=self.zero[:];self.one[0]=1
    def add(self,a,b): return [(x+y)%self.p for x,y in zip(a,b)]
    def sub(self,a,b): return [(x-y)%self.p for x,y in zip(a,b)]
    def shift(self,a,k): return ([0]*k+a)[:self.N+1]
    def mul(self,a,b): return [sum(a[j]*b[i-j] for j in range(i+1))%self.p for i in range(self.N+1)]
    def scale(self,a,x): return [v*x%self.p for v in a]
    def power(self,a,s):
        # constant factor omitted: returns (a/a0)^s.
        p=self.p;u=self.scale(a,inv(a[0],p));u[0]=0
        result=self.one[:]; term=self.one[:];c=1
        for k in range(1,self.N+1):
            c=c*(s-k+1)*inv(k,p)%p
            term=self.mul(term,u);result=self.add(result,self.scale(term,c))
        return result
    def rec(self,a):return self.scale(self.power(a,-1),inv(a[0],self.p))


def evaluate(ser,q,groups,p0,g0):
    p=ser.p; half=inv(2,p)
    add,sub,mul,scale,shift=ser.add,ser.sub,ser.mul,ser.scale,ser.shift
    X,Y,B,C=q[:4],q[4:8],q[8:10],q[10:12];groupsq=[(X,Y),(B,C)]
    G=[ser.zero[:] for _ in q];dh=ser.zero[:]
    for (J,K),(xs,ys) in zip(groups,groupsq):
        for a,(x,y) in enumerate(zip(xs,ys)):
            G[J[a]]=scale(y,half); G[K[a]]=scale(x,half)
        for a in range(len(xs)):
            for b in range(a+1,len(xs)):
                dx=sub(xs[a],xs[b]); dy=sub(ys[a],ys[b])
                pair=scale(ser.power(mul(dx,dy),-half),p0[J[a],J[b]])
                fx=scale(mul(pair,ser.rec(dx)),-half)
                fy=scale(mul(pair,ser.rec(dy)),-half)
                G[J[a]]=add(G[J[a]],fx); G[J[b]]=sub(G[J[b]],fx)
                G[K[a]]=add(G[K[a]],fy); G[K[b]]=sub(G[K[b]],fy)
    for j in range(2):
        for k in range(4):
            u=sub(B[j],shift(Y[k],2));v=sub(X[k],shift(C[j],2))
            g=scale(ser.power(mul(u,v),-half),g0[j,k])
            gu=mul(g,ser.rec(u));gv=mul(g,ser.rec(v))
            dh=add(dh,add(g,shift(add(mul(gu,Y[k]),mul(gv,C[j])),2)))
            f1=scale(shift(gu,1),-half);f2=scale(shift(gv,1),-half)
            G[8+j]=add(G[8+j],f1); G[k]=add(G[k],f2)
            G[4+k]=sub(G[4+k],shift(f1,2)); G[10+j]=sub(G[10+j],shift(f2,2))
    return G,dh


def run_equal(p,N=4,diag=1):
    z=pow(int(primitive_root(p)),(p-1)//8,p);i=z*z%p;d=(z+inv(z,p))%p
    rad=(inv(d,p)+diag*inv(4,p))%p
    rset=[r for r in range(1,p) if (r**3-rad**2)%p==0]
    bset=[r for r in range(1,p) if (r**3-4)%p==0]
    if len(rset)!=3 or len(bset)!=3:return
    alpha=i*d%p;assert (alpha*alpha+2)%p==0
    x=[pow(z,-2*j,p) for j in range(4)]; B=[inv(2,p),-inv(2,p)%p]
    groups=[(list(range(4)),list(range(4,8))),([8,9],[10,11])]
    ids=[1,2,3,4,5,6,7,9,10,11];hf=7
    forces={(a,b):inv((2*d if (a-b)%2 else 8*diag)*rad,p)
            for a in range(4) for b in range(a+1,4)}
    masks=[]
    for a in product((1,-1),repeat=4):
        for b in product((1,-1),repeat=4):
            g0={(0,j):alpha*aj*z**j%p for j,aj in enumerate(a)}
            g0.update({(1,j):alpha*i*bj*z**j%p for j,bj in enumerate(b)})
            if sum(g0.values())%p==0:masks.append(g0)
    counts=Counter();residues=Counter()
    for rs,rb in product(rset,bset):
        y=[rs*inv(xj,p)%p for xj in x]; C=[rb*b%p for b in B]
        q0=x+y+B+C
        Hq=block([1]*4,x,y,forces,p);Hb=block([1,1],B,C,{(0,1):inv(2,p)},p)
        p0={(a,b):(x[a]-x[b])*(y[a]-y[b])*f%p for (a,b),f in forces.items()}
        p0[8,9]=(B[0]-B[1])*(C[0]-C[1])*inv(2,p)%p
        for (a,b),v in p0.items():
            j=a+4 if a<4 else a+2; k=b+4 if b<4 else b+2
            assert (v*v*(q0[a]-q0[b])*(q0[j]-q0[k])-1)%p==0
        for g0 in masks:
            for (a,j),v in g0.items():
                assert (v*v*(-B[a]*x[j])-1)%p==0
            q=[[t0]+[0]*N for t0 in q0];ser=Series(p,N)
            g,dh=evaluate(ser,q,groups,p0,g0)
            assert all(r[0]==0 for r in g) and dh[0]==0
            for k in range(1,N+1):
                rhs=[-g[ix][k]%p for ix in ids]
                step=solve(Hq,rhs[:hf],p)+solve(Hb,rhs[hf:],p)
                for j,v in zip(ids,step):q[j][k]=v
                g,dh=evaluate(ser,q,groups,p0,g0)
                assert all(not any(g[ix][:k+1]) for ix in ids)
                if dh[k]:
                    counts[k]+=1;residues[k,dh[k]]+=1;break
            else:counts['residual']+=1
    return len(masks),rset,bset,counts,residues

if __name__=='__main__':
    for p,diag in ((457,-1),(2113,1)):
        n,rs,rb,orders,residues=run_equal(p,3,diag)
        assert n==16 and orders=={3:144} and len(residues)==4
        print('prime',p,'diagonal sign',diag,'square and binary scales',rs,rb)
        print('first obstruction orders',orders,'residues',residues)
