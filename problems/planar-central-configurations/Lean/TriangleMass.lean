import Mathlib.Tactic

/-!
On a triple chosen from the five-equal mass family, either of Tomar's
triangle conditions (Theorem 9.9) forces the distinguished mass to be on
the triple and to have value 1/4. The assignment disjunction describes the
four placements, including a distinguished body outside the triple.
The enumeration of the tree and leading-force conditions uses separate code.
-/
namespace TriangleMass

def balance (a b s : ℝ) : ℝ :=
  a^2*b^2 + b^2*s^2 + s^2*a^2 - 2*a*b*s*(a+b+s)

def second (a b s : ℝ) : Prop := s^2*(a+b)^4 = a^3*b^3

theorem exceptional_mass {a b s t : ℝ} (ht : 0 < t)
    (placement : (a = 1 ∧ b = 1 ∧ s = 1) ∨ (a = t ∧ b = 1 ∧ s = 1) ∨
      (a = 1 ∧ b = t ∧ s = 1) ∨ (a = 1 ∧ b = 1 ∧ s = t))
    (condition : balance a b s = 0 ∨ second a b s) : t = 1 / 4 := by
  have impossible : (t+1)^4 > t^3 := by
    nlinarith [show 0 ≤ t^4 by positivity, show 0 ≤ t^3 by positivity,
      show 0 ≤ t^2 by positivity]
  rcases placement with ⟨rfl,rfl,rfl⟩ | ⟨rfl,rfl,rfl⟩ | ⟨rfl,rfl,rfl⟩ | ⟨rfl,rfl,rfl⟩
  all_goals rcases condition with h | h <;> simp [balance, second] at h
  all_goals first | linarith | nlinarith only [h, ht, impossible]

#print axioms exceptional_mass

end TriangleMass
