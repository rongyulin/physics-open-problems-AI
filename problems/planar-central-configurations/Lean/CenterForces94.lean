import Mathlib.Tactic

namespace Diagram94

/-- Remove the unknown center ordinate and multiplier from one outer force equation. -/
theorem center_residual {K : Type*} [Field K]
    (v t r a b y c : K) (hx : v = t*r^3+a)
    (hy : v*(y+c) = t*r^3*y+b) :
    b-a*y = v*c := by
  linear_combination y*hx-hy

/-- If a center cube differs from its reference value, this geometry pins the mass. -/
theorem mass_from_distinct_center_cube {K : Type*} [Field K]
    (v t r a₁ a₂ : K) (hx₁ : v = t+a₁) (hx₂ : v = t*r^3+a₂)
    (hr : r^3 ≠ 1) : t = (a₂-a₁)/(1-r^3) := by
  apply (eq_div_iff (sub_ne_zero.mpr (Ne.symm hr))).2
  linear_combination hx₂-hx₁

end Diagram94
