"""Exclude the mixed zero-projection, equal central inverse-cubes fibre at t=2.
All univariate gcds and exact divisions take place over Q(sqrt(-3)).
"""
from itertools import product
from sympy import sqrt, QQ
from sympy.polys.rings import ring


def verify(mass=2, single_row=False):
    field = QQ.algebraic_field(sqrt(-3))
    R, x = ring('x', field)
    w = R.ground_new(field.from_sympy((-1+sqrt(-3))/2))
    roots = (R.one,w,w*w)
    y = (R.one,x,-mass-x)
    Y = x*(-mass-x)
    for a,b in product(roots, repeat=2):
        # All three relative X entries are expressed over their common denominator Y.
        d = (Y,a*y[2],b*x)
        D = mass*d[0]+d[1]+d[2]
        X = (-D,*((mass+3)*p-D for p in d))  # common denominator 5Y
        invalid = Y * D
        for i in range(3):
            invalid *= X[i+1]
            for j in range(i):
                invalid *= (y[i]-y[j])*(d[i]-d[j])
        invalid = invalid.sqf_part()
        # One necessary equation for zero stress and one for rank-one stress.
        a0 = ((y[0]-y[1])*(d[0]-d[1]))**3-Y**3
        a1 = (y[1]-y[2])*d[0]+(y[2]-y[0])*d[1]+(y[0]-y[1])*d[2]
        seed = a0*a1
        assert seed
        while (common:=seed.gcd(invalid)).degree()>0:
            seed=seed.exquo(common)
        for s1,s2,s3 in ([(1,1,1)] if single_row else product((1,-1),repeat=3)):
            # A_i = sign_i * mass_i^2/X_i. Use the common nonzero denominator prod X.
            A=[]
            for k,coefficient in enumerate((1,mass**2*s1,s2,s3)):
                value=R.ground_new(coefficient)
                for j in range(4):
                    if j != k:
                        value *= X[j]
                A.append(value)
            a,b,c,d=A
            h=((a+b-c-d)**2-4*a*b-4*c*d)**2-64*a*b*c*d
            assert seed.gcd(h).degree()==0
    print(f'At quartet mass {mass}: all 9 cube-root patterns and {1 if single_row else 8} squared torque signs excluded over Q(sqrt(-3)).')


if __name__=='__main__':
    verify()
