"""Single-parameter fibre witnesses for the four nonreal cube-ratio cases."""
from itertools import product
from sympy import sqrt_mod

P = 1009
def frac(x,y=1): return x*pow(y%P,-1,P)%P
w=374
assert (w*w+w+1)%P == 0
phases=(w,w*w%P)


def witness(u,v,midpoint):
    U,V=(frac(2*(r+1),r-1) for r in (u,v))
    for seed in range(2,P):
        if midpoint:
            d,l=frac(1,2),seed
        else:
            d=seed
            denom=(U*d-V*(d-1))%P
            if not denom:continue
            l=frac(2*d-1,denom)
        J=(U*d*l-d*d)%P
        A=((d+l)**2+J-l*l)%P
        B=((d-1+l)**2+J-l*l)%P
        if not A or not B or not J or not (J-l*l)%P:continue
        assert A==u*((d-l)**2+J-l*l)%P
        assert B==v*((d-1-l)**2+J-l*l)%P
        # Cubes of signed normalized inverse distances on pair-to-fixed
        # edges and across the exchanged pair, respectively.
        roots=[sqrt_mod(frac(1,W**3),P,all_roots=True) for W in (A,B,4*J)]
        if any(len(rs)!=2 for rs in roots):continue
        residues=[]
        for r,s,m in product(*roots):
            f0=(2*m+r-1-2*(1-d)*s-2*d*r)%P
            f1=(s-1)%P
            if not f1:break
            t=frac(-f0,f1)
            acceleration=(2*m+r+t*s)%P
            residual=((2*d+t)*acceleration-(3+t)*(2*d*r+t))%P
            if not residual:break
            residues.append(residual)
        if len(residues)==8:return seed,residues
    raise AssertionError("Missing witness")

if __name__=='__main__':
    for u,v in product(phases,repeat=2):
        for midpoint in ([False,True] if u!=v else [False]):
            print(u,v,'midpoint' if midpoint else 'generic',witness(u,v,midpoint))
