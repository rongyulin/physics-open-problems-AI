import Std
import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.LinearAlgebra.Dimension.Finite
import Mathlib.Tactic.Ring
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-! Single-file verification of the complex Perkel dimension lower bound.
    Lean 4.28.0, Mathlib v4.28.0. See also the full Lake project for attainability. -/

section

/-! A finite certificate for the Perkel graph with Brouwer's labelling.
   Vertices are (layer,index) in Z/3 × Z/19. For consecutive layers in
   cyclic order, the cube of the index difference is 2^(6*layer) mod 19.
   The Boolean adjacency below is computed directly from this equation.
   Tables used as witnesses are checked against it in the Lean kernel. -/
namespace PerkelGraph
set_option maxHeartbeats 0
set_option maxRecDepth 300000
abbrev V := Fin 57
private def forward (v w : V) : Bool :=
  ((v.val / 19 + 1) % 3 == w.val / 19) &&
  ((19 + w.val % 19 - v.val % 19)^3 % 19 == 2^(6*(v.val / 19)) % 19)

def adj (v w : V) : Bool := forward v w || forward w v
private def nbData (i : Nat) : Nat := (0x85f7103c481e6cf3837dd68e34279c64d30175b60c2c071a5d22ca6d959128969855024865750f2076164ce1c695754d18591650c1448d54cb10396250a0c29214c90819638080409227d21c08e17924468a0751405baba512c7b6aa10286b299cf245ae898e204e2a9cd1c3de998c182e36a0b141df59ca100db4992243e35cd1202df4c901c1db3c4f180d72c12385d31bd1344cf0b90303cafb4f2c2c6eb0e281c2dacd240beca92308ce89dd653ca79a5718e319a46d7e37c23696df6be2655db5ba1614d74b605d3d33b257d6cf2ae4795cb1aa3754c70a62713c2fa2585bbee9e481abad9a37d9e2db22798decae1757dabaa0716d6aa5f6d5d29a1e694 >>> (6*i)) % 64
private def colorData (i : Nat) : Nat := (0x209400626981258a6a6056426585292108a16a81011298511496a546841a00246510869165662a606692800246510689165664218669280a98848114a554808859284a1a56a252251068009166421a459680a9819a486459a42a94544689064182a01290155262996609a2a225216209054009400626881258a6a6656426585019a42aa1914689065152a0129106059a42aa1904689065152a01291061aa92108a11481011299a11496a5490aa86459a24194544604a44182a2459a42aa1544689065182a012910108a16aa4811298520496a54684500626882508a6a6604966585015906459a42aa0544689065182a012912055498a6518268a889485882415055498a6580268a889465882415022aaaaaaaaa5555555554000000000 >>> (2*i)) % 4
private def witness (i : Nat) : Nat := (0xc32054018567481e80adc00b1022010251cc0384c52002819840431e30818223d0011201601a310500914e820086484405902e101a6414e049c4c300a3219a071584300a413060204ca480a8184800a84828062394205046b101216106018562801e669c201a0b00813040c207048340088135204888a300458242029829400c3415801bd85101ea10c804ac24500e91acc048c2658026110600a5e7601046a8200954938041239601896d381875104012924380e95056072987200a910600328e8081a24058009d281008b130e0644a25802a31ca0 >>> (5*i)) % 32
private def selData (i : Nat) : Nat := (0x240060908040400114600980524510218524404524858800800a18518504614020110054010a08400120940214400048980404050210800104561089191899211955a590458699555295851a9541469849925a29955 >>> (2*i)) % 4
private def parentData (i : Nat) : Nat := (0xf79a78068969418d5045090007a2a68a68369a00d33d00c34c2dc404a89f16b6534d1e529a1ab5eaeba40 >>> (6*i)) % 64

def nb (v : V) (i : Fin 6) : V := Fin.ofNat 57 (nbData (6*v.val+i.val))
private def baseColor (c : Fin 20) (v : V) : Fin 3 :=
  Fin.ofNat 3 (colorData (57*c.val+v.val))
private def which (v : V) (r : Fin 6) : Fin 20 := Fin.ofNat 20 (witness (6*v.val+r.val))
def col (v : V) (r : Fin 6) (w : V) : Fin 3 := baseColor (which v r) w
def sel (v : V) (r : Fin 6) : Fin 3 := Fin.ofNat 3 (selData (6*v.val+r.val))
def tr0 (r : Fin 6) : Fin 6 := #[0,0,0,0,0,1][r.val]!
def tr1 (r : Fin 6) : Fin 6 := #[1,1,1,1,2,2][r.val]!
def tr2 (r : Fin 6) : Fin 6 := #[2,3,4,5,3,3][r.val]!

private def allF {n : Nat} (p : Fin n → Bool) : Bool := (List.finRange n).all p
private theorem spec {n : Nat} {p : Fin n → Bool} (h : allF p = true) (v : Fin n) : p v = true :=
  List.all_eq_true.mp h v (List.mem_finRange _)
private theorem from2 {n m : Nat} (p : Fin n → Fin m → Prop) [∀x y, Decidable (p x y)]
    (h : allF (fun x => allF (fun y => decide (p x y))) = true) : ∀x y,p x y :=
  fun x y => of_decide_eq_true (spec (spec h x) y)
private theorem from3 {n m k : Nat} (p : Fin n → Fin m → Fin k → Prop)
    [∀ x y z, Decidable (p x y z)] (h : allF (fun x => allF (fun y => allF (fun z => decide (p x y z)))) = true) : ∀ x y z, p x y z :=
  fun x y z => of_decide_eq_true (spec (spec (spec h x) y) z)
theorem adjacent_symm : ∀ v w : V, adj v w = adj w v := by
  intro v w
  exact Bool.or_comm _ _

theorem sixth : ∀ v w : V, adj v w = true → ∃ i : Fin 6, w = nb v i  := by
  apply from2
  rfl

theorem neighborEdge : ∀ (v : V) (i : Fin 6), adj v (nb v i) = true  := by
  apply from2
  rfl

private theorem proper_on_nb : ∀ (c : Fin 20) (v : V) (i : Fin 6),
    baseColor c v ≠ baseColor c (nb v i)  := by
  apply from3
  rfl

theorem proper (v : V) (r : Fin 6) (u w : V) (h : adj u w = true) :
    col v r u ≠ col v r w := by
  obtain ⟨i,rfl⟩ := sixth u w h
  exact proper_on_nb (which v r) u i

theorem excluded : ∀ (v : V) (r : Fin 6), col v r v ≠ sel v r  := by
  apply from2
  rfl

private theorem local_slice : ∀ (v : V) (r i : Fin 6),
    col v r (nb v i) = sel v r ↔
    (i = tr0 r ∨ i = tr1 r ∨ i = tr2 r)  := by
  apply from3
  rfl

theorem slice3 (v : V) (r : Fin 6) (w : V) :
    (col v r w = sel v r ∧ adj v w = true) ↔
    (w = nb v (tr0 r) ∨ w = nb v (tr1 r) ∨ w = nb v (tr2 r)) := by
  constructor
  · rintro ⟨hc, he⟩
    obtain ⟨i,rfl⟩ := sixth v w he
    rcases (local_slice v r i).mp hc with h|h|h
    · exact Or.inl (congrArg (nb v) h)
    · exact Or.inr (Or.inl (congrArg (nb v) h))
    · exact Or.inr (Or.inr (congrArg (nb v) h))
  · intro h
    rcases h with rfl|rfl|rfl
    · exact ⟨(local_slice _ _ _).mpr (Or.inl rfl), neighborEdge _ _⟩
    · exact ⟨(local_slice _ _ _).mpr (Or.inr (Or.inl rfl)), neighborEdge _ _⟩
    · exact ⟨(local_slice _ _ _).mpr (Or.inr (Or.inr rfl)), neighborEdge _ _⟩

theorem triple_nodup : ∀ (v : V) (r : Fin 6),
    nb v (tr0 r) ≠ nb v (tr1 r) ∧ nb v (tr0 r) ≠ nb v (tr2 r) ∧
    nb v (tr1 r) ≠ nb v (tr2 r)  := by
  apply from2
  rfl

private def parent (v : V) : V := Fin.ofNat 57 (parentData (v.val))
private theorem spans : ∀ v, v = parent v ∨ adj v (parent v) = true := by decide
private theorem depth : ∀ v, parent (parent (parent v)) = 0 := by decide

theorem eq_of_edge_eq {α : Type u} {f : V → α}
    (h : ∀ v w, adj v w = true → f v = f w) (v : V) : f v = f 0 := by
  have hp (w : V) : f w = f (parent w) := by
    rcases spans w with e|e
    · exact congrArg f e
    · exact h _ _ e
  calc
    f v = f (parent v) := hp v
    _ = f (parent (parent v)) := hp _
    _ = f (parent (parent (parent v))) := hp _
    _ = f 0 := congrArg f (depth v)

#print axioms proper
#print axioms slice3
#print axioms eq_of_edge_eq
end PerkelGraph

end

section

/-! An integer left inverse, scaled by 627, for the principal Perkel Gram
block on vertices 0 through 36. The two data arrays are ordinary integers.
The proof checks each of the 1369 product entries inside the Lean kernel.
Dimension.lean ties the first array to the Perkel adjacency relation. -/
namespace PerkelRank
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def gramData : Array (Array Int) :=
#[#[3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
#[0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0],
#[0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0],
#[0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0],
#[0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0],
#[0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0],
#[0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1],
#[0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0],
#[0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0],
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0],
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
#[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
#[0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#[1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#[0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#[0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#[0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#[0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#[0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#[0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#[0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0],
#[0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0],
#[1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0],
#[0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0],
#[0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0],
#[0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0],
#[0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0],
#[0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0],
#[0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3]]
def inverseData : Array (Array Int) :=
#[#[743, 326, 335, 359, 422, 359, 446, 206, 350, 443, 446, 206, 371, 398, 380, 422, 359, 215, 377, -366, -528, -384, -321, -363, -345, -372, -537, -297, -300, -393, -537, -297, -384, -321, -384, -408, -417],
#[326, 647, 278, 311, 311, 374, 335, 230, 302, 323, 398, 230, 323, 278, 395, 311, 374, 167, 338, -321, -309, -480, -273, -336, -252, -369, -324, -417, -249, -324, -345, -417, -312, -273, -336, -336, -369],
#[335, 278, 647, 302, 311, 311, 398, 167, 374, 323, 326, 230, 395, 278, 323, 374, 311, 230, 338, -369, -312, -309, -417, -336, -273, -324, -369, -252, -417, -321, -324, -273, -480, -249, -336, -336, -345],
#[359, 311, 302, 695, 326, 335, 359, 254, 335, 419, 350, 182, 419, 374, 347, 326, 398, 191, 425, -393, -384, -336, -270, -504, -297, -369, -348, -321, -276, -513, -345, -276, -360, -441, -336, -360, -369],
#[422, 311, 311, 326, 695, 326, 359, 191, 398, 356, 422, 182, 347, 374, 419, 326, 326, 254, 362, -369, -384, -384, -273, -333, -441, -369, -369, -276, -321, -348, -513, -273, -339, -297, -504, -336, -369],
#[359, 374, 311, 335, 326, 695, 350, 191, 335, 419, 359, 254, 347, 302, 419, 398, 326, 182, 425, -369, -360, -384, -321, -336, -270, -513, -369, -297, -276, -393, -348, -441, -336, -276, -360, -504, -345],
#[446, 335, 398, 359, 359, 350, 743, 206, 359, 380, 446, 215, 443, 326, 371, 422, 422, 206, 377, -393, -384, -384, -345, -408, -297, -366, -537, -321, -321, -372, -417, -300, -528, -297, -363, -384, -537],
#[206, 230, 167, 254, 191, 191, 206, 407, 182, 212, 215, 110, 212, 230, 203, 182, 254, 110, 209, -201, -216, -216, -153, -240, -177, -201, -198, -297, -153, -225, -204, -177, -195, -297, -192, -195, -225],
#[350, 302, 374, 335, 398, 335, 359, 182, 695, 347, 359, 191, 419, 311, 419, 326, 326, 254, 425, -513, -336, -360, -297, -360, -321, -393, -345, -270, -441, -369, -369, -276, -384, -276, -504, -336, -348],
#[443, 323, 323, 419, 356, 419, 380, 212, 347, 737, 371, 212, 377, 395, 377, 419, 347, 203, 446, -390, -525, -357, -318, -381, -318, -414, -414, -294, -291, -534, -390, -318, -360, -342, -360, -525, -366],
#[446, 398, 326, 350, 422, 359, 446, 215, 359, 371, 743, 206, 380, 335, 443, 359, 422, 206, 377, -372, -384, -528, -297, -384, -321, -393, -417, -345, -297, -366, -537, -321, -384, -300, -408, -363, -537],
#[206, 230, 230, 182, 182, 254, 215, 110, 191, 212, 206, 407, 203, 167, 212, 254, 191, 110, 209, -201, -195, -216, -297, -192, -153, -225, -225, -177, -177, -201, -198, -297, -216, -153, -195, -240, -204],
#[371, 323, 395, 419, 347, 347, 443, 212, 419, 377, 380, 203, 737, 323, 377, 356, 419, 212, 446, -534, -357, -360, -318, -525, -294, -390, -390, -318, -342, -414, -366, -291, -525, -318, -381, -360, -414],
#[398, 278, 278, 374, 374, 302, 326, 230, 311, 395, 335, 167, 323, 647, 323, 311, 311, 230, 338, -324, -480, -312, -252, -336, -417, -321, -345, -273, -273, -369, -369, -249, -309, -417, -336, -336, -324],
#[380, 395, 323, 347, 419, 419, 371, 203, 419, 377, 443, 212, 377, 323, 737, 347, 356, 212, 446, -414, -360, -525, -294, -360, -318, -534, -366, -318, -318, -390, -414, -342, -357, -291, -525, -381, -390],
#[422, 311, 374, 326, 326, 398, 422, 182, 326, 419, 359, 254, 356, 311, 347, 695, 326, 191, 362, -348, -384, -339, -441, -336, -276, -369, -513, -273, -297, -369, -369, -321, -384, -273, -333, -504, -369],
#[359, 374, 311, 398, 326, 326, 422, 254, 326, 347, 422, 191, 419, 311, 356, 326, 695, 182, 362, -369, -339, -384, -276, -504, -273, -348, -369, -441, -273, -369, -369, -297, -384, -321, -336, -333, -513],
#[215, 167, 230, 191, 254, 182, 206, 110, 254, 203, 206, 110, 212, 230, 212, 191, 182, 407, 209, -225, -216, -195, -177, -195, -297, -201, -204, -153, -297, -201, -225, -153, -216, -177, -240, -192, -198],
#[377, 338, 338, 425, 362, 425, 377, 209, 425, 446, 377, 209, 446, 338, 446, 362, 362, 209, 749, -540, -387, -387, -303, -411, -303, -540, -372, -303, -324, -540, -372, -324, -387, -324, -411, -411, -372],
#[-366, -321, -369, -393, -369, -369, -393, -201, -513, -390, -372, -201, -534, -324, -414, -348, -369, -225, -540, 738, 360, 369, 306, 432, 306, 441, 369, 297, 369, 441, 369, 297, 432, 306, 432, 369, 378],
#[-528, -309, -312, -384, -384, -360, -384, -216, -336, -525, -384, -195, -357, -480, -360, -384, -339, -216, -387, 360, 720, 351, 297, 360, 360, 369, 432, 288, 288, 432, 432, 288, 351, 360, 360, 423, 369],
#[-384, -480, -309, -336, -384, -384, -384, -216, -360, -357, -528, -216, -360, -312, -525, -339, -384, -195, -387, 369, 351, 720, 288, 360, 297, 432, 369, 360, 288, 360, 432, 360, 351, 288, 423, 360, 432],
#[-321, -273, -417, -270, -273, -321, -345, -153, -297, -318, -297, -297, -318, -252, -294, -441, -276, -177, -303, 306, 297, 288, 594, 288, 234, 306, 369, 234, 297, 297, 297, 297, 360, 225, 288, 360, 306],
#[-363, -336, -336, -504, -333, -336, -408, -240, -360, -381, -384, -192, -525, -336, -360, -336, -504, -195, -411, 432, 360, 360, 288, 720, 288, 369, 369, 360, 297, 432, 360, 288, 423, 360, 351, 351, 432],
#[-345, -252, -273, -297, -441, -270, -297, -177, -321, -318, -321, -153, -294, -417, -318, -276, -273, -297, -303, 306, 360, 297, 234, 288, 594, 297, 306, 234, 297, 306, 369, 225, 288, 297, 360, 288, 297],
#[-372, -369, -324, -369, -369, -513, -366, -201, -393, -414, -393, -225, -390, -321, -534, -369, -348, -201, -540, 441, 369, 432, 306, 369, 297, 738, 369, 306, 306, 441, 378, 369, 360, 297, 432, 432, 369],
#[-537, -324, -369, -348, -369, -369, -537, -198, -345, -414, -417, -225, -390, -345, -366, -513, -369, -204, -372, 369, 432, 369, 369, 369, 306, 369, 738, 297, 306, 378, 441, 306, 432, 297, 360, 432, 441],
#[-297, -417, -252, -321, -276, -297, -321, -297, -270, -294, -345, -177, -318, -273, -318, -273, -441, -153, -303, 297, 288, 360, 234, 360, 234, 306, 297, 594, 225, 306, 306, 297, 297, 297, 288, 288, 369],
#[-300, -249, -417, -276, -321, -276, -321, -153, -441, -291, -297, -177, -342, -273, -318, -297, -273, -297, -324, 369, 288, 288, 297, 297, 297, 306, 306, 225, 594, 297, 306, 234, 360, 234, 360, 288, 297],
#[-393, -324, -321, -513, -348, -393, -372, -225, -369, -534, -366, -201, -414, -369, -390, -369, -369, -201, -540, 441, 432, 360, 297, 432, 306, 441, 378, 306, 297, 738, 369, 306, 369, 369, 369, 432, 369],
#[-537, -345, -324, -345, -513, -348, -417, -204, -369, -390, -537, -198, -366, -369, -414, -369, -369, -225, -372, 369, 432, 432, 297, 360, 369, 378, 441, 306, 306, 369, 738, 297, 369, 306, 432, 369, 441],
#[-297, -417, -273, -276, -273, -441, -300, -177, -276, -318, -321, -297, -291, -249, -342, -321, -297, -153, -324, 297, 288, 360, 297, 288, 225, 369, 306, 297, 234, 306, 297, 594, 288, 234, 297, 360, 306],
#[-384, -312, -480, -360, -339, -336, -528, -195, -384, -360, -384, -216, -525, -309, -357, -384, -384, -216, -387, 432, 351, 351, 360, 423, 288, 360, 432, 297, 360, 369, 369, 288, 720, 288, 360, 360, 432],
#[-321, -273, -249, -441, -297, -276, -297, -297, -276, -342, -300, -153, -318, -417, -291, -273, -321, -177, -324, 306, 360, 288, 225, 360, 297, 297, 297, 297, 234, 369, 306, 234, 288, 594, 288, 297, 306],
#[-384, -336, -336, -336, -504, -360, -363, -192, -504, -360, -408, -195, -381, -336, -525, -333, -336, -240, -411, 432, 360, 423, 288, 351, 360, 432, 360, 288, 360, 369, 432, 297, 360, 288, 720, 351, 369],
#[-408, -336, -336, -360, -336, -504, -384, -195, -336, -525, -363, -240, -360, -336, -381, -504, -333, -192, -411, 369, 423, 360, 360, 351, 288, 432, 432, 288, 288, 432, 369, 360, 360, 297, 351, 720, 360],
#[-417, -369, -345, -369, -369, -345, -537, -225, -348, -366, -537, -204, -414, -324, -390, -369, -513, -198, -372, 378, 369, 432, 306, 432, 297, 369, 441, 369, 297, 369, 441, 306, 432, 306, 369, 360, 738]]
def G (i j : Nat) : Int := (gramData[i]!)[j]!
def B (i j : Nat) : Int := (inverseData[i]!)[j]!
def intSum (f : Nat → Int) : Nat → Int
  | 0 => 0
  | k+1 => intSum f k + f k

theorem product_checked : ∀ i j : Fin 37,
    intSum (fun k => B i k * G k j) 37 = if i=j then 627 else 0 := by
  decide +kernel

#print axioms product_checked
end PerkelRank

end

section

namespace PerkelDimension
open PerkelRank
set_option maxHeartbeats 10000000
set_option maxRecDepth 100000

def site (i : Fin 37) : Fin 57 := ⟨i.val, by omega⟩

theorem block_entries : ∀ i j : Fin 37,
    G i j = if site i = site j then 3 else if PerkelGraph.adj (site i) (site j) then 1 else 0 := by
  decide +kernel

#print axioms block_entries
end PerkelDimension

end

section

/-! An integer inverse certificate for a 37 by 37 principal block of the
scaled Gram matrix. The last theorem proves the physical dimension lower
bound for actual vectors in any finite-dimensional complex inner product
space having the rigid Perkel Gram matrix. -/
namespace PerkelDimension
open PerkelRank
open scoped BigOperators InnerProductSpace
set_option maxRecDepth 100000
set_option maxHeartbeats 10000000

private theorem intSum_eq (f : Nat → ℤ) (n : Nat) :
    (∑ k : Fin n, f k.val) = intSum f n := by
  induction n with
  | zero => simp [intSum]
  | succ n ih =>
    rw [Fin.sum_univ_castSucc]
    simpa [intSum] using congrArg (fun t => t + f n) ih

private theorem complex_inverse (i j : Fin 37) :
    (∑ k : Fin 37, (B i k : ℂ) * (G k j : ℂ)) = if i=j then 627 else 0 := by
  have h := product_checked i j
  rw [← intSum_eq] at h
  have hc := congrArg (fun x : ℤ => (x : ℂ)) h
  simpa [Int.cast_sum, Int.cast_mul, apply_ite] using hc

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

/-- A fully saturated Perkel Gram matrix has 37 linearly independent event
vectors already among the first 37 vertices. -/
theorem independent_block (x : Fin 57 → H)
    (hGram : ∀ i j, (57:ℂ) * ⟪x i, x j⟫_ℂ =
      if i=j then 3 else if PerkelGraph.adj i j then 1 else 0) :
    LinearIndependent ℂ (fun i : Fin 37 => x (site i)) := by
  classical
  have entries (k j : Fin 37) :
      (G k j : ℂ) = 57 * ⟪x (site k), x (site j)⟫_ℂ := by
    rw [block_entries, hGram]
    split_ifs <;> simp
  apply Fintype.linearIndependent_iff.mpr
  intro c hc i
  have row (k : Fin 37) : (∑ j : Fin 37, (G k j : ℂ)*c j) = 0 := by
    calc
      _ = 57 * ⟪x (site k), ∑ j : Fin 37, c j • x (site j)⟫_ℂ := by
        rw [inner_sum, Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro j _
        rw [entries, inner_smul_right]
        ring
      _ = 0 := by rw [hc]; simp
  have hc' : (∑ j : Fin 37, (if i=j then (627:ℂ) else 0)*c j) = 0 := by
    calc
      _ = ∑ j : Fin 37, ∑ k : Fin 37, (B i k : ℂ)*((G k j : ℂ)*c j) := by
        apply Finset.sum_congr rfl
        intro j _
        rw [← complex_inverse i j, Finset.sum_mul]
        apply Finset.sum_congr rfl
        intro k _
        exact mul_assoc _ _ _
      _ = ∑ k : Fin 37, ∑ j : Fin 37, (B i k : ℂ)*((G k j : ℂ)*c j) :=
        Finset.sum_comm
      _ = 0 := by simp_rw [← Finset.mul_sum, row, mul_zero, Finset.sum_const_zero]
  simpa [ite_mul] using hc'

/-- The Perkel Gram matrix forces ambient complex dimension at least 37. -/
theorem dimension_lower [Module.Finite ℂ H] (x : Fin 57 → H)
    (hGram : ∀ i j, (57:ℂ) * ⟪x i, x j⟫_ℂ =
      if i=j then 3 else if PerkelGraph.adj i j then 1 else 0) :
    37 ≤ Module.finrank ℂ H := by
  simpa using (independent_block x hGram).fintype_card_le_finrank

#print axioms dimension_lower
end PerkelDimension

end

section

/-! At a saturated pure state, exclusion and the projection identities force
the whole 57 by 57 Gram matrix. No Gram entries or color-class saturation
conditions are assumed in the main theorem. -/

open scoped BigOperators InnerProductSpace
open PerkelGraph

namespace PerkelRigidity

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

private theorem self_complex (u : E) : ⟪u,u⟫_ℂ = ((‖u‖^2 : ℝ) : ℂ) := by
  apply Complex.ext
  · exact @inner_self_eq_norm_sq ℂ E _ _ _ u
  · exact @inner_self_im ℂ E _ _ _ u

def fiber (c : V → Fin 3) (s : Fin 3) : Finset V :=
  Finset.univ.filter fun w => c w = s

/-- Orthogonality in a context gives an exact norm deficit, including its
equality case. -/
theorem deficit (ψ : E) (x : V → E) (S : Finset V) (unit : ‖ψ‖ = 1)
    (born : ∀ v, ⟪x v, ψ⟫_ℂ = ⟪x v, x v⟫_ℂ)
    (orth : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → ⟪x i, x j⟫_ℂ = 0) :
    ‖(∑ i ∈ S, x i) - ψ‖ ^ 2 = 1 - ∑ i ∈ S, ‖x i‖^2 := by
  have hh (i : V) (hi : i ∈ S) :
      ⟪x i, ∑ j ∈ S, x j⟫_ℂ = ⟪x i, x i⟫_ℂ := by
    rw [inner_sum]
    apply Finset.sum_eq_single_of_mem i hi
    intro j hj hji
    exact orth i hi j hj hji.symm
  have both : ⟪∑ i ∈ S, x i, ∑ i ∈ S, x i⟫_ℂ =
      ((∑ i ∈ S, ‖x i‖^2 : ℝ) : ℂ) := by
    rw [sum_inner, Complex.ofReal_sum]
    apply Finset.sum_congr rfl
    intro i hi
    rw [hh i hi, self_complex]
  have cross : ⟪∑ i ∈ S, x i, ψ⟫_ℂ =
      ((∑ i ∈ S, ‖x i‖^2 : ℝ) : ℂ) := by
    rw [sum_inner, Complex.ofReal_sum]
    apply Finset.sum_congr rfl
    intro i _
    rw [born, self_complex]
  rw [@norm_sub_sq ℂ _ _ _ _ _ _, ← @inner_self_eq_norm_sq ℂ _ _ _ _ _, both,
      cross, unit]
  change (∑ i ∈ S, ‖x i‖^2) - 2 * (∑ i ∈ S, ‖x i‖^2) + (1:ℝ)^2 = _
  ring

/-- Saturation of the total through a partition into three orthogonal
classes implies that *each* class sums to the state vector. -/
private theorem context_sum (ψ : E) (x : V → E) (c : V → Fin 3)
    (unit : ‖ψ‖=1) (born : ∀ v, ⟪x v,ψ⟫_ℂ = ⟪x v,x v⟫_ℂ)
    (orth : ∀ i j, i ≠ j → c i = c j → ⟪x i,x j⟫_ℂ=0)
    (sat : ∑ v, ‖x v‖^2 = 3) (s : Fin 3) : ∑ i ∈ fiber c s, x i = ψ := by
  let m (z : Fin 3) := ∑ i ∈ fiber c z, ‖x i‖^2
  have hd (z : Fin 3) : ‖(∑ i ∈ fiber c z, x i) - ψ‖^2 = 1-m z := by
    apply deficit ψ x _ unit born
    intro i hi j hj hij
    exact orth i j hij ((Finset.mem_filter.mp hi).2.trans (Finset.mem_filter.mp hj).2.symm)
  have hm : ∑ z, m z = 3 := by
    calc
      ∑ z, m z = ∑ i, ∑ z : Fin 3, if c i = z then ‖x i‖ ^ 2 else 0 := by
        simp only [m, fiber, Finset.sum_filter]; rw [Finset.sum_comm]
      _ = _ := by simpa using sat
  have hzero : ∑ z : Fin 3, ‖(∑ i ∈ fiber c z, x i) - ψ‖^2 = 0 := by
    simp only [hd, Finset.sum_sub_distrib, hm]
    norm_num
  have hz := (Finset.sum_eq_zero_iff_of_nonneg
    (fun z (_ : z ∈ (Finset.univ : Finset (Fin 3))) =>
      sq_nonneg ‖(∑ i ∈ fiber c z, x i) - ψ‖)).mp hzero s (Finset.mem_univ s)
  exact sub_eq_zero.mp (norm_eq_zero.mp (sq_eq_zero_iff.mp hz))

private theorem six_equations (z : Fin 6 → ℂ) (p : ℂ)
    (h : ∀ r, z (tr0 r) + z (tr1 r) + z (tr2 r) = p) :
    ∀ i, 3 * z i = p := by
  have h0 : z 0 + z 1 + z 2 = p := h 0
  have h1 : z 0 + z 1 + z 3 = p := h 1
  have h2 : z 0 + z 1 + z 4 = p := h 2
  have h3 : z 0 + z 1 + z 5 = p := h 3
  have h4 : z 0 + z 2 + z 3 = p := h 4
  have h5 : z 1 + z 2 + z 3 = p := h 5
  intro i
  fin_cases i
  · change 3 * z 0 = p
    linear_combination h0 + h1 + h4 - 2*h5
  · change 3 * z 1 = p
    linear_combination h0 + h1 - 2*h4 + h5
  · change 3 * z 2 = p
    linear_combination h0 - 2*h1 + h4 + h5
  · change 3 * z 3 = p
    linear_combination -2*h0 + h1 + h4 + h5
  · change 3 * z 4 = p
    linear_combination -2*h0 - 2*h1 + 3*h2 + h4 + h5
  · change 3 * z 5 = p
    linear_combination -2*h0 - 2*h1 + 3*h3 + h4 + h5

/-- Exact complex Gram equality for the original events; the assumptions
are the Born identities of the projected vectors, exclusivity, normalization
of the state, and saturation of the total probability. -/
theorem gram_rigidity (ψ : E) (x : V → E) (unit : ‖ψ‖=1)
    (born : ∀ v, ⟪x v,ψ⟫_ℂ = ⟪x v,x v⟫_ℂ)
    (excl : ∀ v w, v ≠ w → adj v w = false → ⟪x v,x w⟫_ℂ = 0)
    (sat : ∑ v, ‖x v‖^2 = 3) :
    ∀ v w, (57:ℂ) * ⟪x v,x w⟫_ℂ =
      if v=w then 3 else if adj v w then 1 else 0 := by
  classical
  let p (v : V) : ℂ := ⟪x v,x v⟫_ℂ
  have hedges (v w : V) (hw : adj v w = true) : 3 * ⟪x v,x w⟫_ℂ = p v := by
    obtain ⟨i,rfl⟩ := sixth v w hw
    apply six_equations (fun j => ⟪x v, x (nb v j)⟫_ℂ) (p v) _ i
    intro r
    let c := col v r
    let s := sel v r
    let T : Finset V := {nb v (tr0 r), nb v (tr1 r), nb v (tr2 r)}
    have hT (u : V) : u ∈ T ↔ (c u = s ∧ adj v u = true) := by
      simpa [T,c,s] using (slice3 v r u).symm
    have sub : T ⊆ fiber c s := fun u hu =>
      Finset.mem_filter.mpr ⟨Finset.mem_univ _, ((hT u).mp hu).1⟩
    have hsum : ∑ u ∈ T, ⟪x v,x u⟫_ℂ = ∑ u ∈ fiber c s, ⟪x v,x u⟫_ℂ := by
      apply Finset.sum_subset sub
      intro u hu hnu
      have hc := (Finset.mem_filter.mp hu).2
      have hne : v ≠ u := by
        rintro rfl; exact excluded v r hc
      apply excl v u hne
      cases he : adj v u with
      | false => rfl
      | true => exact False.elim (hnu ((hT u).mpr ⟨hc,he⟩))
    have orth (i j : V) (hij : i ≠ j) (hc : c i = c j) : ⟪x i,x j⟫_ℂ=0 := by
      apply excl i j hij
      cases he : adj i j with
      | false => rfl
      | true => exact False.elim (proper v r i j he hc)
    rw [← inner_sum (fiber c s) x (x v), context_sum ψ x c unit born orth sat s, born] at hsum
    obtain ⟨e01,e02,e12⟩ := triple_nodup v r
    simpa [p, T, e01,e02,e12,add_assoc] using hsum
  have hp (u : V) : ‖x u‖^2 = ‖x 0‖^2 := by
    apply eq_of_edge_eq (f:=fun v => ‖x v‖^2) _ u
    intro i j hij
    have hji : adj j i = true := by rw [adjacent_symm, hij]
    have h1 := congrArg Complex.re (hedges i j hij)
    have h2 := congrArg Complex.re (hedges j i hji)
    have hs := @inner_re_symm ℂ E _ _ _ (x i) (x j)
    change (⟪x i,x j⟫_ℂ).re = (⟪x j,x i⟫_ℂ).re at hs
    simp only [p, self_complex, Complex.ofReal_re, Complex.mul_re] at h1 h2
    norm_num at h1 h2
    linarith
  have m0 : (57:ℝ)*‖x 0‖^2 = 3 := by simpa [hp] using sat
  have pval (v : V) : (57:ℂ) * p v = 3 := by
    have hr : (57:ℝ) * ‖x v‖^2 = 3 := by rw [hp v]; exact m0
    change (57:ℂ)*⟪x v,x v⟫_ℂ=3
    rw [self_complex]
    exact_mod_cast hr
  intro v w
  by_cases he : v=w
  · subst w; simpa only [if_pos rfl] using pval v
  · simp only [if_neg he]
    cases ha : adj v w with
    | false => simp [excl v w he ha]
    | true =>
      simp only [if_true]
      have hh := hedges v w ha
      have hd := pval v
      linear_combination 19 * hh + (1/3 : ℂ) * hd

#print axioms gram_rigidity
end PerkelRigidity

end

section

/-! Connect the abstract Gram and rank theorems to orthogonal projective
measurements of arbitrary rank. The score is the sum of Born probabilities. -/
open scoped BigOperators InnerProductSpace

namespace PerkelModel
open PerkelGraph
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- Orthogonal projections with the exclusivities specified by the graph. -/
structure Measurements (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℂ E] where
  P : V → E →ₗ[ℂ] E
  selfAdj : ∀ i u v, ⟪P i u, v⟫_ℂ = ⟪u, P i v⟫_ℂ
  idem : ∀ i u, P i (P i u) = P i u
  exclusive : ∀ i j, i ≠ j → adj i j = false → ∀ u, P i (P j u) = 0

noncomputable def score (M : Measurements E) (ψ : E) : ℝ :=
  ∑ i, ‖M.P i ψ‖ ^ 2

/-- The Gram matrix of the projected state vectors in any perfect realization. -/
theorem saturated_gram (M : Measurements E) (ψ : E) (unit : ‖ψ‖ = 1)
    (sat : score M ψ = 3) :
    ∀ i j, (57 : ℂ) * ⟪M.P i ψ, M.P j ψ⟫_ℂ =
      if i = j then 3 else if adj i j then 1 else 0 := by
  apply PerkelRigidity.gram_rigidity ψ (fun i => M.P i ψ) unit
  · intro i
    calc
      ⟪M.P i ψ, ψ⟫_ℂ = ⟪M.P i (M.P i ψ), ψ⟫_ℂ := by rw [M.idem]
      _ = ⟪M.P i ψ, M.P i ψ⟫_ℂ := M.selfAdj i _ _
  · intro i j hij hex
    rw [M.selfAdj, M.exclusive i j hij hex ψ, inner_zero_right]
  · exact sat

/-- A unit state attaining total probability three forces complex dimension 37 or higher. -/
theorem minimum_dimension [Module.Finite ℂ E] (M : Measurements E) (ψ : E)
    (unit : ‖ψ‖ = 1) (sat : score M ψ = 3) : 37 ≤ Module.finrank ℂ E :=
  PerkelDimension.dimension_lower _ (saturated_gram M ψ unit sat)

#print axioms minimum_dimension
end PerkelModel

end

section

/-! Any finite probabilistic mixture of normalized states obeys the same
exact witness. The measurements are fixed across the ensemble. -/
open scoped BigOperators InnerProductSpace
open PerkelGraph PerkelRigidity

namespace PerkelModel
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem score_upper (M : Measurements E) (ψ : E) (unit : ‖ψ‖ = 1) : score M ψ ≤ 3 := by
  classical
  let c := col (0 : V) 0
  let x := fun i => M.P i ψ
  have born (i : V) : ⟪x i, ψ⟫_ℂ = ⟪x i, x i⟫_ℂ := by
    change ⟪M.P i ψ, ψ⟫_ℂ = ⟪M.P i ψ, M.P i ψ⟫_ℂ
    rw [← M.selfAdj, M.idem]
  have orth (z : Fin 3) (i : V) (hi : i ∈ fiber c z) (j : V)
      (hj : j ∈ fiber c z) (ne : i ≠ j) : ⟪x i,x j⟫_ℂ = 0 := by
    have hc : c i = c j := (Finset.mem_filter.mp hi).2.trans (Finset.mem_filter.mp hj).2.symm
    have he : adj i j = false := by
      cases e : adj i j with
      | false => rfl
      | true => exact False.elim (proper 0 0 i j e hc)
    change ⟪M.P i ψ, M.P j ψ⟫_ℂ = 0
    rw [M.selfAdj, M.exclusive _ _ ne he, inner_zero_right]
  have hctx (z : Fin 3) : ∑ i ∈ fiber c z, ‖x i‖^2 ≤ 1 := by
    have hd := deficit ψ x (fiber c z) unit born (orth z)
    linarith only [hd, sq_nonneg ‖(∑ i ∈ fiber c z, x i) - ψ‖]
  calc
    score M ψ = ∑ z : Fin 3, ∑ i ∈ fiber c z, ‖x i‖^2 := by
      simp only [fiber, Finset.sum_filter]
      rw [Finset.sum_comm]
      simp [score, x]
    _ ≤ ∑ _ : Fin 3, (1:ℝ) := Finset.sum_le_sum fun z _ => hctx z
    _ = 3 := by simp

/-- For an ensemble reaching the ideal score, each component with positive
weight reaches the same score using the very same measurements. -/
theorem component_saturates {ι : Type*} [Fintype ι] (M : Measurements E)
    (ψ : ι → E) (w : ι → ℝ) (unit : ∀ i, ‖ψ i‖ = 1)
    (wpos : ∀ i, 0 ≤ w i) (normalized : ∑ i, w i = 1)
    (sat : ∑ i, w i * score M (ψ i) = 3) (i : ι) (hi : 0 < w i) :
    score M (ψ i) = 3 := by
  have hnon (j : ι) : 0 ≤ w j * (3 - score M (ψ j)) :=
    mul_nonneg (wpos j) (sub_nonneg.mpr (score_upper M _ (unit j)))
  have htotal : ∑ j, w j * (3 - score M (ψ j)) = 0 := by
    simp_rw [mul_sub]
    rw [Finset.sum_sub_distrib, ← Finset.sum_mul, normalized, sat]
    norm_num
  have hzero := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => hnon j)).mp htotal i (Finset.mem_univ i)
  rcases mul_eq_zero.mp hzero with h | h
  · exact False.elim (hi.ne' h)
  · linarith

/-- The same 37-dimensional lower bound for every saturating finite convex
mixture of pure states, including spectral ensembles of density operators. -/
theorem mixed_minimum_dimension [Module.Finite ℂ E] {ι : Type*} [Fintype ι]
    (M : Measurements E) (ψ : ι → E) (w : ι → ℝ) (unit : ∀ i, ‖ψ i‖ = 1)
    (wpos : ∀ i, 0 ≤ w i) (normalized : ∑ i, w i = 1)
    (sat : ∑ i, w i * score M (ψ i) = 3) : 37 ≤ Module.finrank ℂ E := by
  classical
  have h : ∃ i, 0 < w i := by
    by_contra! h
    have hzero : ∀ j, w j = 0 := fun j => le_antisymm (h j) (wpos j)
    simp [hzero] at normalized
  obtain ⟨i,hi⟩ := h
  exact minimum_dimension M _ (unit i) (component_saturates M ψ w unit wpos normalized sat i hi)

#print axioms mixed_minimum_dimension
end PerkelModel

end
