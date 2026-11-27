import IsoMatrixBound
import I3322Scalar
import IsoPhases
import IsoExperiment
import IsoReduction

/-! # The I3322 local bound and exact maximum for noisy maximally entangled qutrits

The state is an explicit density matrix of order nine. Each of the six outcome-one
effects is positive and bounded by the identity. The complementary effect is I−E.
All scores use the Born rule. The theorem `maximum` states both the upper bound
and attainment; `conjecture_one` is the question in Ito–Imai–Avis (2006). -/
namespace IsotropicI3322
open IsoBell IsoExperiment BellIsoPhases
noncomputable section

private theorem upper (α : ℝ) (h0 : 0≤α) (h1 : α≤1) (A B : Triple 3)
    (ha : ∀ i, Effect (A i)) (hb : ∀ i, Effect (B i)) : score 3 α A B ≤ V α := by
  obtain ⟨P,Q,hP,hQ,hs⟩ := projectivize 3 α A B ha hb
  obtain ⟨r,s,u,v,j,k,x,y,z,w,hx,hy,hz,hw,hxz,hyw,hbnd⟩ :=
    IsoMatrixBound.projector_bound α h0 P Q hP hQ
  have hh := IsoScalar.envelope r s u v j k x y z w hx hy hz hw hxz hyw
    α BellIsoOpt.H h0 h1 BellIsoOpt.half_le (fun a b c d ha hb hc hd hp hq =>
      BellIsoOpt.upper a b c d ⟨ha,hb,hc,hd,hp,hq⟩)
  have hn : 0≤V α := le_max_left _ _
  have hc : c α ≤ V α := (le_max_left _ _).trans (le_max_right _ _)
  have hd : d α ≤ V α := (le_max_right _ _).trans (le_max_right _ _)
  have hm : max 0 (max (3*α*(Real.sqrt 2-1)-4*(1-α)) (3*α*BellIsoOpt.H-7*(1-α))) ≤ 9*V α := by
    apply max_le (by linarith only [hn])
    apply max_le
    · unfold c at hc; linarith only [hc]
    · unfold d at hd; linarith only [hd]
  linarith only [hs,hbnd,hh,hm]

private theorem max_mem {S : Set ℝ} {a b : ℝ} (ha : a ∈ S) (hb : b ∈ S) : max a b ∈ S := by
  rcases le_total a b with h|h
  · simpa only [max_eq_right h] using hb
  · simpa only [max_eq_left h] using ha

theorem maximum (α : ℝ) (hl : 0 ≤ α) (hu : α ≤ 1) :
    IsGreatest (IsoExperiment.values α) (BellIsoPhases.V α) := by
  constructor
  · apply max_mem (zero_attained α)
    apply max_mem
    · have h := from_projectors α IsoWitness.alice IsoWitness.bob IsoWitness.alice_proj IsoWitness.bob_proj
      simpa only [IsoWitness.attained,c] using h
    · obtain ⟨x,y,z,w,hf,he⟩ := BellIsoOpt.attain
      have h := from_projectors α _ _ (IsoWitness.a3_proj x z hf.2.2.2.2.1)
        (IsoWitness.b3_proj y w hf.2.2.2.2.2)
      rw [IsoWitness.third_attained] at h
      change -2+x+x*y+z+w=BellIsoOpt.H at he
      rw [he] at h
      convert h using 1 <;> unfold d <;> ring
  · rintro v ⟨A,B,ha,hb,rfl⟩
    rw [observed_eq _ _ _ ha hb]
    exact upper _ hl hu _ _ ha hb

/-- Conjecture 1 in the authors' exact normalization, with all six physical effects. -/
theorem conjecture_one (A B : Triple 3) (ha : ∀ i, Effect (A i)) (hb : ∀ i, Effect (B i)) :
    observed (isotropic 3 (4/(1+3*Real.sqrt 2))) A B ≤ 0 := by
  have h := (maximum α0 ordered.1.le (ordered.2.1.trans ordered.2.2).le).2
    (show observed (isotropic 3 α0) A B ∈ values α0 from ⟨A,B,ha,hb,rfl⟩)
  rwa [low (le_refl α0)] at h

theorem violation_iff (α : ℝ) (hl : 0 ≤ α) (hu : α ≤ 1) :
    (∃ s ∈ values α, 0<s) ↔ 4/(1+3*Real.sqrt 2) < α := by
  have h := maximum α hl hu
  constructor
  · rintro ⟨s,hs,hpos⟩
    exact (V_pos_iff α).mp (hpos.trans_le (h.2 hs))
  · intro hpos
    exact ⟨_,h.1,(V_pos_iff α).mpr hpos⟩

#print axioms conjecture_one
#print axioms maximum
#print axioms violation_iff
end
end IsotropicI3322
