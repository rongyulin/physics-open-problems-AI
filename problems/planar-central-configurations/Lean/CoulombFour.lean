import Mathlib.Tactic

namespace CoulombFour

def allowed (t : ℝ) : Prop :=
  3*t^2=1 ∨ 3*t^6-106*t^4-97*t^2-25=0

private theorem ratio_obstruction (a u t : ℝ)
    (hr : a^2*((2+u)*(1+u)) = -1)
    (hs : a^2*(4+u+u^3) = 1+u) (ht : t= -a^3*(2+u^3)) :
    3*t^6-106*t^4-97*t^2-25=0 := by
  have hc : u^3+2*u^2+3*u+3=0 := by
    linear_combination ((4+u+u^3)/2)*hr - (((2+u)*(1+u))/2)*hs
  let d : ℝ := (2+u)*(1+u)
  have hd : d ≠ 0 := by
    intro h
    change a^2*d= -1 at hr
    rw [h,mul_zero] at hr
    norm_num at hr
  let D : ℝ := -17*u^2-33*u-13
  let N : ℝ := 7*u^2+18*u+11
  have hD : d^3=D := by
    dsimp [d,D]
    linear_combination (u^3+7*u^2+16*u+7)*hc
  have hN : -(2+u^3)^2=N := by
    dsimp [N]
    linear_combination (-u^3+2*u^2-u-5)*hc
  have hp : 3*N^3-106*N^2*D-97*N*D^2-25*D^3=0 := by
    dsimp [N,D]
    linear_combination (15921*u^3+50445*u^2+50310*u+15111)*hc
  have hy : t^2*d^3=N := by
    rw [ht, ← hN]
    calc (-a^3*(2+u^3))^2*d^3 = (a^2*d)^3*(2+u^3)^2 := by ring
         _ = -(2+u^3)^2 := by rw [show a^2*d= -1 from hr]; ring
  rw [←hD, ←hy] at hp
  exact (mul_eq_zero.mp (show (3*t^6-106*t^4-97*t^2-25)*d^9=0 by
    linear_combination hp)).resolve_right (pow_ne_zero 9 hd)

private theorem doubled (a c t : ℝ) (ha : a ≠ 0) (ht : t= -(2*a^3+c^3))
    (h₁ : (2*a+c)*a^2+a=2*a+c+t)
    (h₂ : (2*a+c)*c^2+c=2*a+c+t) : allowed t := by
  by_cases he : a=c
  · subst c
    have h0 : a*(3*a^2-1)=0 := by linear_combination (h₁ + ht)/2
    have hn := (mul_eq_zero.mp h0).resolve_left ha
    left
    rw [ht]
    linear_combination (9*a^4 + 3*a^2+1)*hn
  · have h0 : (a-c)*((2*a+c)*(a+c)+1)=0 := by linear_combination h₁-h₂
    have hn := (mul_eq_zero.mp h0).resolve_left (sub_ne_zero.mpr he)
    let u := c/a
    have hu : a*u=c := by dsimp [u]; field_simp
    have hr : a^2*((2+u)*(1+u))= -1 := by
      rw [←hu] at hn
      linear_combination hn
    have hs : a^2*(4+u+u^3) = 1+u := by
      rw [←hu] at ht h₁
      apply (mul_left_cancel₀ ha : a*_ = a*_ → _)
      linear_combination h₁+ht
    right
    apply ratio_obstruction a u t hr hs
    rw [←hu] at ht
    linear_combination ht

/-- The three inverted squared edge lengths equal one in a real Coulomb shape.
These four scalar equations imply the complete necessary polynomial condition. -/
theorem mass_obstruction (a b c t : ℝ) (ha : a ≠ 0) (hb : b ≠ 0) (hc : c ≠ 0)
    (ht : t= -(a^3+b^3+c^3))
    (h₁ : (a+b+c)*a^2+a=a+b+c+t)
    (h₂ : (a+b+c)*b^2+b=a+b+c+t)
    (h₃ : (a+b+c)*c^2+c=a+b+c+t) : allowed t := by
  by_cases hab : a=b
  · subst b
    apply doubled a c t ha <;> first | linear_combination ht | linear_combination h₁ | linear_combination h₃
  by_cases hbc : b=c
  · subst c
    apply doubled b a t hb <;> first | linear_combination ht | linear_combination h₂ | linear_combination h₁
  by_cases hac : a=c
  · subst c
    apply doubled a b t ha <;> first | linear_combination ht | linear_combination h₁ | linear_combination h₂
  have e₁ : (a-b)*((a+b+c)*(a+b)+1)=0 := by linear_combination h₁-h₂
  have e₂ : (b-c)*((a+b+c)*(b+c)+1)=0 := by linear_combination h₂-h₃
  have v₁ := (mul_eq_zero.mp e₁).resolve_left (sub_ne_zero.mpr hab)
  have v₂ := (mul_eq_zero.mp e₂).resolve_left (sub_ne_zero.mpr hbc)
  have hz : (a+b+c)*(a-c)=0 := by linear_combination v₁-v₂
  have hh := (mul_eq_zero.mp hz).resolve_right (sub_ne_zero.mpr hac)
  rw [hh, zero_mul, zero_add] at v₁
  norm_num at v₁

/-- Four ordered charges cannot cancel their three nontrivial outer field rows:
the Pfaffian is strictly positive by the ordering of inverse squared distances. -/
theorem no_collinear (a b c d e f x y z w : ℝ)
    (hb : 0 < b) (he : 0 < e) (hc : 0 < c) (hd : 0 < d)
    (hab : b < a) (hef : e < f) (hx : x ≠ 0)
    (hy : -a*x+d*z+e*w=0) (hz : -b*x-d*y+f*w=0) (hw : -c*x-e*y-f*z=0) : False := by
  have hid : (a*f-b*e+c*d)*x=0 := by linear_combination -f*hy+e*hz-d*hw
  have h₁ := mul_lt_mul_of_pos_right hab he
  have h₂ := mul_lt_mul_of_pos_left hef (lt_trans hb hab)
  have hpos : 0 < a*f-b*e+c*d := by linarith [mul_pos hc hd]
  exact (mul_ne_zero hpos.ne' hx) hid

#print axioms mass_obstruction
#print axioms no_collinear
end CoulombFour
