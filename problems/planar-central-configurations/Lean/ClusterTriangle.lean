import Mathlib.Tactic

/-!
At the all-unit point of any positive cluster-mass specialization, the
two equations of Tomar, Lemma 9.11, have no common complex root. This
file checks the polynomial obstruction. Reading off the two cluster
weights from the coordinate trees is done by the accompanying verifier.
-/

namespace ClusterTriangle

def obstruction {K : Type*} [CommRing K] (r : K) : K :=
  r^6 + 3*r^5 + 33*r^4 + 61*r^3 + 33*r^2 + 3*r + 1

theorem commonRoot {K : Type*} [CommRing K] {r x : K}
    (hx : x^3 = r) (hy : (1+r)*(1+x)^3 = r) : obstruction r = 0 := by
  let a := 1+r+r^2
  let b := 3*(1+r)
  have hsum : a + b*x + b*x^2 = 0 := by
    dsimp [a,b]
    linear_combination hy - (1+r)*hx
  have cubic : a^3 + (b*x)^3 + (b*x^2)^3 - 3*a*(b*x)*(b*x^2) = 0 := by
    linear_combination (a^2 + (b*x)^2 + (b*x^2)^2 - a*(b*x) - a*(b*x^2) - (b*x)*(b*x^2))*hsum
  have h6 : x^6 = r^2 := by rw [show 6=3*2 by decide, pow_mul, hx]
  have eq : a^3 + b^3*x^3 + b^3*x^6 - 3*a*b^2*x^3 = 0 := by
    linear_combination cubic
  rw [h6,hx] at eq
  dsimp [a,b] at eq
  unfold obstruction
  linear_combination eq

theorem noCommonRoot {r : ℝ} (hr : 0 < r) :
    ¬ ∃ x : ℂ, x^3 = (r : ℂ) ∧ (1+(r : ℂ))*(1+x)^3 = (r : ℂ) := by
  rintro ⟨x,hx,hy⟩
  have h := commonRoot hx hy
  unfold obstruction at h
  have hz : r^6 + 3*r^5 + 33*r^4 + 61*r^3 + 33*r^2 + 3*r + 1 = 0 := by
    exact_mod_cast h
  have hp : 0 < r^6 + 3*r^5 + 33*r^4 + 61*r^3 + 33*r^2 + 3*r + 1 := by positivity
  linarith

theorem noCommonRootForClusters {A B : ℝ} (hA : 0 < A) (hB : 0 < B) :
    ¬ ∃ x : ℂ, (A : ℂ)*x^3 = (B : ℂ) ∧ ((A : ℂ)+B)*(1+x)^3 = (B : ℂ) := by
  rintro ⟨x,hx,hy⟩
  have ha : (A : ℂ) ≠ 0 := by exact_mod_cast ne_of_gt hA
  apply noCommonRoot (div_pos hB hA)
  refine ⟨x, ?_, ?_⟩
  · push_cast
    apply (eq_div_iff ha).mpr
    simpa [mul_comm] using hx
  · push_cast
    field_simp [ha]
    linear_combination hy

/-- Two complex numbers with positive real cubes and a positive real difference
must both lie on the positive real axis. -/
theorem positiveAxis {z : ℂ} {a u v : ℝ} (ha : 0 < a) (hu : 0 < u)
    (hv : 0 < v) (hz : z^3 = (u : ℂ)) (hs : (z+(a : ℂ))^3 = (v : ℂ)) :
    z.im = 0 ∧ 0 < z.re := by
  have real_cube (w : ℂ) : (w^3).re = w.re^3 - 3*w.re*w.im^2 := by
    simp [pow_succ, Complex.mul_re, Complex.mul_im]
    ring
  have imag_cube (w : ℂ) : (w^3).im = 3*w.re^2*w.im - w.im^3 := by
    simp [pow_succ, Complex.mul_re, Complex.mul_im]
    ring
  have hzr := congrArg Complex.re hz
  have hzi := congrArg Complex.im hz
  have hsr := congrArg Complex.re hs
  have hsi := congrArg Complex.im hs
  simp only [real_cube, imag_cube, Complex.add_re, Complex.add_im,
    Complex.ofReal_im, Complex.ofReal_re, add_zero] at hzr hzi hsr hsi
  have prod : (3*a) * z.im * (2*z.re+a) = 0 := by linear_combination hsi - hzi
  have h0 : z.im = 0 := by
    by_contra hn
    have hr := (mul_eq_zero.mp prod).resolve_left (mul_ne_zero (by positivity) hn)
    have factor : u+v = (2*z.re+a)*(z.re^2+a*z.re+a^2-3*z.im^2) := by
      linear_combination -hzr - hsr
    rw [hr,zero_mul] at factor
    linarith
  refine ⟨h0, ?_⟩
  rw [h0] at hzr
  by_contra! h
  have h3 : z.re^3 ≤ 0 := by
    simpa [pow_succ] using mul_nonpos_of_nonneg_of_nonpos (sq_nonneg z.re) h
  nlinarith

/-- The real positive-root equations from Lemma 9.11 require a strictly
smaller central mass than either of the two balanced masses. -/
theorem smallerCenter {a b s A B k : ℝ} (ha : 0 < a) (hb : 0 < b) (hs : 0 < s)
    (hA : 0 < A) (hB : 0 < B) (hk : 0 < k)
    (hk3 : A*b*k^3 = B*a)
    (heq : s^2*(A+B)*(a+b*k)^3 = a^3*b^2*B) : s < a ∧ s < b := by
  have positive_correction : 0 < (a+b*k)^3 - a^3 - (b*k)^3 := by
    ring_nf
    positivity
  constructor
  · by_contra! h
    have hsa : 0 ≤ s^2-a^2 := by nlinarith [mul_nonneg (sub_nonneg.mpr h) (show 0 ≤ s+a by positivity)]
    have hp : 0 < s^2*(A+B)*(a+b*k)^3 - a^2*A*b^3*k^3 := by
      nlinarith only [show 0 < s^2*(A+B)*((a+b*k)^3-a^3-(b*k)^3) by positivity,
                      show 0 < s^2*(A+B)*a^3 by positivity,
                      show 0 < s^2*B*b^3*k^3 by positivity,
                      show 0 ≤ (s^2-a^2)*A*b^3*k^3 by positivity]
    have heq' : s^2*(A+B)*(a+b*k)^3 - a^2*A*b^3*k^3 = 0 := by
      linear_combination heq - a^2*b^2*hk3
    linarith
  · by_contra! h
    have hsb : 0 ≤ s^2-b^2 := by nlinarith [mul_nonneg (sub_nonneg.mpr h) (show 0 ≤ s+b by positivity)]
    have hp : 0 < s^2*(A+B)*(a+b*k)^3 - a^3*b^2*B := by
      nlinarith only [show 0 < s^2*(A+B)*((a+b*k)^3-a^3-(b*k)^3) by positivity,
                      show 0 < s^2*(A+B)*(b*k)^3 by positivity,
                      show 0 < s^2*A*a^3 by positivity,
                      show 0 ≤ (s^2-b^2)*B*a^3 by positivity]
    linarith

theorem strictCenterOfComplex {a b s A B : ℝ} {k : ℂ}
    (ha : 0 < a) (hb : 0 < b) (hs : 0 < s) (hA : 0 < A) (hB : 0 < B)
    (h1 : (A:ℂ)*b*k^3 = B*a)
    (h2 : (s:ℂ)^2*(A+B)*(a+b*k)^3 = a^3*b^2*B) : s < a ∧ s < b := by
  -- Both b*k and a+b*k have positive real cubes.
  let u : ℝ := b^2*B*a/A
  let v : ℝ := a^3*b^2*B/(s^2*(A+B))
  have hu : 0 < u := by dsimp [u]; positivity
  have hv : 0 < v := by dsimp [v]; positivity
  have hA' : (A:ℂ) ≠ 0 := by exact_mod_cast ne_of_gt hA
  have hd : ((s:ℂ)^2*((A:ℂ)+B)) ≠ 0 := by
    exact_mod_cast (show s^2*(A+B) ≠ 0 by positivity)
  have hcu : ((b:ℂ)*k)^3 = (u:ℂ) := by
    dsimp [u]
    push_cast
    apply (eq_div_iff hA').mpr
    linear_combination (b:ℂ)^2*h1
  have hcv : ((b:ℂ)*k+a)^3 = (v:ℂ) := by
    dsimp [v]
    push_cast
    apply (eq_div_iff hd).mpr
    linear_combination h2
  obtain ⟨him, hre⟩ := positiveAxis ha hu hv hcu hcv
  simp only [Complex.mul_im, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im,
    zero_mul, sub_zero, add_zero] at him hre
  have him0 := (mul_eq_zero.mp him).resolve_left (ne_of_gt hb)
  have hk : 0 < k.re := (mul_pos_iff_of_pos_left hb).mp hre
  have hc : (k.re : ℂ) = k := by
    apply Complex.ext <;> simp [him0]
  rw [← hc] at h1 h2
  apply smallerCenter ha hb hs hA hB hk
  · exact_mod_cast h1
  · exact_mod_cast h2

#print axioms strictCenterOfComplex
#print axioms positiveAxis
#print axioms smallerCenter
#print axioms commonRoot
#print axioms noCommonRootForClusters
end ClusterTriangle
