import Mathlib.Tactic

namespace OpposingPairWindow

/-- Eliminate the cube of the triangle distance ratio in the marked derivative. -/
theorem ratio_cube {K : Type*} [Field K] (r t q : K) (hd : t + 1 ≠ 0)
    (ht : t ≠ 0) (hr : r^2 * (t+1) * (t+q) = t) :
    (1+q/t)*r^3 = r/(1+t) := by
  have h' : 1 + t ≠ 0 := add_comm 1 t ▸ hd
  field_simp [ht,h']
  linear_combination r * hr

/-- A centered trial with rank spacing one twelfth has bounded squared displacement. -/
theorem rank_cost : (∑ i ∈ Finset.range 5, (1+(i:ℚ)/12)^2) = 55/8 := by
  norm_num [Finset.sum_range_succ]

/-- From the energy, center of mass and marked potential estimates, get an upper bound. -/
theorem marked_upper (t H E P Q : ℝ) (ht : 0 < t) (hH : H = P + Q/2)
    (hU : t*P ≤ E) (hC : t*(t+5)*Q ≤ 5*E) :
    2*t*(t+5)*H ≤ (2*t+15)*E := by
  rw [hH]
  nlinarith [mul_nonneg (le_of_lt (show 0 < t+5 by positivity)) (sub_nonneg.mpr hU)]

end OpposingPairWindow
