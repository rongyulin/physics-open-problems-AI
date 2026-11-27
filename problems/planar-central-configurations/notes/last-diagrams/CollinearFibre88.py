"""Collinear t=2 quartet shapes over the full algebraic closure of F_65521."""
from itertools import combinations, permutations, product
from math import prod
from flint import nmod_mpoly_ctx, fmpz_mod_poly_ctx, fq_default_ctx, fq_default_poly_ctx

P = 65521
R = nmod_mpoly_ctx.get(["x","y"],P)
x,y = R.gens()
edges = list(combinations(range(4),2))
q = [R.constant(0),R.constant(1),x,y]
m = [1,1,1,2]


def orbit(signs):
    images = set()
    for perm in permutations(range(3)):
        pi = (*perm,3)
        for overall in (1,-1):
            value=[]
            for i,j in edges:
                a,b=pi[i],pi[j]
                value.append(overall*(1 if a<b else -1)*signs[edges.index(tuple(sorted((a,b))))])
            images.add(tuple(value))
    return images


def exclude(poly,bad):
    common = poly.gcd(bad)
    while poly.degree()>0 and common.degree()>0:
        poly=poly//common
        common=poly.gcd(bad)
    return poly


def test(signs):
    denom=prod((q[i]-q[j])**2 for i,j in edges)
    acc=[R.constant(0) for _ in m]
    for sign,(i,j) in zip(signs,edges):
        term=sign*(denom//((q[i]-q[j])**2))
        acc[i]+=m[j]*term
        acc[j]-=m[i]*term
    f,g=[(acc[i]-acc[0])-q[i]*(acc[1]-acc[0]) for i in (2,3)]
    resultant=f.resultant(g,'y')
    assert resultant
    total=0
    for factor,_ in resultant.factor()[1]:
        terms=factor.to_dict()
        assert all(j==0 for i,j in terms)
        U=fmpz_mod_poly_ctx(P)
        modulus=U([int(terms.get((i,0),0)) for i in range(factor.degrees()[0]+1)])
        F=fq_default_ctx(modulus=modulus,var="v",check_modulus=False)
        xi=F.gen() if modulus.degree()>1 else F(-int(modulus[0])*pow(int(modulus[1]),-1,P))
        if xi.is_zero() or (xi-1).is_zero():continue
        Yring=fq_default_poly_ctx(F)
        Y=Yring.gen()
        def specialize(poly):
            vals=[F.zero() for _ in range(poly.degrees()[1]+1)]
            for (i,j),c in poly.to_dict().items(): vals[j]+=int(c)*xi**i
            return Yring(vals)
        geom=specialize(f).gcd(specialize(g))
        assert geom
        coords=[Yring.zero(),Yring.one(),Yring([xi]),Y]
        centered=[5*pos-(1+xi+2*Y) for pos in coords]
        for h in [Y,Y-1,Y-xi,*centered]:geom=exclude(geom,h)
        if geom.degree()==0:continue
        total+=geom.degree()*modulus.degree()
        squared=[(mj**2*prod(centered[:i]+centered[i+1:]))%geom for i,mj in enumerate(m)]
        for pattern in product((1,-1),repeat=3):
            a,b,c,d=[e*v for e,v in zip((1,*pattern),squared)]
            torque=((a+b-c-d)**2-4*a*b-4*c*d)**2-64*a*b*c*d
            assert geom.gcd(torque).degree()==0
    print(signs,"geometric shapes before torque, with projection multiplicities",total)


if __name__=="__main__":
    seen=set()
    for signs in product((1,-1),repeat=6):
        if signs in seen:continue
        seen.update(orbit(signs))
        test(signs)
    assert len(seen)==64
