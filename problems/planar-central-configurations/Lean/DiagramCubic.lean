import Std
/- Dyadic rectangles for the cubic-order torque tests at t=3. -/
set_option maxHeartbeats 0
set_option maxRecDepth 100000
namespace CubicTorque
structure I where
  l : Int
  h : Int
  deriving Inhabited
def S : Int := 2^80
def ceil (x y : Int) := -((-x)/y)
def ofI (n : Int) : I := ⟨n*S,n*S⟩
instance : Add I := ⟨fun a b => ⟨a.l+b.l,a.h+b.h⟩⟩
instance : Neg I := ⟨fun a => ⟨-a.h,-a.l⟩⟩
instance : Sub I := ⟨fun a b => a+(-b)⟩
instance : Mul I := ⟨fun a b =>
  ⟨min (min (a.l*b.l) (a.l*b.h)) (min (a.h*b.l) (a.h*b.h)) / S,
   ceil (max (max (a.l*b.l) (a.l*b.h)) (max (a.h*b.l) (a.h*b.h))) S⟩⟩
def sq (a : I) : I :=
  ⟨(if a.l≤0 && 0≤a.h then 0 else min (a.l^2) (a.h^2))/S,
   ceil (max (a.l^2) (a.h^2)) S⟩
structure C where
  r : I
  i : I
  deriving Inhabited
def v (a : Int) : C := ⟨ofI a,ofI 0⟩
instance : Add C := ⟨fun a b => ⟨a.r+b.r,a.i+b.i⟩⟩
instance : Neg C := ⟨fun a => ⟨-a.r,-a.i⟩⟩
instance : Sub C := ⟨fun a b => a+(-b)⟩
instance : Mul C := ⟨fun a b => ⟨a.r*b.r-a.i*b.i,a.r*b.i+a.i*b.r⟩⟩
def inv (a : C) : Option C := do
  let norm := sq a.r + sq a.i
  if norm.l ≤ 0 then none else
    let u : I := ⟨S*S/norm.h,ceil (S*S) norm.l⟩
    return ⟨a.r*u,-(a.i*u)⟩
def seed (x y h : Int) : C :=
  ⟨⟨x*2^32-h,x*2^32+h⟩,⟨y*2^32-h,y*2^32+h⟩⟩
def lowerI (a : I) := max (max a.l (-a.h)) 0
def lower (a : C) := max (lowerI a.r) (lowerI a.i)
def root3 : Int := 2093920942154385339393396
def omega : C := ⟨⟨-S/2,-S/2⟩,⟨root3/2,(root3+2)/2⟩⟩
theorem root_bound : root3^2 < 3*S^2 ∧ 3*S^2 < (root3+1)^2 := by decide +kernel
abbrev Triple := C × C × C
def scale (x : C) (y : Triple) : Triple := (x*y.1,x*y.2.1,x*y.2.2)
def W (x : C) (invM : C) : Triple := scale invM
 (v 1+v 3*x, v 3*x-v 4,v 1-v 2*x)
def dot (x y : Triple) : C := x.1*y.1+x.2.1*y.2.1+x.2.2*y.2.2
def cube (x : C) := x*x*x
def passes (a b c : C) : Bool :=
  lower a > S/20 && lower ((v 3)*b*cube a+c) > 2*S
structure Row where
  y : C
  rad : Triple
  deriving Inhabited
def check (r : Row) : Option Bool := do
  let invM ← inv (v 5)
  let y := r.y
  let w := W y invM
  let wy : Triple := (← inv w.1,← inv w.2.1,← inv w.2.2)
  let iy ← inv y
  let sy ← inv (y*y)
  let sy1 ← inv ((y-v 1)*(y-v 1))
  let four : List (C × C) := [(v 1,v 1),(v 1,v (-1)),(v (-1),v 1),(v (-1),v (-1))]
  for (sg,sh) in four do
    let a : Triple := (r.rad.1,sg*r.rad.2.1,sh*r.rad.2.2)
    let test := cube (dot a wy)
    for d in [v 1,omega,omega*omega] do
      if !(passes (dot a (W (d*iy) invM)) (v 25) test) then return false
    for (u,z) in four do
      let f := v 2+v 3*u*sy-v 3*z*sy1
      if !(passes (dot a w) (f*f) test) then return false
  return true
def mix0 : Row := ⟨seed (140737488355328) (-243764480361061) (2^41),(seed (136400373433342) (58042025928272) (2^48),seed (58042025928272) (136400373433342) (2^48),seed (453696819801004) (-453696819801004) (2^48))⟩
theorem cubic0 : check mix0 = some true := by decide +kernel
def mix1 : Row := ⟨seed (140737488355328) (243764480361061) (2^41),(seed (136400373433342) (-58042025928272) (2^48),seed (58042025928272) (-136400373433342) (2^48),seed (453696819801004) (453696819801004) (2^48))⟩
theorem cubic1 : check mix1 = some true := by decide +kernel
def mix2 : Row := ⟨seed (106407554119526) (-52841401652252) (2^41),(seed (187887490938538) (24374531288284) (2^48),seed (15954414823405) (163926271384081) (2^48),seed (1109094548294562) (-602052300589083) (2^48))⟩
theorem cubic2 : check mix2 = some true := by decide +kernel
def mix3 : Row := ⟨seed (106407554119526) (52841401652252) (2^41),(seed (187887490938538) (-24374531288284) (2^48),seed (15954414823405) (-163926271384081) (2^48),seed (1109094548294562) (602052300589083) (2^48))⟩
theorem cubic3 : check mix3 = some true := by decide +kernel
def mix4 : Row := ⟨seed (597279887657114) (-296605882013313) (2^41),(seed (97384004426457) (20014746040529) (2^48),seed (126664391743739) (63413331043771) (2^48),seed (121976384225009) (-411641251689309) (2^48))⟩
theorem cubic4 : check mix4 = some true := by decide +kernel
def mix5 : Row := ⟨seed (597279887657114) (296605882013313) (2^41),(seed (97384004426457) (-20014746040529) (2^48),seed (126664391743739) (-63413331043771) (2^48),seed (121976384225009) (411641251689309) (2^48))⟩
theorem cubic5 : check mix5 = some true := by decide +kernel
def mix6 : Row := ⟨seed (-315804910946458) (-296605882013312) (2^41),(seed (63413331043771) (126664391743739) (2^48),seed (20014746040529) (97384004426458) (2^48),seed (411641251689310) (-121976384225009) (2^48))⟩
theorem cubic6 : check mix6 = some true := by decide +kernel
def mix7 : Row := ⟨seed (-315804910946458) (296605882013312) (2^41),(seed (63413331043771) (-126664391743739) (2^48),seed (20014746040529) (-97384004426458) (2^48),seed (411641251689310) (121976384225009) (2^48))⟩
theorem cubic7 : check mix7 = some true := by decide +kernel
def mix8 : Row := ⟨seed (175067422591130) (-52841401652251) (2^41),(seed (163926271384081) (15954414823405) (2^48),seed (24374531288284) (187887490938538) (2^48),seed (602052300589083) (-1109094548294564) (2^48))⟩
theorem cubic8 : check mix8 = some true := by decide +kernel
def mix9 : Row := ⟨seed (175067422591130) (52841401652251) (2^41),(seed (163926271384081) (-15954414823405) (2^48),seed (24374531288284) (-187887490938538) (2^48),seed (602052300589083) (1109094548294564) (2^48))⟩
theorem cubic9 : check mix9 = some true := by decide +kernel
def mix10 : Row := ⟨seed (-133295707497992) (-125192134512859) (2^41),(seed (140715234037175) (191908128565166) (2^48),seed (14341551850466) (118264859480652) (2^48),seed (563945332719121) (-122719249706930) (2^48))⟩
theorem cubic10 : check mix10 = some true := by decide +kernel
def mix11 : Row := ⟨seed (-133295707497992) (125192134512859) (2^41),(seed (140715234037175) (-191908128565166) (2^48),seed (14341551850466) (-118264859480652) (2^48),seed (563945332719121) (122719249706930) (2^48))⟩
theorem cubic11 : check mix11 = some true := by decide +kernel
def mix12 : Row := ⟨seed (414770684208648) (-125192134512859) (2^41),(seed (118264859480652) (14341551850466) (2^48),seed (191908128565166) (140715234037175) (2^48),seed (122719249706930) (-563945332719121) (2^48))⟩
theorem cubic12 : check mix12 = some true := by decide +kernel
def mix13 : Row := ⟨seed (414770684208648) (125192134512859) (2^41),(seed (118264859480652) (-14341551850466) (2^48),seed (191908128565166) (-140715234037175) (2^48),seed (122719249706930) (563945332719121) (2^48))⟩
theorem cubic13 : check mix13 = some true := by decide +kernel
def mix14 : Row := ⟨seed (-126374236140503) (-402377118999033) (2^41),(seed (92003569293046) (99746482651392) (2^48),seed (35651218415378) (101429182288053) (2^48),seed (401686845627937) (-215483837431970) (2^48))⟩
theorem cubic14 : check mix14 = some true := by decide +kernel
def mix15 : Row := ⟨seed (-126374236140503) (402377118999033) (2^41),(seed (92003569293046) (-99746482651392) (2^48),seed (35651218415378) (-101429182288053) (2^48),seed (401686845627937) (215483837431970) (2^48))⟩
theorem cubic15 : check mix15 = some true := by decide +kernel
def mix16 : Row := ⟨seed (144102185109101) (-94676061820442) (2^41),(seed (167334315039372) (32069996980319) (2^48),seed (33311212852112) (169247447103517) (2^48),seed (714728637641471) (-740580627509907) (2^48))⟩
theorem cubic16 : check mix16 = some true := by decide +kernel
def mix17 : Row := ⟨seed (144102185109101) (94676061820442) (2^41),(seed (167334315039372) (-32069996980319) (2^48),seed (33311212852112) (-169247447103517) (2^48),seed (714728637641471) (740580627509907) (2^48))⟩
theorem cubic17 : check mix17 = some true := by decide +kernel
def mix18 : Row := ⟨seed (668231543839445) (0) (2^41),(seed (98765544935325) (0) (2^48),seed (159300070203084) (0) (2^48),seed (0) (-436171374447454) (2^48))⟩
theorem cubic18 : check mix18 = some true := by decide +kernel
def mix19 : Row := ⟨seed (-9532650419105) (-348735311877243) (2^41),(seed (113108367792106) (89026267724043) (2^48),seed (43053074266969) (111624330569921) (2^48),seed (429448960324598) (-282571746432335) (2^48))⟩
theorem cubic19 : check mix19 = some true := by decide +kernel
def mix20 : Row := ⟨seed (-9532650419105) (348735311877243) (2^41),(seed (113108367792106) (-89026267724043) (2^48),seed (43053074266969) (-111624330569921) (2^48),seed (429448960324598) (282571746432335) (2^48))⟩
theorem cubic20 : check mix20 = some true := by decide +kernel
def mix21 : Row := ⟨seed (291007627129761) (-348735311877242) (2^41),(seed (111624330569921) (43053074266969) (2^48),seed (89026267724043) (113108367792106) (2^48),seed (282571746432335) (-429448960324599) (2^48))⟩
theorem cubic21 : check mix21 = some true := by decide +kernel
def mix22 : Row := ⟨seed (291007627129761) (348735311877242) (2^41),(seed (111624330569921) (-43053074266969) (2^48),seed (89026267724043) (-113108367792106) (2^48),seed (282571746432335) (429448960324599) (2^48))⟩
theorem cubic22 : check mix22 = some true := by decide +kernel
def mix23 : Row := ⟨seed (-386756567128790) (0) (2^41),(seed (0) (-159300070203084) (2^48),seed (0) (-98765544935325) (2^48),seed (436171374447453) (0) (2^48))⟩
theorem cubic23 : check mix23 = some true := by decide +kernel
def mix24 : Row := ⟨seed (137372791601555) (-94676061820442) (2^41),(seed (169247447103517) (33311212852112) (2^48),seed (32069996980319) (167334315039372) (2^48),seed (740580627509906) (-714728637641471) (2^48))⟩
theorem cubic24 : check mix24 = some true := by decide +kernel
def mix25 : Row := ⟨seed (137372791601555) (94676061820442) (2^41),(seed (169247447103517) (-33311212852112) (2^48),seed (32069996980319) (-167334315039372) (2^48),seed (740580627509906) (714728637641471) (2^48))⟩
theorem cubic25 : check mix25 = some true := by decide +kernel
def mix26 : Row := ⟨seed (407849212851159) (-402377118999033) (2^41),(seed (101429182288053) (35651218415378) (2^48),seed (99746482651392) (92003569293046) (2^48),seed (215483837431970) (-401686845627937) (2^48))⟩
theorem cubic26 : check mix26 = some true := by decide +kernel
def mix27 : Row := ⟨seed (407849212851159) (402377118999033) (2^41),(seed (101429182288053) (-35651218415378) (2^48),seed (99746482651392) (-92003569293046) (2^48),seed (215483837431970) (401686845627937) (2^48))⟩
theorem cubic27 : check mix27 = some true := by decide +kernel
def mix28 : Row := ⟨seed (-439538041617825) (0) (2^41),(seed (0) (-146636192043068) (2^48),seed (0) (-95513205495564) (2^48),seed (415861596258774) (0) (2^48))⟩
theorem cubic28 : check mix28 = some true := by decide +kernel
def mix29 : Row := ⟨seed (721013018328481) (0) (2^41),(seed (95513205495564) (0) (2^48),seed (146636192043068) (0) (2^48),seed (0) (-415861596258774) (2^48))⟩
theorem cubic29 : check mix29 = some true := by decide +kernel
def rows : List Row := [mix0,mix1,mix2,mix3,mix4,mix5,mix6,mix7,mix8,mix9,mix10,mix11,mix12,mix13,mix14,mix15,mix16,mix17,mix18,mix19,mix20,mix21,mix22,mix23,mix24,mix25,mix26,mix27,mix28,mix29]
theorem all_cubic_tests : rows.all (fun r => check r == some true) = true := by
  simp [rows,cubic0,cubic1,cubic2,cubic3,cubic4,cubic5,cubic6,cubic7,cubic8,cubic9,cubic10,cubic11,cubic12,cubic13,cubic14,cubic15,cubic16,cubic17,cubic18,cubic19,cubic20,cubic21,cubic22,cubic23,cubic24,cubic25,cubic26,cubic27,cubic28,cubic29]
#print axioms all_cubic_tests
end CubicTorque
