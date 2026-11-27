"""Exclude paired sixth powers from the mixed zero-projection diagram-88 chart.
Uses only Python 3 and SymPy. Run from any directory.
"""
from sympy.polys.domains import GF, ZZ
from sympy.polys.rings import ring
from OuterZeroChart88 import equations


def restrict(polynomial, moving_ratio, primitive, ring2):
    # The six powers of zeta in the basis (1,zeta), where zeta^2-zeta+1=0.
    powers = ((1, 0), (0, 1), (-1, 1), (-1, 0), (0, -1), (1, -1))
    a, b = {}, {}
    for (i, j, k), coefficient in polynomial.items():
        key = (i+j if moving_ratio else j, k)
        x, y = powers[i % 6] if primitive else ((-1)**i, 0)
        a[key] = a.get(key, 0) + x * coefficient
        b[key] = b.get(key, 0) + y * coefficient
    a = ring2.from_dict(a)
    if not primitive:
        return a
    b = ring2.from_dict(b)
    return a*a + a*b + b*b


def verify():
    ring2, s, t = ring('s,t', ZZ)
    field, z = ring('z', GF(1009))
    originals = equations()
    for moving_ratio in (False, True):
        for primitive in (False, True):
            required = [(s**3*t+s**3-t+1)**2, ring2.one,
                        s**14, s**28][2*int(moving_ratio)+int(primitive)]
            polynomials = [restrict(f, moving_ratio, primitive, ring2).exquo(required)
                           for f in originals]
            # A possible common curve must lie in both projections. Full degrees
            # and a unit modular gcd certify a nonzero integer Sylvester resultant.
            pair = polynomials[0], polynomials[1] + 2 * polynomials[2]
            for axis, other in ((s,t), (t,s)):
                for number in (2,3,5,7,11,13,17):
                    degrees = [poly.degree(other) for poly in pair]
                    reduced = [field.from_dict({e: int(c) % 1009 for e,c in
                                                poly.evaluate(axis,number).items()})
                               for poly in pair]
                    if (degrees == [poly.degree() for poly in reduced] and
                            reduced[0].gcd(reduced[1]).monic() == field.one):
                        break
                else:
                    raise AssertionError('no degree-preserving coprime fibre')
                print(f'moving={moving_ratio}, primitive={primitive}, '
                      f'{axis}={number}, degrees {degrees}, gcd 1',flush=True)


if __name__ == '__main__':
    verify()
