import Mathlib.Tactic

/-!
# The leading torque on the regular square of diagram 88

For `r = √2` and `ζ = (1+i)/√2`, the two real coordinates below
are the real and imaginary parts of twice the signed sum
`a₀ + a₁ζ + a₂ζ² + a₃ζ³`. Multiplication by two avoids denominators.
For each square vertex, its two edges to bodies 5 and 6 carry independent
signs in this leading torque test.

The classification concerns only this torque and this square seed.
-/

namespace Diagram88Square

abbrev Signs := Bool × Bool × Bool × Bool

def sign (a : Bool) : ℝ := if a then 1 else -1

def realPart (r : ℝ) (a : Signs) : ℝ :=
  2 * sign a.1 + r * (sign a.2.1 - sign a.2.2.2)

def imagPart (r : ℝ) (a : Signs) : ℝ :=
  2 * sign a.2.2.1 + r * (sign a.2.1 + sign a.2.2.2)

def normSquared (r : ℝ) (a : Signs) : ℝ :=
  realPart r a ^ 2 + imagPart r a ^ 2

def torqueZero (r ρ : ℝ) (a b : Signs) : Prop :=
  realPart r a = ρ * imagPart r b ∧ imagPart r a = -(ρ * realPart r b)

theorem normValues {r : ℝ} (hr : r ^ 2 = 2) (a : Signs) :
    normSquared r a = 16 - 8*r ∨ normSquared r a = 16 + 8*r := by
  rcases a with ⟨a,b,c,d⟩
  cases a <;> cases b <;> cases c <;> cases d <;>
    simp [normSquared, realPart, imagPart, sign] <;>
    first | left; nlinarith | right; nlinarith

private theorem recoverPositive {u v d : ℝ} (hu : 0 < u) (hv : 0 < v)
    (hd : 0 < d) (h : u^2*d = v^2*d) : u = v := by
  have hsq : u^2 = v^2 := mul_right_cancel₀ (ne_of_gt hd) h
  have hprod : (u-v)*(u+v) = 0 := by nlinarith
  exact sub_eq_zero.mp ((mul_eq_zero.mp hprod).resolve_right (by positivity))

theorem necessaryRatios {r ρ : ℝ} (hr : r^2 = 2) (hpos : 0 < r)
    (hρ : 0 < ρ) {a b : Signs} (hz : torqueZero r ρ a b) :
    ρ = r-1 ∨ ρ = 1 ∨ ρ = r+1 := by
  obtain ⟨hx, hy⟩ := hz
  have h : normSquared r a = ρ^2 * normSquared r b := by
    unfold normSquared
    rw [hx, hy]
    ring
  have hsmall : 0 < 16-8*r := by nlinarith
  have hlarge : 0 < 16+8*r := by positivity
  have hr1 : 0 < r-1 := by nlinarith
  have hrp : 0 < r+1 := by positivity
  have smallRatio : (r-1)^2*(16+8*r) = 16-8*r := by
    linear_combination (8*r) * hr
  have largeRatio : (r+1)^2*(16-8*r) = 16+8*r := by
    linear_combination (-8*r) * hr
  rcases normValues hr a with ha | ha <;> rcases normValues hr b with hb | hb <;>
    rw [ha, hb] at h
  · right; left
    apply recoverPositive hρ zero_lt_one hsmall
    simpa using h.symm
  · left
    exact recoverPositive hρ hr1 hlarge (h.symm.trans smallRatio.symm)
  · right; right
    exact recoverPositive hρ hrp hsmall (h.symm.trans largeRatio.symm)
  · right; left
    apply recoverPositive hρ zero_lt_one hlarge
    simpa using h.symm

theorem signWitnesses {r : ℝ} (hr : r^2 = 2) :
    torqueZero r (r-1) (true,true,false,true) (false,true,true,true) ∧
    torqueZero r 1 (true,true,true,true) (false,false,true,true) ∧
    torqueZero r (r+1) (true,true,true,true) (false,true,false,true) := by
  refine ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;>
    simp [realPart, imagPart, sign] <;> nlinarith

theorem squareTorqueClassification {r ρ : ℝ} (hr : r^2 = 2) (hpos : 0 < r)
    (hρ : 0 < ρ) :
    (∃ a b, torqueZero r ρ a b) ↔ ρ = r-1 ∨ ρ = 1 ∨ ρ = r+1 := by
  constructor
  · rintro ⟨a,b,h⟩
    exact necessaryRatios hr hpos hρ h
  · obtain ⟨hm, h1, hp⟩ := signWitnesses hr
    rintro (rfl | rfl | rfl)
    · exact ⟨_, _, hm⟩
    · exact ⟨_, _, h1⟩
    · exact ⟨_, _, hp⟩

#print axioms squareTorqueClassification

end Diagram88Square
