"""Verify the finite boundary multiplicities for the complete quartet distance chart.

Requirements: python-flint 0.8.0. No serialized polynomial or solver output is read.
The local-intersection and degree argument is in FiniteRatioBoundary88.md.
"""
from fractions import Fraction
from itertools import combinations
from math import comb
from flint import fmpz_mpoly_ctx, fmpz_poly, nmod_mpoly_ctx
from UniversalChart88 import shapes, R

r3,s3,k3 = R.gens()
B = fmpz_mpoly_ctx.get(["r","s"])
r,s = B.gens()
T = fmpz_mpoly_ctx.get(["s"])
z, = T.gens()
ONE = B.constant(1)


def k_coeffs(pol):
    rows = [{} for _ in range(1+pol.degrees()[2])]
    for (i,j,n),v in pol.to_dict().items():
        rows[n][i,j] = v
    return [B.from_dict(row) for row in rows]


def order(pol, factor):
    if not pol:
        return float("inf")
    n = 0
    while True:
        quotient, remainder = divmod(pol, factor)
        if remainder:
            return n
        pol = quotient
        n += 1


def shifted(coeffs, b, c):
    # Coefficients in w of c^n F(s,b/c+w). A unit factor c^n is harmless.
    n = len(coeffs)-1
    return [sum((comb(j,i)*coeffs[j]*b**(j-i)*c**(n-j+i) for j in range(i,n+1)), B.constant(0))
            for i in range(n+1)]


def base_intersection(f, g, divisor):
    a, b = ([order(coef,divisor) for coef in row] for row in (f,g))
    weights = sorted({Fraction(a[i]-a[j], j-i)
                      for i,j in combinations(range(len(a)),2)
                      if a[j]<a[i]<float("inf")})
    total = Fraction(0)
    for w in weights:
        h = [v+i*w for i,v in enumerate(a)]
        ends = [i for i,v in enumerate(h) if v==min(h)]
        if len(ends)>1:
            total += (ends[-1]-ends[0])*min(v+i*w for i,v in enumerate(b))
    return total


def univariate(q, v):
    value = q.compose(T.constant(v), z)
    d = value.to_dict()
    return fmpz_poly([int(d.get((j,),0)) for j in range(1+value.degrees()[0])])


def root_orders_at_one_third(polys):
    # Use integer universal F and G, not a fresh cancellation in F_p.
    S = nmod_mpoly_ctx.get(["s","k"],1009)
    sv,kv=S.gens()
    reduced=[]
    for p in polys:
        terms={}
        for (i,j,l),a in p.to_dict().items():
            terms[j,l]=(terms.get((j,l),0)+int(a)*pow(673,i,1009))%1009
        P=S.from_dict(terms)
        assert P.degrees()[1]==p.degrees()[2]
        reduced.append(P)
    res=reduced[0].resultant(reduced[1],1)
    for i,want in ((1,76),(374,0),(634,0)):
        assert order(res,sv-i)==want
    assert all((w*w+w+1)%1009==0 for w in (374,634))


def run():
    F,G,t,alpha,edges,rr=shapes()
    assert F.gcd(G).is_one()
    assert F.degrees()==(82,82,28) and G.degrees()==(100,100,34)
    from RatioChart88 import shapes as fixed_shapes, R as fixed_ring
    fs,fk=fixed_ring.gens()
    f3,g3,*_=fixed_shapes(3)
    assert F.compose(fixed_ring.constant(3),fs,fk) == -f3
    assert G.compose(fixed_ring.constant(3),fs,fk) == g3
    raw=[k_coeffs(f) for f in (F,G)]
    centers=[B.constant(0),ONE,r**3,s**3]
    series={j:[shifted(a,c,ONE) for a in raw] for j,c in enumerate(centers)}
    D1,D2,D3=[v.a for v in edges.values()]
    assert D1.resultant(D3,2) and D2.resultant(D3,2)
    partial=D1.resultant(D2,2)
    cross=B.from_dict({(i,j):a for (i,j,k),a in partial.to_dict().items()})
    nodal=[f for f,e in cross.factor()[1] if f.degrees() in ((4,4),(5,5))]
    assert len(nodal)==2
    divisors={str(f):f for f in nodal}
    for f,g in series.values():
        for h,_ in f[0].gcd(g[0]).factor()[1]:
            if h.degrees()[1]>0:
                divisors[str(h)] = h
    assert len(divisors)==18

    # The two transverse distance intersections.
    co=[k_coeffs(d) for d in (D1,D2,D3)]
    A,B1=co[0][2],co[1][2]
    b=A*co[1][0]-B1*co[0][0]
    c=B1*co[0][1]-A*co[1][1]
    def plug(row):
        return sum(v*b**j*c**(len(row)-1-j) for j,v in enumerate(row))
    nd={}
    for h in nodal:
        assert cross%(h**2) and b%h and c%h
        assert all(z%h for z in (r,s,r**3-s**3,co[0][2],co[1][2]))
        assert all((b-v*c)%h for v in centers)  # finite chart denominators
        assert all(not plug(row)%h for row in co[:2])
        nd[str(h)]=72 if not plug(co[2])%h else 54
    assert sorted(nd.values())==[54,72]

    # Complete the s=0 count at the two finite k positions.
    have0=base_intersection(*series[0],s)
    half=[shifted(row,ONE,2*ONE) for row in raw]
    assert have0==696 and base_intersection(*half,s)==72
    transformed=[]
    for pol in (F,G):
        q=pol.compose(r3,s3,s3**2*(1-r3**4+k3))
        # Before the translation in k, the mass of the slope-two edge was
        # already counted. Divide it out, retaining the extra at k=0.
        low=min(j for i,j,k in q.to_dict())
        transformed.append(k_coeffs(q//(s3**int(low))))
    assert base_intersection(*transformed,s)==24

    # At s=1, count the other common k roots by their intersection with s=1.
    K=fmpz_mpoly_ctx.get(["r","k"]); rx,kx=K.gens()
    f,g=[p.compose(rx,K.constant(1),kx) for p in (F,G)]
    sub=f.gcd(g)
    while not sub%(kx-rx**3):
        sub=sub//(kx-rx**3)
    assert sub.degrees()[1]==22
    assert base_intersection(*series[2],s-1)==54
    root_orders_at_one_third((F,G))

    # Compare every predicted specialized factor and its multiplicity. The
    # small part is reconstructed in characteristic zero below without input data.
    num = fmpz_poly([1])
    seen=fmpz_poly([1])
    excluded= {str(r-s):156, str(r**2+r*s+s**2):56}
    for key,h in divisors.items():
        hs=univariate(h,3)
        assert hs.degree()==h.degrees()[1] and hs.gcd(hs.derivative()).degree()==0
        assert hs.gcd(seen).degree()==0
        seen*=hs
        if h==s:
            mult=792
        elif h==s-1:
            mult=76
        elif key in excluded:
            # These two numbers only reidentify the old-chart special factors;
            # the exclusion itself uses the transformed coordinates at r'=1/3.
            mult=excluded[key]
        elif key in nd:
            mult=nd[key]
        else:
            mult=sum((base_intersection(*row,h) for row in series.values()),Fraction(0))
            assert mult.denominator==1 and mult>0
            mult=int(mult)
        num*=hs**mult
        print('s-degree',h.degrees()[1], 'special multiplicity', mult, flush=True)
    assert num.degree()==3370
    from RatioResultant88 import resultant
    P=resultant()
    simple,rem=divmod(P,num//num.content())
    assert not rem and simple.degree()==676 and simple.gcd(seen).degree()==0
    assert simple.gcd(simple.derivative()).degree()==0
    print("All finite boundary groups and the complementary simple part are accounted for.")


if __name__=="__main__":
    run()
