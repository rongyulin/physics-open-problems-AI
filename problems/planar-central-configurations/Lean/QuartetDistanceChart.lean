import Mathlib.Tactic

namespace QuartetDistanceChart

/-- Polarization of an affine dependence in light-cone coordinates. -/
theorem squared_edge {ai aj al zi zj zl wi wj wl : ℂ}
    (hz : ai*zi + aj*zj = -al*zl) (hw : ai*wi + aj*wj = -al*wl) :
    ai*aj*((zi-zj)*(wi-wj)) =
    (ai+aj)*(ai*(zi*wi)+aj*(zj*wj)) - al^2*(zl*wl) := by
  have h := congrArg₂ (· * ·) hz hw
  linear_combination -h

theorem projection_quadratic {h R D : ℂ} (hn : h ≠ 0)
    (edge : D = (1-h)*(1-R/h)) :
    h^2-(1+R-D)*h+R=0 := by
  field_simp at edge
  linear_combination edge

/-- The signed distance equation exhibits the squared distance as a rational square. -/
theorem distance_is_square {K : Type*} [CommRing K] {b d : K}
    (h : b^2*d^3 = 1) : (b*d^2)^2 = d := by
  linear_combination d*h

/-- Equal values of (a-k)/(b-k) at finite admissible parameters force equality. -/
theorem star_ratio_injective {K : Type*} [Field K] {a b k k' : K}
    (hab : a ≠ b) (h : (a-k)*(b-k') = (a-k')*(b-k)) : k = k' := by
  have hh : (a-b)*(k-k') = 0 := by linear_combination h
  exact sub_eq_zero.mp ((mul_eq_zero.mp hh).resolve_left (sub_ne_zero.mpr hab))

open Polynomial
/-- A rational square with a denominator having two distinct simple roots and
numerator of degree at most two must be constant. The identity is cleared of
the denominator of the proposed square root. -/
theorem rational_square_simple_poles {F : Type*} [Field F] {a b : F} (hab : a ≠ b)
    {N U V : Polynomial F} (hN : N ≠ 0) (hU : U ≠ 0) (hV : V ≠ 0)
    (hdeg : N.natDegree ≤ 2)
    (hsq : N*V^2 = (X-C a)*(X-C b)*U^2) :
    ∃ c : F, N = (X-C a)*(X-C b)*C c := by
  classical
  have ha : (X-C a : Polynomial F) ≠ 0 := X_sub_C_ne_zero a
  have hb : (X-C b : Polynomial F) ≠ 0 := X_sub_C_ne_zero b
  have both (x : F) (hx : x = a ∨ x = b) : IsRoot N x := by
    have e := congrArg (fun q : Polynomial F => rootMultiplicity x q) hsq
    dsimp at e
    simp only [pow_two, rootMultiplicity_mul (mul_ne_zero hN (mul_ne_zero hV hV)),
      rootMultiplicity_mul (mul_ne_zero (mul_ne_zero ha hb) (mul_ne_zero hU hU)),
      rootMultiplicity_mul (mul_ne_zero ha hb), rootMultiplicity_mul (mul_ne_zero hV hV),
      rootMultiplicity_mul (mul_ne_zero hU hU), rootMultiplicity_X_sub_C] at e
    apply (rootMultiplicity_pos hN).mp
    rcases hx with rfl | rfl
    · simp [hab] at e
      omega
    · simp [Ne.symm hab] at e
      omega
  have coprime := isCoprime_X_sub_C_of_isUnit_sub (sub_ne_zero.mpr hab).isUnit
  obtain ⟨g, hg⟩ := coprime.mul_dvd (dvd_iff_isRoot.mpr (both a (.inl rfl)))
      (dvd_iff_isRoot.mpr (both b (.inr rfl)))
  have hg0 : g ≠ 0 := by intro hz; simp [hg, hz] at hN
  rw [hg, natDegree_mul (mul_ne_zero ha hb) hg0, natDegree_mul ha hb,
    natDegree_X_sub_C, natDegree_X_sub_C] at hdeg
  exact ⟨g.coeff 0, hg.trans (congrArg _ (eq_C_of_natDegree_le_zero (by omega)))⟩

#print axioms rational_square_simple_poles
#print axioms distance_is_square
#print axioms star_ratio_injective
#print axioms squared_edge
#print axioms projection_quadratic
end QuartetDistanceChart

namespace AbsoluteInversion88

/-- The polarization formula for the inverse points in the complex bilinear plane. -/
theorem squared_inverse_edge {K : Type*} [CommRing K]
    (a b x y z w : K) (h : a^2*x*y=1) (g : b^2*z*w=1) :
    (a^2*x-b^2*z)*(a^2*y-b^2*w)=a^2*b^2*(x-z)*(y-w) := by
  linear_combination (a^2-b^2) * h + (b^2-a^2)*g

/-- The triangle resulting from inversion has cube-root squared edges. -/
theorem edge_cube {K : Type*} [CommRing K] (p a b D : K)
    (hp : p^3=a^3*b^3) (hd : p^2*D=1) : (a^2*b^2*D)^3=1 := by
  calc (a^2*b^2*D)^3 = (a^3*b^3)^2*D^3 := by ring
       _ = (p^2*D)^3 := by rw [← hp]; ring
       _ = 1 := by rw [hd]; norm_num
end AbsoluteInversion88

namespace AbsoluteInversion88

/-- Signed inverse distances a_i and a_i a_j give zero force if the four
    weights and their first moments vanish, in either projection. -/
theorem outer_force_from_balance {K : Type*} [CommRing K]
    (t a b c x y z : K) (mass : t + a^3 + b^3 + c^3 = 0)
    (center : a^3*x + b^3*y + c^3*z = 0) :
    t*a^3*x + (a*b)^3*(x-y) + (a*c)^3*(x-z) = 0 := by
  linear_combination a^3*x*mass - a^3*center

/-- The exceptional real parameter in the asymmetric construction enforces
    the required third squared norm after inversion of an equilateral triangle. -/
theorem third_norm {K : Type*} [CommRing K] (u : K)
    (hu : u^3 + 2*u^2 + 3*u + 3 = 0) :
    u^2*(1+u+u^2) = 3 := by
  linear_combination (u-1)*hu

#print axioms outer_force_from_balance
#print axioms third_norm

end AbsoluteInversion88
