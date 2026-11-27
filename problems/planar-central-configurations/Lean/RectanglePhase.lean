import Mathlib.Tactic

/-!
Algebraic contradictions for the positions and distance phases of the
rectangle cells. The identification with a singular place is proved in the
accompanying mathematical notes.
-/

namespace RectanglePhase

theorem opposite_position_mass {K : Type*} [Field K] {t z : K}
    (hz : z ≠ 0) (balance : t*z + (-z) = 0) : t = 1 := by
  have h : (t-1)*z = 0 := by linear_combination balance
  exact sub_eq_zero.mp ((mul_eq_zero.mp h).resolve_right hz)

theorem incompatible_phase {K : Type*} [Field K] [CharZero K] {k : K}
    (distance : k^2 = -1) (torque : k^3 = 1) : False := by
  have hk : k = -1 := by linear_combination k*distance - torque
  rw [hk] at distance
  norm_num at distance

/-- The real part of the leading energy equation, multiplied by two. -/
theorem central_mass_candidates {t k p q : ℝ} (ht : 0 < t)
    (hk : k = -1 ∨ k = 1) (hp : p = -4 ∨ p = 0 ∨ p = 4)
    (hq : q = -4 ∨ q = 0 ∨ q = 4) (energy : k + p + t*q = 0) :
    t = 1/4 ∨ t = 3/4 ∨ t = 5/4 := by
  rcases hk with rfl | rfl <;> rcases hp with rfl | rfl | rfl <;>
    rcases hq with rfl | rfl | rfl <;>
    first | left; linarith | right; left; linarith | right; right; linarith

#print axioms central_mass_candidates
#print axioms opposite_position_mass
#print axioms incompatible_phase

end RectanglePhase
