# Energy bounds for physical six-body ends · 实六体有限性的能量约束

[English](#english) · [中文](#中文) · [English paper (PDF)](../../papers/PhysicalSixBodyEnds.pdf) · [LaTeX](../../papers/PhysicalSixBodyEnds.tex) · [22 physical representatives](PhysicalRepresentatives.csv)

## English

This page records the energy-bound stage. A subsequent paper excludes all 22 remaining physical classes, proving real finiteness for all positive mass ratios outside a finite algebraic set on this mass line. [Standalone paper (PDF)](../../papers/FiveEqualFiniteness.pdf) · [Final case ledger](../last-diagrams/README.md) · [Original final-diagram paper](../../papers/LastDiagrams.pdf)

For masses $(1,1,1,1,1,t)$ and generic positive $t$, a hypothetical infinite family of real planar central configurations must yield a complex end in **diagram 88 or 94**. The previous 29 symmetry classes compatible with real finiteness are reduced to **22**. Generic here allows a finite set of algebraic exceptions. The derivation builds on Tomar’s nonpositive-end catalogue on this mass line and our earlier list. [Previous list](../reduction/README.md) · [Tomar’s preprint](https://hexagonmath.org/pdf/2611.00377v1)

| Diagram | Signed placements | Signed orbits | Placements still needed for real finiteness | Orbits still needed for real finiteness |
| --- | ---: | ---: | ---: | ---: |
| 88 | 54 | 8 | 20 | 3 |
| 93 | 5 | 4 | 0 | 0 |
| 94 | 126 | 41 | 54 | 19 |
| Total | 185 | 53 | 74 | 22 |

The potential of a normalized central configuration is constant on a fixed-mass irreducible component. A real configuration gives a quantitative lower bound for this value. Varying the marked mass gives a second quantity constant on each relevant fixed-mass component outside finitely many parameters. At diagram 93 the limiting energy is the sum of the energies of two triples. Its magnitude or its mass derivative contradicts the bounds imposed by a real configuration. In diagram 88 the mass derivative is too small when the marked mass lies in the binary. This removes all five previous physical orbits in 93 and two in 88. [Proof](../../papers/PhysicalSixBodyEnds.pdf) · [Details of the marked-binary bound](PhysicalEnvelope.md)

The unrestricted signed-complex count falls from 55 to 53 orbits, or from 187 to 185 labelled placements. In diagram 93 the force supports at cells 60 and 62 put the partially circled vertex in a forbidden range of exponents when it carries the marked mass. These two cells also belonged to the 29 physical candidates and have already been counted there. In fact any negative special exponent is inconsistent for that placement. [Two-cell derivation](Negative93.md) · [Full exponent restriction](OuterStiffness93.md)

The supplementary local calculations address specific leading shapes. For diagram 88 they exclude the regular-square unit quartet for every positive binary ratio, including the three ratios admitted by the first torque. For diagram 94 an equilateral triple of units around the shared body solves the leading four-body equations with positive internal distances; the first cross torque admits it for every binary ratio. A cubic obstruction excludes its lift at generic parameter when the marked mass belongs to the shared body or the opposing binary. On the 72 core-bearing placements of diagram 94, the four-body projection obeys one of four quartics and thus has at most sixteen ratios per fixed assignment of masses. [Diagram 88 shape and sign tests](Diagram88Cluster.md) · [Square obstruction](SquareLift.md) · [Equilateral obstruction](Equilateral94.md) · [Quartic reduction](ShapeCandidates.md)

### Reproduce the counts

Use Python 3.10+ and the [upstream checkout](https://github.com/tejasvi/smale6-six-bodies-generic/tree/84bbcf276d029fdf31375c4a21c6a7e136955e51) at revision `84bbcf2`. Run the commands from this directory. The replay verifies the preceding CSV files and pinned source inputs, reads the actual binary labels and lowest-order force supports, and checks agreement throughout every previously computed symmetry orbit.

~~~sh
python3 replay.py /path/to/smale6-six-bodies-generic /tmp/sixbody-ends
diff PhysicalRepresentatives.csv /tmp/sixbody-ends/PhysicalRepresentatives.csv
diff PlacementLedger.csv /tmp/sixbody-ends/PlacementLedger.csv
diff OrbitLedger.csv /tmp/sixbody-ends/OrbitLedger.csv
~~~

[PhysicalRepresentatives.csv](PhysicalRepresentatives.csv) contains the 22 representatives. [PlacementLedger.csv](PlacementLedger.csv) and [OrbitLedger.csv](OrbitLedger.csv) give a status and reason for each entry of the previous lists, including entries that failed the earlier origin test. A slot is numbered from one. A cell retains its zero-based Tomar index. The individual research notes give commands for the supplementary local checks, including SymPy for the square replay. The signed and physical conclusions have distinct hypotheses. [Lean files and verification scope](../../Lean/README.md)

## 中文

本页保留能量约束阶段的结果与复验材料。后续研究稿排除这一阶段剩余的全部 22 类，得到五重等质量线上除有限多个代数例外值外的实中心构型有限性。[独立论文 PDF](../../papers/FiveEqualFiniteness.pdf) · [最终清单与复验](../last-diagrams/README.md#中文) · [早期收尾论文](../../papers/LastDiagrams.pdf)

对五个单位质量和第六个正质量 $t$，上轮发现一般参数下的实构型有限性只需考察 29 个对称代表。本次把它们缩至 **22 个**，其中图 88 有 3 个，图 94 有 19 个。图 93 的 5 个代表全部排除；图 88 中变质量落在双体组的 2 个代表也被排除。已假定 $t$ 避开有限多个可能的代数例外值。[英文论文](../../papers/PhysicalSixBodyEnds.pdf) · [22 项实问题清单](PhysicalRepresentatives.csv)

证明使用了实中心构型在归一化后必须满足的势能下界。即使反证所用曲线的端点坐标已经变成复数，其势能仍等于曲线上实构型的势能。图 93 会把这个值拆成两个三体贡献，当能量的大小还不能给出矛盾时，可以检验能量随质量比变化的导数。图 88 的孤立双体在同一导数上也与实构型给出的严格下界冲突。

若连没有实构型的复曲线也考虑，剩余 **53 个**对称代表，分别为图 88 的 8 个、图 93 的 4 个、图 94 的 41 个。与上轮相比，图 93 的第 60、62 单元给出两个新的复方程排除。这两项已包含在上述实问题的计数中。另对图 88 的正方形和图 94 的一个等边首项给出了不能延拓到完整六体方程的局部判据。后两项只排除了指定首项，各自所在单元仍有其他可能。[逐项原因](OrbitLedger.csv) · [四次方程对图 94 的进一步约束](ShapeCandidates.md) · [Lean 核查说明](../../Lean/README.md#中文)
