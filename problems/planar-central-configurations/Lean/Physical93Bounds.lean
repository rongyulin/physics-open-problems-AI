import Mathlib.Tactic

/-! The physical lower bound U^3 ≥ S^3/M uses Jensen at a real configuration;
this file proves the incompatibility of the scalar bounds at the special vertex.
The nonnegative real variables x, y are upper bounds for |I_A|, |I_B|.
-/

namespace Physical93Bounds

theorem special_potential_gap {t x y U : ℝ} (ht : 0 < t)
    (hU : 0 < U)
    (hA : x^3 ≤ 8*(t+1/4)^2) (hB : y^3 ≤ 9)
    (hLower : (5*(t+2))^3 ≤ (t+5)*U^3) : x + y < U := by
  let k : ℝ := (t+2) ^ (2/3 : ℝ)
  have hk : 0 < k := Real.rpow_pos_of_pos (by linarith) _
  have hp : k^3 = (t+2)^2 := by
    dsimp [k]
    rw [← Real.rpow_natCast ((t+2) ^ (2 / 3 : ℝ)) 3, ← Real.rpow_mul (by linarith : 0 ≤ t+2)]
    norm_num
  have hX : x < 2*k := by
    by_contra! H
    have H3 := pow_le_pow_left₀ (by positivity : 0 ≤ 2*k) H 3
    nlinarith [hp]
  have hY : y < 3*k/2 := by
    by_contra! H
    have H3 := pow_le_pow_left₀ (by positivity : 0 ≤ 3*k/2) H 3
    nlinarith [hp, sq_nonneg t]
  have hZ : 7*k/2 < U := by
    by_contra! H
    have H3 := pow_le_pow_left₀ hU.le H 3
    have q := mul_le_mul_of_nonneg_left H3 (by linarith : 0 ≤ t+5)
    have p : 343*(t+5) < 1000*(t+2) := by linarith
    have m := mul_lt_mul_of_pos_left p (sq_pos_of_pos (by linarith : 0 < t+2))
    nlinarith [hp, show (t+5)*k^3 = (t+5)*(t+2)^2 by rw [hp]]
  linarith

#print axioms special_potential_gap
end Physical93Bounds
