"""Compute a fixed-r integer resultant by ordinary exact evaluations and interpolation."""
from flint import fmpz_poly
from RatioChart88 import shapes
from math import factorial,comb
from multiprocessing import Pool
from time import monotonic

f,g,*_=shapes(3)
MF,MG=f.degrees()[1],g.degrees()[1]

def setup_poly(pol):
    coeff=[{} for i in range(1+pol.degrees()[1])]
    for (i,k),x in pol.to_dict().items():coeff[k][i]=x
    return [fmpz_poly([row.get(j,0) for j in range(max(row)+1)]) for row in coeff]
F,G=map(setup_poly,(f,g))

def value(q):
    a,b=(fmpz_poly([v(q) for v in row]) for row in (F,G))
    da,db=a.degree(),b.degree()
    if da<0 or db<0 or da<MF and db<MG:return 0
    z=a.resultant(b)
    if da<MF:z*=((-1)**MG*b.leading_coefficient())**(MF-da)
    if db<MG:z*=a.leading_coefficient()**(MG-db)
    return int(z)

def interpolate(values):
    n=len(values)-1
    nv=[fmpz_poly([v*comb(n,i)*(-1)**(n-i)]) for i,v in enumerate(values)]
    prod=[fmpz_poly([-i,1]) for i in range(n+1)]
    while len(nv)>1:
        totals=[nv[i]*prod[i+1]+nv[i+1]*prod[i] for i in range(0,len(nv)-1,2)]
        products=[prod[i]*prod[i+1] for i in range(0,len(nv)-1,2)]
        if len(nv)%2:
            products.append(prod[-1]);totals.append(nv[-1])
        nv,prod=totals,products
    return nv[0]//factorial(n)

def resultant():
    with Pool(3) as pool:
        # Sylvester determinant uses 34 coefficients of f and 28 of g.
        degree = f.degrees()[0]*MG + g.degrees()[0]*MF
        vals=list(pool.imap(value,range(degree+1),chunksize=16))
    P=interpolate(vals)
    assert P(degree+1)==value(degree+1) and P.degree()==4046
    return P//P.content()
