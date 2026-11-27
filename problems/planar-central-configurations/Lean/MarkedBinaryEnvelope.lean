import Mathlib.Tactic

/-!
Algebra used in the physical mass-derivative obstruction. The inputs in
`envelope_lower` are dimensionless quantities obtained by scaling by
(1+t)^{1/3}. Bounds on inertia and the inverse-distance sum enter as
hypotheses. The proof of convexity, the variational identity on algebraic
families, and the identification of binary leading terms are in the note.
-/
namespace MarkedBinaryEnvelope

theorem projection_constant :
    (8 : ℝ)*55*(77/12)^2 < 27^3 := by norm_num

theorem marked_range {t : ℝ} (ht : 0 < t) :
    (t+5)/(t+1) ≤ 5 := by
  apply (div_le_iff₀ (by linarith : 0 < t+1)).mpr
  linarith

/-- If dimensionless H were at most 3/2, both of its nonnegative
summands would separately satisfy the corresponding upper bounds, in
contradiction with Jensen's inequality and the inertia bound. -/
theorem envelope_lower {y q A H : ℝ} (hY : 0 ≤ y) (hQ : 0 < q)
    (hA : 0 ≤ A) (hU : H = q + y/2)
    (hI : A ≤ 27 + 5*y) (hJ : 125 ≤ q^2*A) : 3/2 < H := by
  by_contra! h
  have hy : y ≤ 3 := by linarith
  have hq : q ≤ 3/2 := by linarith
  have hsq : q^2 ≤ (3/2 : ℝ)^2 := by nlinarith [mul_nonneg (sub_nonneg.mpr hq) (show 0 ≤ 3/2+q by linarith)]
  have hprod := mul_le_mul hsq (show A ≤ 42 by linarith) hA (by positivity)
  nlinarith

theorem binary_product {b Z W t : ℂ} (hb : b^3*(1+t)=1)
    (hD : b^2*((1+t)*Z)*((1+t)*W)=1) :
    (1+t)*(Z*W)=b := by
  have hp : b * (1+t) ≠ 0 := by intro h; rcases mul_eq_zero.mp h with e|e <;> simp [e] at hb
  apply mul_left_cancel₀ (show b^2*(1+t) ≠ 0 by
    rcases mul_ne_zero_iff.mp hp with ⟨u,v⟩; exact mul_ne_zero (pow_ne_zero _ u) v)
  linear_combination hD - hb

theorem binary_factor_bound {t : ℝ} (ht : 0 < t) :
    1 + 1/(2*(1+t)) ≤ 3/2 := by
  have hp : 0 < 2*(1+t) := by positivity
  have h : (1:ℝ)/(2*(1+t)) ≤ 1/2 := (div_le_iff₀ hp).mpr (by linarith)
  linarith

#print axioms envelope_lower
#print axioms binary_product
end MarkedBinaryEnvelope
