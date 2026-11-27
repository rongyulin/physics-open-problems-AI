import Std

/-!
# Four-colourings of width-six triangular tori
The row consists of six consecutive two-bit spin labels, starting at the low bits.
Each strip counts the oriented preimages of face (0,1,2) of the colour tetrahedron.
All local arithmetic of degrees and potentials is modulo four.
-/
namespace PottsSix
abbrev Row := BitVec 12
abbrev ModFour := BitVec 2

def color (r : Row) (i : Nat) : BitVec 2 :=
  r.extractLsb' (2*i) 2

/-- The two rows include their horizontal edges and the vertical and northeast edges. -/
def compatible (r s : Row) : Bool :=
  (List.range 6).all fun i =>
    let j := (i+1)%6
    (color r i != color r j) && (color s i != color s j) &&
    (color r i != color s i) && (color r i != color s j)

/-- Signed multiplicity of the positively oriented target face. -/
def face (a b c : BitVec 2) : ModFour :=
  if (a == 0 && b == 1 && c == 2) || (a == 1 && b == 2 && c == 0) ||
     (a == 2 && b == 0 && c == 1) then 1
  else if (a == 0 && b == 2 && c == 1) || (a == 2 && b == 1 && c == 0) ||
          (a == 1 && b == 0 && c == 2) then 3
  else 0

def strip (r s : Row) : ModFour :=
  (List.range 6).foldl (fun acc i =>
    let j := (i+1)%6
    acc + face (color r i) (color r j) (color s j)
        + face (color r i) (color s j) (color s i)) 0

/- A finite certificate. The Boolean decision trees encode labels on all
   732 horizontally proper rows. Their values on improper rows are immaterial.
   The theorem below verifies them against the physical definitions for arbitrary
   12-bit inputs; the generator and its search need not be trusted. -/
def sector (r : Row) : Bool :=
  let v0 := if r.getLsbD 1 then (!(r.getLsbD 0)) else true
  let v1 := if r.getLsbD 2 then false else v0
  let v2 := if r.getLsbD 3 then true else v1
  let v3 := if r.getLsbD 1 then (r.getLsbD 0) else true
  let v4 := if r.getLsbD 2 then false else v3
  let v5 := if r.getLsbD 3 then true else v4
  let v6 := if r.getLsbD 4 then v5 else v2
  let v7 := if r.getLsbD 5 then v6 else true
  let v8 := if r.getLsbD 3 then (!(r.getLsbD 2)) else v3
  let v9 := if r.getLsbD 4 then v8 else false
  let v10 := if r.getLsbD 5 then v5 else v9
  let v11 := if r.getLsbD 3 then (r.getLsbD 2) else v0
  let v12 := if r.getLsbD 4 then v11 else false
  let v13 := if r.getLsbD 5 then v2 else v12
  let v14 := if r.getLsbD 6 then v13 else v10
  let v15 := if r.getLsbD 7 then v14 else v7
  let v16 := if r.getLsbD 2 then true else (r.getLsbD 1)
  let v17 := if r.getLsbD 3 then false else v16
  let v18 := if r.getLsbD 4 then v17 else true
  let v19 := if r.getLsbD 5 then v18 else v11
  let v20 := if r.getLsbD 5 then v17 else false
  let v21 := if r.getLsbD 6 then v20 else v19
  let v22 := if r.getLsbD 7 then v13 else v21
  let v23 := if r.getLsbD 4 then true else v17
  let v24 := if r.getLsbD 5 then v23 else v8
  let v25 := if r.getLsbD 6 then v20 else v24
  let v26 := if r.getLsbD 7 then v10 else v25
  let v27 := if r.getLsbD 8 then v26 else v22
  let v28 := if r.getLsbD 9 then v27 else v15
  let v29 := if r.getLsbD 2 then v0 else false
  let v30 := if r.getLsbD 3 then true else v29
  let v31 := if r.getLsbD 2 then v3 else false
  let v32 := if r.getLsbD 3 then true else v31
  let v33 := if r.getLsbD 4 then v32 else v30
  let v34 := if r.getLsbD 5 then v33 else true
  let v35 := if r.getLsbD 4 then false else v8
  let v36 := if r.getLsbD 5 then v32 else v35
  let v37 := if r.getLsbD 4 then false else v11
  let v38 := if r.getLsbD 5 then v30 else v37
  let v39 := if r.getLsbD 6 then v38 else v36
  let v40 := if r.getLsbD 7 then v39 else v34
  let v41 := if r.getLsbD 2 then (r.getLsbD 1) else true
  let v42 := if r.getLsbD 3 then false else v41
  let v43 := if r.getLsbD 5 then v42 else false
  let v44 := if r.getLsbD 4 then v42 else true
  let v45 := if r.getLsbD 5 then v44 else v11
  let v46 := if r.getLsbD 6 then v45 else v43
  let v47 := if r.getLsbD 7 then v38 else v46
  let v48 := if r.getLsbD 4 then true else v42
  let v49 := if r.getLsbD 5 then v48 else v8
  let v50 := if r.getLsbD 6 then v49 else v43
  let v51 := if r.getLsbD 7 then v36 else v50
  let v52 := if r.getLsbD 8 then v51 else v47
  let v53 := if r.getLsbD 9 then v52 else v40
  let v54 := if r.getLsbD 10 then v53 else v28
  let v55 := if r.getLsbD 1 then true else (!(r.getLsbD 0))
  let v56 := if r.getLsbD 2 then false else v55
  let v57 := if r.getLsbD 3 then v56 else true
  let v58 := if r.getLsbD 3 then v55 else (r.getLsbD 2)
  let v59 := if r.getLsbD 4 then v58 else false
  let v60 := if r.getLsbD 5 then v59 else v57
  let v61 := if r.getLsbD 2 then true else (!(r.getLsbD 1))
  let v62 := if r.getLsbD 3 then v61 else false
  let v63 := if r.getLsbD 4 then v62 else true
  let v64 := if r.getLsbD 5 then v58 else v63
  let v65 := if r.getLsbD 5 then false else v62
  let v66 := if r.getLsbD 6 then v65 else v64
  let v67 := if r.getLsbD 7 then v66 else v60
  let v68 := if r.getLsbD 1 then true else (r.getLsbD 0)
  let v69 := if r.getLsbD 2 then false else v68
  let v70 := if r.getLsbD 3 then v69 else true
  let v71 := if r.getLsbD 3 then v68 else (!(r.getLsbD 2))
  let v72 := if r.getLsbD 4 then v71 else false
  let v73 := if r.getLsbD 5 then v72 else v70
  let v74 := if r.getLsbD 4 then true else v62
  let v75 := if r.getLsbD 5 then v71 else v74
  let v76 := if r.getLsbD 6 then v65 else v75
  let v77 := if r.getLsbD 7 then v76 else v73
  let v78 := if r.getLsbD 8 then v77 else v67
  let v79 := if r.getLsbD 6 then v60 else v73
  let v80 := if r.getLsbD 4 then v70 else v57
  let v81 := if r.getLsbD 5 then true else v80
  let v82 := if r.getLsbD 7 then v81 else v79
  let v83 := if r.getLsbD 9 then v82 else v78
  let v84 := if r.getLsbD 2 then v55 else false
  let v85 := if r.getLsbD 3 then v84 else true
  let v86 := if r.getLsbD 4 then false else v58
  let v87 := if r.getLsbD 5 then v86 else v85
  let v88 := if r.getLsbD 2 then (!(r.getLsbD 1)) else true
  let v89 := if r.getLsbD 3 then v88 else false
  let v90 := if r.getLsbD 5 then false else v89
  let v91 := if r.getLsbD 4 then v89 else true
  let v92 := if r.getLsbD 5 then v58 else v91
  let v93 := if r.getLsbD 6 then v92 else v90
  let v94 := if r.getLsbD 7 then v93 else v87
  let v95 := if r.getLsbD 2 then v68 else false
  let v96 := if r.getLsbD 3 then v95 else true
  let v97 := if r.getLsbD 4 then false else v71
  let v98 := if r.getLsbD 5 then v97 else v96
  let v99 := if r.getLsbD 4 then true else v89
  let v100 := if r.getLsbD 5 then v71 else v99
  let v101 := if r.getLsbD 6 then v100 else v90
  let v102 := if r.getLsbD 7 then v101 else v98
  let v103 := if r.getLsbD 8 then v102 else v94
  let v104 := if r.getLsbD 6 then v87 else v98
  let v105 := if r.getLsbD 4 then v96 else v85
  let v106 := if r.getLsbD 5 then true else v105
  let v107 := if r.getLsbD 7 then v106 else v104
  let v108 := if r.getLsbD 9 then v107 else v103
  let v109 := if r.getLsbD 10 then v108 else v83
  let v110 := if r.getLsbD 11 then v109 else v54
  v110

def low (r : Row) : Bool :=
  let v0 := if r.getLsbD 2 then (!(r.getLsbD 0)) else false
  let v1 := if r.getLsbD 3 then false else v0
  let v2 := if r.getLsbD 2 then (r.getLsbD 0) else false
  let v3 := if r.getLsbD 3 then false else v2
  let v4 := if r.getLsbD 4 then v3 else v1
  let v5 := if r.getLsbD 5 then v4 else false
  let v6 := if r.getLsbD 2 then false else (!(r.getLsbD 1))
  let v7 := if r.getLsbD 3 then v6 else (!(r.getLsbD 0))
  let v8 := if r.getLsbD 1 then (!(r.getLsbD 0)) else false
  let v9 := if r.getLsbD 3 then false else v8
  let v10 := if r.getLsbD 4 then v9 else v7
  let v11 := if r.getLsbD 5 then v3 else v10
  let v12 := if r.getLsbD 2 then true else (r.getLsbD 1)
  let v13 := if r.getLsbD 3 then v12 else (r.getLsbD 0)
  let v14 := if r.getLsbD 1 then (r.getLsbD 0) else false
  let v15 := if r.getLsbD 2 then false else (r.getLsbD 1)
  let v16 := if r.getLsbD 3 then v15 else v14
  let v17 := if r.getLsbD 4 then v16 else v13
  let v18 := if r.getLsbD 2 then (r.getLsbD 0) else v14
  let v19 := if r.getLsbD 3 then false else v18
  let v20 := if r.getLsbD 5 then v19 else v17
  let v21 := if r.getLsbD 6 then v20 else v11
  let v22 := if r.getLsbD 7 then v21 else v5
  let v23 := if r.getLsbD 3 then v6 else false
  let v24 := if r.getLsbD 3 then (r.getLsbD 1) else false
  let v25 := if r.getLsbD 4 then v24 else false
  let v26 := if r.getLsbD 5 then v25 else v23
  let v27 := if r.getLsbD 3 then false else v6
  let v28 := if r.getLsbD 4 then v24 else v27
  let v29 := if r.getLsbD 5 then v28 else v7
  let v30 := if r.getLsbD 6 then v29 else v26
  let v31 := if r.getLsbD 7 then v20 else v30
  let v32 := if r.getLsbD 3 then (r.getLsbD 2) else false
  let v33 := if r.getLsbD 4 then false else (r.getLsbD 3)
  let v34 := if r.getLsbD 5 then v33 else v32
  let v35 := if r.getLsbD 3 then (!(r.getLsbD 1)) else v6
  let v36 := if r.getLsbD 4 then v35 else (r.getLsbD 3)
  let v37 := if r.getLsbD 5 then v36 else v13
  let v38 := if r.getLsbD 6 then v37 else v34
  let v39 := if r.getLsbD 4 then v32 else v13
  let v40 := if r.getLsbD 2 then (!(r.getLsbD 0)) else v8
  let v41 := if r.getLsbD 3 then false else v40
  let v42 := if r.getLsbD 5 then v41 else v39
  let v43 := if r.getLsbD 7 then v42 else v38
  let v44 := if r.getLsbD 8 then v43 else v31
  let v45 := if r.getLsbD 9 then v44 else v22
  let v46 := if r.getLsbD 2 then false else (!(r.getLsbD 0))
  let v47 := if r.getLsbD 3 then false else v46
  let v48 := if r.getLsbD 2 then false else (r.getLsbD 0)
  let v49 := if r.getLsbD 3 then false else v48
  let v50 := if r.getLsbD 4 then v49 else v47
  let v51 := if r.getLsbD 5 then v50 else false
  let v52 := if r.getLsbD 4 then v7 else v9
  let v53 := if r.getLsbD 5 then v49 else v52
  let v54 := if r.getLsbD 4 then v13 else v16
  let v55 := if r.getLsbD 2 then v14 else (r.getLsbD 0)
  let v56 := if r.getLsbD 3 then false else v55
  let v57 := if r.getLsbD 5 then v56 else v54
  let v58 := if r.getLsbD 6 then v57 else v53
  let v59 := if r.getLsbD 7 then v58 else v51
  let v60 := if r.getLsbD 2 then (!(r.getLsbD 1)) else false
  let v61 := if r.getLsbD 3 then false else v60
  let v62 := if r.getLsbD 4 then v24 else v61
  let v63 := if r.getLsbD 5 then v62 else v7
  let v64 := if r.getLsbD 6 then v26 else v63
  let v65 := if r.getLsbD 7 then v57 else v64
  let v66 := if r.getLsbD 3 then (!(r.getLsbD 1)) else v60
  let v67 := if r.getLsbD 4 then v66 else (r.getLsbD 3)
  let v68 := if r.getLsbD 5 then v67 else v13
  let v69 := if r.getLsbD 6 then v34 else v68
  let v70 := if r.getLsbD 4 then v13 else v32
  let v71 := if r.getLsbD 2 then v8 else (!(r.getLsbD 0))
  let v72 := if r.getLsbD 3 then false else v71
  let v73 := if r.getLsbD 5 then v72 else v70
  let v74 := if r.getLsbD 7 then v73 else v69
  let v75 := if r.getLsbD 8 then v74 else v65
  let v76 := if r.getLsbD 9 then v75 else v59
  let v77 := if r.getLsbD 10 then v76 else v45
  let v78 := if r.getLsbD 1 then false else (r.getLsbD 0)
  let v79 := if r.getLsbD 2 then false else v78
  let v80 := if r.getLsbD 3 then v79 else false
  let v81 := if r.getLsbD 3 then false else (!(r.getLsbD 1))
  let v82 := if r.getLsbD 3 then false else v15
  let v83 := if r.getLsbD 4 then v82 else v81
  let v84 := if r.getLsbD 5 then v83 else v80
  let v85 := if r.getLsbD 4 then v81 else false
  let v86 := if r.getLsbD 5 then v82 else v85
  let v87 := if r.getLsbD 3 then v15 else (r.getLsbD 1)
  let v88 := if r.getLsbD 3 then true else (r.getLsbD 1)
  let v89 := if r.getLsbD 5 then v88 else v87
  let v90 := if r.getLsbD 6 then v89 else v86
  let v91 := if r.getLsbD 7 then v90 else v84
  let v92 := if r.getLsbD 1 then false else (!(r.getLsbD 0))
  let v93 := if r.getLsbD 2 then false else v92
  let v94 := if r.getLsbD 3 then v93 else false
  let v95 := if r.getLsbD 2 then (r.getLsbD 1) else false
  let v96 := if r.getLsbD 3 then false else v95
  let v97 := if r.getLsbD 4 then v96 else v81
  let v98 := if r.getLsbD 5 then v97 else v94
  let v99 := if r.getLsbD 4 then false else v81
  let v100 := if r.getLsbD 5 then v96 else v99
  let v101 := if r.getLsbD 6 then v89 else v100
  let v102 := if r.getLsbD 7 then v101 else v98
  let v103 := if r.getLsbD 8 then v102 else v91
  let v104 := if r.getLsbD 3 then v92 else v60
  let v105 := if r.getLsbD 4 then v104 else v88
  let v106 := if r.getLsbD 5 then v105 else v32
  let v107 := if r.getLsbD 3 then v78 else v6
  let v108 := if r.getLsbD 4 then v107 else v88
  let v109 := if r.getLsbD 5 then v108 else v32
  let v110 := if r.getLsbD 6 then v109 else v106
  let v111 := if r.getLsbD 5 then false else v32
  let v112 := if r.getLsbD 7 then v111 else v110
  let v113 := if r.getLsbD 9 then v112 else v103
  let v114 := if r.getLsbD 2 then v78 else false
  let v115 := if r.getLsbD 3 then v114 else false
  let v116 := if r.getLsbD 3 then v78 else false
  let v117 := if r.getLsbD 4 then true else v116
  let v118 := if r.getLsbD 5 then v117 else v115
  let v119 := if r.getLsbD 3 then v95 else false
  let v120 := if r.getLsbD 5 then true else v119
  let v121 := if r.getLsbD 4 then (!(r.getLsbD 3)) else false
  let v122 := if r.getLsbD 3 then false else (!(r.getLsbD 2))
  let v123 := if r.getLsbD 5 then v122 else v121
  let v124 := if r.getLsbD 6 then v123 else v120
  let v125 := if r.getLsbD 7 then v124 else v118
  let v126 := if r.getLsbD 2 then v92 else false
  let v127 := if r.getLsbD 3 then v126 else false
  let v128 := if r.getLsbD 3 then v92 else false
  let v129 := if r.getLsbD 4 then true else v128
  let v130 := if r.getLsbD 5 then v129 else v127
  let v131 := if r.getLsbD 4 then false else (!(r.getLsbD 3))
  let v132 := if r.getLsbD 3 then false else (r.getLsbD 2)
  let v133 := if r.getLsbD 5 then v132 else v131
  let v134 := if r.getLsbD 6 then v133 else v120
  let v135 := if r.getLsbD 7 then v134 else v130
  let v136 := if r.getLsbD 8 then v135 else v125
  let v137 := if r.getLsbD 6 then v118 else v130
  let v138 := if r.getLsbD 3 then (!(r.getLsbD 2)) else false
  let v139 := if r.getLsbD 5 then false else v138
  let v140 := if r.getLsbD 7 then v139 else v137
  let v141 := if r.getLsbD 9 then v140 else v136
  let v142 := if r.getLsbD 10 then v141 else v113
  let v143 := if r.getLsbD 11 then v142 else v77
  v143

def high (r : Row) : Bool :=
  let v0 := if r.getLsbD 1 then (r.getLsbD 0) else true
  let v1 := if r.getLsbD 2 then (r.getLsbD 0) else v0
  let v2 := if r.getLsbD 3 then true else v1
  let v3 := if r.getLsbD 4 then v2 else true
  let v4 := if r.getLsbD 5 then v3 else true
  let v5 := if r.getLsbD 2 then false else (!(r.getLsbD 1))
  let v6 := if r.getLsbD 3 then v5 else false
  let v7 := if r.getLsbD 3 then (!(r.getLsbD 2)) else true
  let v8 := if r.getLsbD 4 then v7 else v6
  let v9 := if r.getLsbD 3 then false else v1
  let v10 := if r.getLsbD 5 then v9 else v8
  let v11 := if r.getLsbD 3 then true else (r.getLsbD 0)
  let v12 := if r.getLsbD 2 then (!(r.getLsbD 1)) else true
  let v13 := if r.getLsbD 3 then v12 else true
  let v14 := if r.getLsbD 4 then v13 else v11
  let v15 := if r.getLsbD 2 then (r.getLsbD 0) else true
  let v16 := if r.getLsbD 3 then true else v15
  let v17 := if r.getLsbD 5 then v16 else v14
  let v18 := if r.getLsbD 6 then v17 else v10
  let v19 := if r.getLsbD 7 then v18 else v4
  let v20 := if r.getLsbD 1 then (!(r.getLsbD 0)) else true
  let v21 := if r.getLsbD 2 then true else (!(r.getLsbD 1))
  let v22 := if r.getLsbD 3 then v21 else v20
  let v23 := if r.getLsbD 4 then true else (!(r.getLsbD 3))
  let v24 := if r.getLsbD 5 then v23 else v22
  let v25 := if r.getLsbD 2 then true else (r.getLsbD 1)
  let v26 := if r.getLsbD 3 then v25 else true
  let v27 := if r.getLsbD 2 then (!(r.getLsbD 0)) else true
  let v28 := if r.getLsbD 3 then true else v27
  let v29 := if r.getLsbD 4 then true else v28
  let v30 := if r.getLsbD 5 then v29 else v26
  let v31 := if r.getLsbD 6 then v30 else v24
  let v32 := if r.getLsbD 3 then v12 else v0
  let v33 := if r.getLsbD 4 then v32 else v11
  let v34 := if r.getLsbD 5 then v2 else v33
  let v35 := if r.getLsbD 7 then v34 else v31
  let v36 := if r.getLsbD 3 then true else v25
  let v37 := if r.getLsbD 3 then true else (!(r.getLsbD 2))
  let v38 := if r.getLsbD 4 then v37 else v36
  let v39 := if r.getLsbD 5 then v38 else true
  let v40 := if r.getLsbD 1 then (!(r.getLsbD 0)) else false
  let v41 := if r.getLsbD 2 then (!(r.getLsbD 0)) else v40
  let v42 := if r.getLsbD 3 then true else v41
  let v43 := if r.getLsbD 2 then true else v20
  let v44 := if r.getLsbD 3 then (!(r.getLsbD 1)) else v43
  let v45 := if r.getLsbD 4 then v44 else v42
  let v46 := if r.getLsbD 5 then v45 else v11
  let v47 := if r.getLsbD 6 then v46 else v39
  let v48 := if r.getLsbD 4 then true else v11
  let v49 := if r.getLsbD 5 then (!(r.getLsbD 3)) else v48
  let v50 := if r.getLsbD 7 then v49 else v47
  let v51 := if r.getLsbD 8 then v50 else v35
  let v52 := if r.getLsbD 9 then v51 else v19
  let v53 := if r.getLsbD 2 then false else (!(r.getLsbD 0))
  let v54 := if r.getLsbD 3 then (r.getLsbD 1) else v53
  let v55 := if r.getLsbD 2 then v40 else true
  let v56 := if r.getLsbD 3 then false else v55
  let v57 := if r.getLsbD 4 then v56 else v54
  let v58 := if r.getLsbD 5 then v57 else false
  let v59 := if r.getLsbD 3 then v25 else v40
  let v60 := if r.getLsbD 4 then v11 else v59
  let v61 := if r.getLsbD 5 then v56 else v60
  let v62 := if r.getLsbD 1 then (r.getLsbD 0) else false
  let v63 := if r.getLsbD 2 then false else (r.getLsbD 1)
  let v64 := if r.getLsbD 3 then v63 else v62
  let v65 := if r.getLsbD 4 then v26 else v64
  let v66 := if r.getLsbD 2 then v62 else true
  let v67 := if r.getLsbD 3 then (r.getLsbD 1) else v66
  let v68 := if r.getLsbD 5 then v67 else v65
  let v69 := if r.getLsbD 6 then v68 else v61
  let v70 := if r.getLsbD 7 then v69 else v58
  let v71 := if r.getLsbD 3 then false else (!(r.getLsbD 0))
  let v72 := if r.getLsbD 2 then (r.getLsbD 1) else (!(r.getLsbD 0))
  let v73 := if r.getLsbD 3 then (r.getLsbD 1) else v72
  let v74 := if r.getLsbD 4 then v73 else (!(r.getLsbD 3))
  let v75 := if r.getLsbD 5 then v74 else v71
  let v76 := if r.getLsbD 3 then (!(r.getLsbD 2)) else v62
  let v77 := if r.getLsbD 2 then v62 else false
  let v78 := if r.getLsbD 3 then (r.getLsbD 1) else v77
  let v79 := if r.getLsbD 4 then v78 else v56
  let v80 := if r.getLsbD 5 then v79 else v76
  let v81 := if r.getLsbD 6 then v80 else v75
  let v82 := if r.getLsbD 2 then v0 else true
  let v83 := if r.getLsbD 3 then true else v82
  let v84 := if r.getLsbD 5 then v83 else v65
  let v85 := if r.getLsbD 7 then v84 else v81
  let v86 := if r.getLsbD 2 then v0 else (!(r.getLsbD 0))
  let v87 := if r.getLsbD 3 then true else v86
  let v88 := if r.getLsbD 4 then v87 else v83
  let v89 := if r.getLsbD 5 then v88 else v26
  let v90 := if r.getLsbD 3 then (r.getLsbD 2) else false
  let v91 := if r.getLsbD 3 then true else v55
  let v92 := if r.getLsbD 4 then v91 else v83
  let v93 := if r.getLsbD 5 then v92 else v90
  let v94 := if r.getLsbD 6 then v93 else v89
  let v95 := if r.getLsbD 3 then v25 else v62
  let v96 := if r.getLsbD 4 then v26 else v95
  let v97 := if r.getLsbD 3 then false else v72
  let v98 := if r.getLsbD 5 then v97 else v96
  let v99 := if r.getLsbD 7 then v98 else v94
  let v100 := if r.getLsbD 8 then v99 else v85
  let v101 := if r.getLsbD 9 then v100 else v70
  let v102 := if r.getLsbD 10 then v101 else v52
  let v103 := if r.getLsbD 1 then false else (r.getLsbD 0)
  let v104 := if r.getLsbD 2 then false else v103
  let v105 := if r.getLsbD 3 then v104 else false
  let v106 := if r.getLsbD 2 then (!(r.getLsbD 1)) else false
  let v107 := if r.getLsbD 3 then false else v106
  let v108 := if r.getLsbD 3 then false else (r.getLsbD 1)
  let v109 := if r.getLsbD 4 then v108 else v107
  let v110 := if r.getLsbD 5 then v109 else v105
  let v111 := if r.getLsbD 3 then v63 else false
  let v112 := if r.getLsbD 3 then v63 else true
  let v113 := if r.getLsbD 4 then v112 else v111
  let v114 := if r.getLsbD 1 then false else (!(r.getLsbD 0))
  let v115 := if r.getLsbD 3 then v114 else v25
  let v116 := if r.getLsbD 5 then v115 else v113
  let v117 := if r.getLsbD 2 then (r.getLsbD 0) else (r.getLsbD 1)
  let v118 := if r.getLsbD 3 then v117 else true
  let v119 := if r.getLsbD 3 then v63 else (r.getLsbD 1)
  let v120 := if r.getLsbD 4 then v119 else v118
  let v121 := if r.getLsbD 5 then v36 else v120
  let v122 := if r.getLsbD 6 then v121 else v116
  let v123 := if r.getLsbD 7 then v122 else v110
  let v124 := if r.getLsbD 3 then v21 else true
  let v125 := if r.getLsbD 2 then (r.getLsbD 1) else true
  let v126 := if r.getLsbD 3 then true else v125
  let v127 := if r.getLsbD 3 then (!(r.getLsbD 1)) else true
  let v128 := if r.getLsbD 4 then v127 else v126
  let v129 := if r.getLsbD 5 then v128 else v124
  let v130 := if r.getLsbD 3 then false else (!(r.getLsbD 1))
  let v131 := if r.getLsbD 4 then v26 else v130
  let v132 := if r.getLsbD 5 then v127 else v131
  let v133 := if r.getLsbD 1 then true else (r.getLsbD 0)
  let v134 := if r.getLsbD 2 then (r.getLsbD 0) else v133
  let v135 := if r.getLsbD 3 then v134 else true
  let v136 := if r.getLsbD 2 then false else v133
  let v137 := if r.getLsbD 3 then v136 else (r.getLsbD 1)
  let v138 := if r.getLsbD 4 then v137 else v135
  let v139 := if r.getLsbD 5 then v36 else v138
  let v140 := if r.getLsbD 6 then v139 else v132
  let v141 := if r.getLsbD 7 then v140 else v129
  let v142 := if r.getLsbD 8 then v141 else v123
  let v143 := if r.getLsbD 2 then true else v103
  let v144 := if r.getLsbD 3 then v143 else true
  let v145 := if r.getLsbD 3 then (!(r.getLsbD 1)) else v12
  let v146 := if r.getLsbD 4 then v145 else v36
  let v147 := if r.getLsbD 5 then v146 else v144
  let v148 := if r.getLsbD 3 then v21 else false
  let v149 := if r.getLsbD 3 then (!(r.getLsbD 1)) else v125
  let v150 := if r.getLsbD 4 then v149 else v36
  let v151 := if r.getLsbD 5 then v150 else v148
  let v152 := if r.getLsbD 6 then v151 else v147
  let v153 := if r.getLsbD 3 then v143 else false
  let v154 := if r.getLsbD 4 then v153 else v148
  let v155 := if r.getLsbD 3 then (r.getLsbD 1) else false
  let v156 := if r.getLsbD 5 then v155 else v154
  let v157 := if r.getLsbD 7 then v156 else v152
  let v158 := if r.getLsbD 9 then v157 else v142
  let v159 := if r.getLsbD 2 then v103 else true
  let v160 := if r.getLsbD 3 then v159 else false
  let v161 := if r.getLsbD 3 then v133 else false
  let v162 := if r.getLsbD 4 then true else v161
  let v163 := if r.getLsbD 5 then v162 else v160
  let v164 := if r.getLsbD 2 then (r.getLsbD 1) else false
  let v165 := if r.getLsbD 3 then v164 else false
  let v166 := if r.getLsbD 2 then (r.getLsbD 1) else (r.getLsbD 0)
  let v167 := if r.getLsbD 3 then v166 else true
  let v168 := if r.getLsbD 4 then v167 else v165
  let v169 := if r.getLsbD 5 then true else v168
  let v170 := if r.getLsbD 2 then v103 else false
  let v171 := if r.getLsbD 3 then v170 else false
  let v172 := if r.getLsbD 2 then v114 else true
  let v173 := if r.getLsbD 3 then v172 else true
  let v174 := if r.getLsbD 4 then v173 else v171
  let v175 := if r.getLsbD 3 then v133 else (!(r.getLsbD 2))
  let v176 := if r.getLsbD 5 then v175 else v174
  let v177 := if r.getLsbD 6 then v176 else v169
  let v178 := if r.getLsbD 7 then v177 else v163
  let v179 := if r.getLsbD 3 then (r.getLsbD 2) else true
  let v180 := if r.getLsbD 3 then true else v21
  let v181 := if r.getLsbD 4 then true else v180
  let v182 := if r.getLsbD 5 then v181 else v179
  let v183 := if r.getLsbD 1 then true else (!(r.getLsbD 0))
  let v184 := if r.getLsbD 2 then v183 else false
  let v185 := if r.getLsbD 3 then v184 else false
  let v186 := if r.getLsbD 2 then v183 else (r.getLsbD 0)
  let v187 := if r.getLsbD 3 then v186 else true
  let v188 := if r.getLsbD 4 then v187 else v185
  let v189 := if r.getLsbD 5 then true else v188
  let v190 := if r.getLsbD 3 then v184 else true
  let v191 := if r.getLsbD 3 then v170 else true
  let v192 := if r.getLsbD 4 then v191 else v190
  let v193 := if r.getLsbD 3 then (r.getLsbD 1) else (r.getLsbD 2)
  let v194 := if r.getLsbD 5 then v193 else v192
  let v195 := if r.getLsbD 6 then v194 else v189
  let v196 := if r.getLsbD 7 then v195 else v182
  let v197 := if r.getLsbD 8 then v196 else v178
  let v198 := if r.getLsbD 3 then v183 else v21
  let v199 := if r.getLsbD 4 then true else v198
  let v200 := if r.getLsbD 5 then v199 else v190
  let v201 := if r.getLsbD 2 then v133 else true
  let v202 := if r.getLsbD 3 then v201 else (r.getLsbD 1)
  let v203 := if r.getLsbD 5 then v162 else v202
  let v204 := if r.getLsbD 6 then v203 else v200
  let v205 := if r.getLsbD 3 then v125 else (r.getLsbD 1)
  let v206 := if r.getLsbD 2 then v183 else true
  let v207 := if r.getLsbD 3 then v206 else true
  let v208 := if r.getLsbD 4 then v207 else v205
  let v209 := if r.getLsbD 5 then v127 else v208
  let v210 := if r.getLsbD 7 then v209 else v204
  let v211 := if r.getLsbD 9 then v210 else v197
  let v212 := if r.getLsbD 10 then v211 else v158
  let v213 := if r.getLsbD 11 then v212 else v102
  v213


def slope (r : Row) : ModFour := if sector r then 1 else 0
def potential (r : Row) : ModFour :=
  (if low r then 1 else 0) + (if high r then 2 else 0)

set_option maxRecDepth 100000
set_option maxHeartbeats 0


abbrev C := BitVec 2
abbrev Col := C × C

private def eachColor (p : C → Bool) : Bool :=
  (List.finRange 4).all (fun i => p ⟨i⟩)
private theorem eachColor_spec (p : C → Bool) (h : eachColor p = true) (a : C) : p a = true :=
  List.all_eq_true.mp h a.toFin (List.mem_finRange _)

private def eachCol (f : Col → Bool) : Bool :=
  eachColor fun x => eachColor fun y => f (x,y)
private theorem eachCol_spec {f : Col → Bool} (h : eachCol f = true) (a : Col) : f a = true :=
  eachColor_spec _ (eachColor_spec _ h a.1) a.2

private def link (a b : Col) : Bool :=
  (a.1 != b.1) && (a.2 != b.2) && (a.1 != a.2) && (a.1 != b.2)

private def extend (a : Col) (f : Col → Bool) : Bool :=
  eachCol fun b => !(link a b) || f b
private theorem extend_spec {a b : Col} {f : Col → Bool} (h : extend a f = true)
    (t : link a b = true) : f b = true := by
  have p := eachCol_spec h b
  simpa [t] using p

private def pack (a b c d e f : C) : Row :=
  BitVec.ofNat 12 (a.toNat + 4*b.toNat + 16*c.toNat + 64*d.toNat + 256*e.toNat + 1024*f.toNat)

private theorem unpack (r : Row) :
    pack (color r 0) (color r 1) (color r 2) (color r 3) (color r 4) (color r 5) = r := by
  apply BitVec.eq_of_toNat_eq
  have bound := r.isLt
  simp [pack, color, BitVec.extractLsb', Nat.shiftRight_eq_div_pow]
  omega

private def consistent (r s : Row) : Bool :=
  (slope r == slope s) && (strip r s + potential r == slope r + potential s)

private def cells (a : Col) : Bool := extend a fun b =>
  extend b fun c => extend c fun d => extend d fun e => extend e fun f =>
  !(link f a) || consistent (pack a.1 b.1 c.1 d.1 e.1 f.1) (pack a.2 b.2 c.2 d.2 e.2 f.2)

private theorem first_00 : cells (0,0) = true := by rfl
private theorem first_01 : cells (0,1) = true := by rfl
private theorem first_02 : cells (0,2) = true := by rfl
private theorem first_03 : cells (0,3) = true := by rfl
private theorem first_10 : cells (1,0) = true := by rfl
private theorem first_11 : cells (1,1) = true := by rfl
private theorem first_12 : cells (1,2) = true := by rfl
private theorem first_13 : cells (1,3) = true := by rfl
private theorem first_20 : cells (2,0) = true := by rfl
private theorem first_21 : cells (2,1) = true := by rfl
private theorem first_22 : cells (2,2) = true := by rfl
private theorem first_23 : cells (2,3) = true := by rfl
private theorem first_30 : cells (3,0) = true := by rfl
private theorem first_31 : cells (3,1) = true := by rfl
private theorem first_32 : cells (3,2) = true := by rfl
private theorem first_33 : cells (3,3) = true := by rfl

private theorem verified : eachCol cells = true := by
  change ((cells (0,0) && (cells (0,1) && (cells (0,2) && (cells (0,3) && true)))) && ((cells (1,0) && (cells (1,1) && (cells (1,2) && (cells (1,3) && true)))) && ((cells (2,0) && (cells (2,1) && (cells (2,2) && (cells (2,3) && true)))) && ((cells (3,0) && (cells (3,1) && (cells (3,2) && (cells (3,3) && true)))) && true)))) = true
  simp only [first_00, first_01, first_02, first_03, first_10, first_11, first_12, first_13, first_20, first_21, first_22, first_23, first_30, first_31, first_32, first_33, Bool.true_and]


private theorem physical_edges (r s : Row) (h : compatible r s = true) (i : Nat) (hi : i < 6) :
    link (color r i, color s i) (color r ((i+1)%6),color s ((i+1)%6)) = true :=
  List.all_eq_true.mp h i (List.mem_range.mpr hi)

theorem local_certificate (r s : Row) (h : compatible r s = true) :
    slope r = slope s ∧ strip r s + potential r = slope r + potential s := by
  let a := fun i => (color r i, color s i)
  have el (i : Nat) (hi : i < 6) : link (a i) (a ((i+1)%6)) = true := physical_edges _ _ h _ hi
  have v0 : cells (a 0) = true := eachCol_spec verified (a 0)
  have v1 := extend_spec v0 (el 0 (by decide))
  have v2 := extend_spec v1 (el 1 (by decide))
  have v3 := extend_spec v2 (el 2 (by decide))
  have v4 := extend_spec v3 (el 3 (by decide))
  have v5 := extend_spec v4 (el 4 (by decide))
  have last : link (a 5) (a 0) = true := el 5 (by decide)
  change (!link (a 5) (a 0) || consistent _ _) = true at v5
  simp only [last, Bool.not_true, Bool.false_or] at v5
  change consistent (pack (color r 0) (color r 1) (color r 2) (color r 3) (color r 4) (color r 5))
    (pack (color s 0) (color s 1) (color s 2) (color s 3) (color s 4) (color s 5)) = true at v5
  rw [unpack, unpack] at v5
  simpa [consistent] using v5

#print axioms local_certificate

/-- Sum of the signed triangle counts over the first H row strips, modulo four. -/
def degreeModFour (row : Nat → Row) : Nat → ModFour
  | 0 => 0
  | h + 1 => degreeModFour row h + strip (row h) (row (h + 1))

/-- All row pairs of the cut cylinder are proper. Rows 0 and H are identified on closure. -/
def legalRows (row : Nat → Row) (H : Nat) : Prop :=
  ∀ j, j < H → compatible (row j) (row (j + 1)) = true

def closedRows (row : Nat → Row) (H : Nat) : Prop :=
  legalRows row H ∧ row H = row 0

private theorem telescope_step (d e a b c t k : ModFour)
    (ih : d + a = t * k + b) (he : e + b = k + c) :
    (d + e) + a = (t + 1) * k + c := by
  calc
    d + e + a = (d + a) + e := by ac_rfl
    _ = (t * k + b) + e := by rw [ih]
    _ = t * k + (e + b) := by ac_rfl
    _ = t * k + (k + c) := by rw [he]
    _ = (t + 1) * k + c := by simp [BitVec.add_mul, BitVec.add_assoc]

/-- Summing the local identities on a cylinder leaves only its two boundary potentials. -/
theorem cylinder_degree (row : Nat → Row) (H : Nat) (legal : legalRows row H) :
    slope (row H) = slope (row 0) ∧
      degreeModFour row H + potential (row 0) =
        BitVec.ofNat 2 H * slope (row 0) + potential (row H) := by
  induction H with
  | zero => simp [degreeModFour]
  | succ h ih =>
    have prev : legalRows row h := fun j hj => legal j (by omega)
    obtain ⟨hs, hd⟩ := ih prev
    obtain ⟨h1, h2⟩ := local_certificate _ _ (legal h (by omega))
    rw [hs] at h2
    refine ⟨h1.symm.trans hs, ?_⟩
    rw [degreeModFour, BitVec.ofNat_add]
    exact telescope_step _ _ _ _ _ _ _ hd h2

theorem closed_degree (row : Nat → Row) (H : Nat) (hc : closedRows row H) :
    degreeModFour row H = BitVec.ofNat 2 H * slope (row 0) := by
  have eqn := (cylinder_degree row H hc.1).2
  rw [hc.2] at eqn
  exact (BitVec.add_left_inj _).mp eqn

/-- Least-significant digit first: 0,1,0,1,0,1 and 2,3,2,3,2,3. -/
def alternatingRow (j : Nat) : Row := if j % 2 = 0 then 0x444 else 0xEEE

private theorem alternating_legal (H : Nat) : legalRows alternatingRow H := by
  intro j _
  by_cases even : j % 2 = 0
  · have odd : (j + 1) % 2 ≠ 0 := by omega
    simp only [alternatingRow, if_pos even, if_neg odd]
    decide
  · have next : (j + 1) % 2 = 0 := by omega
    simp only [alternatingRow, if_neg even, if_pos next]
    decide

private theorem length_residue (H : Nat) :
    BitVec.ofNat 2 H = 2 ↔ H % 4 = 2 := by
  change BitVec.ofNat 2 H = 2 ↔ (BitVec.ofNat 2 H).toNat = (2 : ModFour).toNat
  exact ⟨congrArg BitVec.toNat, BitVec.eq_of_toNat_eq⟩

/-- Exact classification, with H unbounded. The witness is a closed proper
row sequence of height H, with signed triangle degree equal to two modulo four. -/
theorem closed_degree_two_iff (H : Nat) :
    (∃ row : Nat → Row, closedRows row H ∧ degreeModFour row H = 2) ↔ H % 4 = 2 := by
  constructor
  · rintro ⟨row, hc, hd⟩
    rw [closed_degree row H hc] at hd
    by_cases h : sector (row 0) = true
    · exact (length_residue H).mp (by simpa [slope, h] using hd)
    · simp [slope, h] at hd
  · intro h
    have even : H % 2 = 0 := by omega
    have hc : closedRows alternatingRow H :=
      ⟨alternating_legal H, by simp [alternatingRow, even]⟩
    have hs : slope (alternatingRow 0) = 1 := by decide
    refine ⟨alternatingRow, hc, ?_⟩
    simpa [closed_degree alternatingRow H hc, hs] using ((length_residue H).mpr h)

/-- At three-colourable heights the degree-two-mod-four obstruction occurs
exactly in the residue class M=2 modulo four. -/
theorem obstruction_at_height_three_mul (M : Nat) :
    (∃ row : Nat → Row, closedRows row (3*M) ∧ degreeModFour row (3*M) = 2)
      ↔ M % 4 = 2 := by
  rw [closed_degree_two_iff]
  omega

#print axioms closed_degree_two_iff
#print axioms obstruction_at_height_three_mul


/-- Integer orientation count of the face 0-1-2. The three cyclic orderings are
positive, the three reverse orderings are negative, and other faces contribute zero. -/
def orientedFace (a b c : BitVec 2) : Int :=
  if (a == 0 && b == 1 && c == 2) || (a == 1 && b == 2 && c == 0) ||
     (a == 2 && b == 0 && c == 1) then 1
  else if (a == 0 && b == 2 && c == 1) || (a == 2 && b == 1 && c == 0) ||
          (a == 1 && b == 0 && c == 2) then -1
  else 0

theorem orientedFace_mod (a b c : BitVec 2) :
    BitVec.ofInt 2 (orientedFace a b c) = face a b c := by
  unfold orientedFace face
  split
  · rfl
  · split <;> rfl

/-- Integer degree contribution of the twelve oriented triangles in one row strip. -/
def signedStrip (r s : Row) : Int :=
  (List.range 6).foldl (fun acc i =>
    let j := (i+1)%6
    acc + orientedFace (color r i) (color r j) (color s j)
        + orientedFace (color r i) (color s j) (color s i)) 0

private theorem fold_signed_mod (indices : List Nat) (a b : Nat → Int) (acc : Int) :
    BitVec.ofInt 2 (indices.foldl (fun v i => v + a i + b i) acc) =
      indices.foldl (fun v i => v + BitVec.ofInt 2 (a i) + BitVec.ofInt 2 (b i))
        (BitVec.ofInt 2 acc) := by
  induction indices generalizing acc with
  | nil => rfl
  | cons i rest ih =>
    simp only [List.foldl_cons, ih, BitVec.ofInt_add]

theorem signedStrip_mod (r s : Row) :
    BitVec.ofInt 2 (signedStrip r s) = strip r s := by
  unfold signedStrip strip
  rw [fold_signed_mod]
  simp only [orientedFace_mod]
  rfl

/-- Orientation-preserving preimages minus orientation-reversing preimages
of the target face, summed over all H strips. -/
def signedDegree (row : Nat → Row) : Nat → Int
  | 0 => 0
  | h+1 => signedDegree row h + signedStrip (row h) (row (h+1))

theorem signedDegree_mod (row : Nat → Row) (H : Nat) :
    BitVec.ofInt 2 (signedDegree row H) = degreeModFour row H := by
  induction H with
  | zero => rfl
  | succ h ih =>
    simp only [signedDegree, degreeModFour, BitVec.ofInt_add, ih, signedStrip_mod]

theorem signedDegree_remainder (row : Nat → Row) (H : Nat) :
    signedDegree row H % 4 = ((degreeModFour row H).toNat : Int) := by
  rw [← signedDegree_mod, BitVec.toNat_ofInt]
  simp
  omega

theorem signed_degree_two_iff (H : Nat) :
    (∃ row : Nat → Row, closedRows row H ∧ signedDegree row H % 4 = 2) ↔ H % 4 = 2 := by
  rw [← closed_degree_two_iff]
  apply exists_congr
  intro row
  rw [signedDegree_remainder]
  apply and_congr_right
  intro _
  constructor
  · intro h
    apply BitVec.eq_of_toNat_eq
    change (degreeModFour row H).toNat = 2
    omega
  · intro h
    rw [h]
    decide


/-- The physical integer signed degree of the explicit witness, for every height.
This is a strip sum even before the two ends have been identified. -/
theorem alternating_signedDegree (H : Nat) :
    signedDegree alternatingRow H = -3 * (H : Int) := by
  have step (j : Nat) :
      signedStrip (alternatingRow j) (alternatingRow (j+1)) = -3 := by
    by_cases even : j % 2 = 0
    · have odd : (j+1) % 2 ≠ 0 := by omega
      simp only [alternatingRow, if_pos even, if_neg odd]
      decide
    · have next : (j+1) % 2 = 0 := by omega
      simp only [alternatingRow, if_neg even, if_pos next]
      decide
  induction H with
  | zero => rfl
  | succ h ih =>
      rw [signedDegree, ih, step]
      omega

/-- The obstruction from Mohar and Salas, with their precise integer residue.
This theorem is unconditional and uses neither of the published criteria. -/
theorem degree_six_mod_twelve_iff (M : Nat) :
    (∃ row : Nat → Row, closedRows row (3*M) ∧ signedDegree row (3*M) % 12 = 6) ↔
      M % 4 = 2 := by
  constructor
  · rintro ⟨row, legal, hd⟩
    have four : signedDegree row (3*M) % 4 = 2 := by omega
    have hh := (signed_degree_two_iff (3*M)).mp ⟨row, legal, four⟩
    omega
  · intro hm
    have even : (3*M) % 2 = 0 := by omega
    refine ⟨alternatingRow, ⟨alternating_legal _, ?_⟩, ?_⟩
    · simp [alternatingRow, even]
    · rw [alternating_signedDegree]
      omega

/-- Application of the single published dynamical bridge (Corollary 3.5).
The new classification of its right-hand side has no hypotheses. -/
theorem wsk_classification_from_corollary_3_5
    (M : Nat) (Nonergodic : Prop)
    (corollary35 : Nonergodic ↔ ∃ row : Nat → Row,
      closedRows row (3*M) ∧ signedDegree row (3*M) % 12 = 6) :
    Nonergodic ↔ M % 4 = 2 :=
  corollary35.trans (degree_six_mod_twelve_iff M)

#print axioms alternating_signedDegree
#print axioms degree_six_mod_twelve_iff
#print axioms wsk_classification_from_corollary_3_5

end PottsSix
