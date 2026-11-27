import Mathlib.Tactic

namespace QuartetTorque88

def phi {K : Type*} [CommRing K] (a b c d : K) : K :=
  ((a+b-c-d)^2-4*a*b-4*c*d)^2-64*a*b*c*d

/-- The square-root torque gives a quartic in its four signed squared terms. -/
theorem norm_vanishes {K : Type*} [CommRing K] {a b c d : K} (h : a+b+c+d=0) :
    phi (a^2) (b^2) (c^2) (d^2)=0 := by
  have hd : d=-(a+b+c) := eq_neg_of_add_eq_zero_left (by linear_combination h)
  rw [hd]
  unfold phi
  ring

/-- Compatibility of two affine rows in the distinguished mass. -/
theorem eliminate_mass {K : Type*} [CommRing K] {c d e f t : K}
    (hc : c+t*d=0) (he : e+t*f=0) : c*f-e*d=0 := by
  linear_combination f*hc-d*he

/-- The bipolar parameters generate both signed side-length identities
after multiplication by the square of their common denominator. -/
theorem bipolar_lengths {K : Type*} [CommRing K] (a b : K) :
    (b*(a^2-1))^2+(2*a*b)^2=(b*(a^2+1))^2 ∧
    (b*(a^2-1)-(a-b)*(a*b+1))^2+(2*a*b)^2=(a*(b^2+1))^2 := by
  constructor <;> ring

#print axioms norm_vanishes
#print axioms bipolar_lengths
end QuartetTorque88
