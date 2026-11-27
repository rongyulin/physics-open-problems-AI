"""Exact modular obstruction at the three square torque ratios.
Coordinates in each block are (X_1,...,X_n,Y_1,...,Y_n).
"""
from itertools import product
from sympy import primitive_root
from collections import Counter


def inv(a,p): return pow(int(a)%p,-1,p)

def block(m,x,y,k,p):
    n=len(m)
    H=[[0]*(2*n) for _ in range(2*n)]
    for j in range(n):
        H[j][n+j]=H[n+j][j]=m[j]*inv(2,p)%p
    for (j,l),f in k.items():
        dx,dy=x[j]-x[l],y[j]-y[l]
        weight=m[j]*m[l]*f*inv(4,p)
        xx=weight*3*dy*inv(dx,p); yy=weight*3*dx*inv(dy,p)
        for a,ea in ((j,1),(l,-1)):
            for b,eb in ((j,1),(l,-1)):
                H[a][b]+=ea*eb*xx
                H[a+n][b+n]+=ea*eb*yy
                H[a+n][b]+=ea*eb*weight
                H[a][b+n]+=ea*eb*weight
    # Fix the first X as a gauge and delete the same equation.
    return [[v%p for v in row[1:]] for row in H[1:]]


def solve(h,v,p):
    n=len(v)
    a=[row[:]+[vx%p] for row,vx in zip(h,v)]
    for j in range(n):
        pivot=next(i for i in range(j,n) if a[i][j]%p)
        a[j],a[pivot]=a[pivot],a[j]
        a[j]=[z*inv(a[j][j],p)%p for z in a[j]]
        for i in range(n):
            if i!=j:
                a[i]=[(x-a[i][j]*y)%p for x,y in zip(a[i],a[j])]
    return [r[-1] for r in a]

def form(H,v,p):
    return sum(a*b for a,b in zip(v,solve(H,v,p)))%p


def run(p,verbose=False,diag=1):
    g=int(primitive_root(p)); z=pow(g,(p-1)//8,p); i=z*z%p
    d=(z+inv(z,p))%p
    rad=(inv(d,p)+diag*inv(4,p))%p
    x=[pow(z,-2*j,p) for j in range(4)]; y=[inv(xj,p) for xj in x]
    forces={(a,b):inv((2*d if (a-b)%2 else 8*diag)*rad,p)
            for a in range(4) for b in range(a+1,4)}
    H=block([1]*4,x,y,forces,p)
    counts=Counter(); exceptions=[]
    for rho in ((d-1)%p,1,(d+1)%p):
        ts=[1] if rho==1 else [t for t in range(1,p) if (t**3-rho*rho)%p==0]
        if rho!=1 and len(ts)!=3:
            return
        for t in ts:
            if (1+t)%p==0: return
            m=[1,t]; B=[t*inv(t+1,p)%p,-inv(t+1,p)%p]
            Hb=block(m,B,B,{(0,1):inv(1+t,p)},p)
            for a in product((1,-1),repeat=4):
                for b in product((1,-1),repeat=4):
                    w=[(aj+i*rho*bj)*z**j%p for j,(aj,bj) in enumerate(zip(a,b))]
                    if sum(w)%p: continue
                    # Relative gradient is scaled by -2/alpha.
                    u=[w[j]*inv(x[j],p)%p for j in (1,2,3)]+[0]*4
                    vb=[i*rho*sum(bj*z**j for j,bj in enumerate(b))*inv(B[1],p)%p,0,0]
                    S,T=form(H,u,p),form(Hb,vb,p)
                    test=(S**3*(1+t)**2+T**3*rad**2)%p
                    counts[rho,t]+=1
                    if not test: exceptions.append((rho,t,a,b,S,T))
    if verbose:
        print('second-order certificate',p,diag,'zeta',z,'roots and masks',counts)
    return p,counts,exceptions


if __name__=='__main__':
    for diag in (-1,1):
        p,counts,exceptions=run(241,True,diag)
        assert sorted(counts.values()) == [8]*6+[16]
        assert len(exceptions)==16 and all(row[0]==1 for row in exceptions)
    print('All unequal resonances excluded on both square sign branches.')
