import Mathlib.Tactic

/-! Algebraic obstruction for a balanced, fixed projected triangle. The node
relations and the identification of the six symbols come from the cell argument. -/
namespace NodeTriangle

theorem fixedShape {K : Type*} [Field K] {a b d x y z c : K}
    (hs : a + b + d = 0) (hc : c ≠ 0)
    (ha : a^3*x = c) (hb : b^3*y = c) (hd : d^3*z = c) :
    (x*y + y*z + z*x)^3 = 27*(x*y*z)^2 := by
  have hsum : a^3 + b^3 + d^3 = 3*a*b*d := by
    linear_combination (a^2 + b^2 + d^2 - a*b - a*d - b*d) * hs
  have hfirst : (x*y + y*z + z*x)*c = (x*y*z)*(3*a*b*d) := by
    linear_combination -(y*z)*ha - (x*z)*hb - (x*y)*hd + (x*y*z)*hsum
  have hprod : (x*y*z)*(a*b*d)^3 = c^3 := by
    calc
      _ = (a^3*x)*(b^3*y)*(d^3*z) := by ring
      _ = _ := by rw [ha, hb, hd]; ring
  apply mul_right_cancel₀ (pow_ne_zero 3 hc)
  calc
    (x*y+y*z+z*x)^3*c^3 = ((x*y+y*z+z*x)*c)^3 := by ring
    _ = ((x*y*z)*(3*a*b*d))^3 := by rw [hfirst]
    _ = 27*(x*y*z)^2*((x*y*z)*(a*b*d)^3) := by ring
    _ = 27*(x*y*z)^2*c^3 := by rw [hprod]

#print axioms fixedShape
end NodeTriangle
