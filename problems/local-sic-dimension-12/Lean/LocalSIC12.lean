import Mathlib.LinearAlgebra.Matrix.Rank
import Mathlib.LinearAlgebra.Matrix.Hermitian
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.Data.Complex.BigOperators
import Mathlib.Tactic.Ring
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic
import Mathlib.Analysis.Complex.Norm
import Mathlib.Tactic.NormNum.Irrational
import Mathlib.Data.ZMod.Basic
import Mathlib.RingTheory.RootsOfUnity.Complex
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity

/-! Standalone proof of nonexistence for the full local 144-ray orbit. Lean 4.28.0 with Mathlib v4.28.0. -/

/- Sections from Marginal.lean -/

section

/-! A 12-component pure state, written as a 4 by 3 coefficient matrix.
The reduced density matrix and its rank obstruction need no normalization hypothesis. -/
namespace SicMarginal

open scoped BigOperators Matrix ComplexConjugate
abbrev Pure := Matrix (Fin 4) (Fin 3) ℂ
abbrev Local := Matrix (Fin 4) (Fin 4) ℂ

noncomputable def density (F : Pure) : Local := F * Fᴴ

theorem density_apply (F : Pure) (i j : Fin 4) :
    density F i j = ∑ k, F i k * star (F j k) := by
  rfl

theorem density_isHermitian (F : Pure) : (density F).IsHermitian :=
  Matrix.isHermitian_mul_conjTranspose_self _

theorem density_rank_le (F : Pure) : (density F).rank ≤ 3 :=
  (Matrix.rank_mul_le_left F Fᴴ).trans F.rank_le_width

theorem density_det_zero (F : Pure) : (density F).det = 0 := by
  by_contra h
  have hunit : IsUnit (density F) := (density F).isUnit_iff_isUnit_det.mpr (isUnit_iff_ne_zero.mpr h)
  have hfull : (density F).rank = 4 := by
    simpa using (density F).rank_of_isUnit hunit
  have hsmall := density_rank_le F
  omega

theorem scaled_density_det_zero (F : Pure) (z : ℂ) : (z • density F).det = 0 := by
  simp [density_det_zero]

/-- Matrix-element expectation of a four-dimensional observable tensored with
the identity on the three-dimensional subsystem. -/
noncomputable def overlap (F : Pure) (P : Local) : ℂ :=
  ∑ i, ∑ j, ∑ k, star (F i k) * P i j * F j k

theorem trace_mul_density (F : Pure) (P : Local) :
    (P * density F).trace = overlap F P := by
  classical
  simp only [Matrix.trace, Matrix.diag_apply, Matrix.mul_apply, density_apply, overlap,
    Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
    Finset.sum_congr rfl fun k _ => ?_
  ring

theorem density_mul_trace (F : Pure) (P : Local) :
    (density F * P).trace = overlap F P := by
  rw [Matrix.trace_mul_comm, trace_mul_density]

theorem density_trace (F : Pure) :
    (density F).trace = ((∑ i, ∑ k, Complex.normSq (F i k) : ℝ) : ℂ) := by
  simp only [Matrix.trace, Matrix.diag_apply, density_apply, Complex.star_def, Complex.mul_conj,
    Complex.ofReal_sum]

theorem density_trace_of_unit (F : Pure)
    (unit : (∑ i, ∑ k, Complex.normSq (F i k)) = 1) : (density F).trace = 1 := by
  simp [density_trace, unit]

#print axioms density_det_zero
#print axioms trace_mul_density
end SicMarginal

end

/- Sections from SicPauliBase.lean -/

section

/-! Hermitian Paulis in order I,X,Y,Z.  Two-qubit Pauli index 4*a+b
acts by operator a on the high-order qubit, b on the low-order one.
Computational basis vectors are ordered 00,01,10,11. -/
namespace SicPauli
open scoped BigOperators Matrix
noncomputable section

def onePauli (a : Fin 4) : Matrix (Fin 2) (Fin 2) ℂ :=
  ![!![1,0;0,1], !![0,1;1,0], !![0,-Complex.I;Complex.I,0],
    !![1,0;0,-1]] a

def twoPauli (p : Fin 16) : Matrix (Fin 4) (Fin 4) ℂ := fun i j =>
  onePauli (Fin.ofNat 4 (p.val/4)) (Fin.ofNat 2 (i.val/2)) (Fin.ofNat 2 (j.val/2)) *
  onePauli (Fin.ofNat 4 (p.val%4)) (Fin.ofNat 2 (i.val%2)) (Fin.ofNat 2 (j.val%2))

def signedPauli (s : Fin 16 → Bool) : Matrix (Fin 4) (Fin 4) ℂ :=
  ∑ p : Fin 16, if p=0 then 0 else (if s p then (1:ℂ) else -1) • twoPauli p

end
end SicPauli

end

/- Sections from PauliTables.lean -/

section

set_option linter.unusedSimpArgs false
noncomputable section
open scoped Matrix BigOperators
namespace SicExpansion
open SicPauli

theorem two_0 : twoPauli 0 = !![
1, 0, 0, 0;
0, 1, 0, 0;
0, 0, 1, 0;
0, 0, 0, 1] := by
  have h : twoPauli 0 = !![1 * 1, 1 * 0, 0 * 1, 0 * 0;
1 * 0, 1 * 1, 0 * 0, 0 * 1;
0 * 1, 0 * 0, 1 * 1, 1 * 0;
0 * 0, 0 * 1, 1 * 0, 1 * 1] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_1 : twoPauli 1 = !![
0, 1, 0, 0;
1, 0, 0, 0;
0, 0, 0, 1;
0, 0, 1, 0] := by
  have h : twoPauli 1 = !![1 * 0, 1 * 1, 0 * 0, 0 * 1;
1 * 1, 1 * 0, 0 * 1, 0 * 0;
0 * 0, 0 * 1, 1 * 0, 1 * 1;
0 * 1, 0 * 0, 1 * 1, 1 * 0] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_2 : twoPauli 2 = !![
0, (-Complex.I), 0, 0;
Complex.I, 0, 0, 0;
0, 0, 0, (-Complex.I);
0, 0, Complex.I, 0] := by
  have h : twoPauli 2 = !![1 * 0, 1 * (-Complex.I), 0 * 0, 0 * (-Complex.I);
1 * Complex.I, 1 * 0, 0 * Complex.I, 0 * 0;
0 * 0, 0 * (-Complex.I), 1 * 0, 1 * (-Complex.I);
0 * Complex.I, 0 * 0, 1 * Complex.I, 1 * 0] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_3 : twoPauli 3 = !![
1, 0, 0, 0;
0, (-1), 0, 0;
0, 0, 1, 0;
0, 0, 0, (-1)] := by
  have h : twoPauli 3 = !![1 * 1, 1 * 0, 0 * 1, 0 * 0;
1 * 0, 1 * (-1), 0 * 0, 0 * (-1);
0 * 1, 0 * 0, 1 * 1, 1 * 0;
0 * 0, 0 * (-1), 1 * 0, 1 * (-1)] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_4 : twoPauli 4 = !![
0, 0, 1, 0;
0, 0, 0, 1;
1, 0, 0, 0;
0, 1, 0, 0] := by
  have h : twoPauli 4 = !![0 * 1, 0 * 0, 1 * 1, 1 * 0;
0 * 0, 0 * 1, 1 * 0, 1 * 1;
1 * 1, 1 * 0, 0 * 1, 0 * 0;
1 * 0, 1 * 1, 0 * 0, 0 * 1] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_5 : twoPauli 5 = !![
0, 0, 0, 1;
0, 0, 1, 0;
0, 1, 0, 0;
1, 0, 0, 0] := by
  have h : twoPauli 5 = !![0 * 0, 0 * 1, 1 * 0, 1 * 1;
0 * 1, 0 * 0, 1 * 1, 1 * 0;
1 * 0, 1 * 1, 0 * 0, 0 * 1;
1 * 1, 1 * 0, 0 * 1, 0 * 0] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_6 : twoPauli 6 = !![
0, 0, 0, (-Complex.I);
0, 0, Complex.I, 0;
0, (-Complex.I), 0, 0;
Complex.I, 0, 0, 0] := by
  have h : twoPauli 6 = !![0 * 0, 0 * (-Complex.I), 1 * 0, 1 * (-Complex.I);
0 * Complex.I, 0 * 0, 1 * Complex.I, 1 * 0;
1 * 0, 1 * (-Complex.I), 0 * 0, 0 * (-Complex.I);
1 * Complex.I, 1 * 0, 0 * Complex.I, 0 * 0] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_7 : twoPauli 7 = !![
0, 0, 1, 0;
0, 0, 0, (-1);
1, 0, 0, 0;
0, (-1), 0, 0] := by
  have h : twoPauli 7 = !![0 * 1, 0 * 0, 1 * 1, 1 * 0;
0 * 0, 0 * (-1), 1 * 0, 1 * (-1);
1 * 1, 1 * 0, 0 * 1, 0 * 0;
1 * 0, 1 * (-1), 0 * 0, 0 * (-1)] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_8 : twoPauli 8 = !![
0, 0, (-Complex.I), 0;
0, 0, 0, (-Complex.I);
Complex.I, 0, 0, 0;
0, Complex.I, 0, 0] := by
  have h : twoPauli 8 = !![0 * 1, 0 * 0, (-Complex.I) * 1, (-Complex.I) * 0;
0 * 0, 0 * 1, (-Complex.I) * 0, (-Complex.I) * 1;
Complex.I * 1, Complex.I * 0, 0 * 1, 0 * 0;
Complex.I * 0, Complex.I * 1, 0 * 0, 0 * 1] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_9 : twoPauli 9 = !![
0, 0, 0, (-Complex.I);
0, 0, (-Complex.I), 0;
0, Complex.I, 0, 0;
Complex.I, 0, 0, 0] := by
  have h : twoPauli 9 = !![0 * 0, 0 * 1, (-Complex.I) * 0, (-Complex.I) * 1;
0 * 1, 0 * 0, (-Complex.I) * 1, (-Complex.I) * 0;
Complex.I * 0, Complex.I * 1, 0 * 0, 0 * 1;
Complex.I * 1, Complex.I * 0, 0 * 1, 0 * 0] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_10 : twoPauli 10 = !![
0, 0, 0, (-1);
0, 0, 1, 0;
0, 1, 0, 0;
(-1), 0, 0, 0] := by
  have h : twoPauli 10 = !![0 * 0, 0 * (-Complex.I), (-Complex.I) * 0, (-Complex.I) * (-Complex.I);
0 * Complex.I, 0 * 0, (-Complex.I) * Complex.I, (-Complex.I) * 0;
Complex.I * 0, Complex.I * (-Complex.I), 0 * 0, 0 * (-Complex.I);
Complex.I * Complex.I, Complex.I * 0, 0 * Complex.I, 0 * 0] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_11 : twoPauli 11 = !![
0, 0, (-Complex.I), 0;
0, 0, 0, Complex.I;
Complex.I, 0, 0, 0;
0, (-Complex.I), 0, 0] := by
  have h : twoPauli 11 = !![0 * 1, 0 * 0, (-Complex.I) * 1, (-Complex.I) * 0;
0 * 0, 0 * (-1), (-Complex.I) * 0, (-Complex.I) * (-1);
Complex.I * 1, Complex.I * 0, 0 * 1, 0 * 0;
Complex.I * 0, Complex.I * (-1), 0 * 0, 0 * (-1)] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_12 : twoPauli 12 = !![
1, 0, 0, 0;
0, 1, 0, 0;
0, 0, (-1), 0;
0, 0, 0, (-1)] := by
  have h : twoPauli 12 = !![1 * 1, 1 * 0, 0 * 1, 0 * 0;
1 * 0, 1 * 1, 0 * 0, 0 * 1;
0 * 1, 0 * 0, (-1) * 1, (-1) * 0;
0 * 0, 0 * 1, (-1) * 0, (-1) * 1] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_13 : twoPauli 13 = !![
0, 1, 0, 0;
1, 0, 0, 0;
0, 0, 0, (-1);
0, 0, (-1), 0] := by
  have h : twoPauli 13 = !![1 * 0, 1 * 1, 0 * 0, 0 * 1;
1 * 1, 1 * 0, 0 * 1, 0 * 0;
0 * 0, 0 * 1, (-1) * 0, (-1) * 1;
0 * 1, 0 * 0, (-1) * 1, (-1) * 0] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_14 : twoPauli 14 = !![
0, (-Complex.I), 0, 0;
Complex.I, 0, 0, 0;
0, 0, 0, Complex.I;
0, 0, (-Complex.I), 0] := by
  have h : twoPauli 14 = !![1 * 0, 1 * (-Complex.I), 0 * 0, 0 * (-Complex.I);
1 * Complex.I, 1 * 0, 0 * Complex.I, 0 * 0;
0 * 0, 0 * (-Complex.I), (-1) * 0, (-1) * (-Complex.I);
0 * Complex.I, 0 * 0, (-1) * Complex.I, (-1) * 0] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

theorem two_15 : twoPauli 15 = !![
1, 0, 0, 0;
0, (-1), 0, 0;
0, 0, (-1), 0;
0, 0, 0, 1] := by
  have h : twoPauli 15 = !![1 * 1, 1 * 0, 0 * 1, 0 * 0;
1 * 0, 1 * (-1), 0 * 0, 0 * (-1);
0 * 1, 0 * 0, (-1) * 1, (-1) * 0;
0 * 0, 0 * (-1), (-1) * 0, (-1) * (-1)] := by
    ext i j; fin_cases i <;> fin_cases j <;> rfl
  rw [h]
  simp

end SicExpansion

end

/- Sections from PauliCoordinates.lean -/

section

set_option maxHeartbeats 12000000
set_option maxRecDepth 16000

noncomputable section
open scoped Matrix BigOperators
namespace SicExpansion
open SicPauli
attribute [local simp] two_0 two_1 two_2 two_3 two_4 two_5 two_6 two_7 two_8 two_9 two_10 two_11 two_12 two_13 two_14 two_15

private theorem expand4 {A : Type*} [AddCommMonoid A] (f : Fin 4 → A) :
    ∑ i, f i = f 0 + (f 1 + (f 2 + (f 3))) := by
  simp only [Fin.sum_univ_succ, Finset.univ_unique, Finset.sum_singleton]
  rfl

private theorem expand16 {A : Type*} [AddCommMonoid A] (f : Fin 16 → A) :
    ∑ i, f i = f 0 + (f 1 + (f 2 + (f 3 + (f 4 + (f 5 + (f 6 + (f 7 + (f 8 + (f 9 + (f 10 + (f 11 + (f 12 + (f 13 + (f 14 + (f 15))))))))))))))) := by
  simp only [Fin.sum_univ_succ, Finset.univ_unique, Finset.sum_singleton]
  rfl

/-- The two-qubit Pauli matrices form a trace-orthogonal coordinate system. -/
theorem reconstruct (R : Matrix (Fin 4) (Fin 4) ℂ) :
    (∑ p : Fin 16, (twoPauli p * R).trace • twoPauli p) = (4:ℂ) • R := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [expand16, expand4, Matrix.trace, Matrix.diag, Matrix.mul_apply,
      Matrix.smul_apply, Matrix.add_apply, smul_eq_mul] <;> ring_nf <;> simp <;> ring

theorem pauli_hermitian (p : Fin 16) : (twoPauli p).IsHermitian := by
  unfold Matrix.IsHermitian
  ext i j
  fin_cases p <;> fin_cases i <;> fin_cases j <;> simp [Matrix.conjTranspose_apply]

theorem pauli_zero : twoPauli 0 = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp

end SicExpansion

end

/- Sections from PauliExpansion.lean -/

section

noncomputable section
open scoped Matrix ComplexOrder BigOperators
namespace SicExpansion
private abbrev M := Matrix (Fin 4) (Fin 4) ℂ
open SicPauli

theorem hermitian_trace_real {P R : M} (hP : P.IsHermitian) (hR : R.IsHermitian) :
    (((P * R).trace.re : ℝ) : ℂ) = (P * R).trace := by
  have e : star ((P * R).trace) = (P * R).trace := by
    rw [← Matrix.trace_conjTranspose, Matrix.conjTranspose_mul, hR.eq, hP.eq,
        Matrix.trace_mul_comm]
  apply Complex.ext
  · rfl
  · have e' := congrArg Complex.im e
    simp at e'
    simp only [Complex.ofReal_im]
    linarith

theorem scaled_sign {z : ℂ} (hreal : ((z.re : ℝ) : ℂ) = z)
    (habs : ‖z‖ = 1 / Real.sqrt 13) :
    (Real.sqrt 13 : ℂ) * z = if 0 ≤ z.re then 1 else -1 := by
  have hn : |z.re| = 1 / Real.sqrt 13 := by
    calc |z.re| = ‖((z.re : ℝ) : ℂ)‖ := by simp
         _ = ‖z‖ := by rw [hreal]
         _ = _ := habs
  have hp : Real.sqrt 13 ≠ 0 := by positivity
  split_ifs with hz
  · rw [abs_of_nonneg hz] at hn
    rw [← hreal, ← Complex.ofReal_mul, hn, mul_one_div_cancel hp, Complex.ofReal_one]
  · rw [abs_of_neg (lt_of_not_ge hz)] at hn
    have hz' : z.re = -(1 / Real.sqrt 13) := by linarith
    rw [← hreal, ← Complex.ofReal_mul, hz', mul_neg, mul_one_div_cancel hp]
    norm_num

/-- If all fifteen nonidentity local Pauli expectations have the SIC modulus,
then the marginal is a signed two-qubit Pauli sum with a fixed identity term. -/
theorem signed_expansion (R : M) (herm : R.IsHermitian) (unit : R.trace = 1)
    (flat : ∀ p : Fin 16, p ≠ 0 → ‖(twoPauli p * R).trace‖ = 1 / Real.sqrt 13) :
    ∃ s : Fin 16 → Bool, ((4:ℂ) * (Real.sqrt 13 : ℂ)) • R =
      (Real.sqrt 13 : ℂ) • (1 : M) + signedPauli s := by
  classical
  let s (p : Fin 16) : Bool := decide (0 ≤ (twoPauli p * R).trace.re)
  refine ⟨s, ?_⟩
  let c : ℂ := (Real.sqrt 13 : ℂ)
  have hexp := congrArg (fun Q : M => c • Q) (reconstruct R)
  have hcoeff (p : Fin 16) (hz : p ≠ 0) :
      c * (twoPauli p * R).trace = if s p then 1 else -1 := by
    simpa [s, c] using scaled_sign (hermitian_trace_real (pauli_hermitian p) herm) (flat p hz)
  have hsum (p : Fin 16) :
      c • ((twoPauli p * R).trace • twoPauli p) =
      (if p = 0 then c • (1:M) else 0) +
      (if p = 0 then 0 else (if s p then (1:ℂ) else -1) • twoPauli p) := by
    by_cases hz : p = 0
    · subst p; simp [pauli_zero, unit]
    · simp [hz, smul_smul, hcoeff p hz]
  change c • (∑ p : Fin 16, (twoPauli p * R).trace • twoPauli p) = c • ((4:ℂ) • R) at hexp
  rw [Finset.smul_sum, smul_smul, mul_comm c] at hexp
  calc
    _ = ∑ p : Fin 16, c • ((twoPauli p * R).trace • twoPauli p) := hexp.symm
    _ = _ := by simp_rw [hsum, Finset.sum_add_distrib]; simp [signedPauli, c]

theorem pure_signed_expansion (F : SicMarginal.Pure)
    (unit : (∑ i, ∑ k, Complex.normSq (F i k)) = 1)
    (flat : ∀ p : Fin 16, p ≠ 0 → ‖SicMarginal.overlap F (twoPauli p)‖ = 1 / Real.sqrt 13) :
    ∃ s : Fin 16 → Bool, ((4:ℂ) * (Real.sqrt 13 : ℂ)) • SicMarginal.density F =
      (Real.sqrt 13 : ℂ) • (1 : M) + signedPauli s := by
  apply signed_expansion _ (SicMarginal.density_isHermitian F) (SicMarginal.density_trace_of_unit F unit)
  simpa only [SicMarginal.trace_mul_density] using flat

#print axioms pure_signed_expansion
end SicExpansion

end

/- Sections from DetFour.lean -/

section

namespace SicPauli
open scoped BigOperators Matrix
theorem det_four {R : Type*} [CommRing R] (A : Matrix (Fin 4) (Fin 4) R) :
  A.det = 
    A 0 0*A 1 1*A 2 2*A 3 3
  - A 0 0*A 1 1*A 2 3*A 3 2
  - A 0 0*A 1 2*A 2 1*A 3 3
  + A 0 0*A 1 2*A 2 3*A 3 1
  + A 0 0*A 1 3*A 2 1*A 3 2
  - A 0 0*A 1 3*A 2 2*A 3 1
  - A 0 1*A 1 0*A 2 2*A 3 3
  + A 0 1*A 1 0*A 2 3*A 3 2
  + A 0 1*A 1 2*A 2 0*A 3 3
  - A 0 1*A 1 2*A 2 3*A 3 0
  - A 0 1*A 1 3*A 2 0*A 3 2
  + A 0 1*A 1 3*A 2 2*A 3 0
  + A 0 2*A 1 0*A 2 1*A 3 3
  - A 0 2*A 1 0*A 2 3*A 3 1
  - A 0 2*A 1 1*A 2 0*A 3 3
  + A 0 2*A 1 1*A 2 3*A 3 0
  + A 0 2*A 1 3*A 2 0*A 3 1
  - A 0 2*A 1 3*A 2 1*A 3 0
  - A 0 3*A 1 0*A 2 1*A 3 2
  + A 0 3*A 1 0*A 2 2*A 3 1
  + A 0 3*A 1 1*A 2 0*A 3 2
  - A 0 3*A 1 1*A 2 2*A 3 0
  - A 0 3*A 1 2*A 2 0*A 3 1
  + A 0 3*A 1 2*A 2 1*A 3 0
 := by
  rw [Matrix.det_succ_row_zero]
  simp [Matrix.det_fin_three, Fin.sum_univ_succ, Matrix.submatrix_apply, Fin.succAbove]
  ring
end SicPauli

end

/- Sections from DetDefinitions.lean -/

section

namespace SicPauli
noncomputable section
open scoped Matrix BigOperators
set_option maxRecDepth 100000
set_option maxHeartbeats 6000000

def coordinateMatrix (z : Fin 16 → ℤ) (t : ℝ) : Matrix (Fin 4) (Fin 4) ℂ :=
  !![⟨t + ((z 3 : ℝ) + (z 12 : ℝ) + (z 15 : ℝ)), 0⟩, ⟨(z 1 : ℝ) + (z 13 : ℝ), - (z 2 : ℝ) - (z 14 : ℝ)⟩, ⟨(z 4 : ℝ) + (z 7 : ℝ), - (z 8 : ℝ) - (z 11 : ℝ)⟩, ⟨(z 5 : ℝ) - (z 10 : ℝ), - (z 6 : ℝ) - (z 9 : ℝ)⟩;
  ⟨(z 1 : ℝ) + (z 13 : ℝ), (z 2 : ℝ) + (z 14 : ℝ)⟩, ⟨t + (- (z 3 : ℝ) + (z 12 : ℝ) - (z 15 : ℝ)), 0⟩, ⟨(z 5 : ℝ) + (z 10 : ℝ), (z 6 : ℝ) - (z 9 : ℝ)⟩, ⟨(z 4 : ℝ) - (z 7 : ℝ), - (z 8 : ℝ) + (z 11 : ℝ)⟩;
  ⟨(z 4 : ℝ) + (z 7 : ℝ), (z 8 : ℝ) + (z 11 : ℝ)⟩, ⟨(z 5 : ℝ) + (z 10 : ℝ), - (z 6 : ℝ) + (z 9 : ℝ)⟩, ⟨t + ((z 3 : ℝ) - (z 12 : ℝ) - (z 15 : ℝ)), 0⟩, ⟨(z 1 : ℝ) - (z 13 : ℝ), - (z 2 : ℝ) + (z 14 : ℝ)⟩;
  ⟨(z 5 : ℝ) - (z 10 : ℝ), (z 6 : ℝ) + (z 9 : ℝ)⟩, ⟨(z 4 : ℝ) - (z 7 : ℝ), (z 8 : ℝ) - (z 11 : ℝ)⟩, ⟨(z 1 : ℝ) - (z 13 : ℝ), (z 2 : ℝ) - (z 14 : ℝ)⟩, ⟨t + (- (z 3 : ℝ) - (z 12 : ℝ) + (z 15 : ℝ)), 0⟩]

def constantCoeff (z : Fin 16 → ℤ) : ℤ :=
  (((((((((1) * (z 1)^4)
    + ((2) * (z 1)^2 * (z 2)^2))
    + (((2) * (z 1)^2 * (z 3)^2)
    + (((-2) * (z 1)^2 * (z 4)^2)
    + ((-2) * (z 1)^2 * (z 5)^2))))
    + ((((2) * (z 1)^2 * (z 6)^2)
    + ((2) * (z 1)^2 * (z 7)^2))
    + (((-2) * (z 1)^2 * (z 8)^2)
    + (((-2) * (z 1)^2 * (z 9)^2)
    + ((2) * (z 1)^2 * (z 10)^2)))))
    + (((((2) * (z 1)^2 * (z 11)^2)
    + ((-2) * (z 1)^2 * (z 12)^2))
    + (((-2) * (z 1)^2 * (z 13)^2)
    + (((2) * (z 1)^2 * (z 14)^2)
    + ((2) * (z 1)^2 * (z 15)^2))))
    + ((((-8) * (z 1) * (z 2) * (z 5) * (z 6))
    + ((-8) * (z 1) * (z 2) * (z 9) * (z 10)))
    + (((-8) * (z 1) * (z 2) * (z 13) * (z 14))
    + (((-8) * (z 1) * (z 3) * (z 5) * (z 7))
    + ((-8) * (z 1) * (z 3) * (z 9) * (z 11)))))))
    + ((((((-8) * (z 1) * (z 3) * (z 13) * (z 15))
    + ((8) * (z 1) * (z 4) * (z 10) * (z 15)))
    + (((-8) * (z 1) * (z 4) * (z 11) * (z 14))
    + (((-8) * (z 1) * (z 6) * (z 8) * (z 15))
    + ((8) * (z 1) * (z 6) * (z 11) * (z 12)))))
    + ((((8) * (z 1) * (z 7) * (z 8) * (z 14))
    + ((-8) * (z 1) * (z 7) * (z 10) * (z 12)))
    + (((1) * (z 2)^4)
    + (((2) * (z 2)^2 * (z 3)^2)
    + ((-2) * (z 2)^2 * (z 4)^2)))))
    + (((((2) * (z 2)^2 * (z 5)^2)
    + ((-2) * (z 2)^2 * (z 6)^2))
    + (((2) * (z 2)^2 * (z 7)^2)
    + (((-2) * (z 2)^2 * (z 8)^2)
    + ((2) * (z 2)^2 * (z 9)^2))))
    + ((((-2) * (z 2)^2 * (z 10)^2)
    + (((2) * (z 2)^2 * (z 11)^2)
    + ((-2) * (z 2)^2 * (z 12)^2)))
    + (((2) * (z 2)^2 * (z 13)^2)
    + (((-2) * (z 2)^2 * (z 14)^2)
    + ((2) * (z 2)^2 * (z 15)^2)))))))
    + (((((((-8) * (z 2) * (z 3) * (z 6) * (z 7))
    + ((-8) * (z 2) * (z 3) * (z 10) * (z 11)))
    + (((-8) * (z 2) * (z 3) * (z 14) * (z 15))
    + (((-8) * (z 2) * (z 4) * (z 9) * (z 15))
    + ((8) * (z 2) * (z 4) * (z 11) * (z 13)))))
    + ((((8) * (z 2) * (z 5) * (z 8) * (z 15))
    + ((-8) * (z 2) * (z 5) * (z 11) * (z 12)))
    + (((-8) * (z 2) * (z 7) * (z 8) * (z 13))
    + (((8) * (z 2) * (z 7) * (z 9) * (z 12))
    + ((1) * (z 3)^4)))))
    + (((((-2) * (z 3)^2 * (z 4)^2)
    + ((2) * (z 3)^2 * (z 5)^2))
    + (((2) * (z 3)^2 * (z 6)^2)
    + (((-2) * (z 3)^2 * (z 7)^2)
    + ((-2) * (z 3)^2 * (z 8)^2))))
    + ((((2) * (z 3)^2 * (z 9)^2)
    + ((2) * (z 3)^2 * (z 10)^2))
    + (((-2) * (z 3)^2 * (z 11)^2)
    + (((-2) * (z 3)^2 * (z 12)^2)
    + ((2) * (z 3)^2 * (z 13)^2))))))
    + ((((((2) * (z 3)^2 * (z 14)^2)
    + ((-2) * (z 3)^2 * (z 15)^2))
    + (((8) * (z 3) * (z 4) * (z 9) * (z 14))
    + (((-8) * (z 3) * (z 4) * (z 10) * (z 13))
    + ((-8) * (z 3) * (z 5) * (z 8) * (z 14)))))
    + ((((8) * (z 3) * (z 5) * (z 10) * (z 12))
    + ((8) * (z 3) * (z 6) * (z 8) * (z 13)))
    + (((-8) * (z 3) * (z 6) * (z 9) * (z 12))
    + (((1) * (z 4)^4)
    + ((-2) * (z 4)^2 * (z 5)^2)))))
    + (((((-2) * (z 4)^2 * (z 6)^2)
    + ((-2) * (z 4)^2 * (z 7)^2))
    + (((2) * (z 4)^2 * (z 8)^2)
    + (((2) * (z 4)^2 * (z 9)^2)
    + ((2) * (z 4)^2 * (z 10)^2))))
    + ((((2) * (z 4)^2 * (z 11)^2)
    + (((2) * (z 4)^2 * (z 12)^2)
    + ((2) * (z 4)^2 * (z 13)^2)))
    + (((2) * (z 4)^2 * (z 14)^2)
    + (((2) * (z 4)^2 * (z 15)^2)
    + ((-8) * (z 4) * (z 5) * (z 8) * (z 9)))))))))
    + ((((((((-8) * (z 4) * (z 5) * (z 12) * (z 13))
    + ((-8) * (z 4) * (z 6) * (z 8) * (z 10)))
    + (((-8) * (z 4) * (z 6) * (z 12) * (z 14))
    + (((-8) * (z 4) * (z 7) * (z 8) * (z 11))
    + ((-8) * (z 4) * (z 7) * (z 12) * (z 15)))))
    + ((((1) * (z 5)^4)
    + ((2) * (z 5)^2 * (z 6)^2))
    + (((2) * (z 5)^2 * (z 7)^2)
    + (((2) * (z 5)^2 * (z 8)^2)
    + ((2) * (z 5)^2 * (z 9)^2)))))
    + (((((-2) * (z 5)^2 * (z 10)^2)
    + ((-2) * (z 5)^2 * (z 11)^2))
    + (((2) * (z 5)^2 * (z 12)^2)
    + (((2) * (z 5)^2 * (z 13)^2)
    + ((-2) * (z 5)^2 * (z 14)^2))))
    + ((((-2) * (z 5)^2 * (z 15)^2)
    + ((8) * (z 5) * (z 6) * (z 9) * (z 10)))
    + (((8) * (z 5) * (z 6) * (z 13) * (z 14))
    + (((8) * (z 5) * (z 7) * (z 9) * (z 11))
    + ((8) * (z 5) * (z 7) * (z 13) * (z 15)))))))
    + ((((((1) * (z 6)^4)
    + ((2) * (z 6)^2 * (z 7)^2))
    + (((2) * (z 6)^2 * (z 8)^2)
    + (((-2) * (z 6)^2 * (z 9)^2)
    + ((2) * (z 6)^2 * (z 10)^2))))
    + ((((-2) * (z 6)^2 * (z 11)^2)
    + ((2) * (z 6)^2 * (z 12)^2))
    + (((-2) * (z 6)^2 * (z 13)^2)
    + (((2) * (z 6)^2 * (z 14)^2)
    + ((-2) * (z 6)^2 * (z 15)^2)))))
    + (((((8) * (z 6) * (z 7) * (z 10) * (z 11))
    + ((8) * (z 6) * (z 7) * (z 14) * (z 15)))
    + (((1) * (z 7)^4)
    + (((2) * (z 7)^2 * (z 8)^2)
    + ((-2) * (z 7)^2 * (z 9)^2))))
    + ((((-2) * (z 7)^2 * (z 10)^2)
    + (((2) * (z 7)^2 * (z 11)^2)
    + ((2) * (z 7)^2 * (z 12)^2)))
    + (((-2) * (z 7)^2 * (z 13)^2)
    + (((-2) * (z 7)^2 * (z 14)^2)
    + ((2) * (z 7)^2 * (z 15)^2)))))))
    + (((((((1) * (z 8)^4)
    + ((-2) * (z 8)^2 * (z 9)^2))
    + (((-2) * (z 8)^2 * (z 10)^2)
    + (((-2) * (z 8)^2 * (z 11)^2)
    + ((2) * (z 8)^2 * (z 12)^2))))
    + ((((2) * (z 8)^2 * (z 13)^2)
    + ((2) * (z 8)^2 * (z 14)^2))
    + (((2) * (z 8)^2 * (z 15)^2)
    + (((-8) * (z 8) * (z 9) * (z 12) * (z 13))
    + ((-8) * (z 8) * (z 10) * (z 12) * (z 14))))))
    + (((((-8) * (z 8) * (z 11) * (z 12) * (z 15))
    + ((1) * (z 9)^4))
    + (((2) * (z 9)^2 * (z 10)^2)
    + (((2) * (z 9)^2 * (z 11)^2)
    + ((2) * (z 9)^2 * (z 12)^2))))
    + ((((2) * (z 9)^2 * (z 13)^2)
    + (((-2) * (z 9)^2 * (z 14)^2)
    + ((-2) * (z 9)^2 * (z 15)^2)))
    + (((8) * (z 9) * (z 10) * (z 13) * (z 14))
    + (((8) * (z 9) * (z 11) * (z 13) * (z 15))
    + ((1) * (z 10)^4))))))
    + ((((((2) * (z 10)^2 * (z 11)^2)
    + ((2) * (z 10)^2 * (z 12)^2))
    + (((-2) * (z 10)^2 * (z 13)^2)
    + (((2) * (z 10)^2 * (z 14)^2)
    + ((-2) * (z 10)^2 * (z 15)^2))))
    + ((((8) * (z 10) * (z 11) * (z 14) * (z 15))
    + ((1) * (z 11)^4))
    + (((2) * (z 11)^2 * (z 12)^2)
    + (((-2) * (z 11)^2 * (z 13)^2)
    + ((-2) * (z 11)^2 * (z 14)^2)))))
    + (((((2) * (z 11)^2 * (z 15)^2)
    + ((1) * (z 12)^4))
    + (((-2) * (z 12)^2 * (z 13)^2)
    + (((-2) * (z 12)^2 * (z 14)^2)
    + ((-2) * (z 12)^2 * (z 15)^2))))
    + ((((1) * (z 13)^4)
    + (((2) * (z 13)^2 * (z 14)^2)
    + ((2) * (z 13)^2 * (z 15)^2)))
    + (((1) * (z 14)^4)
    + (((2) * (z 14)^2 * (z 15)^2)
    + ((1) * (z 15)^4)))))))))

def quadCoeff (z : Fin 16 → ℤ) : ℤ :=
  (-2) * (z 1)^2
    + (-2) * (z 2)^2
    + (-2) * (z 3)^2
    + (-2) * (z 4)^2
    + (-2) * (z 5)^2
    + (-2) * (z 6)^2
    + (-2) * (z 7)^2
    + (-2) * (z 8)^2
    + (-2) * (z 9)^2
    + (-2) * (z 10)^2
    + (-2) * (z 11)^2
    + (-2) * (z 12)^2
    + (-2) * (z 13)^2
    + (-2) * (z 14)^2
    + (-2) * (z 15)^2

def oddCoeff (z : Fin 16 → ℤ) : ℤ :=
  (z 1) * (z 4) * (z 5)
    + (z 1) * (z 8) * (z 9)
    + (z 1) * (z 12) * (z 13)
    + (z 2) * (z 4) * (z 6)
    + (z 2) * (z 8) * (z 10)
    + (z 2) * (z 12) * (z 14)
    + (z 3) * (z 4) * (z 7)
    + (z 3) * (z 8) * (z 11)
    + (z 3) * (z 12) * (z 15)
    + (-1) * (z 5) * (z 10) * (z 15)
    + (z 5) * (z 11) * (z 14)
    + (z 6) * (z 9) * (z 15)
    + (-1) * (z 6) * (z 11) * (z 13)
    + (-1) * (z 7) * (z 9) * (z 14)
    + (z 7) * (z 10) * (z 13)

end
end SicPauli

end

/- Sections from DetPolynomial.lean -/

section

/-! Characteristic polynomial of the two-qubit Pauli sign sum.
The sign variables are first treated as unrestricted integers. Lean checks
the polynomial identity by expanding a 4 by 4 determinant over C. -/
namespace SicPauli
noncomputable section
open scoped Matrix BigOperators
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

private theorem coord00 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 0 0 = ⟨t + ((z 3 : ℝ) + (z 12 : ℝ) + (z 15 : ℝ)), 0⟩ := rfl

private theorem coord01 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 0 1 = ⟨(z 1 : ℝ) + (z 13 : ℝ), - (z 2 : ℝ) - (z 14 : ℝ)⟩ := rfl

private theorem coord02 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 0 2 = ⟨(z 4 : ℝ) + (z 7 : ℝ), - (z 8 : ℝ) - (z 11 : ℝ)⟩ := rfl

private theorem coord03 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 0 3 = ⟨(z 5 : ℝ) - (z 10 : ℝ), - (z 6 : ℝ) - (z 9 : ℝ)⟩ := rfl

private theorem coord10 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 1 0 = ⟨(z 1 : ℝ) + (z 13 : ℝ), (z 2 : ℝ) + (z 14 : ℝ)⟩ := rfl

private theorem coord11 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 1 1 = ⟨t + (- (z 3 : ℝ) + (z 12 : ℝ) - (z 15 : ℝ)), 0⟩ := rfl

private theorem coord12 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 1 2 = ⟨(z 5 : ℝ) + (z 10 : ℝ), (z 6 : ℝ) - (z 9 : ℝ)⟩ := rfl

private theorem coord13 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 1 3 = ⟨(z 4 : ℝ) - (z 7 : ℝ), - (z 8 : ℝ) + (z 11 : ℝ)⟩ := rfl

private theorem coord20 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 2 0 = ⟨(z 4 : ℝ) + (z 7 : ℝ), (z 8 : ℝ) + (z 11 : ℝ)⟩ := rfl

private theorem coord21 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 2 1 = ⟨(z 5 : ℝ) + (z 10 : ℝ), - (z 6 : ℝ) + (z 9 : ℝ)⟩ := rfl

private theorem coord22 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 2 2 = ⟨t + ((z 3 : ℝ) - (z 12 : ℝ) - (z 15 : ℝ)), 0⟩ := rfl

private theorem coord23 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 2 3 = ⟨(z 1 : ℝ) - (z 13 : ℝ), - (z 2 : ℝ) + (z 14 : ℝ)⟩ := rfl

private theorem coord30 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 3 0 = ⟨(z 5 : ℝ) - (z 10 : ℝ), (z 6 : ℝ) + (z 9 : ℝ)⟩ := rfl

private theorem coord31 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 3 1 = ⟨(z 4 : ℝ) - (z 7 : ℝ), (z 8 : ℝ) - (z 11 : ℝ)⟩ := rfl

private theorem coord32 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 3 2 = ⟨(z 1 : ℝ) - (z 13 : ℝ), (z 2 : ℝ) - (z 14 : ℝ)⟩ := rfl

private theorem coord33 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 3 3 = ⟨t + (- (z 3 : ℝ) - (z 12 : ℝ) + (z 15 : ℝ)), 0⟩ := rfl

theorem coordinate_det_re (z : Fin 16 → ℤ) (t : ℝ) :
    ((coordinateMatrix z t).det).re =
      t^4+(quadCoeff z : ℝ)*t^2+8*(oddCoeff z : ℝ)*t+(constantCoeff z : ℝ) := by
  rw [det_four]
  simp only [coord00, coord01, coord02, coord03, coord10, coord11, coord12, coord13, coord20, coord21, coord22, coord23, coord30, coord31, coord32, coord33,
    Complex.add_re, Complex.sub_re,
    Complex.mul_re, Complex.mul_im, Complex.add_im, Complex.sub_im,
    quadCoeff, oddCoeff, constantCoeff, Int.cast_add, Int.cast_mul,
    Int.cast_pow, Int.cast_neg, Int.cast_ofNat]
  ring
end
end SicPauli

end

/- Sections from PauliMatrixLink.lean -/

section

namespace SicPauli
noncomputable section
open scoped BigOperators Matrix
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option linter.unusedSimpArgs false

private theorem expand16 {A : Type*} [AddCommMonoid A] (f : Fin 16 → A) :
    ∑ i, f i = f 0 + (f 1 + (f 2 + (f 3 + (f 4 + (f 5 + (f 6 + (f 7 + (f 8 + (f 9 + (f 10 + (f 11 + (f 12 + (f 13 + (f 14 + (f 15))))))))))))))) := by
  simp only [Fin.sum_univ_succ, Finset.univ_unique, Finset.sum_singleton, Finset.univ_eq_empty, Finset.sum_empty, add_zero]
  all_goals rfl

def signs (s : Fin 16 → Bool) (p : Fin 16) : ℤ := if s p then 1 else -1

private theorem complex_sign (s : Fin 16 → Bool) (p : Fin 16) :
    (if s p then (1:ℂ) else -1) = (signs s p : ℂ) := by
  cases h : s p <;> simp [signs, h]

private theorem matrixEntry00 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 0 0 = ⟨t + ((z 3 : ℝ) + (z 12 : ℝ) + (z 15 : ℝ)), 0⟩ := rfl

private theorem matrixEntry01 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 0 1 = ⟨(z 1 : ℝ) + (z 13 : ℝ), - (z 2 : ℝ) - (z 14 : ℝ)⟩ := rfl

private theorem matrixEntry02 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 0 2 = ⟨(z 4 : ℝ) + (z 7 : ℝ), - (z 8 : ℝ) - (z 11 : ℝ)⟩ := rfl

private theorem matrixEntry03 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 0 3 = ⟨(z 5 : ℝ) - (z 10 : ℝ), - (z 6 : ℝ) - (z 9 : ℝ)⟩ := rfl

private theorem matrixEntry10 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 1 0 = ⟨(z 1 : ℝ) + (z 13 : ℝ), (z 2 : ℝ) + (z 14 : ℝ)⟩ := rfl

private theorem matrixEntry11 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 1 1 = ⟨t + (- (z 3 : ℝ) + (z 12 : ℝ) - (z 15 : ℝ)), 0⟩ := rfl

private theorem matrixEntry12 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 1 2 = ⟨(z 5 : ℝ) + (z 10 : ℝ), (z 6 : ℝ) - (z 9 : ℝ)⟩ := rfl

private theorem matrixEntry13 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 1 3 = ⟨(z 4 : ℝ) - (z 7 : ℝ), - (z 8 : ℝ) + (z 11 : ℝ)⟩ := rfl

private theorem matrixEntry20 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 2 0 = ⟨(z 4 : ℝ) + (z 7 : ℝ), (z 8 : ℝ) + (z 11 : ℝ)⟩ := rfl

private theorem matrixEntry21 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 2 1 = ⟨(z 5 : ℝ) + (z 10 : ℝ), - (z 6 : ℝ) + (z 9 : ℝ)⟩ := rfl

private theorem matrixEntry22 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 2 2 = ⟨t + ((z 3 : ℝ) - (z 12 : ℝ) - (z 15 : ℝ)), 0⟩ := rfl

private theorem matrixEntry23 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 2 3 = ⟨(z 1 : ℝ) - (z 13 : ℝ), - (z 2 : ℝ) + (z 14 : ℝ)⟩ := rfl

private theorem matrixEntry30 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 3 0 = ⟨(z 5 : ℝ) - (z 10 : ℝ), (z 6 : ℝ) + (z 9 : ℝ)⟩ := rfl

private theorem matrixEntry31 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 3 1 = ⟨(z 4 : ℝ) - (z 7 : ℝ), (z 8 : ℝ) - (z 11 : ℝ)⟩ := rfl

private theorem matrixEntry32 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 3 2 = ⟨(z 1 : ℝ) - (z 13 : ℝ), (z 2 : ℝ) - (z 14 : ℝ)⟩ := rfl

private theorem matrixEntry33 (z : Fin 16 → ℤ) (t : ℝ) :
    coordinateMatrix z t 3 3 = ⟨t + (- (z 3 : ℝ) - (z 12 : ℝ) + (z 15 : ℝ)), 0⟩ := rfl

attribute [local simp] SicExpansion.two_0 SicExpansion.two_1 SicExpansion.two_2 SicExpansion.two_3 SicExpansion.two_4 SicExpansion.two_5 SicExpansion.two_6 SicExpansion.two_7 SicExpansion.two_8 SicExpansion.two_9 SicExpansion.two_10 SicExpansion.two_11 SicExpansion.two_12 SicExpansion.two_13 SicExpansion.two_14 SicExpansion.two_15
attribute [local simp] matrixEntry00 matrixEntry01 matrixEntry02 matrixEntry03 matrixEntry10 matrixEntry11 matrixEntry12 matrixEntry13 matrixEntry20 matrixEntry21 matrixEntry22 matrixEntry23 matrixEntry30 matrixEntry31 matrixEntry32 matrixEntry33

local macro "checkPauliEntry" : tactic =>
  `(tactic| (simp_rw [signedPauli, complex_sign, expand16]; apply Complex.ext <;>
    simp [Matrix.one_apply, Matrix.smul_apply, Matrix.add_apply, smul_eq_mul,
          Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im] <;> ring))

private theorem link00 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 0 0 =
 coordinateMatrix (signs s) t 0 0 := by
  checkPauliEntry

private theorem link01 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 0 1 =
 coordinateMatrix (signs s) t 0 1 := by
  checkPauliEntry

private theorem link02 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 0 2 =
 coordinateMatrix (signs s) t 0 2 := by
  checkPauliEntry

private theorem link03 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 0 3 =
 coordinateMatrix (signs s) t 0 3 := by
  checkPauliEntry

private theorem link10 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 1 0 =
 coordinateMatrix (signs s) t 1 0 := by
  checkPauliEntry

private theorem link11 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 1 1 =
 coordinateMatrix (signs s) t 1 1 := by
  checkPauliEntry

private theorem link12 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 1 2 =
 coordinateMatrix (signs s) t 1 2 := by
  checkPauliEntry

private theorem link13 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 1 3 =
 coordinateMatrix (signs s) t 1 3 := by
  checkPauliEntry

private theorem link20 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 2 0 =
 coordinateMatrix (signs s) t 2 0 := by
  checkPauliEntry

private theorem link21 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 2 1 =
 coordinateMatrix (signs s) t 2 1 := by
  checkPauliEntry

private theorem link22 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 2 2 =
 coordinateMatrix (signs s) t 2 2 := by
  checkPauliEntry

private theorem link23 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 2 3 =
 coordinateMatrix (signs s) t 2 3 := by
  checkPauliEntry

private theorem link30 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 3 0 =
 coordinateMatrix (signs s) t 3 0 := by
  checkPauliEntry

private theorem link31 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 3 1 =
 coordinateMatrix (signs s) t 3 1 := by
  checkPauliEntry

private theorem link32 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 3 2 =
 coordinateMatrix (signs s) t 3 2 := by
  checkPauliEntry

private theorem link33 (s : Fin 16 → Bool) (t : ℝ) :
 ((t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s) 3 3 =
 coordinateMatrix (signs s) t 3 3 := by
  checkPauliEntry
theorem matrix_link (s : Fin 16 → Bool) (t : ℝ) :
 (t:ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s =
 coordinateMatrix (signs s) t := by
  ext i j : 1
  fin_cases i <;> fin_cases j
  · exact link00 s t
  · exact link01 s t
  · exact link02 s t
  · exact link03 s t
  · exact link10 s t
  · exact link11 s t
  · exact link12 s t
  · exact link13 s t
  · exact link20 s t
  · exact link21 s t
  · exact link22 s t
  · exact link23 s t
  · exact link30 s t
  · exact link31 s t
  · exact link32 s t
  · exact link33 s t
end
end SicPauli

end

/- Sections from PauliObstruction.lean -/

section

/-!
The real determinant is A + 8L sqrt(13), with A,L integers.
L is a sum of fifteen signed odd products, hence is odd and nonzero.
As sqrt(13) is irrational, the determinant cannot vanish.
-/
namespace SicPauli
open scoped Matrix BigOperators
noncomputable section
set_option maxRecDepth 100000
set_option maxHeartbeats 10000000

private theorem sign_mod2 (s : Fin 16 → Bool) (p : Fin 16) :
    (signs s p : ZMod 2) = 1 := by
  cases h : s p <;> simp [signs, h]

theorem oddCoeff_ne_zero (s : Fin 16 → Bool) : oddCoeff (signs s) ≠ 0 := by
  have ho : (oddCoeff (signs s) : ZMod 2) = 1 := by
    simp only [oddCoeff, Int.cast_add, Int.cast_mul, Int.cast_neg, Int.cast_one, sign_mod2]
    decide
  intro h
  rw [h] at ho
  simpa using ho

/-- In fact every irrational scale whose square is rational gives a
nonsingular shift of every two-qubit Pauli sign sum. -/
theorem signed_det_nonzero_general (s : Fin 16 → Bool) (t : ℝ) (r : ℚ)
    (ht : Irrational t) (hsq : t^2 = (r:ℝ)) :
    ((t : ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s).det ≠ 0 := by
  intro h
  rw [matrix_link] at h
  have hd := congrArg Complex.re h
  rw [coordinate_det_re, Complex.zero_re] at hd
  have h4 : t^4 = (r:ℝ)^2 := by rw [show (4:ℕ)=2*2 by decide, pow_mul, hsq]
  rw [h4,hsq] at hd
  let A : ℚ := r^2 + r*(quadCoeff (signs s) : ℚ) + constantCoeff (signs s)
  let B : ℤ := 8*oddCoeff (signs s)
  have nz : B ≠ 0 := mul_ne_zero (by decide) (oddCoeff_ne_zero s)
  have hb : (B:ℝ) ≠ 0 := by exact_mod_cast nz
  apply ht
  refine ⟨-A / (B:ℚ), ?_⟩
  push_cast
  apply (div_eq_iff hb).mpr
  dsimp [A,B]
  push_cast
  linarith

theorem signed_det_nonzero (s : Fin 16 → Bool) :
    ((Real.sqrt 13 : ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) + signedPauli s).det ≠ 0 := by
  apply signed_det_nonzero_general s (Real.sqrt 13) 13
  · norm_num
  · norm_num

#print axioms signed_det_nonzero
end
end SicPauli

end

/- Sections from LocalOrbit.lean -/

section

/-! The local Heisenberg–Weyl orbit in dimensions 2, 2, and 3.
The four projective displacement representatives on each qubit are I, X, Y, Z.
On the qutrit we use X^a Z^b, with the cyclic shift X|k⟩ = |k+1⟩
and clock Z|k⟩ = exp(2πik/3) |k⟩. -/
namespace SicLocalOrbit
open scoped BigOperators
open SicMarginal SicPauli
noncomputable section

/-- Translation group in the notation used for finite abelian Gabor systems. -/
def translationGroupEquiv :
    (ZMod 2 × ZMod 2 × ZMod 3) ≃+ (ZMod 2 × ZMod 6) :=
  AddEquiv.prodCongr (AddEquiv.refl _) (ZMod.chineseRemainder (by decide : Nat.Coprime 2 3)).toAddEquiv.symm

theorem six_smul_translation (x : ZMod 2 × ZMod 2 × ZMod 3) : (6 : ℕ) • x = 0 := by
  rcases x with ⟨a,b,c⟩
  ext <;> simp [nsmul_eq_mul, show (6 : ZMod 2) = 0 by decide, show (6 : ZMod 3) = 0 by decide]
theorem translationGroup_not_Z12 : IsEmpty ((ZMod 2 × ZMod 2 × ZMod 3) ≃+ ZMod 12) := by
  constructor
  intro e
  obtain ⟨x, hx⟩ := e.surjective 1
  have hn : (6 : ZMod 12) ≠ 0 := by decide
  apply hn
  calc
    (6 : ZMod 12) = (6 : ℕ) • (1 : ZMod 12) := by decide
    _ = 6 • e x := by rw [hx]
    _ = e (6 • x) := (map_nsmul e 6 x).symm
    _ = 0 := by rw [six_smul_translation, map_zero]

abbrev Label := Fin 16 × Fin 3 × Fin 3

theorem label_count : Fintype.card Label = 144 := by norm_num [Label, Fintype.card_prod]

def omega3 : ℂ := Complex.exp (2 * (Real.pi : ℂ) * Complex.I / 3)

theorem omega3_primitive : IsPrimitiveRoot omega3 3 := by
  simpa [omega3] using (Complex.isPrimitiveRoot_exp 3 (by decide))

/-- Amplitudes in the computational basis. The two last label components
are the powers of the qutrit shift and clock. -/
def orbit (g : Label) (F : Pure) : Pure := fun i k =>
  omega3 ^ (g.2.2.val * (k - g.2.1).val) * (twoPauli g.1 * F) i (k - g.2.1)

def amplitude (F G : Pure) : ℂ := ∑ i, ∑ k, star (F i k) * G i k

/-- A SIC consists of 144 unit vectors with squared overlap 1/(12+1)
for every two distinct labels. Global phases leave this property unchanged. -/
structure IsSICFamily (V : Label → Pure) : Prop where
  unit (g : Label) : (∑ i, ∑ k, Complex.normSq (V g i k)) = 1
  equiangular (g h : Label) (hne : g ≠ h) :
    ‖amplitude (V g) (V h)‖ ^ 2 = (1 : ℝ) / 13

abbrev IsLocalOrbitSIC (F : Pure) : Prop := IsSICFamily (fun g => orbit g F)

theorem amplitude_smul (a b : ℂ) (F G : Pure) :
    amplitude (a • F) (b • G) = (star a * b) * amplitude F G := by
  simp only [amplitude, Matrix.smul_apply, smul_eq_mul, star_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun k _ => ?_
  ring

/-- A separate phase choice for every vector leaves the SIC conditions invariant. -/
theorem phase_invariant (V : Label → Pure) (c : Label → ℂ) (hc : ∀ g, ‖c g‖ = 1) :
    IsSICFamily (fun g => c g • V g) ↔ IsSICFamily V := by
  have hu (g : Label) : (∑ i, ∑ k, Complex.normSq ((c g • V g) i k)) =
      ∑ i, ∑ k, Complex.normSq (V g i k) := by
    have hc' : Complex.normSq (c g) = 1 := by simp [Complex.normSq_eq_norm_sq, hc]
    simp [Matrix.smul_apply, Complex.normSq_mul, hc']
  have he (g h : Label) : ‖amplitude (c g • V g) (c h • V h)‖ =
      ‖amplitude (V g) (V h)‖ := by simp [amplitude_smul, hc]
  constructor
  · intro hs
    exact ⟨fun g => (hu g).symm.trans (hs.unit g),
      fun g h hn => by simpa only [he] using hs.equiangular g h hn⟩
  · intro hs
    exact ⟨fun g => (hu g).trans (hs.unit g),
      fun g h hn => by simpa only [he] using hs.equiangular g h hn⟩

theorem twoPauli_identity : twoPauli 0 = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;> norm_num [twoPauli, onePauli, Matrix.one_apply, Fin.last, Matrix.vecCons]

@[simp] theorem orbit_qubit (p : Fin 16) (F : Pure) :
    orbit (p, 0, 0) F = twoPauli p * F := by
  ext i k
  simp [orbit]

@[simp] theorem orbit_origin (F : Pure) : orbit (0, 0, 0) F = F := by
  simp [twoPauli_identity]

theorem amplitude_qubit (F : Pure) (P : Local) :
    amplitude F (P * F) = overlap F P := by
  classical
  unfold amplitude overlap
  refine Finset.sum_congr rfl fun i _ => ?_
  simp only [Matrix.mul_apply, Finset.mul_sum]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
  ring

theorem norm_of_squared {z : ℂ} (h : ‖z‖ ^ 2 = (1 : ℝ) / 13) :
    ‖z‖ = 1 / Real.sqrt 13 := by
  have hs : (1 / Real.sqrt 13) ^ 2 = (1 : ℝ) / 13 := by
    rw [div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 13), one_pow]
  exact (sq_eq_sq₀ (norm_nonneg _) (by positivity)).mp (h.trans hs.symm)

theorem unit_fiducial {F : Pure} (h : IsLocalOrbitSIC F) :
    (∑ i, ∑ k, Complex.normSq (F i k)) = 1 := by
  simpa only [orbit_origin] using h.unit (0, 0, 0)

theorem marginal_pauli_norm {F : Pure} (h : IsLocalOrbitSIC F)
    (p : Fin 16) (hp : p ≠ 0) :
    ‖(twoPauli p * density F).trace‖ = 1 / Real.sqrt 13 := by
  have hne : ((0, 0, 0) : Label) ≠ (p, 0, 0) := by
    intro heq
    exact hp (congrArg Prod.fst heq).symm
  have hsq := h.equiangular (0, 0, 0) (p, 0, 0) hne
  rw [orbit_origin, orbit_qubit, amplitude_qubit] at hsq
  rw [trace_mul_density]
  exact norm_of_squared hsq

#print axioms marginal_pauli_norm
end
end SicLocalOrbit

end

/- Sections from NoLocalSIC.lean -/

section

/-! Dimension 12 with the tensor-product projective displacement action on
two qubits and one qutrit. The fiducial may be arbitrarily entangled. -/
namespace SicNoGo
open SicPauli SicMarginal SicLocalOrbit
open scoped Matrix BigOperators
noncomputable section

/-- Any Hermitian, trace-one four-by-four matrix with all fifteen
nonidentity Pauli expectations of modulus 1/√13 has nonzero determinant. -/
theorem flat_marginal_det_ne_zero (R : Local) (herm : R.IsHermitian) (unit : R.trace = 1)
    (flat : ∀ p : Fin 16, p ≠ 0 → ‖(twoPauli p * R).trace‖ = 1 / Real.sqrt 13) :
    R.det ≠ 0 := by
  obtain ⟨s, h⟩ := SicExpansion.signed_expansion R herm unit flat
  intro hdet
  apply signed_det_nonzero s
  rw [← h, Matrix.det_smul, hdet, mul_zero]

/-- Fifteen fiducial overlaps already obstruct a pure state on ℂ⁴ ⊗ ℂ³. -/
theorem no_flat_pure_state (F : Pure) (unit : (∑ i, ∑ k, Complex.normSq (F i k)) = 1) :
    ¬ ∀ p : Fin 16, p ≠ 0 → ‖overlap F (twoPauli p)‖ = 1 / Real.sqrt 13 := by
  intro flat
  apply flat_marginal_det_ne_zero (density F) (density_isHermitian F)
    (density_trace_of_unit F unit) _ (density_det_zero F)
  simpa only [trace_mul_density] using flat

/-- There is no 144-ray local Heisenberg–Weyl SIC orbit in dimension
12 on ℂ² ⊗ ℂ² ⊗ ℂ³. The two assumptions in IsLocalOrbitSIC are exactly
unit norm and equal squared overlap 1/13 for all distinct orbit labels. -/
theorem no_local_hw_sic_dim12 : ¬ ∃ F : Pure, IsLocalOrbitSIC F := by
  rintro ⟨F, h⟩
  apply no_flat_pure_state F (unit_fiducial h)
  simpa only [trace_mul_density] using marginal_pauli_norm h

/-- The same statement with arbitrary unit phases on the 144 representatives.
This covers the phase conventions in displacement-operator definitions. -/
theorem no_local_hw_sic_dim12_with_phases :
    ¬ ∃ (F : Pure) (c : Label → ℂ), (∀ g, ‖c g‖ = 1) ∧
      IsSICFamily (fun g => c g • orbit g F) := by
  rintro ⟨F, c, hc, h⟩
  exact no_local_hw_sic_dim12 ⟨F, (phase_invariant _ c hc).mp h⟩

#print axioms no_local_hw_sic_dim12_with_phases
#print axioms flat_marginal_det_ne_zero
#print axioms no_flat_pure_state
#print axioms no_local_hw_sic_dim12
end
end SicNoGo

end
