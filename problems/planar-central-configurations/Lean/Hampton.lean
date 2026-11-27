import Std

/-! Independent integer replay of the Newtonian interval enclosure certificate.
No floating-point arithmetic, external libraries, or native_decide are used.
Each approximate integer square root is checked by its two defining inequalities. -/
namespace HamptonReplay

structure I where
  l : Int
  h : Int
  deriving Repr, Inhabited, DecidableEq
abbrev Pt := I × I
abbrev Mat := Pt × Pt
def d : Int := 2^72
def ceilDiv (a b : Int) := -((-a)/b)
def rat (a b : Int) : I := ⟨a*d/b, ceilDiv (a*d) b⟩
def value (a : Int) := rat a 1
instance : Add I := ⟨fun x y => ⟨x.l+y.l,x.h+y.h⟩⟩
instance : Sub I := ⟨fun x y => ⟨x.l-y.h,x.h-y.l⟩⟩
instance : Mul I := ⟨fun x y => Id.run do
  let a := x.l*y.l; let b := x.l*y.h; let c := x.h*y.l; let e := x.h*y.h
  return ⟨min (min a b) (min c e) / d, ceilDiv (max (max a b) (max c e)) d⟩⟩
def sq (x : I) : I :=
  ⟨if x.l ≤ 0 && 0 ≤ x.h then 0 else min (x.l*x.l) (x.h*x.h)/d,
   ceilDiv (max (x.l*x.l) (x.h*x.h)) d⟩
def inv (x : I) : Option I :=
  if x.l ≤ 0 && 0 ≤ x.h then none else some ⟨d*d/x.h,ceilDiv (d*d) x.l⟩

def sqrtIter (n : Nat) : Nat → Nat → Nat
  | 0, a => a
  | k+1, a => let b := (a+n/a)/2; if a ≤ b then a else sqrtIter n k b

def checkedSqrt (n : Int) : Option Int := do
  if n < 0 then none else
    let a := n.toNat
    let r : Int := (sqrtIter a 24 (2^((a.log2+2)/2)) : Nat)
    if r*r ≤ n && n < (r+1)*(r+1) then some r else none

def sqrtI (x : I) : Option I := do
  let l ← checkedSqrt (x.l*d); let u ← checkedSqrt (x.h*d)
  return ⟨l, if u*u == x.h*d then u else u+1⟩
def nz (x : I) := decide (x.l>0 ∨ x.h<0)
def mid (x : I) : I := let m := (x.l+x.h)/2; ⟨m,m⟩
def mag (x : I) := max x.l.natAbs x.h.natAbs
def width (x : I) := x.h-x.l
def inside (x y : I) := decide (y.l ≤ x.l ∧ x.h ≤ y.h)
def interior (x y : I) := decide (y.l < x.l ∧ x.h < y.h)
def ballI (x ε : I) : I := ⟨x.l-ε.h,x.h+ε.h⟩
def ball (p : Pt) (ε : I) : Pt := (ballI p.1 ε,ballI p.2 ε)
def point (p : Int × Int) : Pt := (rat p.1 (10^12),rat p.2 (10^12))
def r2 (p q : Pt) : I := sq (p.1-q.1)+sq (p.2-q.2)
def id2 : Mat := ((value 1,value 0),(value 0,value 1))


/-! Form the real Cartesian derivative of the planar Newtonian central
residual for unit multiplier and masses 1/n, restricting it to the rotation
slice y_(n-2)=0 (zero-indexed) by removing this coordinate and its row. -/
structure Configuration where
  label : String
  centers : List (Int × Int)
  deriving Repr

def blockH (a b m : I) : Option (Array I) := do
  let r := sq a+sq b
  let rt ← sqrtI r
  let r3 ← inv (rt*r); let r2i ← inv r
  let v := m*r3; let s := value 3 * v * r2i
  let ab := s*(a*b)
  return #[s*sq a-v, ab, ab, s*sq b-v]

abbrev Square := Array (Array I)

def addAt (mat : Square) (i j : Nat) (delta : I) : Square :=
  mat.modify i (fun row => row.modify j (·+delta))

def hessian (cfg : Configuration) (radDen : Nat) : Option Square := do
  let n := cfg.centers.length
  if n<2 || radDen == 0 then none else
    let coords := cfg.centers.toArray
    let ε := rat 1 radDen
    let mut q : Array Pt := #[]
    for i in [:n] do
      let (x,y) := coords[i]!
      let c := (rat x (10^15),rat y (10^15))
      if i == n-2 && (y != 0 || c.1.l ≤ ε.h) then return ← none
      let p := (ballI c.1 ε, if i==n-2 then c.2 else ballI c.2 ε)
      q := q.push p
    let dim := 2*n
    let mut j : Square := (Array.range dim).map fun i => (Array.range dim).map fun k =>
      value (if i==k then 1 else 0)
    let m := rat 1 n
    for i in [:n] do
      for k in [:i] do
        let v ← blockH (q[i]!.1-q[k]!.1) (q[i]!.2-q[k]!.2) m
        for a in [:2] do
          for b in [:2] do
            let t := v[2*a+b]!
            j := addAt j (2*i+a) (2*i+b) t
            j := addAt j (2*k+a) (2*k+b) t
            j := addAt j (2*i+a) (2*k+b) (value 0-t)
            j := addAt j (2*k+a) (2*i+b) (value 0-t)
    let active := (Array.range dim).filter (· != (2*(n-2)+1))
    return active.map fun i => active.map fun k => j[i]![k]!

/-- Interval LDL elimination. A sign is accepted only if the entire pivot
interval is strictly on one side of zero. No numerical row permutations. -/
def indexOf (cfg : Configuration) (radDen : Nat) : Option Nat := do
  let mut j ← hessian cfg radDen
  let mut neg := 0; let dim := j.size
  for i in [:dim] do
    let p := j[i]![i]!
    if p.h < 0 then neg := neg+1 else if p.l ≤ 0 then return ← none
    let pinv ← inv p
    for r in [i+1:dim] do
      for c in [i+1:dim] do
        let e := j[r]![c]! -(j[r]![i]! * pinv * j[i]![c]!)
        j := j.modify r (fun row => row.setIfInBounds c e)
  return neg

def s6_1 : Configuration := ⟨"1", [(-1107397433081460,0), (-625233870676090,0), (625233870676090,0), (203575165825110,0), (1107397433081460,0), (-203575165825110,0)]⟩

def s6_2 : Configuration := ⟨"2", [(-872977355465590,0), (0,-734802798734270), (295887279050530,0), (0,734802798734270), (872977355465590,0), (-295887279050530,0)]⟩

def s6_3 : Configuration := ⟨"3", [(-456615783055310,790881735789650), (-456615783055310,-790881735789650), (363232151101310,0), (-181616075550650,-314568270325000), (913231566110620,0), (-181616075550650,314568270325000)]⟩

def s6_4 : Configuration := ⟨"4", [(-610049235340690,347973755287530), (-565904514240440,-689402774960940), (328405365659080,-59374759314670), (118099557190730,692313728377550), (891921580275730,0), (-162472753544420,-291509949389460)]⟩

def s6_5 : Configuration := ⟨"5", [(-672806508022140,0), (-336403254011070,-582667527778670), (336403254011070,-582667527778670), (336403254011070,582667527778670), (672806508022140,0), (-336403254011070,582667527778670)]⟩

def s6_6 : Configuration := ⟨"6", [(-647362823610500,0), (-348660481613240,-603897668745570), (323681411805250,-560632650712320), (323681411805250,560632650712320), (697320963226490,0), (-348660481613240,603897668745570)]⟩

def s6_7 : Configuration := ⟨"7", [(-910812902709620,412098359814890), (-151090147215470,-700463991537610), (485647198354730,13142533081170), (13601009861720,63055188126180), (999702556715970,0), (-437047715007330,212167910515370)]⟩

def s6_8 : Configuration := ⟨"8", [(-643093933994800,70368958897470), (-388625334821800,-575898796678110), (305911843490720,-570034685198480), (237420159573500,351829826710090), (780440119336790,0), (-292052853584410,723734696269030)]⟩

def s6_9 : Configuration := ⟨"9", [(-594127025165020,431658550819700), (226936329978170,-698438206760800), (226936329978170,698438206760800), (0,0), (734381390373690,0), (-594127025165020,-431658550819700)]⟩
def cfg6 := [s6_1,s6_2,s6_3,s6_4,s6_5,s6_6,s6_7,s6_8,s6_9]

def s7_1 : Configuration := ⟨"shape_01", [(-1178580610715143,0), (359105126471599,0), (738613748891421,0), (0,0), (-359105126471599,0), (1178580610715143,0), (-738613748891421,0)]⟩

def s7_2 : Configuration := ⟨"shape_02", [(-977019134282859,0), (0,-744522488912803), (477174436171689,0), (0,744522488912803), (0,0), (977019134282859,0), (-477174436171689,0)]⟩

def s7_3 : Configuration := ⟨"shape_03", [(-622136927276329,299605353599185), (-153655131756710,-673207118701929), (430532111969191,539870192499524), (430532111969191,-539870192499524), (-153655131756710,673207118701929), (690519894127696,0), (-622136927276329,-299605353599185)]⟩

def s7_4 : Configuration := ⟨"shape_04", [(-739197560476688,0), (369598780238344,-640163865788296), (369598780238344,640163865788296), (0,0), (-369598780238344,-640163865788296), (739197560476688,0), (-369598780238344,640163865788296)]⟩

def s7_5 : Configuration := ⟨"shape_05", [(-700061527607047,302004428069752), (-151358008014505,-815798448747476), (327774991994430,402844278921618), (319033000663143,-383668868641950), (-169231446484592,743406708693151), (829720649115657,0), (-455877659667084,-248788098295095)]⟩

def s7_6 : Configuration := ⟨"shape_06", [(-696306703367664,387844586807002), (-408308119810521,-707456990804506), (346330405267465,-599757322600175), (254807264243402,228763328180661), (12149797470581,796943430295816), (816829795331542,0), (-325502439134804,-106337031878799)]⟩

def s7_7 : Configuration := ⟨"shape_07", [(-593958076375049,315351169307610), (-105543849820638,-807146661545095), (280704097969491,-344325849664555), (280704097969491,344325849664555), (-105543849820638,807146661545095), (837595656452391,0), (-593958076375049,-315351169307610)]⟩

def s7_8 : Configuration := ⟨"shape_08", [(-828058624904156,243694855893802), (276263633848248,-669617251627629), (297689770179217,68928284029258), (111125380134634,771205439663983), (-266119323318189,150169282362414), (863173371384488,0), (-454074207324241,-564380610321829)]⟩

def s7_9 : Configuration := ⟨"shape_09", [(-707852453792059,40463372096153), (-466459941853879,-763113612667628), (360450055908211,-127565768764377), (334650237546096,625061276461094), (-79147365454655,-374076145599082), (894386528964386,0), (-336027061318099,599230878473840)]⟩

def s7_10 : Configuration := ⟨"shape_10", [(-734603875339325,0), (-256004166778014,-853998429455579), (411460658922879,0), (-48836324956307,-350789750715202), (-48836324956307,350789750715202), (932824199885087,0), (-256004166778014,853998429455579)]⟩

def s7_11 : Configuration := ⟨"shape_11", [(-490710013565281,849934675277878), (-490710013565279,-849934675277878), (487977207775609,0), (0,0), (-243988603887804,-422600658401475), (981420027130560,0), (-243988603887805,422600658401475)]⟩

def s7_12 : Configuration := ⟨"shape_12", [(-519648964322770,823051016145329), (-519648964322771,-823051016145329), (508897246535370,0), (36654665197734,0), (-251575562537562,-405120033032562), (996897141987560,0), (-251575562537562,405120033032562)]⟩

def s7_13 : Configuration := ⟨"shape_13", [(-763954313138394,631266019497243), (151096218042526,-698781073119115), (496401643022312,31415152920350), (49678092997688,138109502305265), (-362653054061981,340417780686876), (991021180366318,0), (-561589767228469,-442427382290620)]⟩

def s7_14 : Configuration := ⟨"shape_14", [(-1023269574733745,360951829312056), (-122211608594287,-713843187591382), (622688436313490,8260404370950), (211003650646201,30626920865915), (-188798554830792,99073985291576), (1085065364694449,0), (-584477713495317,214930047750885)]⟩
def cfg7 := [s7_1,s7_2,s7_3,s7_4,s7_5,s7_6,s7_7,s7_8,s7_9,s7_10,s7_11,s7_12,s7_13,s7_14]

end HamptonReplay

def main : IO Unit := do
  for cfg in HamptonReplay.cfg6 ++ HamptonReplay.cfg7 do
    let den := if cfg.centers.length == 6 then 10^12 else 10^11
    let index := HamptonReplay.indexOf cfg den
    IO.println s!"{cfg.centers.length} {cfg.label} : {repr index}"
    if index.isNone then throw (IO.userError "singular pivot interval")

namespace HamptonReplay
set_option maxHeartbeats 3000000
set_option maxRecDepth 100000
theorem index_6_1 : indexOf s6_1 (10^12) = some 4 := by decide +kernel
theorem index_6_2 : indexOf s6_2 (10^12) = some 2 := by decide +kernel
theorem index_6_3 : indexOf s6_3 (10^12) = some 3 := by decide +kernel
theorem index_6_4 : indexOf s6_4 (10^12) = some 2 := by decide +kernel
theorem index_6_5 : indexOf s6_5 (10^12) = some 1 := by decide +kernel
theorem index_6_6 : indexOf s6_6 (10^12) = some 0 := by decide +kernel
theorem index_6_7 : indexOf s6_7 (10^12) = some 3 := by decide +kernel
theorem index_6_8 : indexOf s6_8 (10^12) = some 1 := by decide +kernel
theorem index_6_9 : indexOf s6_9 (10^12) = some 0 := by decide +kernel

def weights6 : List Nat := [360,360,240,720,120,240,720,720,144]

theorem indices6 : cfg6.map (fun cfg => indexOf cfg (10^12)) = [some 4,some 2,some 3,some 2,some 1,some 0,some 3,some 1,some 0] := by
  simp only [cfg6, List.map_cons, List.map_nil, index_6_1, index_6_2, index_6_3, index_6_4, index_6_5, index_6_6, index_6_7, index_6_8, index_6_9]
theorem index_7_1 : indexOf s7_1 (10^11) = some 5 := by decide +kernel
theorem index_7_2 : indexOf s7_2 (10^11) = some 3 := by decide +kernel
theorem index_7_3 : indexOf s7_3 (10^11) = some 2 := by decide +kernel
theorem index_7_4 : indexOf s7_4 (10^11) = some 0 := by decide +kernel
theorem index_7_5 : indexOf s7_5 (10^11) = some 2 := by decide +kernel
theorem index_7_6 : indexOf s7_6 (10^11) = some 1 := by decide +kernel
theorem index_7_7 : indexOf s7_7 (10^11) = some 1 := by decide +kernel
theorem index_7_8 : indexOf s7_8 (10^11) = some 2 := by decide +kernel
theorem index_7_9 : indexOf s7_9 (10^11) = some 2 := by decide +kernel
theorem index_7_10 : indexOf s7_10 (10^11) = some 3 := by decide +kernel
theorem index_7_11 : indexOf s7_11 (10^11) = some 5 := by decide +kernel
theorem index_7_12 : indexOf s7_12 (10^11) = some 4 := by decide +kernel
theorem index_7_13 : indexOf s7_13 (10^11) = some 3 := by decide +kernel
theorem index_7_14 : indexOf s7_14 (10^11) = some 4 := by decide +kernel

def weights7 : List Nat := [2520,2520,720,840,5040,5040,5040,5040,5040,5040,1680,5040,5040,5040]

theorem indices7 : cfg7.map (fun cfg => indexOf cfg (10^11)) = [some 5,some 3,some 2,some 0,some 2,some 1,some 1,some 2,some 2,some 3,some 5,some 4,some 3,some 4] := by
  simp only [cfg7, List.map_cons, List.map_nil, index_7_1, index_7_2, index_7_3, index_7_4, index_7_5, index_7_6, index_7_7, index_7_8, index_7_9, index_7_10, index_7_11, index_7_12, index_7_13, index_7_14]

/-- Count per index after restoring the labelled positive-rotation orbits. -/
def coefficients (degrees : Nat) (indices : List (Option Nat)) (weights : List Nat) : List Nat :=
  (List.range degrees).map fun k => ((indices.zip weights).map fun pair =>
    if pair.1 == some k then pair.2 else 0).sum

theorem hampton6 : coefficients 5 (cfg6.map (fun cfg => indexOf cfg (10^12))) weights6 = [384,840,1080,960,360] := by
  rw [indices6]
  decide +kernel
#print axioms hampton6

theorem hampton7 : coefficients 6 (cfg7.map (fun cfg => indexOf cfg (10^11))) weights7 = [840,10080,15840,12600,10080,4200] := by
  rw [indices7]
  decide +kernel
#print axioms hampton7
end HamptonReplay
