"""Exclude a planar zero-stress quartet from its Gram determinant.

All squared distances are cube roots of unity after normalizing the first
edge. The finite enumeration covers all abstract roots in characteristic
65521 and also gives nonzero residues for their characteristic-zero lifts.
"""
from itertools import product


def verify():
    p=65521
    roots=[u for u in range(1,p) if u**3 % p==1]
    assert len(roots)==3
    seen=set()
    for d02,d03,d12,d13,d23 in product(roots,repeat=5):
        # Gram of twice the bilinear form on vectors from 0 to 1,2,3.
        a,b,c=2,2*d02,2*d03
        u,v,w=1+d02-d12,1+d03-d13,d02+d03-d23
        det=(a*b*c+2*u*v*w-a*w*w-b*v*v-c*u*u) % p
        assert det
        seen.add(det)
    print('All 243 squared-distance tuples have nonzero Gram determinant.',
          len(seen),'distinct nonzero residues.')


if __name__=='__main__':
    verify()
