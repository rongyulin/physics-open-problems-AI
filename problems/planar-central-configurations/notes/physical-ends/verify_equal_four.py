"""Exact interval enclosure for the unequal-radius concave kite of four unit masses."""
from fractions import Fraction as Q
from math import isqrt


class Interval:
    def __init__(self, lo, hi=None):
        self.lo = Q(lo)
        self.hi = self.lo if hi is None else Q(hi)
        assert self.lo <= self.hi

    @staticmethod
    def lift(x):
        return x if isinstance(x, Interval) else Interval(x)

    def __add__(self, other):
        y=self.lift(other)
        return Interval(self.lo+y.lo,self.hi+y.hi)
    __radd__=__add__

    def __neg__(self):
        return Interval(-self.hi,-self.lo)

    def __sub__(self,y):
        return self+(-self.lift(y))

    def __rsub__(self,y):
        return self.lift(y)+(-self)

    def __mul__(self,other):
        y=self.lift(other)
        terms=[a*b for a in (self.lo,self.hi) for b in (y.lo,y.hi)]
        return Interval(min(terms),max(terms))
    __rmul__=__mul__

    def inv(self):
        assert self.lo*self.hi>0
        return Interval(1/self.hi,1/self.lo)

    def __truediv__(self,y):
        return self*self.lift(y).inv()

    def sqrt(self):
        assert self.lo>0
        scale=2**72
        def lower(z):
            return isqrt((z*scale**2).__floor__())
        return Interval(Q(lower(self.lo),scale),Q(lower(self.hi)+1,scale))

    def mag(self):
        return max(-self.lo,self.hi)


def equations(u,v):
    x,y=1+u*u,1+v*v
    A,B=(x*x.sqrt()).inv(),(y*y.sqrt()).inv()
    d=v-u
    H=(d*d).inv()
    L=Q(1,4)+A+B
    a=(3*u-v)/4
    b=(3*v-u)/4
    F=(2*A*u-H-L*a,2*B*v+H-L*b)
    Ap=-3*u*A/x
    Bp=-3*v*B/y
    K=2*H/d
    J=((2*A+2*Ap*u-K-Ap*a-3*L/4, K-Bp*a+L/4),
       (K-Ap*b+L/4, 2*B+2*Bp*v-K-Bp*b-3*L/4))
    return F,J


def main():
    center=(Q('0.650378472'),Q('1.817239400'))
    radius=Q(1,10**6)
    box=[Interval(x-radius,x+radius) for x in center]
    F,_=equations(*(Interval(x) for x in center))
    _,J=equations(*box)
    T=((Q('-20.338'),Q('-14.584')),(Q('-23.956'),Q('-17.656')))
    assert T[0][0]*T[1][1]!=T[0][1]*T[1][0]
    move=max(sum(a*b for a,b in zip(row,F)).mag() for row in T)
    contraction=max(sum((int(i==j)-sum(T[i][k]*J[k][j] for k in range(2))).mag()
                        for j in range(2)) for i in range(2))
    assert contraction<Q(1,10) and move<Q(1,10)*radius
    u,v=box
    center_mass=(u+v)/4
    inner=u-center_mass
    outer=v-center_mass
    assert inner.lo>0 and inner.hi<Q(1,25) and outer.lo>1
    # Each off-axis radius |±i - center_mass| exceeds one.
    # Hence the inner reciprocal square root exceeds 5 and the other three sum to <3.
    print('Kite contraction <1/10, displacement <1/10 of box radius.')
    print('0 < inner axial radius < 1/25; other three radii > 1.')



def check_catalogue(cellfile):
    """Identify each quartet coordinate at zero on the opposite internal scale."""
    import json
    import hashlib
    import lzma
    raw=lzma.decompress(cellfile.read_bytes())
    manifest=cellfile.parent / 'SHA256SUMS'
    hashes={name:digest for digest,name in (line.split() for line in manifest.read_text().splitlines())}
    assert hashlib.sha256(raw).hexdigest()==hashes['c127.jsonl']
    outcomes=[]
    for line in raw.splitlines():
        tree=json.loads(line)['wtree']
        children={int(n):v for n,v in tree['children'].items()}
        parents={k:n for n,ch in children.items() for k in ch}
        def path(i):
            p=[tree['leaf'][str(i)]]
            while p[-1] in parents:p.append(parents[p[-1]])
            return p
        paths=[path(i) for i in range(7)]
        quartet_node=next(n for n in paths[1] if all(n in paths[i] for i in (2,3,4,6)))
        def child_below(i):
            return paths[i][paths[i].index(quartet_node)-1]
        special=[i for i in range(1,5) if child_below(i)==child_below(6)]
        assert len(special)<=1
        if not special:outcomes.append(('none',None))
        else:
            body=special[0]
            kind='origin leaf' if paths[body][0]==paths[6][0] else 'smaller scale'
            outcomes.append((kind,body))
    assert outcomes==[('smaller scale',2),('smaller scale',1),
                      ('origin leaf',1),('origin leaf',2),('origin leaf',3),('origin leaf',4),
                      ('none',None),('smaller scale',4),('smaller scale',3)]
    print('Catalogue cells 0-8: four smaller-scale, four exact-origin, one no zero.')


if __name__=='__main__':
    import argparse
    from pathlib import Path
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cells',type=Path,help='optional original c127.jsonl.xz with SHA256SUMS alongside')
    args=parser.parse_args()
    main()
    if args.cells:check_catalogue(args.cells)
