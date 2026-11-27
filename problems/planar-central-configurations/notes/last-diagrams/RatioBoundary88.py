"""Remove forbidden chart roots exactly in each small number field."""
from flint import fmpz_poly
from RatioChart88 import shapes
from sympy import QQ,Poly,Symbol
from sympy.polys.rings import ring

uf=Symbol('z')
f,g,t,a,edges,rr=shapes(3)
def repeated_factors(P):
    for part,m in P.factor_squarefree()[1]:
     if m==1:continue
     for mod,_ in part.factor()[1]:
      w=Poly.from_list(list(map(int,reversed(mod.coeffs()))),uf,domain=QQ)
      if w.degree()==1:
       D=QQ;z=D.convert(-w.nth(0))/D.convert(w.nth(1))
      else:
       D=QQ.alg_field_from_poly(w);z=D.unit
      if z**3 in (D.zero,D.one,D(27)):continue
      K,k=ring('k',D)
      def ev(poly):
       terms=poly.to_dict()
       coeffs=[{} for i in range(1+poly.degrees()[1])]
       for (i,j),c in terms.items():coeffs[j][i]=int(c)
       # Using an integer polynomial remainder before entering the number field
       # avoids repeated conversion of large powers of z.
       ans={}
       for j,coeff in enumerate(coeffs):
        p=fmpz_poly([coeff.get(i,0) for i in range(max(coeff,default=-1)+1)])
        pe=Poly.from_list([int(c) for c in reversed(p.coeffs())],uf,domain=QQ).rem(w)
        entry=D.zero
        for v in pe.all_coeffs():entry=entry*z+D.convert(v)
        if entry:ans[(j,)]=entry
       return K.from_dict(ans)
      F,G=ev(f),ev(g)
      for H in [k,*(ev(e.a) for e in a),ev(edges[0,1].a)]:
       while (h:=F.gcd(H)).degree()>0:F=F.exquo(h)
      # Compute a coprime witness after reduction in a finite residue field. The
      # first polynomial's k-degree is preserved; every factor in common over D
      # would reduce to a nonconstant common factor after monic normalization.
      from flint import fmpz_mod_poly_ctx, fq_default_ctx,fq_default_poly_ctx
      pp=1009; modp=fmpz_mod_poly_ctx(pp)([int(c) for c in mod.coeffs()]); cert=False
      for f0,_ in modp.factor()[1]:
       Z=fq_default_ctx(modulus=f0,var='z',check_modulus=False);T=fq_default_poly_ctx(Z);z0=Z.gen()
       if f0.degree()==1:z0=Z(-int(f0[0])*pow(int(f0[1]),-1,pp))
       def red(x):
        val=Z.zero()
        coeffs=x.to_list() if w.degree()>1 else [x]
        for rational in coeffs:
         val=val*z0+int(rational.numerator)*pow(int(rational.denominator),-1,pp)
        return val
       def redp(Q):
        out=[Z.zero() for i in range(Q.degree()+1)]
        for (i,),v in Q.items():out[i]=red(v)
        return T(out)
       try:
        Fm,Gm=redp(F),redp(G)
       except ValueError:continue
       if Fm.degree()==F.degree() and Fm.gcd(Gm).degree()==0:cert=True;break
      assert cert
      print('Removed boundary roots for', w.as_expr(), flush=True)
