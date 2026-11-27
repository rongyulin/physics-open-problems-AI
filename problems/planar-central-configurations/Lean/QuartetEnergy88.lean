import Mathlib.Tactic

namespace QuartetEnergy88

/-- A polynomial certificate for comparing the sum of two nonnegative cube roots. -/
theorem separated (x y z : ℝ) (hx : 0 ≤ x) (hy : 0 ≤ y) (hz : 0 ≤ z)
    (hc : 27*z^3*x^3*y^3 < (z^3-x^3-y^3)^3) : x+y < z := by
  by_contra! h
  have hq : 0 ≤ z^2+z*x+z*y+x^2-x*y+y^2 := by
    nlinarith [sq_nonneg (x-y), sq_nonneg x, sq_nonneg y,
      sq_nonneg z, mul_nonneg hz hx, mul_nonneg hz hy]
  have hr : z^3-x^3-y^3 ≤ 3*z*x*y := by
    nlinarith [mul_nonpos_of_nonpos_of_nonneg (sub_nonpos.mpr h) hq]
  let a := z^3-x^3-y^3
  let b := 3*z*x*y
  have hsum : 0 ≤ a^2+a*b+b^2 := by
    nlinarith [sq_nonneg (a+b), sq_nonneg a, sq_nonneg b]
  have hr' : a-b ≤ 0 := sub_nonpos.mpr hr
  have hcube : a^3 ≤ b^3 := by
    nlinarith [mul_nonpos_of_nonpos_of_nonneg hr' hsum]
  dsimp [a,b] at hcube
  nlinarith

/-- Costs of the endpoint and interior angle-chamber trial layouts. -/
theorem trial_costs (g : ℝ) :
    1 + (1+g)^2 + (1+2*g)^2 = 3+6*g+5*g^2 ∧ 1+(1+g)+(1+2*g) = 3*(1+g) := by
  constructor <;> ring

end QuartetEnergy88
