import Mathlib

/-!
# Three counterexamples about stabilizer-code distance under a change of alphabet

This file is self-contained apart from mathlib. It was prepared for Lean 4.28.0
and mathlib revision 8f9d9cff6bd728b17a24e163c9402775d9e6a365.
In a Lake project with that dependency, run
`lake env lean -o DistanceCollapse.olean DistanceCollapse.lean` and
`LEAN_PATH=".:$(lake env printenv LEAN_PATH)" lake env leanchecker --verbose DistanceCollapse`
with the current directory on the kernel checker's module path.

## Theorem index

* `FrobeniusCounterexample.counterexample` gives a five-site free stabilizer over
  Z/4 with relative distance one; its coordinatewise reduction over F₂ has distance two.
  This contradicts Gluesing-Luerssen and Pllaha, Conjecture 5.5, arXiv:1710.09884.
* `PrescribedLDI.prescribed` verifies the lower-triangular integer correction of
  Gunderman, arXiv:2110.15274. Its seven-site input has distance three by
  `PrescribedLDI.binary_distance`. The output has distance two at every modulus
  greater than two by `PrescribedLDI.large_distance`; `PrescribedLDI.no_prime_cutoff`
  expresses the failure at primes above any proposed finite cutoff.
* `CanonicalSteane.centered_systematic_recipe` checks Eq. (13) of Islam, Reza and
  Gunderman, arXiv:2610.15893. The eight-site example has binary distance three
  and target distance one at every modulus greater than two, by
  `CanonicalSteane.exact_binary_distance` and `CanonicalSteane.exact_target_distance`.
* `distance_collapse_examples` states the six distance values together.
-/


/-! Canonical cyclic Pauli labels with one position and one phase coordinate per site. -/
namespace CyclicPauli

abbrev Labels (R : Type*) (n : ℕ) := Fin n → R × R

def bracket {R : Type*} [CommRing R] {n : ℕ} (x y : Labels R n) : R :=
  ∑ i, ((x i).1 * (y i).2 - (x i).2 * (y i).1)

def supported {R : Type*} [Zero R] {n : ℕ} (S : Finset (Fin n))
    (x : Labels R n) : Prop := ∀ i, i ∉ S → x i = 0

def Far {R : Type*} [CommRing R] {n : ℕ}
    (L : Submodule R (Labels R n)) (δ : ℕ) : Prop :=
  ∀ x, (∀ y ∈ L, bracket x y = 0) →
    ∀ S : Finset (Fin n), S.card < δ → supported S x → x = 0

def Isotropic {R : Type*} [CommRing R] {n : ℕ}
    (L : Submodule R (Labels R n)) : Prop :=
  ∀ x ∈ L, ∀ y ∈ L, bracket x y = 0

end CyclicPauli

/-! A free cyclic stabilizer over Z/4 whose relative symplectic distance
is one, whereas its reduction over F₂ has relative symplectic distance two. -/
namespace FrobeniusCounterexample
open CyclicPauli
open scoped BigOperators
variable {R : Type*} [CommRing R]

/-- The three coefficients are for the marked ancilla Z, data X check, and data Z check. -/
def enc (c : Fin 3 → R) : Labels R 5 :=
  ![(0,c 0),(c 1,2*c 0+c 2),(c 1,-2*c 0+c 2),(c 1,-c 2),(c 1,-c 2)]

def encoder (R : Type*) [CommRing R] : (Fin 3 → R) →ₗ[R] Labels R 5 where
  toFun := enc
  map_add' a b := by
    funext i; fin_cases i <;> apply Prod.ext <;> dsimp [enc] <;> ring
  map_smul' c a := by
    funext i; fin_cases i <;> apply Prod.ext <;> dsimp [enc] <;> ring

def code (R : Type*) [CommRing R] := LinearMap.range (encoder R)

theorem enc_injective : Function.Injective (enc (R:=R)) := by
  intro a b h
  have h0 := congrArg (fun x : Labels R 5 => (x 0).2) h
  have h1 := congrArg (fun x : Labels R 5 => (x 1).1) h
  have h2 := congrArg (fun x : Labels R 5 => (x 3).2) h
  funext i; fin_cases i
  · exact h0
  · exact h1
  · exact neg_injective h2

noncomputable def freeBasis (R : Type*) [CommRing R] : (Fin 3 → R) ≃ₗ[R] code R :=
  LinearEquiv.ofInjective (encoder R) enc_injective

theorem free (R : Type*) [CommRing R] : Module.Free R (code R) :=
  Module.Free.of_equiv (freeBasis R)

theorem isotropic (R : Type*) [CommRing R] : Isotropic (code R) := by
  rintro _ ⟨a,rfl⟩ _ ⟨b,rfl⟩
  change bracket (enc a) (enc b)=0
  simp [bracket,Fin.sum_univ_succ,enc] <;> ring

abbrev res : ZMod 4 →+* ZMod 2 := ZMod.castHom (by decide) (ZMod 2)

def reduce (v : Labels (ZMod 4) 5) : Labels (ZMod 2) 5 := fun i => (res (v i).1,res (v i).2)

theorem reduce_enc (a : Fin 3 → ZMod 4) : reduce (enc a)=enc (fun i => res (a i)) := by
  revert a
  decide +kernel

theorem reduction_exact : reduce '' (code (ZMod 4) : Set _) = (code (ZMod 2) : Set _) := by
  ext x
  constructor
  · rintro ⟨_,⟨a,rfl⟩,rfl⟩
    exact ⟨fun i => res (a i),(reduce_enc a).symm⟩
  · rintro ⟨a,rfl⟩
    let b : Fin 3 → ZMod 4 := fun i => ((a i).val:ZMod 4)
    refine ⟨enc b,⟨b,rfl⟩,?_⟩
    rw [reduce_enc]
    apply congrArg enc
    funext i
    change res ((a i).val:ZMod 4)=a i
    rw [map_natCast,ZMod.natCast_zmod_val]

def wt {n : ℕ} [DecidableEq R] (x : Labels R n) := (Finset.univ.filter (fun i => x i≠0)).card

def logical {n : ℕ} (C : Submodule R (Labels R n)) (x : Labels R n) : Prop :=
  (∀ y∈C,bracket x y=0) ∧ x∉C

noncomputable def relativeDistance {n : ℕ} [DecidableEq R] (C : Submodule R (Labels R n)) : ℕ :=
  sInf {w | ∃ x : Labels R n, logical C x ∧ wt x=w}

private theorem realize_distance {n : ℕ} [DecidableEq R] {C : Submodule R (Labels R n)} {d : ℕ}
    (witness : ∃ x, logical C x ∧ wt x=d) (lower : ∀ x, logical C x → d≤wt x) :
    relativeDistance C=d := by
  apply le_antisymm
  · exact Nat.sInf_le witness
  · apply le_csInf ⟨d,witness⟩
    rintro _ ⟨x,h,rfl⟩; exact lower x h

private def e0 : Labels (ZMod 4) 5 := ![(0,1),0,0,0,0]

theorem ring_distance : relativeDistance (code (ZMod 4)) = 1 := by
  apply realize_distance
  · refine ⟨e0,⟨?_,?_⟩,by decide⟩
    · rintro _ ⟨a,rfl⟩
      change bracket e0 (enc a)=0
      simp [e0,bracket,enc,Fin.sum_univ_succ]
    · rintro ⟨a,h⟩
      have h0 := congrArg (fun x : Labels (ZMod 4) 5 => (x 0).2) h
      have h1 := congrArg (fun x : Labels (ZMod 4) 5 => (x 1).2) h
      have h3 := congrArg (fun x : Labels (ZMod 4) 5 => (x 3).2) h
      change a 0=1 at h0
      change 2*a 0+a 2=0 at h1
      change -a 2=0 at h3
      rw [h0,neg_eq_zero.mp h3] at h1
      exact (by decide : (2:ZMod 4)≠0) (by simpa using h1)
  · intro x h
    by_contra! hz
    have e : (Finset.univ.filter (fun i => x i≠0))=∅ := Finset.card_eq_zero.mp (by change wt x=0; omega)
    have hx : x=0 := by
      funext i
      by_contra hi
      have hm : i∈Finset.univ.filter (fun j => x j≠0) := Finset.mem_filter.mpr ⟨Finset.mem_univ _,hi⟩
      rw [e] at hm; exact Finset.notMem_empty _ hm
    exact h.2 (hx ▸ (code (ZMod 4)).zero_mem)

private def e12 : Labels (ZMod 2) 5 := ![0,(0,1),(0,1),0,0]

private theorem binary_small : ∀ (x : Labels (ZMod 2) 5), wt x < 2 →
    bracket x (enc ![1,0,0])=0 → bracket x (enc ![0,1,0])=0 →
    bracket x (enc ![0,0,1])=0 → x=enc ![(x 0).2,0,0] := by decide +kernel

theorem field_distance : relativeDistance (code (ZMod 2)) = 2 := by
  apply realize_distance
  · refine ⟨e12,⟨?_,?_⟩,by decide⟩
    · rintro _ ⟨a,rfl⟩
      change bracket e12 (enc a)=0
      simp [e12,bracket,enc,Fin.sum_univ_succ]
      ring_nf
      rw [show (2:ZMod 2)=0 by decide,mul_zero]
    · rintro ⟨a,h⟩
      have h0 := congrArg (fun x : Labels (ZMod 2) 5 => (x 0).2) h
      have h1 := congrArg (fun x : Labels (ZMod 2) 5 => (x 1).2) h
      have h3 := congrArg (fun x : Labels (ZMod 2) 5 => (x 3).2) h
      change a 0=0 at h0
      change 2*a 0+a 2=1 at h1
      change -a 2=0 at h3
      rw [h0,neg_eq_zero.mp h3] at h1
      norm_num at h1
  · intro x h
    by_contra! hz
    have c (a : Fin 3 → ZMod 2) := h.1 (enc a) ⟨a,rfl⟩
    have e := binary_small x hz (c _) (c _) (c _)
    exact h.2 ⟨_,e.symm⟩

/-- Counterexample to Gluesing-Luerssen and Pllaha, Conjecture 5.5. -/
theorem counterexample : Module.Free (ZMod 4) (code (ZMod 4)) ∧
    Isotropic (code (ZMod 4)) ∧ reduce '' (code (ZMod 4) : Set _) = (code (ZMod 2) : Set _) ∧
    relativeDistance (code (ZMod 4)) = 1 ∧ relativeDistance (code (ZMod 2)) = 2 :=
  ⟨free _,isotropic _,reduction_exact,ring_distance,field_distance⟩
#print axioms counterexample
end FrobeniusCounterexample

namespace FrobeniusCounterexample
open CyclicPauli

/-- The same integral generators give distance one for every coefficient ring
in which two is nonzero.  The field family therefore has no large-prime cutoff. -/
theorem distance_eq_one_of_two_ne_zero (R : Type*) [CommRing R] [DecidableEq R]
    (two_ne : (2 : R) ≠ 0) : relativeDistance (code R) = 1 := by
  let z : Labels R 5 := ![(0,1),0,0,0,0]
  have one_ne : (1 : R) ≠ 0 := fun h => two_ne (by rw [show (2:R)=1+1 by ring,h,add_zero])
  have hz : logical (code R) z := by
    constructor
    · rintro _ ⟨a,rfl⟩
      change bracket z (enc a)=0
      simp [bracket,z,enc,Fin.sum_univ_succ]
    · rintro ⟨a,h⟩
      have h0 := congrArg (fun x : Labels R 5 => (x 0).2) h
      have h1 := congrArg (fun x : Labels R 5 => (x 1).2) h
      have h3 := congrArg (fun x : Labels R 5 => (x 3).2) h
      change a 0=1 at h0
      change 2*a 0+a 2=0 at h1
      change -a 2=0 at h3
      exact two_ne (by simpa [h0,neg_eq_zero.mp h3] using h1)
  have hw : wt z = 1 := by
    have he : Finset.univ.filter (fun i => z i ≠ 0) = {0} := by
      ext j
      fin_cases j <;> simp [z,one_ne]
    simp [wt, he]
  unfold relativeDistance
  apply le_antisymm
  · exact Nat.sInf_le ⟨z,hz,hw⟩
  · apply le_csInf (s := {w | ∃ x : Labels R 5, logical (code R) x ∧ wt x = w}) ⟨1,z,hz,hw⟩
    rintro _ ⟨x,h,rfl⟩
    obtain ⟨i,hi⟩ : ∃ i, x i ≠ 0 := by
      by_contra! e
      exact h.2 (funext e ▸ (code R).zero_mem)
    exact Finset.card_pos.mpr ⟨i,Finset.mem_filter.mpr ⟨Finset.mem_univ i, hi⟩⟩

theorem distance_all_moduli {m : ℕ} (hm : 2 < m) : relativeDistance (code (ZMod m)) = 1 := by
  have h : ¬m ∣ 2 := Nat.not_dvd_of_pos_of_lt (by decide) hm
  exact distance_eq_one_of_two_ne_zero _ (by simpa using (ZMod.natCast_eq_zero_iff 2 m).not.mpr h)

#print axioms distance_all_moduli
end FrobeniusCounterexample

/-! A direct check of the lower triangular local-dimension-invariant lift
specified in Gunderman's Theorem 8. -/
namespace PrescribedLDI
open CyclicPauli FrobeniusCounterexample
open scoped BigOperators
set_option maxHeartbeats 0
set_option maxRecDepth 1000000
abbrev Site := Fin 7
abbrev Row := Fin 6

def raw : Row → Labels ℤ 7 := ![![(1,0),(0,0),(0,0),(0,1),(0,0),(0,1),(1,0)],![(0,1),(1,0),(0,1),(0,0),(0,1),(0,1),(0,1)],![(0,0),(0,1),(1,0),(0,1),(0,1),(0,0),(0,0)],![(0,0),(0,0),(0,1),(1,0),(0,0),(0,1),(0,1)],![(0,1),(0,1),(0,1),(0,0),(1,1),(0,1),(0,1)],![(0,0),(0,0),(0,0),(0,0),(0,0),(1,0),(1,1)]]
def lifted : Row → Labels ℤ 7 := ![![(1,0),(0,0),(0,0),(0,1),(0,0),(0,1),(1,0)],![(0,-1),(1,0),(0,1),(0,0),(0,1),(0,1),(0,1)],![(0,0),(0,1),(1,0),(0,1),(0,1),(0,0),(0,0)],![(0,0),(0,0),(0,1),(1,0),(0,0),(0,1),(0,1)],![(0,-1),(0,1),(0,1),(0,0),(1,1),(0,1),(0,1)],![(0,0),(0,2),(0,0),(0,2),(0,2),(1,0),(1,1)]]

/-- Only the strictly lower triangular part of the leading phase block changes. -/
def recipe (q : Row → Labels ℤ 7) (g : Row) (i : Site) : ℤ × ℤ :=
  ((q g i).1, (q g i).2 + if h : i.val<g.val then
    bracket (q g) (q ⟨i.val,by omega⟩) else 0)

theorem prescribed : (∀ g i, (raw g i).1∈({0,1}:Finset ℤ) ∧ (raw g i).2∈({0,1}:Finset ℤ)) ∧
    (∀ g i : Row, (raw g i.castSucc).1 = if g=i then 1 else 0) ∧
    ∀ (g : Row) (i : Site), recipe raw g i = lifted g i := by decide +kernel

variable {R : Type*} [CommRing R]
def enc (c : Row → R) : Labels R 7 := ![(c 0,-c 1-c 4),(c 1,c 2+c 4+2*c 5),(c 2,c 1+c 3+c 4),(c 3,c 0+c 2+2*c 5),(c 4,c 1+c 2+c 4+2*c 5),(c 5,c 0+c 1+c 3+c 4),(c 0+c 5,c 1+c 3+c 4+c 5)]

def encoder (R : Type*) [CommRing R] : (Row→R) →ₗ[R] Labels R 7 where
  toFun := enc
  map_add' a b := by funext i; fin_cases i <;> apply Prod.ext <;> dsimp [enc] <;> ring
  map_smul' c a := by funext i; fin_cases i <;> apply Prod.ext <;> dsimp [enc] <;> ring

def code (R : Type*) [CommRing R] := LinearMap.range (encoder R)
def rowR (g : Row) : Labels R 7 := enc (Pi.single g 1)

theorem integer_matrix : ∀ (g : Row) (i : Site), rowR (R:=ℤ) g i=lifted g i := by decide +kernel
theorem binary_matrix : ∀ (g : Row) (i : Site), rowR (R:=ZMod 2) g i=
    (((raw g i).1:ZMod 2),((raw g i).2:ZMod 2)) := by decide +kernel

theorem pivot (c : Row→R) (i : Row) : (enc c i.castSucc).1=c i := by fin_cases i <;> rfl

theorem independent : Function.Injective (enc (R:=R)) := by
  intro a b e
  funext i
  simpa only [pivot] using congrArg (fun x: Labels R 7 => (x i.castSucc).1) e

theorem isotropic (R : Type*) [CommRing R] : Isotropic (code R) := by
  rintro _ ⟨a,rfl⟩ _ ⟨b,rfl⟩
  change bracket (enc a) (enc b)=0
  simp [enc,bracket,Fin.sum_univ_succ] <;> ring

def short (R : Type*) [CommRing R] : Labels R 7 :=
  ![0,0,0,0,0,(1,-2),(-1,1)]

theorem short_normal (R : Type*) [CommRing R] (y) (hy:y∈code R) :
    bracket (short R) y=0 := by
  obtain ⟨c,rfl⟩ := hy
  change bracket (short R) (enc c)=0
  simp [short,enc,bracket,Fin.sum_univ_succ] <;> ring

theorem short_logical (R : Type*) [CommRing R] (h2 : (2:R)≠0) :
    logical (code R) (short R) := by
  refine ⟨short_normal R,?_⟩
  rintro ⟨c,e⟩
  change enc c = short R at e
  have ce (i : Row) : c i = (short R i.castSucc).1 := by
    rw [←e,pivot]
  have t := congrArg (fun x:Labels R 7 => (x 6).1) e
  change c 0 + c 5 = -1 at t
  simp only [ce] at t
  change (0:R)+1 = -1 at t
  exact h2 (by linear_combination t)

theorem short_weight (R : Type*) [CommRing R] [DecidableEq R] [Nontrivial R] :
    wt (short R)=2 := by
  have s : (Finset.univ.filter fun i:Site=>short R i≠0) = {5,6} := by
    ext i; fin_cases i <;> simp [short,Prod.mk.injEq]
  simp [wt,s]

end PrescribedLDI

namespace PrescribedLDI
open CyclicPauli FrobeniusCounterexample
open scoped BigOperators
set_option maxHeartbeats 0
set_option maxRecDepth 1000000

abbrev F := ZMod 2
def twoSites (i j : Site) (u v : F×F) : Labels F 7 :=
  fun k => if k=i then u else if k=j then v else 0

private theorem binary_test : ∀ (i j : Site) (u v : F×F),
    (∀ g:Row, bracket (twoSites i j u v) (rowR g)=0) →
    ∀ k:Site, twoSites i j u v k = enc (fun a:Row => (twoSites i j u v a.castSucc).1) k := by
  decide +kernel

private theorem tiny_supported {R : Type*} [CommRing R] [DecidableEq R]
    (b : Labels R 7) (small : wt b≤2) : ∃ i j : Site,
      ∀ k : Site, k≠i → k≠j → b k=0 := by
  let s := (Finset.univ : Finset Site).filter (fun i=> b i≠0)
  obtain ⟨t,st,_,ht⟩ := Finset.exists_subsuperset_card_eq (Finset.subset_univ s) small
    (show 2≤ (Finset.univ : Finset Site).card by decide)
  obtain ⟨i,j,_,h⟩ := Finset.card_eq_two.mp ht
  refine ⟨i,j,fun k ki kj => ?_⟩
  by_contra h'
  have hm : k∈t := st (Finset.mem_filter.mpr ⟨Finset.mem_univ _,h'⟩)
  simpa [h,ki,kj] using hm

private theorem binary_lower (e : Labels F 7) (h : logical (code F) e) : 3≤wt e := by
  by_contra! small
  obtain ⟨i,j,off⟩ := tiny_supported e (by omega)
  have ee : e=twoSites i j (e i) (e j) := by
    funext k
    by_cases ki:k=i
    · simp [twoSites,ki]
    · by_cases kj:k=j
      · subst k; simp [twoSites,ki]
      · simp [twoSites,ki,kj,off k ki kj]
  have norm (g:Row) : bracket (twoSites i j (e i) (e j)) (rowR g)=0 := by
    rw [← ee]
    exact h.1 (rowR g) ⟨Pi.single g 1,rfl⟩
  have recon :=  funext (binary_test i j (e i) (e j) norm)
  rw [← ee] at recon
  exact h.2 ⟨fun a:Row=>(e a.castSucc).1,recon.symm⟩

def three : Labels F 7 := ![(1,0),(1,1),(0,1),0,0,0,0]

private theorem three_logical : logical (code F) three := by
  constructor
  · rintro _ ⟨c,rfl⟩
    change bracket three (enc c)=0
    revert c
    decide +kernel
  · rintro ⟨c,e⟩
    change enc c=three at e
    have h (i:Row) : c i=(three i.castSucc).1 := by rw [←e,pivot]
    have he : c=fun i:Row=>(three i.castSucc).1 := funext h
    rw [he] at e
    exact (by decide : enc (fun i:Row=>(three i.castSucc).1)≠three) e

theorem binary_distance : relativeDistance (code F)=3 := by
  let s : Set ℕ := {w | ∃ x : Labels F 7, logical (code F) x ∧ wt x=w}
  have h3 : 3∈s := ⟨three,three_logical,by decide⟩
  change sInf s=3
  apply le_antisymm (Nat.sInf_le h3)
  · apply le_csInf ⟨3,h3⟩
    rintro _ ⟨x,h,rfl⟩
    exact binary_lower x h

theorem large_distance_le_two (p : ℕ) [Fact p.Prime] (hp : 2<p) :
    relativeDistance (code (ZMod p))≤2 := by
  have h2 : (2:ZMod p) ≠ 0 := by
    intro z
    have e := congrArg ZMod.val z
    simp [ZMod.val_ofNat,Nat.mod_eq_of_lt hp] at e
  exact Nat.sInf_le ⟨short _,short_logical _ h2,short_weight _⟩

#print axioms binary_distance
#print axioms large_distance_le_two
end PrescribedLDI

namespace PrescribedLDI
open CyclicPauli FrobeniusCounterexample
set_option maxHeartbeats 0

theorem enc_cast (R : Type*) [CommRing R] (c : Row→ℤ) (i : Site) :
    enc (fun a => (c a:R)) i = (((enc c i).1:R),((enc c i).2:R)) := by
  fin_cases i <;> simp [enc]

/-- The checks used over every target ring are the coefficientwise images
of exactly the integers produced by the prescribed binary lift. -/
theorem change_ring (R : Type*) [CommRing R] (g : Row) (i : Site) :
    rowR (R:=R) g i = (((recipe raw g i).1:R),((recipe raw g i).2:R)) := by
  rw [prescribed.2.2 g i]
  rw [← integer_matrix g i]
  have single_cast : (Pi.single g 1 : Row→R) = fun a : Row => (((Pi.single g 1 : Row→ℤ) a):R) := by
    funext a
    by_cases h : a=g <;> simp [Pi.single_apply,h]
  unfold rowR
  rw [single_cast]
  exact enc_cast R _ i

noncomputable def freeBasis (R : Type*) [CommRing R] : (Row→R) ≃ₗ[R] code R :=
  LinearEquiv.ofInjective (encoder R) independent

theorem free (R : Type*) [CommRing R] : Module.Free R (code R) :=
  Module.Free.of_equiv (freeBasis R)

theorem binary_degenerate : short (ZMod 2)∈code (ZMod 2) ∧ wt (short (ZMod 2))=2 := by
  refine ⟨⟨Pi.single (5:Row) 1,?_⟩,short_weight _⟩
  decide +kernel

#print axioms change_ring
#print axioms binary_degenerate
end PrescribedLDI

/-! An integral pair of checks with local entries (1,0) and (0,1) exists
at every site. This rules out single-site centralizer elements over every
commutative ring, including composite cyclic alphabets. -/
namespace PrescribedLDI
open CyclicPauli FrobeniusCounterexample
open scoped BigOperators
variable {R : Type*} [CommRing R]
private def localX (i : Site) : Row→ℤ := ![![1,0,0,0,0,0],![0,1,0,0,0,0],![0,0,1,0,0,0],![0,0,0,1,0,0],![0,-1,0,0,1,0],![0,0,0,0,0,1],![1,0,0,0,0,0]] i
private def localZ (i : Site) : Row→ℤ := ![![0,-1,0,0,0,0],![0,0,1,0,0,0],![0,1,0,0,0,0],![1,0,0,0,0,0],![0,1,0,0,0,0],![1,0,0,0,0,0],![0,1,0,0,0,0]] i

private theorem local_tests (i : Site) :
    enc (fun a => (localX i a:R)) i=(1,0) ∧ enc (fun a => (localZ i a:R)) i=(0,1) := by
  have cert : ∀ k : Site, enc (localX k) k=(1,0) ∧ enc (localZ k) k=(0,1) := by decide +kernel
  rw [enc_cast,enc_cast,(cert i).1,(cert i).2]
  simp

private theorem local_bracket (x y : Labels R 7) (i : Site)
    (off : ∀ j, j≠i → x j=0) :
    bracket x y=(x i).1*(y i).2-(x i).2*(y i).1 := by
  unfold bracket
  apply Finset.sum_eq_single i
  · intro j _ hj; simp [off j hj]
  · simp

/-- A commuting Pauli label supported on at most one site vanishes. -/
theorem one_site_zero [DecidableEq R] (x : Labels R 7)
    (h : ∀ y∈code R, bracket x y=0) (small : wt x≤1) : x=0 := by
  let s := (Finset.univ : Finset Site).filter (fun i => x i≠0)
  obtain ⟨t,st,_,ht⟩ := Finset.exists_subsuperset_card_eq (Finset.subset_univ s) small
    (show 1≤ (Finset.univ : Finset Site).card by decide)
  obtain ⟨i,rfl⟩ := Finset.card_eq_one.mp ht
  have off (j : Site) (ji : j≠i) : x j=0 := by
    by_contra hn
    exact ji (Finset.mem_singleton.mp (st (Finset.mem_filter.mpr ⟨Finset.mem_univ _,hn⟩)))
  have hx := h (enc (fun a => (localX i a:R))) ⟨fun a => (localX i a:R),rfl⟩
  have hz := h (enc (fun a => (localZ i a:R))) ⟨fun a => (localZ i a:R),rfl⟩
  rw [local_bracket _ _ i off, (local_tests i).1] at hx
  rw [local_bracket _ _ i off, (local_tests i).2] at hz
  simp at hx hz
  funext j
  by_cases ji:j=i
  · subst j; exact Prod.ext hz hx
  · exact off j ji

/-- The exact distance in arbitrary characteristic not dividing 2, including nonfields. -/
theorem lifted_distance (R : Type*) [CommRing R] [DecidableEq R] [Nontrivial R]
    (h2 : (2:R)≠0) : relativeDistance (code R)=2 := by
  let s : Set ℕ := {w | ∃ x : Labels R 7, logical (code R) x ∧ wt x=w}
  have h2s : 2∈s := ⟨short R,short_logical R h2,short_weight R⟩
  change sInf s=2
  apply le_antisymm (Nat.sInf_le h2s)
  apply le_csInf ⟨2,h2s⟩
  rintro _ ⟨x,h,rfl⟩
  by_contra! small
  have e := one_site_zero x h.1 (by omega)
  exact h.2 (e ▸ (code R).zero_mem)

theorem large_distance (m : ℕ) (hm : 2 < m) :
    relativeDistance (code (ZMod m))=2 := by
  letI : Fact (1 < m) := ⟨by omega⟩
  have h2 : (2:ZMod m)≠0 := by
    intro z
    have e := congrArg ZMod.val z
    simp [ZMod.val_ofNat,Nat.mod_eq_of_lt hm] at e
  exact lifted_distance (ZMod m) h2

theorem no_prime_cutoff (bound : ℕ) : ∃ p > bound, Nat.Prime p ∧
    relativeDistance (code (ZMod p)) < relativeDistance (code (ZMod 2)) := by
  obtain ⟨p,hp,prime⟩ := Nat.exists_infinite_primes (bound+3)
  exact ⟨p,by omega,prime,by rw [large_distance p (by omega),binary_distance]; decide⟩

#print axioms no_prime_cutoff
#print axioms one_site_zero
#print axioms large_distance
end PrescribedLDI

/-! An eight-site counterexample for the centered systematic CSS lift in Eq. (13)
of Islam, Reza and Gunderman (2026). Vectors and stabilizer spans below are
over the same ring as the Pauli labels. -/
namespace CanonicalSteane
open scoped BigOperators
set_option maxRecDepth 8000
set_option maxHeartbeats 0
abbrev Vec (R : Type*) := Fin 8 → R
def xInteger : Fin 4 → Vec ℤ :=
  ![![-3,-2,-2,-1,-1,-1,0,0],![-2,-3,-2,-1,-1,0,-1,0],
    ![-2,-2,-3,-1,0,-1,-1,0],![-1,-1,-2,0,0,-1,-1,-1]]
def zInteger : Fin 3 → Vec ℤ :=
  ![![1,0,0,-1,-1,-1,0,0],![0,1,0,-1,-1,0,-1,0],![0,0,1,-1,0,-1,-1,0]]
def xs (R : Type*) [CommRing R] (j : Fin 4) (i : Fin 8) : R := (xInteger j i : R)
def zs (R : Type*) [CommRing R] (j : Fin 3) (i : Fin 8) : R := (zInteger j i : R)
def anc (R : Type*) [CommRing R] : Vec R := ![0,0,0,0,0,0,0,1]
def xspan {R : Type*} [CommRing R] (v : Vec R) := ∃ a b c d : R,
    ∀ i,v i=a*xs R 0 i+b*xs R 1 i+c*xs R 2 i+d*xs R 3 i
def zspan {R : Type*} [CommRing R] (v : Vec R) := ∃ a b c : R,
    ∀ i,v i=a*zs R 0 i+b*zs R 1 i+c*zs R 2 i
def xnormal {R : Type*} [CommRing R] (v : Vec R) :=
  ∀ j : Fin 3, (∑ i,v i*zs R j i)=0
def znormal {R : Type*} [CommRing R] (v : Vec R) :=
  ∀ j : Fin 4,(∑ i,v i*xs R j i)=0
def wt {R : Type*} [Zero R] [DecidableEq R] (x z : Vec R) : ℕ :=
    (Finset.univ.filter fun i => x i ≠ 0 ∨ z i ≠ 0).card

/-- The Z pivot block is the identity. Both tails use exactly the centered
binary representatives, and each X pivot is the prescribed entry of -C D^T. -/
theorem centered_systematic_recipe :
    (∀ i j : Fin 3,zInteger i (Fin.castAdd 5 j) = if i=j then 1 else 0) ∧
    (∀ j (k : Fin 5),zInteger j (Fin.natAdd 3 k)=0 ∨ zInteger j (Fin.natAdd 3 k)= -1) ∧
    (∀ j (k : Fin 5),xInteger j (Fin.natAdd 3 k)=0 ∨ xInteger j (Fin.natAdd 3 k)= -1) ∧
    (∀ i j,xInteger i (Fin.castAdd 5 j) =
        -(∑ k : Fin 5,xInteger i (Fin.natAdd 3 k)*zInteger j (Fin.natAdd 3 k))) := by
  decide +kernel

theorem commutes {R : Type*} [CommRing R] (j : Fin 4) : xnormal (xs R j) := by
  intro h
  fin_cases j <;> fin_cases h <;> norm_num [xs,zs,xInteger,zInteger,Fin.sum_univ_succ]

/-- In all moduli greater than two there is a nontrivial single-site X error. -/
theorem target_weight_one (m : ℕ) (hm : 2 < m) :
    xnormal (anc (ZMod m)) ∧ ¬xspan (anc (ZMod m)) ∧ wt (anc (ZMod m)) 0=1 := by
  letI : NeZero m := ⟨by omega⟩
  haveI : Nontrivial (ZMod m) := ZMod.nontrivial_iff.2 (by omega)
  refine ⟨?_,?_,?_⟩
  · intro j
    fin_cases j <;> norm_num [anc,zs,zInteger,Fin.sum_univ_succ]
  · rintro ⟨a,b,c,d,h⟩
    have e3 := h 3
    change 0 = a*((-1 : ℤ) : ZMod m) + b*((-1 : ℤ) : ZMod m) + c*((-1 : ℤ) : ZMod m) + d*((0 : ℤ) : ZMod m) at e3
    have e4 := h 4
    change 0 = a*((-1 : ℤ) : ZMod m) + b*((-1 : ℤ) : ZMod m) + c*((0 : ℤ) : ZMod m) + d*((0 : ℤ) : ZMod m) at e4
    have e5 := h 5
    change 0 = a*((-1 : ℤ) : ZMod m) + b*((0 : ℤ) : ZMod m) + c*((-1 : ℤ) : ZMod m) + d*((-1 : ℤ) : ZMod m) at e5
    have e6 := h 6
    change 0 = a*((0 : ℤ) : ZMod m) + b*((-1 : ℤ) : ZMod m) + c*((-1 : ℤ) : ZMod m) + d*((-1 : ℤ) : ZMod m) at e6
    have e7 := h 7
    change 1 = a*((0 : ℤ) : ZMod m) + b*((0 : ℤ) : ZMod m) + c*((0 : ℤ) : ZMod m) + d*((-1 : ℤ) : ZMod m) at e7
    norm_num at e3 e4 e5 e6 e7
    have bad : (2 : ZMod m)=0 := by linear_combination 2*e3-e4-e5-e6+2*e7
    exact Nat.not_dvd_of_pos_of_lt (by decide) hm ((ZMod.natCast_eq_zero_iff 2 m).mp bad)
  · have sf : (Finset.univ.filter fun i => (anc (ZMod m)) i≠0 ∨ (0 : Vec (ZMod m)) i≠0) = {7} := by
      ext i
      fin_cases i <;> simp [anc]
    simp only [wt,sf,Finset.card_singleton]

theorem x_injective {R : Type*} [CommRing R] (a b c d : R)
    (h : ∀ i,a*xs R 0 i+b*xs R 1 i+c*xs R 2 i+d*xs R 3 i=0) :
    a=0 ∧ b=0 ∧ c=0 ∧ d=0 := by
  have e3 := h 3
  change a*((-1 : ℤ) : R) + b*((-1 : ℤ) : R) + c*((-1 : ℤ) : R) + d*((0 : ℤ) : R) = 0 at e3
  have e4 := h 4
  change a*((-1 : ℤ) : R) + b*((-1 : ℤ) : R) + c*((0 : ℤ) : R) + d*((0 : ℤ) : R) = 0 at e4
  have e5 := h 5
  change a*((-1 : ℤ) : R) + b*((0 : ℤ) : R) + c*((-1 : ℤ) : R) + d*((-1 : ℤ) : R) = 0 at e5
  have e6 := h 6
  change a*((0 : ℤ) : R) + b*((-1 : ℤ) : R) + c*((-1 : ℤ) : R) + d*((-1 : ℤ) : R) = 0 at e6
  have e7 := h 7
  change a*((0 : ℤ) : R) + b*((0 : ℤ) : R) + c*((0 : ℤ) : R) + d*((-1 : ℤ) : R) = 0 at e7
  norm_num at e3 e4 e5 e6 e7
  exact ⟨by linear_combination e3-e4-e5-e7, by linear_combination -e3+e5+e7,
         by linear_combination -e3+e4,e7⟩

theorem z_injective {R : Type*} [CommRing R] (a b c : R)
    (h : ∀ i,a*zs R 0 i+b*zs R 1 i+c*zs R 2 i=0) : a=0 ∧ b=0 ∧ c=0 := by
  have h0 := h 0; have h1 := h 1; have h2 := h 2
  change a*((1:ℤ):R)+b*((0:ℤ):R)+c*((0:ℤ):R)=0 at h0
  change a*((0:ℤ):R)+b*((1:ℤ):R)+c*((0:ℤ):R)=0 at h1
  change a*((0:ℤ):R)+b*((0:ℤ):R)+c*((1:ℤ):R)=0 at h2
  norm_num at h0 h1 h2
  exact ⟨h0,h1,h2⟩

abbrev F := ZMod 2

/-- Separate component bounds avoid enumerating pairs of error vectors. -/
private theorem x_lower : ∀ v : Vec F, xnormal v → wt v 0 ≤ 2 → xspan v := by
  unfold xnormal wt xspan xs zs xInteger zInteger
  decide +kernel
private theorem z_lower : ∀ v : Vec F, znormal v → wt 0 v ≤ 2 → zspan v := by
  unfold znormal wt zspan xs zs xInteger zInteger
  decide +kernel

theorem binary_lower (x z : Vec F) (hx : xnormal x) (hz : znormal z) (w : wt x z ≤ 2) :
    xspan x ∧ zspan z := by
  constructor
  · apply x_lower x hx
    apply le_trans _ w
    apply Finset.card_le_card
    intro i hi
    simp at hi ⊢
    exact Or.inl hi
  · apply z_lower z hz
    apply le_trans _ w
    apply Finset.card_le_card
    intro i hi
    simp at hi ⊢
    exact Or.inr hi

theorem binary_upper :
    ∃ v : Vec F,xnormal v ∧ ¬xspan v ∧ wt v 0=3 := by
  refine ⟨![1,1,0,0,1,0,0,0],?_⟩
  unfold xnormal wt xspan xs zs xInteger zInteger
  decide +kernel

#print axioms centered_systematic_recipe
#print axioms target_weight_one
#print axioms binary_lower
#print axioms binary_upper
end CanonicalSteane

namespace CanonicalSteane

/-- CSS distance, counting each physical site once even when both components act there. -/
noncomputable def relativeDistance (R : Type*) [CommRing R] [DecidableEq R] : ℕ :=
  sInf {w | ∃ x z : Vec R, xnormal x ∧ znormal z ∧ ¬(xspan x ∧ zspan z) ∧ wt x z=w}

private theorem zero_normal (R : Type*) [CommRing R] : znormal (0 : Vec R) := by simp [znormal]

theorem exact_binary_distance : relativeDistance (ZMod 2)=3 := by
  obtain ⟨x,hx,logical,hw⟩ := binary_upper
  have member : 3 ∈ {w | ∃ x z : Vec F,xnormal x ∧ znormal z ∧ ¬(xspan x ∧ zspan z) ∧ wt x z=w} :=
    ⟨x,0,hx,zero_normal _,fun e => logical e.1,hw⟩
  apply le_antisymm (Nat.sInf_le member)
  apply le_csInf ⟨3,member⟩
  rintro _ ⟨v,z,hn,hz,hs,rfl⟩
  by_contra! small
  exact hs (binary_lower v z hn hz (by omega))

theorem exact_target_distance (m : ℕ) (hm : 2 < m) : relativeDistance (ZMod m)=1 := by
  let R := ZMod m
  obtain ⟨hx,logical,hw⟩ := target_weight_one m hm
  have member : 1 ∈ {w | ∃ x z : Vec R,xnormal x ∧ znormal z ∧ ¬(xspan x ∧ zspan z) ∧ wt x z=w} :=
    ⟨anc R,0,hx,zero_normal _,fun e => logical e.1,hw⟩
  apply le_antisymm (Nat.sInf_le member)
  apply le_csInf ⟨1,member⟩
  rintro _ ⟨v,z,_,_,hs,rfl⟩
  by_contra! small
  have empty : Finset.univ.filter (fun i => v i ≠ 0 ∨ z i ≠ 0)=∅ :=
    Finset.card_eq_zero.mp (by change wt v z=0; omega)
  have zero (i : Fin 8) : v i=0 ∧ z i=0 := by
    by_contra! hn
    have h : i ∈ Finset.univ.filter (fun j => v j ≠ 0 ∨ z j ≠ 0) :=
      Finset.mem_filter.mpr ⟨Finset.mem_univ _,by tauto⟩
    rw [empty] at h
    exact Finset.notMem_empty _ h
  exact hs ⟨⟨0,0,0,0,fun i => by simp [(zero i).1]⟩,
    ⟨0,0,0,fun i => by simp [(zero i).2]⟩⟩
end CanonicalSteane

/-- The three finite examples in one statement. The seven- and eight-site
input distances hold for the original binary codes and the target statements
hold for every cyclic modulus above two. -/
theorem distance_collapse_examples :
    FrobeniusCounterexample.relativeDistance (FrobeniusCounterexample.code (ZMod 4))=1 ∧
    FrobeniusCounterexample.relativeDistance (FrobeniusCounterexample.code (ZMod 2))=2 ∧
    FrobeniusCounterexample.relativeDistance (PrescribedLDI.code (ZMod 2))=3 ∧
    (∀ m:ℕ, 2 < m → FrobeniusCounterexample.relativeDistance (PrescribedLDI.code (ZMod m))=2) ∧
    CanonicalSteane.relativeDistance (ZMod 2)=3 ∧
    ∀ m:ℕ, 2 < m → CanonicalSteane.relativeDistance (ZMod m)=1 :=
  ⟨FrobeniusCounterexample.ring_distance,FrobeniusCounterexample.field_distance,
   PrescribedLDI.binary_distance,PrescribedLDI.large_distance,
   CanonicalSteane.exact_binary_distance,CanonicalSteane.exact_target_distance⟩

#print axioms distance_collapse_examples
