import Mathlib.Data.Complex.Basic
import Mathlib.Tactic

/-!
# Algebra for the outer triple of diagram 93

The squared distance ratios have leading coefficients in ℂ, while b and c
are positive masses. The first two lemmas give a denominator-free lower
bound for the squared norm of (b+c)(b+qc)/(bc), for any cube root q of 1.
The third identifies the missing W-equation residual using a normalized
outer W-equation. The last rules out a purely imaginary nonzero multiple of
a sixth root being another sixth root.

The identification of the parameters with limits of solutions, the torque
estimates, the classification of signed sums, and any exclusion of
degenerations are outside the statements of this file.
-/

namespace Diagram93Algebra

theorem cubeRoot_data {q : ℂ} (hq : q ^ 3 = 1) :
    -1 ≤ 2 * q.re ∧ q.re ^ 2 + q.im ^ 2 = 1 := by
  have prod : (q-1) * (q^2+q+1) = 0 := by linear_combination hq
  rcases mul_eq_zero.mp prod with e | e
  · have h : q = 1 := sub_eq_zero.mp e
    subst q
    norm_num
  · have hr := congrArg Complex.re e
    have hi := congrArg Complex.im e
    simp [pow_two, Complex.mul_re] at hr
    simp [pow_two, Complex.mul_im] at hi
    have prodIm : q.im * (2*q.re+1) = 0 := by linarith
    rcases mul_eq_zero.mp prodIm with him | hreal
    · rw [him] at hr
      nlinarith [sq_nonneg (q.re + 1/2)]
    · constructor <;> nlinarith

theorem squaredRatio_bound {b c : ℝ} (hb : 0 < b) (hc : 0 < c)
    {q : ℂ} (hq : q ^ 3 = 1) :
    4*b^2*c^2 ≤ (b+c)^2 * Complex.normSq ((b : ℂ) + q*(c : ℂ)) := by
  obtain ⟨hr, hn⟩ := cubeRoot_data hq
  have normIdentity : Complex.normSq ((b : ℂ) + q*(c : ℂ)) =
      b^2+2*b*c*q.re+c^2 := by
    simp [Complex.normSq_apply, Complex.mul_re, Complex.mul_im]
    linear_combination c^2 * hn
  rw [normIdentity]
  have lower : b^2-b*c+c^2 ≤ b^2+2*b*c*q.re+c^2 := by
    nlinarith [mul_nonneg (mul_nonneg hb.le hc.le) (show 0 ≤ 2*q.re+1 by linarith)]
  have correction : 0 ≤ (b-c)^2 * (b^2+3*b*c+c^2) := by positivity
  calc
    4*b^2*c^2 ≤ (b+c)^2*(b^2-b*c+c^2) := by nlinarith [correction]
    _ ≤ _ := mul_le_mul_of_nonneg_left lower (sq_nonneg _)

theorem outerResidual {a b c A B q δ W : ℂ} (hb : b ≠ 0)
    (hZ : 1 = a*A+(b+c)*B)
    (hW : W+δ = a*A*δ + c*B*(δ+q*c*δ/b)) :
    W - (b*A*(-δ)+c*A*(q*c*δ/b)) = (A-B)*(b-q*c^2/b)*δ := by
  field_simp [hb] at hW ⊢
  linear_combination hW - b*δ*hZ

theorem imaginaryMultiple_notSixthRoot {u : ℂ} (hu : u^6 = 1) (r : ℝ) :
    (Complex.I*(r : ℂ)*u)^6 ≠ 1 := by
  intro h
  have hi : Complex.I ^ 6 = -1 := by
    rw [show 6 = 2*3 by decide, pow_mul, Complex.I_sq]
    norm_num
  rw [mul_pow, mul_pow, hu, hi] at h
  have hr := congrArg Complex.re h
  simp [← Complex.ofReal_pow] at hr
  nlinarith [sq_nonneg (r^3)]

#print axioms cubeRoot_data
#print axioms squaredRatio_bound
#print axioms outerResidual
#print axioms imaginaryMultiple_notSixthRoot

end Diagram93Algebra
