import Mathlib.Tactic

/-!
The centered inner squared distances are
D₁=d, D₂=d(p²-e²), D₃=d((p-1)²-e²).
Treat e² as an independent coordinate.  The first lemma computes the minor
of their Jacobian after deleting the first row and first column.  The
second proves the nonzero Schur complement criterion used to deduce the
nonzero fourth-order soft coefficient from a nondegenerate Hessian.
These lemmas do not formalize the Puiseux force reduction.
-/
namespace Negative93Algebra

theorem distance_jacobian {d p : ℂ} (hd : d ≠ 0) :
    (2*d*p)*(-d) - (-d)*(2*d*(p-1)) ≠ 0 := by
  have h : (2*d*p)*(-d) - (-d)*(2*d*(p-1)) = -2*d^2 := by ring
  rw [h]
  exact mul_ne_zero (by norm_num) (pow_ne_zero _ hd)

theorem schur_nonzero {a b c d e f : ℂ} (hminor : a*d-b^2 ≠ 0)
    (hfull : a*d*f+2*b*c*e-a*e^2-d*c^2-b^2*f ≠ 0) :
    f - (d*c^2-2*b*c*e+a*e^2)/(a*d-b^2) ≠ 0 := by
  intro h
  apply hfull
  have heq := (eq_div_iff hminor).mp (sub_eq_zero.mp h)
  linear_combination heq

#print axioms distance_jacobian
#print axioms schur_nonzero
end Negative93Algebra
