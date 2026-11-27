"""Verify the characteristic-zero exclusion at signed inverse-distance ratio three."""
from flint import fmpz_poly,fmpz_mod_poly_ctx,fq_default_ctx,fq_default_poly_ctx
from itertools import product
from RatioChart88 import shapes
from math import prod
f1,f2,t,a,edges,rr=shapes(3)
def simple_factors(P):
    [(group,n)]=[(v,j) for v,j in P.factor_squarefree()[1] if j==1]
    pm=fmpz_mod_poly_ctx(1009)
    modular=pm([int(c) for c in group.coeffs()])
    assert modular.degree()==group.degree()==676
    factors=modular.factor()[1]
    assert sorted((f.degree(),e) for f,e in factors)==[(6,1),(670,1)]
    for mod,n in factors:
        F=fq_default_ctx(modulus=mod,var='s',check_modulus=False)
        s=F.gen(); K=fq_default_poly_ctx(F);h=K.gen();spow=[F.one()]
        for i in range(310):spow.append(spow[-1]*s)
        def ev(poly):
            vals=[F.zero() for j in range(poly.degrees()[1]+1)]
            for (i,j),co in poly.to_dict().items():vals[j]+=int(co)*spow[i]
            return K(vals)
        f,g=ev(f1),ev(f2)
        assert f.degree()==f1.degrees()[1] or g.degree()==f2.degrees()[1]
        gcd=f.gcd(g);assert gcd.degree()==1
        k0=-gcd[0]/gcd[1]
        def plug(frac):
            den=ev(frac.b)(k0)
            assert not den.is_zero()
            return ev(frac.a)(k0)/den
        A=list(map(plug,a)); tt=plug(t); r2=plug(rr[1]); D12=plug(edges[0,1])
        assert all(not x.is_zero() for x in A) and not (tt+3).is_zero()
        H=h**2-(1+r2-D12)*h+r2
        z3=-(A[0]+A[1]*h)/A[2]
        high=[K.zero(),K.one(),h,z3]
        v=sum(high,K.zero());xs=[(z*(3+tt)-v)%H for z in high]
        for signs in product((1,-1),repeat=3):
            Y=[(tt**2 if i==0 else F.one())*e*prod(xs[:i]+xs[i+1:]) for i,e in enumerate((1,*signs))]
            b,c,d,e=[u%H for u in Y];torque=((b+c-d-e)**2-4*b*c-4*d*e)**2-64*b*c*d*e
            assert H.gcd(torque).degree()==0
        print('No torque sheet for degree',mod.degree(),flush=True)

if __name__ == "__main__":
    from RatioResultant88 import resultant
    from RatioBoundary88 import repeated_factors
    P=resultant()
    repeated_factors(P)
    simple_factors(P)
    print("Fixed ratio 3 excluded from the collision-free, distinct-cube chart.")
