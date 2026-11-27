"""Certify an upper bound of 4046 at s=infinity over Q(r) for Res_k(F,G).

Only exact arithmetic in integer polynomials and Q(z) is used.
Requires python-flint 0.8.0. Run beside InfinityChart88.py.
"""
from collections import defaultdict
from fractions import Fraction
from functools import reduce
from math import comb

from flint import fmpz_poly

from InfinityChart88 import force_polynomials

ONE = fmpz_poly([1])
ZERO = fmpz_poly([])
Z = fmpz_poly([0,1])


def integer_terms(f):
    return {tuple(map(int, powers)):int(c) for powers,c in f.to_dict().items()}


def k_degrees(terms):
    result = {}
    for (_,j,i) in terms:
        result[i] = max(result.get(i,-1), j)
    return result


def newton(degrees):
    """Return k-root degrees in s, with multiplicity, from the upper hull."""
    hull = []
    for i,d in sorted(degrees.items()):
        while len(hull)>1:
            u,h = hull[-1]
            v,b = hull[-2]
            if Fraction(d-h,i-u) < Fraction(h-b,u-v):
                break
            hull.pop()
        hull.append((i,d))
    return [(Fraction(x-y,b-a),b-a) for (a,x),(b,y) in zip(hull,hull[1:])]


def height(degrees, slope):
    return max(d+slope*n for n,d in degrees.items())


def group_terms(terms, powers):
    rows = defaultdict(dict)
    for (i,j,k),v in terms.items():
        rows[j,k][i] = v
    return {idx:sum((a*powers[i] for i,a in coeffs.items()), ZERO) for idx,coeffs in rows.items()}


def shift_degrees(terms, slope, n, d):
    """k becomes v+s^slope n/d. A common denominator d^deg_k is cleared."""
    m = max(k for i,j,k in terms)
    rows = group_terms(terms,[Z**i for i in range(1+max(i for i,j,k in terms))])
    multipliers = [n**i*d**(m-i) for i in range(m+1)]
    cells = defaultdict(list)
    for (j,k),p in rows.items():
        for v in range(k+1):
            cells[v,j+slope*(k-v)].append((comb(k,v),p,k-v))
    deg = {}
    for (v,j), items in sorted(cells.items(), reverse=True):
        if v not in deg and sum((b*p*multipliers[i] for b,p,i in items),ZERO):
            deg[v] = j
    return deg


def local_jets(terms, precision):
    """Coefficients near k=c s²-c² s+v s^(2/3), with w=s^(-1/3)."""
    rnum, rden = Z**2-4*Z+2, Z**2-2
    cnum, cden = rnum, -2*Z**2+4*Z-4
    # This parametrizes the quadratic extension with c²=r²/(2(1+r²)).
    assert 2*cnum**2*(rnum**2+rden**2) == rnum**2*cden**2
    dr, dk = max(i for i,j,k in terms), max(k for i,j,k in terms)
    rp = [rnum**i*rden**(dr-i) for i in range(dr+1)]
    cp = [cnum**i*cden**(2*dk-i) for i in range(2*dk+1)]
    rows = group_terms(terms,rp)
    terms_by_weight = defaultdict(list)
    for (j,k),p in rows.items():
        for v in range(k+1):
            for b in range(k-v+1):
                a = k-v-b
                order = 3*j+6*a+3*b+2*v
                terms_by_weight[order].append((p,v,a+2*b,(-1)**b*comb(k,v)*comb(k-v,b)))
    leading = None
    out = [{} for _ in range(precision)]
    for order, items in sorted(terms_by_weight.items(), reverse=True):
        if leading is not None and leading-order >= precision:
            break
        by_power = defaultdict(lambda: ZERO)
        for p,v,e,d in items:
            by_power[v,e] = by_power[v,e]+d*p
        row = defaultdict(lambda: ZERO)
        for (v,e),p in by_power.items():
            row[v] = row[v]+p*cp[e]
        row = {n:y for n,y in row.items() if y}
        if row:
            if leading is None:
                leading = order
            out[leading-order] = row
    # A common scalar unit in Q(z) does not change any divisibility test.
    g = reduce(fmpz_poly.gcd,[q for row in out for q in row.values()])
    return leading,[{n:p//g for n,p in row.items()} for row in out]


class Rational:
    def __init__(self, a, b=ONE):
        if not b:
            raise ZeroDivisionError()
        g=a.gcd(b)
        self.a,self.b=a//g,b//g

    def __sub__(self, other):
        return Rational(self.a*other.b-other.a*self.b,self.b*other.b)

    def __mul__(self, other):
        return Rational(self.a*other.a,self.b*other.b)

    def __truediv__(self, other):
        return Rational(self.a*other.b,self.b*other.a)

    def __bool__(self):
        return bool(self.a)


def trace_simple_roots(f_terms, h_terms):
    # vanishing through w^20 gives 21/3 units of extra s-degree loss.
    precision = 21
    jets = []
    for terms, expected in [(f_terms,264),(h_terms,207)]:
        leading,rows = local_jets(terms,precision)
        assert leading == expected
        jets.append([{n:Rational(q) for n,q in row.items()} for row in rows])
    f,h = jets
    assert set(h[0]) == {0,3}  # a cubic with three simple nonzero roots
    lc, bottom = h[0][3],h[0][0]
    zero = Rational(ZERO)
    for i in range(precision):
        quot = {}
        rem = f[i].copy()
        for n in range(max(rem,default=0),2,-1):
            if rem.get(n):
                w = rem.pop(n)/lc
                quot[n-3] = w
                rem[n-3] = rem.get(n-3,zero)-w*bottom
        assert not any(rem.values()), i
        for j in range(i+1,precision):
            for n,q in quot.items():
                for v,p in h[j-i].items():
                    f[j][n+v] = f[j].get(n+v,zero)-q*p
    return (264-precision)//3


def verify():
    f,g,h,u,v = force_polynomials()
    fd,hd = integer_terms(f),integer_terms(h)
    assert [p.degrees()[2] for p in (f,g,h,u,v)] == [28,34,22,14,2]
    # Degrees 34=22+14-2 make the leading-coefficient correction zero.
    correction = 0
    for sign,p in [(1,u),(-1,v)]:
        for factor,multiplicity in p.factor()[1]:
            result = f.resultant(factor,2)
            assert result
            correction += sign*multiplicity*result.degrees()[1]
    assert correction == 1424
    F,H = k_degrees(fd),k_degrees(hd)
    assert newton(H) == [(-3,2),(0,2),(1,6),(2,6),(3,6)]
    bounds = [height(F,b) for b in (-3,0,1,3)]
    for slope,num,den,sub in [(1,ONE,ONE,0),(3,Z**2,2*Z**2-1,2)]:
        hh = shift_degrees(hd,slope,num,den)
        assert [z for z in newton(hh) if z[0]<slope] == [(sub,3)]
        bounds.append(height(shift_degrees(fd,slope,num,den),sub))
    bounds.append(trace_simple_roots(fd,hd))
    assert bounds == [70,82,86,118,80,112,81]
    multiplicities = [2,2,3,3,3,3,6]
    assert H[22] == 23
    degree = 28*H[22]+sum(b*m for b,m in zip(bounds,multiplicities))
    assert degree == 2622 and degree+correction == 4046
    print("Universal s-degree bound on Res_k(F,H):",degree)
    print("Degree correction:",correction,"; bound on Res_k(F,G):",degree+correction)


if __name__ == "__main__":
    verify()
