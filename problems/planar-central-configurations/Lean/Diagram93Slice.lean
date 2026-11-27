import Mathlib.Tactic

/-!
Scalar algebra in the first-order outer force test for diagram 93.
Here x is the normalized variation of the special z-coordinate and y is
the variation of its w-coordinate relative to the regular pair's midpoint,
divided by the finite nonzero limiting half-separation. The analytic
linearization, mass/shape input and the census are documented separately.
-/
namespace Diagram93Slice

noncomputable def determinant (t u : ℂ) : ℂ :=
  1 + t*u/2 + u*(1-4*t*u)*(1+t/2)

theorem determinant_annihilates {t u x y : ℂ}
    (A : x + u*(1+t/2)*x + 3*u*y/2 = 0)
    (B : (1+t*u/2)*y + 3*t*u*(1+t/2)*x = 0) :
    determinant t u * x = 0 := by
  unfold determinant
  linear_combination (1+t*u/2)*A - 3*u/2*B

theorem plus_determinant {t u : ℂ} (h : (4*t+1)*u=4) :
    (4*t+1)^2 * determinant t u = 5-36*t := by
  unfold determinant
  linear_combination ((-8*t^3-18*t^2-4*t)*u - 4*t^2 - 11*t + 1)*h

theorem minus_determinant {t u : ℂ} (h : (4*t-1)*u=4) :
    (4*t-1)^2 * determinant t u = -3*(20*t+1) := by
  unfold determinant
  linear_combination ((-8*t^3-14*t^2+4*t)*u - 4*t^2 - 13*t - 1)*h

#print axioms determinant_annihilates
#print axioms plus_determinant
#print axioms minus_determinant
end Diagram93Slice
