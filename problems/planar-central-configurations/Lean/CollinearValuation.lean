import Mathlib

/-! At a valuation ring, the poles of a complex signed collinear central
configuration cannot be supported by a cluster of nonzero unit mass. -/
namespace CollinearValuation
open Finset
open scoped BigOperators

variable {K J : Type*} [Field K] [CharZero K] [Fintype J] [DecidableEq J]

omit [Fintype J] [DecidableEq J] in
private theorem internal_force_cancel (a : J → J → K) (C : Finset J)
    (skew : ∀ i j, a i j = -a j i) : ∑ i ∈ C, ∑ j ∈ C, a i j = 0 := by
  have h : (∑ i ∈ C, ∑ j ∈ C, a i j) = -(∑ i ∈ C, ∑ j ∈ C, a i j) := by
    calc
      (∑ i ∈ C, ∑ j ∈ C, a i j) = ∑ i ∈ C, ∑ j ∈ C, -a j i := by
        exact sum_congr rfl (fun i _ => sum_congr rfl (fun j _ => skew i j))
      _ = -(∑ i ∈ C, ∑ j ∈ C, a i j) := by simp only [sum_neg_distrib]; rw [sum_comm]
  linear_combination (1/2 : K) * h

/-- This applies to every valuation ring containing the coefficient field,
including the local rings at the closed places of a smooth complete curve. -/
theorem coordinates_regular (O : Subring K)
    (inverse_regular : ∀ u : K, u ∉ O → u⁻¹ ∈ O)
    (x m : J → K) (s : J → J → K)
    (mass_regular : ∀ i, m i ∈ O) (sign_regular : ∀ i j, s i j ∈ O)
    (skew : ∀ i j, s i j = -s j i)
    (mass_unit : ∀ C : Finset J, C.Nonempty → (∑ i ∈ C, m i) ≠ 0 ∧ (∑ i ∈ C, m i)⁻¹ ∈ O)
    (balance : ∀ i, x i = ∑ j : J, s i j * m j * (x i - x j)⁻¹ ^ 2)
    (k : J) : x k ∈ O := by
  classical
  let C : Finset J := univ.filter (fun j => x j - x k ∈ O)
  have inside (j : J) : j ∈ C ↔ x j - x k ∈ O := by simp [C]
  have hk : k ∈ C := (inside k).mpr (by simp)
  obtain ⟨hm, hinv⟩ := mass_unit C ⟨k,hk⟩
  let a := fun i j => m i * (s i j * m j * (x i-x j)⁻¹ ^ 2)
  have hsk (i j : J) : a i j = -a j i := by
    dsimp [a]; conv_lhs => rw [skew i j, show x i - x j = -(x j - x i) by ring]
    rw [inv_neg]; ring
  have hforce (i j : J) (hi : i ∈ C) (hj : j ∉ C) : a i j ∈ O := by
    have hu : x i - x j ∉ O := by
      intro h; apply hj; apply (inside j).mpr
      convert O.sub_mem ((inside i).mp hi) h using 1; ring
    exact O.mul_mem (mass_regular i) (O.mul_mem (O.mul_mem (sign_regular i j) (mass_regular j)) (O.pow_mem (inverse_regular _ hu) _))
  have hb (i : J) : m i * x i = ∑ j, a i j := by
    conv_lhs => rw [balance i]; rw [Finset.mul_sum]
  have hsum : ∑ i ∈ C, m i * x i ∈ O := by
    have he : (∑ i ∈ C, m i * x i) = ∑ i ∈ C, ∑ j ∈ (univ \ C), a i j := calc
      (∑ i ∈ C, m i * x i) = ∑ i ∈ C, ∑ j, a i j := sum_congr rfl fun i _ => hb i
      _ = ∑ i ∈ C, ((∑ j ∈ C, a i j) + ∑ j ∈ (univ \ C), a i j) := by
        apply sum_congr rfl; intro i _
        rw [add_comm, sum_sdiff (subset_univ C)]
      _ = ∑ i ∈ C, ∑ j ∈ (univ \ C), a i j := by rw [sum_add_distrib, internal_force_cancel a C hsk, zero_add]
    rw [he]
    exact O.sum_mem (fun i hi => O.sum_mem (fun j hj => hforce i j hi (mem_sdiff.mp hj).2))
  have hd : (∑ i ∈ C, m i * (x i - x k)) ∈ O :=
    O.sum_mem (fun i hi => O.mul_mem (mass_regular i) ((inside i).mp hi))
  have hprod : (∑ i ∈ C, m i) * x k ∈ O := by
    convert O.sub_mem hsum hd using 1
    simp only [mul_sub, sum_sub_distrib, sum_mul]; ring
  have hh := O.mul_mem hinv hprod
  simpa [← mul_assoc, hm] using hh

/-- Every coordinate is integral over the coefficient ring after inverting
nonempty subset masses. No projective compactification is assumed here. -/
theorem coordinates_integral (R : Subring K) (x m : J → K) (s : J → J → K)
    (hm : ∀ i, m i ∈ R) (hs : ∀ i j, s i j ∈ R)
    (skew : ∀ i j, s i j = -s j i)
    (units : ∀ C : Finset J, C.Nonempty → (∑ i ∈ C, m i) ≠ 0 ∧ (∑ i ∈ C, m i)⁻¹ ∈ R)
    (balance : ∀ i, x i = ∑ j : J, s i j * m j * (x i - x j)⁻¹ ^ 2)
    (k : J) : IsIntegral R (x k) := by
  have hh := iInf_valuationSubring_superset (s := (R : Set K))
  rw [Subring.closure_eq] at hh
  change x k ∈ (integralClosure R K).toSubring
  rw [← hh, Subring.mem_iInf]
  intro V
  apply coordinates_regular V.1.toSubring (fun u hu => (V.1.mem_or_inv_mem u).resolve_left hu) x m s
  · exact fun i => V.2 (hm i)
  · exact fun i j => V.2 (hs i j)
  · exact skew
  · intro C hC
    exact ⟨(units C hC).1, V.2 (units C hC).2⟩
  · exact balance


/-- A solution over an extension of an algebraically closed coefficient field
already has all its coordinates in the coefficient field. -/
theorem coordinates_in_ground {F : Type*} [Field F] [IsAlgClosed F] [Algebra F K]
    (x : J → K) (m : J → F) (s : J → J → F)
    (skew : ∀ i j, s i j = -s j i)
    (nonresonant : ∀ C : Finset J, C.Nonempty → ∑ i ∈ C, m i ≠ 0)
    (balance : ∀ i, x i = ∑ j : J, algebraMap F K (s i j) * algebraMap F K (m j) * (x i-x j)⁻¹ ^ 2)
    (i : J) : x i ∈ (algebraMap F K).range := by
  let f := algebraMap F K
  let e := RingEquiv.ofBijective f.rangeRestrict ⟨f.rangeRestrict.injective, f.rangeRestrict_surjective⟩
  have hI := coordinates_integral f.range x (fun i => f (m i)) (fun i j => f (s i j))
    (fun i => ⟨m i,rfl⟩) (fun i j => ⟨s i j,rfl⟩) (fun i j => (congrArg f (skew i j)).trans (map_neg f _))
    (fun C hC => by rw [← map_sum]; exact ⟨f.injective.ne (nonresonant C hC) ∘ (·.trans f.map_zero.symm),
      ⟨_, map_inv₀ f _⟩⟩) balance i
  have hI' : IsIntegral F (x i) := (e.isIntegral_iff (by ext a; rfl) _).mpr hI
  exact minpoly.natDegree_eq_one_iff.mp ((IsAlgClosed.splits _).natDegree_eq_one_of_irreducible (minpoly.irreducible hI'))

open Filter in
/-- Finiteness of the explicitly stated signed scalar central-configuration
equations. Lean uses inverse(0)=0, so the set even includes collision tuples
satisfying that convention. The physical noncollision set is a subset. -/
theorem finite_signed_collinear [IsAlgClosed K]
    (m : J → K) (s : J → J → K) (skew : ∀ i j, s i j = -s j i)
    (nonresonant : ∀ C : Finset J, C.Nonempty → ∑ i ∈ C, m i ≠ 0) :
    {x : J → K | ∀ i, x i = ∑ j : J, s i j * m j * (x i-x j)⁻¹ ^ 2}.Finite := by
  classical
  let S := {x : J → K | ∀ i, x i = ∑ j : J, s i j * m j * (x i-x j)⁻¹ ^ 2}
  change S.Finite
  by_contra h
  letI : Infinite S := Set.infinite_coe_iff.mpr h
  let L : Filter S := hyperfilter S
  let E := Germ L K
  let G : (S → K) →+* E := Germ.coeRingHom L
  let f : K →+* E := G.comp (Pi.constRingHom S K)
  letI : Algebra K E := f.toAlgebra
  letI : CharZero E := Algebra.charZero_of_charZero K E
  let g : J → S → K := fun i a => a.val i
  let X : J → E := fun i => G (g i)
  have hbal (i : J) : X i = ∑ j, f (s i j) * f (m j) * (X i-X j)⁻¹ ^ 2 := by
    let c := Pi.constRingHom S K
    have eq : g i = ∑ j, c (s i j) * c (m j) * (g i - g j)⁻¹ ^ 2 := by
      funext a; rw [sum_apply]; exact a.property i
    calc
      X i = G (∑ j, c (s i j) * c (m j) * (g i - g j)⁻¹ ^ 2) := congrArg G eq
      _ = _ := by rw [map_sum]; apply sum_congr rfl; intro j _
                  rw [map_mul, map_mul, map_pow]; rfl
  have hbase (i : J) := coordinates_in_ground X m s skew nonresonant hbal i
  choose b hb using hbase
  have hsub : ∀ᶠ a : S in L, ∀ i, b i = a.val i := by
    apply eventually_all.mpr; intro i
    exact Germ.coe_eq.mp (hb i)
  have hf : {a : S | ∀ i, b i = a.val i}.Subsingleton := by
    intro a ha d hd; apply Subtype.ext; funext i; exact (ha i).symm.trans (hd i)
  exact notMem_hyperfilter_of_finite hf.finite hsub

/-- The direction of a signed inverse-square force for an unordered pair;
the opposite row receives the opposite signed force. -/
def signedPair {n : ℕ} (b : Fin n → Fin n → Bool) (i j : Fin n) : K :=
  if i < j then (if b i j then 1 else -1)
  else if j < i then -(if b j i then 1 else -1) else 0

omit [CharZero K] in
private theorem signedPair_skew {n : ℕ} (b : Fin n → Fin n → Bool) (i j : Fin n) :
    signedPair (K := K) b i j = -signedPair b j i := by
  rcases lt_trichotomy i j with h | rfl | h
  · simp [signedPair, h, not_lt.mpr (le_of_lt h)]
  · simp [signedPair]
  · simp [signedPair, h, not_lt.mpr (le_of_lt h)]

/-- Collision-free scalar positions admitted by some square-root sign sheet. -/
def sixBodyCollinear (t : K) : Set (Fin 6 → K) :=
  {x : Fin 6 → K | Function.Injective x ∧ ∃ b : Fin 6 → Fin 6 → Bool, ∀ i,
        x i = ∑ j, signedPair b i j * (if j = 5 then t else 1) * (x i - x j)⁻¹ ^ 2}

/-- The entire complex noncollision collinear fiber, with arbitrary signed
inverse distances, for five unit masses and a sixth (distinguished) mass.
The only excluded specializations are t = 0, -1, -2, -3, -4 and -5. -/
theorem six_body_line_finite [IsAlgClosed K] (t : K)
    (hn : ∀ l : ℕ, l ≤ 5 → t + (l : K) ≠ 0) :
    (sixBodyCollinear t).Finite := by
  unfold sixBodyCollinear
  classical
  let m : Fin 6 → K := fun j => if j = 5 then t else 1
  have hn' (C : Finset (Fin 6)) (hC : C.Nonempty) : ∑ j ∈ C, m j ≠ 0 := by
    by_cases h : (5 : Fin 6) ∈ C
    · rw [← add_sum_erase C _ h]
      have he (j : Fin 6) (hj : j ∈ C.erase 5) : m j = 1 := if_neg (ne_of_mem_erase hj)
      rw [sum_congr rfl he]; simp only [m, if_true, sum_const, nsmul_eq_mul, mul_one]
      apply hn; have hc : C.card ≤ 6 := Finset.card_le_univ C
      rw [card_erase_of_mem h]; omega
    · have he (j : Fin 6) (hj : j ∈ C) : m j = 1 := if_neg (by aesop)
      rw [sum_congr rfl he]; simpa using (Nat.cast_ne_zero.mpr (Finset.card_ne_zero.mpr hC) : (C.card : K) ≠ 0)
  let B := Fin 6 → Fin 6 → Bool
  let T (b : B) := {x : Fin 6 → K | ∀ i, x i = ∑ j, signedPair b i j * m j * (x i-x j)⁻¹ ^ 2}
  have hf : (⋃ b : B, T b).Finite := Set.finite_iUnion fun b => finite_signed_collinear m (signedPair b) (signedPair_skew b) hn'
  apply hf.subset
  rintro x ⟨_,b,hb⟩; exact Set.mem_iUnion.mpr ⟨b,hb⟩

/-- The actual function field specialization and its algebraic closure. -/
theorem generic_six_body_line_finite :
    (sixBodyCollinear (algebraMap (RatFunc ℚ) (AlgebraicClosure (RatFunc ℚ)) RatFunc.X)).Finite := by
  apply six_body_line_finite
  intro l _
  let f := algebraMap (RatFunc ℚ) (AlgebraicClosure (RatFunc ℚ))
  let g := algebraMap (Polynomial ℚ) (RatFunc ℚ)
  have hp : (Polynomial.X + (l : Polynomial ℚ)) ≠ 0 := by
    intro h
    have : (1 : ℚ) = 0 := by simpa using congrArg (fun p : Polynomial ℚ => p.coeff 1) h
    exact one_ne_zero this
  have hq := RatFunc.algebraMap_ne_zero hp
  have he : (RatFunc.X : RatFunc ℚ) + (l : RatFunc ℚ) ≠ 0 := by
    simpa [g, map_add, RatFunc.algebraMap_X] using hq
  simpa [f, map_add] using f.injective.ne he

/-- The complex fiber is finite at every positive real mass. -/
theorem positive_six_body_line_finite (t : ℝ) (ht : 0 < t) :
    (sixBodyCollinear (t : ℂ)).Finite := by
  apply six_body_line_finite
  intro l _
  exact_mod_cast (ne_of_gt (show 0 < t+(l:ℝ) by positivity))

#print axioms generic_six_body_line_finite
#print axioms positive_six_body_line_finite
end CollinearValuation
