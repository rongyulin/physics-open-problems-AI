import Std

/-! Independent integer replay of the Newtonian interval enclosure certificate.
No floating-point arithmetic, external libraries, or native_decide are used.
Each approximate integer square root is checked by its two defining inequalities. -/
namespace Replay

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

def evalField (Q : List Pt) (x : Pt) (jac : Bool) : Option (Pt × Mat) := do
  let mut p := x; let mut J := id2
  for q in Q do
    let a := x.1-q.1; let b := x.2-q.2; let r := sq a+sq b
    let root ← sqrtI r; let cube ← inv (r*root); let m := rat 1 5 * cube
    p := (p.1-m*a,p.2-m*b)
    if jac then
      let invR ← inv r; let s := value 3 * m * invR
      let u := s*(a*b)
      J := ((J.1.1+s*sq a-m,J.1.2+u),(J.2.1+u,J.2.2+s*sq b-m))
  return (p,J)

def dot (a b : Pt) := a.1*b.1+a.2*b.2

def checkRoot (Q : List Pt) (x : Pt) : Bool := (go.getD false) where
  go : Option Bool := do
    let c := (mid x.1,mid x.2)
    let (f, m) ← evalField Q c true
    let (_, j) ← evalField Q x true
    let a := mid m.1.1; let b := mid m.1.2; let h := mid m.2.1; let k := mid m.2.2
    let di ← inv (a*k-h*b)
    let B : Mat := ((mid (k*di),mid ((value 0-b)*di)),(mid ((value 0-h)*di),mid (a*di)))
    if !nz (B.1.1*B.2.2-B.1.2*B.2.1) then return false
    let dx := (x.1-c.1,x.2-c.2)
    let col0 := (j.1.1,j.2.1); let col1 := (j.1.2,j.2.2)
    let row (i : I × I) (s t : I) (cval range : I) : Bool := Id.run do
      let e0 := s-dot i col0; let e1 := t-dot i col1
      let K := cval-dot i f+dot (e0,e1) dx
      return (mag e0+mag e1 < d.toNat) && interior K range
    return row B.1 (value 1) (value 0) c.1 x.1 && row B.2 (value 0) (value 1) c.2 x.2

def classify (Q roots : List Pt) (box : Pt) : Bool := Id.run do
  if roots.any (fun r => inside box.1 r.1 && inside box.2 r.2) then return true
  if Q.any (fun s => (r2 box s).h ≤ (rat 1 1024).l) then return true
  if Q.any (fun s => (r2 box s).l ≤ 0) then return false
  match evalField Q box false with
  | none => return false
  | some v => return nz v.1.1 || nz v.1.2

def cover (Q roots : List Pt) : Nat → Pt → Option Nat
  | 0, _ => none
  | depth+1, box => do
    if classify Q roots box then return 1
    let (a,b) := box
    let (left,right) : Pt × Pt := if width a ≥ width b then
      let m := mid a
      ((⟨a.l,m.h⟩,b),(⟨m.l,a.h⟩,b))
    else
      let m := mid b
      ((a,⟨b.l,m.h⟩),(a,⟨m.l,b.h⟩))
    let l ← cover Q roots depth left; let r ← cover Q roots depth right
    return l+r+1

structure Shape where
  label : String
  primaries : List (Int × Int)
  roots : List (Int × Int)
  deriving Repr

def pairwiseB {α : Type} (f : α → α → Bool) : List α → Bool
  | [] => true
  | a::l => l.all (f a) && pairwiseB f l

def check (shape : Shape) : Option (Nat × Nat) := do
  let q := shape.primaries.map (fun v => ball (point v) (rat 1 (10^9)))
  let roots := shape.roots.map (fun v => ball (point v) (rat 1 16384))
  if !(q.length == 5 && q.all (fun v => (sq v.1+sq v.2).h < (value 4).l) &&
      pairwiseB (fun a b => (r2 a b).l > (rat 1 16).h) q) then none else
    if !(roots.all (checkRoot q) && pairwiseB (fun a b => nz (a.1-b.1) || nz (a.2-b.2)) roots) then none else
      let axis : I := ⟨(value (-4)).l,(value 4).h⟩
      let nodes ← cover q roots 121 (axis,axis)
      return (roots.length,nodes)
end Replay

namespace Replay
def line : Shape := ⟨"line",
  [(-1019255981502,0), (-480767438961,0), (480767438961,0), (1019255981502,0), (0,0)],
  [(-1453397192655,0), (-745421714060,0), (-239404512783,0), (0,-822519859054), (0,822519859054), (239404512783,0), (745421714060,0), (1453397192655,0)]⟩
def square_center : Shape := ⟨"square_center",
  [(-731500856775,0), (0,-731500856775), (0,0), (731500856775,0), (0,731500856775)],
  [(-1214835980413,0), (-668775383456,-668775383456), (-668775383456,668775383456), (-369654991311,0), (0,-1214835980413), (0,-369654991311), (0,369654991311), (0,1214835980413), (369654991311,0), (668775383456,-668775383456), (668775383456,668775383456), (1214835980413,0)]⟩
def two_triangles : Shape := ⟨"two_triangles",
  [(-760989823180,468463530475), (-190247292235,-671953633698), (305064582055,23529346753), (893623852842,0), (-247451319482,179960756470)],
  [(-1148539575828,701844995747), (-816950826619,-380613058817), (-502113872796,321414095578), (-323158103085,-1141394755618), (-80888588984,-285698580273), (26716211343,94361686201), (234805134861,829331980119), (496168411807,-752390763354), (596083382891,10486311642), (1345997770150,-4422448389)]⟩
def trapezium : Shape := ⟨"trapezium",
  [(-659140512424,180013923452), (-280723132908,-714399281550), (98765710649,-144927270254), (767575280236,0), (73522654448,679312628352)],
  [(-1138104317592,308372292440), (-885066101023,-409720850606), (-558737920715,819883349236), (-464845895996,-1153588075281), (-288162004181,16446911580), (-232339655082,340931602289), (-223157816746,327458315282), (-98436410526,-424227160266), (90081169317,274213829864), (129226758594,1172038972615), (430838465722,-63534454265), (515607922136,-756595059008), (705028971038,673904539678), (1243676695967,10743852447)]⟩
def pentagon : Shape := ⟨"pentagon",
  [(-526276482005,382362245666), (201019728646,-618675109502), (201019728646,618675109502), (650513506718,0), (-526276482005,-382362245666)],
  [(-1039469667334,0), (-938286643072,-681705149651), (-938286643072,681705149651), (-534841061867,0), (-321213792343,-988594400609), (-321213792343,988594400609), (-165274977407,-508664077071), (-165274977407,508664077071), (0,0), (358393606464,-1103022102442), (358393606464,1103022102442), (432695508340,-314371688486), (432695508340,314371688486), (840948626010,-610984940664), (840948626010,610984940664), (1159786073217,0)]⟩
def data := [line, square_center, two_triangles, trapezium, pentagon]
end Replay

def main : IO Unit := do
  for shape in Replay.data do
    let out := Replay.check shape
    IO.println s!"{shape.label} {repr out}"
    if out.isNone then throw (IO.userError "certificate did not verify")

namespace Replay
/-- Every suggested restricted root box passes rigorous self-mapping,
contraction and invertible-preconditioner checks for this primary box. -/
def localPass (s : Shape) : Bool := s.roots.all (fun r => checkRoot
    (s.primaries.map (fun q => ball (point q) (rat 1 (10^9))))
    (ball (point r) (rat 1 16384)))
set_option maxHeartbeats 2000000
set_option maxRecDepth 100000

theorem line_local : localPass line = true := by decide +kernel
theorem square_local : localPass square_center = true := by decide +kernel
theorem two_triangles_local : localPass two_triangles = true := by decide +kernel
theorem trapezium_local : localPass trapezium = true := by decide +kernel
theorem pentagon_local : localPass pentagon = true := by decide +kernel

#print axioms line_local
#print axioms square_local
#print axioms two_triangles_local
#print axioms trapezium_local
#print axioms pentagon_local
end Replay
