"""An equal quartet with one zero ordinate, opposite a variable-mass binary."""
import argparse
from itertools import product
from math import prod

from flint import fmpz_poly
from EqualFibre88 import verify as verify_equal_cubes
from MixedZeroFibre88 import Quotient, integer_resultants, specialize


def verify(workers):
    polynomials = specialize(mass=1)
    first, second = integer_resultants(polynomials, workers, expected_degrees=(3850,3915))
    common = first.gcd(second)
    assert common.degree() == 3192
    radical = common // common.gcd(common.derivative())
    radical = radical // radical.content()
    if radical.leading_coefficient() < 0:
        radical = -radical
    factors = [fmpz_poly(a) for a in (
        [0,1],[-1,1],[1,1,1],[1,1],
        [-1,2,1,-2,1],[1,2,1,2,1],[-1,2,-1,-2,1])]
    assert radical.degree()==17 and radical==prod(factors,start=fmpz_poly([1]))
    # The first three factors violate r!=0 and r^3!=1. Symmetry gives the
    # same eliminant in s, so the other four factors give 16 product sectors.
    for p,q in product(factors[3:],repeat=2):
        Quotient(p,q,54).check(polynomials,mass=1)
    print("At unit quartet mass the three forces exclude all 16 distinct-cube sectors.")
    verify_equal_cubes(mass=1,single_row=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--workers',type=int,default=3)
    verify(parser.parse_args().workers)
