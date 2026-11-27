import Mathlib.Tactic

/-! Rank-one quartet stress, torque specialization, and the finite-fibre chart obstruction. -/
namespace ZeroProjection88

/-- Eliminate the common stress scale from two edges that meet at a vertex. -/
theorem edge_relation {K : Type*} [CommRing K] {a b c k l x y : K}
    (hx : x = k + l * a * b) (hy : y = k + l * a * c) :
    c * x - b * y = k * (c - b) := by
  rw [hx, hy]
  ring

/-- Remove the two independent signs after clearing the squared distances. -/
theorem squared_relation {K : Type*} [CommRing K] {x y z : K}
    (h : x - y = z) : (x^2 + y^2 - z^2)^2 - 4*x^2*y^2 = 0 := by
  rw [← h]
  ring

/-- If two cubes agree, the two center equations force the third to agree too. -/
theorem no_two_equal {K : Type*} [Field K] {a b c u v w : K}
    (h0 : u + v + w = 0) (h1 : a*u + b*v + c*w = 0)
    (hw : w ≠ 0) (hab : a = b) : c = a := by
  subst b
  have hp : (c-a)*w = 0 := by linear_combination h1 - a*h0
  exact sub_eq_zero.mp ((mul_eq_zero.mp hp).resolve_right hw)

/-- The torque condition after squaring the four summands. All quantities may
be specialized in a commutative ring before passing to the residue field. -/
def torquePolynomial {R : Type*} [CommRing R] (a b c d : R) : R :=
  ((a + b - c - d)^2 - 4*a*b - 4*c*d)^2 - 64*a*b*c*d

/-- Clear the four abscissa denominators, then specialize. If the four
abscissas stay distinct and the signed mass squares stay nonzero, the
torque equation rules out a zero at every abscissa of the limiting quartet. -/
theorem four_abscissas_nonzero_after_specialization
    {A K : Type*} [CommRing A] [Field K] (φ : A →+* K)
    (m x : Fin 4 → A) (hm : ∀ i, φ (m i) ≠ 0)
    (hdist : Function.Injective (fun i => φ (x i)))
    (ht : torquePolynomial
      (m 0 * x 1 * x 2 * x 3) (m 1 * x 0 * x 2 * x 3)
      (m 2 * x 0 * x 1 * x 3) (m 3 * x 0 * x 1 * x 2) = 0) :
    ∀ i, φ (x i) ≠ 0 := by
  have h := congrArg φ ht
  simp only [torquePolynomial, map_zero, map_sub, map_pow, map_mul,
    map_add, map_ofNat] at h
  intro i hi
  have others (j : Fin 4) (hj : j ≠ i) : φ (x j) ≠ 0 := by
    intro hz
    exact hj (hdist (hz.trans hi.symm))
  fin_cases i <;>
    simp_all [mul_eq_zero]

/-- The exact rank tests in each of the 49 rational factor algebras establish
the ideal-membership hypothesis for a product of 13 chart factors. A field
evaluation killing the three edge equations must kill at least one factor.
The target can be any field extension, including an algebraic closure. -/
theorem mixed_fibre_forces_chart_boundary
    {A K : Type*} [CommRing A] [Field K] (evaluate : A →+* K)
    (force : Fin 3 → A) (factor : Fin 13 → A)
    (certificate : (∏ j, factor j) ∈ Ideal.span (Set.range force))
    (hforce : ∀ i, evaluate (force i) = 0) :
    ∃ j, evaluate (factor j) = 0 := by
  have hker : Ideal.span (Set.range force) ≤ RingHom.ker evaluate := by
    apply Ideal.span_le.mpr
    rintro y ⟨j, rfl⟩
    exact hforce j
  have hp : evaluate (∏ j, factor j) = 0 := hker certificate
  rw [map_prod] at hp
  exact (Finset.prod_eq_zero_iff.mp hp).imp fun _ h => h.2

#print axioms four_abscissas_nonzero_after_specialization
#print axioms mixed_fibre_forces_chart_boundary
#print axioms edge_relation
#print axioms squared_relation
#print axioms no_two_equal
end ZeroProjection88
