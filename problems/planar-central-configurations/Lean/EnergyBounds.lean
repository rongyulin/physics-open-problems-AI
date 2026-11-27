import Mathlib.Tactic

/-! Real scalar inequalities for the regular-vertex case of six-body diagram 93.
The inputs specify the bounds obtained from the limiting complex triangle and
the physical variational identity. Norms, the Jensen step, the Puiseux limits,
and the algebraic genericity argument are derived in the accompanying text. -/

namespace SixBodyEnergyBounds

/-- The elementary maximum gives t^(3/2)/(1+t)^2 < 1/3. -/
theorem mass_ratio {t r : ℝ} (ht : 0 < t)
    (hr : r^2*(t+1)^4=t^3) : r < 1/3 := by
  have hf : 0 ≤ (t-3)^2*(27*t^2+14*t+3) := by positivity
  have gap : 9*t^3 < (t+1)^4 := by nlinarith [pow_pos ht 3]
  by_contra! h
  have hsq := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 1/3) h 2
  have hprod := mul_le_mul_of_nonneg_right hsq (by positivity : 0 ≤ (t+1)^4)
  nlinarith

theorem triangle_factor {r f : ℝ} (hr : 0 ≤ r) (h : r ≤ 1/3)
    (hf : f^3 ≤ (1+r)^2) : f < 5/4 := by
  have hs := pow_le_pow_left₀ (by positivity : 0 ≤ 1+r) (show 1+r ≤ 4/3 by linarith) 2
  by_contra! g
  have hc := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 5/4) g 3
  nlinarith

theorem unit_triangle {B : ℝ} (hb : B^3 ≤ 9) : B < 21/10 := by
  by_contra! h
  have hc := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 21/10) h 3
  nlinarith

/-- Jensen and the two limiting cluster bounds are incompatible for 0<t≤32. -/
theorem regular_medium {t A B U d : ℝ} (ht : 0 < t) (ht32 : t ≤ 32)
    (hU : 0 < U) (hd : d^3=t+5)
    (hLower : 5*(t+2) ≤ d*U)
    (hA : A ≤ (5/4)*(t+1)) (hB : B^3 ≤ 9) : A+B < U := by
  have hb := unit_triangle hB
  by_cases hs : t ≤ 2
  · have hu : d < 2 := by
      by_contra! hh
      have hc := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 2) hh 3
      nlinarith
    have hprod := mul_lt_mul_of_pos_right hu hU
    linarith
  · have hu : d < 10/3 := by
      by_contra! hh
      have hc := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 10/3) hh 3
      nlinarith
    have hprod := mul_lt_mul_of_pos_right hu hU
    linarith

/-- If k=(t+1)g³ then |k|²(t+1)(t-1)³≤t³. -/
theorem coupling_small {t k : ℝ} (ht : 32 ≤ t)
    (h : k^2*((t+1)*(t-1)^3) ≤ t^3) : k < 1/5 := by
  obtain ⟨s, hs, rfl⟩ := le_iff_exists_nonneg_add.mp ht
  have hp : 25*(32+s)^3 < (32+s+1)*(32+s-1)^3 := by
    rw [← sub_pos]
    ring_nf
    positivity
  by_contra! hcontra
  have hsq := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 1/5) hcontra 2
  have hpos : 0 ≤ (32+s+1)*(32+s-1)^3 := by
    have : 0 ≤ 32+s-1 := by linarith
    positivity
  have hm := mul_le_mul_of_nonneg_right hsq hpos
  nlinarith

theorem logarithmic_error {k e : ℝ} (hk : k < 1/5)
    (he : e*(1-k) ≤ 1/31+k/3) : e < 1/8 := by
  by_contra! h
  have hm := mul_le_mul_of_nonneg_right h (by linarith : 0 ≤ 1-k)
  linarith

/-- |A|>(t-1)(4/5) proves a uniform separation from the bounded inner energy. -/
theorem large_cluster {t A B : ℝ} (ht : 32 ≤ t)
    (hA : (t-1)*(4/5) < A) (hB : B^3 ≤ 9) : 24 < A ∧ B < A/10 := by
  have hb := unit_triangle hB
  constructor <;> linarith

/-- D denotes the modulus of t times the derivative of the candidate energy. -/
theorem derivative_lower {A B D E : ℝ} (hE : 0 < E)
    (hB : B < A/10) (hD : 7*A/8 < D) (hSum : E ≤ A+B) : 35/44 < D/E := by
  apply (lt_div_iff₀ hE).mpr
  linarith

/-- Upper bound on a physical branch from the inverse distances of the marked
body and its share of the inertia, after dividing by the positive energy. -/
theorem derivative_upper {t v h d : ℝ} (ht : 32 ≤ t)
    (hv : v ≤ 1) (hh : (t+5)*h ≤ 5) (hd : 3*d=2*v+h) : d < 3/4 := by
  have h1 : h < 1/4 := by
    by_contra! h0
    have hp := mul_le_mul_of_nonneg_left h0 (by linarith : 0 ≤ t+5)
    linarith
  linarith

theorem slope_contradiction {s : ℝ} (h : 35/44 < s) (h' : s < 3/4) : False := by
  linarith

#print axioms mass_ratio
#print axioms regular_medium
#print axioms coupling_small
#print axioms derivative_upper

/-- Weighted energy bound for any finite pair list. Here d³ is the total mass,
and the two sum hypotheses express the normalization U=I=E. -/
theorem physical_energy_lower {ι : Type*} (pairs : Finset ι) (weight radius : ι → ℝ)
    {d E : ℝ} (hd : 0 < d) (hw : ∀ i ∈ pairs, 0 ≤ weight i)
    (hr : ∀ i ∈ pairs, 0 < radius i)
    (hI : ∑ i ∈ pairs, weight i * (radius i)^2 = d^3 * E)
    (hU : ∑ i ∈ pairs, weight i / radius i = E) :
    (∑ i ∈ pairs, weight i) ≤ d * E := by
  have single (i : ι) (hi : i ∈ pairs) :
      3*d^2*weight i ≤ weight i*(radius i)^2 + (2*d^3)*(weight i/radius i) := by
    have gap : (3*d^2-(radius i)^2)*radius i ≤ 2*d^3 := by
      nlinarith [mul_nonneg (sq_nonneg (radius i-d)) (show 0 ≤ radius i+2*d by linarith [hr i hi])]
    have bound := (le_div_iff₀ (hr i hi)).mpr gap
    have multiplied := mul_le_mul_of_nonneg_right bound (hw i hi)
    calc
      3*d^2*weight i ≤ weight i*(radius i)^2 + (2*d^3/radius i)*weight i := by
        nlinarith only [multiplied]
      _ = _ := by ring
  have total := Finset.sum_le_sum single
  simp only [Finset.sum_add_distrib, ← Finset.mul_sum, hI, hU] at total
  apply (mul_le_mul_iff_right₀ (show 0 < 3*d^2 by positivity)).mp
  calc
    3*d^2 * (∑ i ∈ pairs, weight i) ≤ d^3*E + 2*d^3*E := total
    _ = 3*d^2*(d*E) := by ring

/-- Energy at the partially circled triple, after removing its common scale. -/
theorem triangle_energy_identity {a b c q g p : ℂ}
    (hN : p^3*(a+(b+c)*g^3) = 1)
    (hD : g^2*(b+c)*(b+q*c) = b*c) :
    (p*(a*(b+q*c)+b*c*g))*p^2 = b+q*c := by
  linear_combination (b+q*c)*hN - p^3*g*hD

#print axioms physical_energy_lower
#print axioms triangle_energy_identity
end SixBodyEnergyBounds
