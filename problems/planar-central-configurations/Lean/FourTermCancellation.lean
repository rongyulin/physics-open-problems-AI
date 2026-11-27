import Mathlib.Tactic

/-!
Elementary algebra used for the first-torque test on a fixed quartet.
The geometric reconstruction and the finite-shape input are in the note.
-/
namespace FourTermCancellation

theorem eliminant {K : Type*} [CommRing K] {a b c d : K}
    (h : a+b+c+d=0) :
    (((a^2+b^2-c^2-d^2)^2-4*(a*b)^2-4*(c*d)^2)^2 -
        64*(a*b*c*d)^2) = 0 := by
  have hd : d = -(a+b+c) := eq_neg_of_add_eq_zero_left (by linear_combination h)
  rw [hd]
  ring

theorem kite_dominance {r a b c : ℝ} (hr : 5 < r)
    (ha : a < 1) (hb : b < 1) (hc : c < 1) : a+b+c < r := by linarith

#print axioms eliminant
#print axioms kite_dominance
end FourTermCancellation
