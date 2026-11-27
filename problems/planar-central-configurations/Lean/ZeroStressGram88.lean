import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

namespace ZeroStressGram88

abbrev F := ZMod 65521



def root (i : Fin 3) : F := if i = 0 then 1 else if i = 1 then 16673 else 48847

/-- Determinant of the doubled three-by-three Gram matrix when D₀₁ = 1. -/
def gram {R : Type*} [CommRing R] (a b c d e : R) : R :=
  let u := 1 + a - c
  let v := 1 + b - d
  let w := a + b - e
  2*(2*a)*(2*b) + 2*u*v*w - 2*w^2 - 2*a*v^2 - 2*b*u^2

set_option maxRecDepth 18000 in
set_option maxHeartbeats 6000000 in
theorem exact_table : ∀ i j k l m : Fin 3,
    gram (root i) (root j) (root k) (root l) (root m) ≠ 0 := by decide

/-- All three cube roots specialize to the entries in the preceding table,
including in arbitrary extensions of the test field. -/
theorem cubic_root {K : Type*} [Field K] (f : F →+* K) {x : K} (hx : x^3 = 1) :
    ∃ i : Fin 3, x = f (root i) := by
  have hs : (16673 : F) + 48847 = -1 := by decide
  have hp : (16673 : F) * 48847 = 1 := by decide
  have hs' := congrArg f hs
  have hp' := congrArg f hp
  rw [map_add, map_neg, map_one] at hs'
  rw [map_mul, map_one] at hp'
  have h : (x-1)*(x-f 16673)*(x-f 48847) = 0 := by
    calc
      _ = (x-1)*(x^2-(f 16673+f 48847)*x+f 16673*f 48847) := by ring
      _ = x^3-1 := by rw [hs',hp']; ring
      _ = 0 := by rw [hx]; ring
  rcases mul_eq_zero.mp h with h | h
  · rcases mul_eq_zero.mp h with h | h
    · exact ⟨0, by simpa [root] using sub_eq_zero.mp h⟩
    · exact ⟨1, by simpa [root] using sub_eq_zero.mp h⟩
  · exact ⟨2, by simpa [root] using sub_eq_zero.mp h⟩

/-- The Gram obstruction over any extension of the test field. -/
theorem gram_nonzero {K : Type*} [Field K] (f : F →+* K) (hf : Function.Injective f) {a b c d e : K}
    (ha : a^3=1) (hb : b^3=1) (hc : c^3=1) (hd : d^3=1) (he : e^3=1) :
    gram a b c d e ≠ 0 := by
  obtain ⟨i,rfl⟩ := cubic_root f ha
  obtain ⟨j,rfl⟩ := cubic_root f hb
  obtain ⟨k,rfl⟩ := cubic_root f hc
  obtain ⟨l,rfl⟩ := cubic_root f hd
  obtain ⟨m,rfl⟩ := cubic_root f he
  have hn := hf.ne (exact_table i j k l m)
  simpa only [gram, map_add, map_one, map_sub, map_mul, map_ofNat, map_pow, map_zero] using hn

/-- Two projected coordinates give a rank-at-most-two Gram matrix.
The first point is the origin and the second is (1,1). -/
theorem planar_identity {K : Type*} [CommRing K] (x y u v : K) :
    gram (x*y) (u*v) ((x-1)*(y-1)) ((u-1)*(v-1)) ((x-u)*(y-v)) = 0 := by
  unfold gram
  ring

/-- No normalized planar quartet in any extension can have all six
squared distances in the cube roots of unity. -/
theorem no_planar_quartet {K : Type*} [Field K] (f : F →+* K) (hf : Function.Injective f) (x y u v : K)
    (ha : (x*y)^3=1) (hb : (u*v)^3=1) (hc : ((x-1)*(y-1))^3=1)
    (hd : ((u-1)*(v-1))^3=1) (he : ((x-u)*(y-v))^3=1) : False :=
  gram_nonzero f hf ha hb hc hd he (planar_identity x y u v)

#print axioms no_planar_quartet

end ZeroStressGram88
