import Mathlib.Tactic

namespace Diagram94

/-- A stationary projective direction of a binary cubic forces its discriminant to vanish. -/
theorem cubic_discriminant_of_stationary_direction
    {K : Type*} [Field K] [CharZero K]
    (a b c d x y : K) (hne : x ≠ 0 ∨ y ≠ 0)
    (p : 3*a*x^2 + 2*b*x*y + c*y^2 = 0)
    (q : b*x^2 + 2*c*x*y + 3*d*y^2 = 0) :
    b^2*c^2 - 4*a*c^3 - 4*b^3*d - 27*a^2*d^2 + 18*a*b*c*d = 0 := by
  by_cases hx : x = 0
  · subst x
    have hy : y ≠ 0 := hne.resolve_left (by simp)
    simp [hy] at p q
    simp [p, q]
  by_cases hy : y = 0
  · subst y
    simp [hx] at p q
    simp [p, q]
  let u := 6*a*c - 2*b^2
  let v := 9*a*d - b*c
  let w := 6*b*d - 2*c^2
  have h₁ : y*(u*x + v*y) = 0 := by
    dsimp [u, v]
    linear_combination (3*a)*q - b*p
  have h₂ : x*(v*x + w*y) = 0 := by
    dsimp [v, w]
    linear_combination (3*d)*p - c*q
  have h₃ := (mul_eq_zero.mp h₁).resolve_left hy
  have h₄ := (mul_eq_zero.mp h₂).resolve_left hx
  have h₅ : (v^2-u*w)*y = 0 := by linear_combination v*h₃ - u*h₄
  have h₆ := (mul_eq_zero.mp h₅).resolve_right hy
  dsimp [u,v,w] at h₆
  linear_combination (-1/3 : K)*h₆

#print axioms cubic_discriminant_of_stationary_direction
end Diagram94
