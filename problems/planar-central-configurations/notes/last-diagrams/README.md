# Generic finiteness for the planar six-body problem on the five-equal-mass line

[English](#english) · [中文](#中文) · [English paper (PDF)](../../papers/LastDiagrams.pdf) · [LaTeX source](../../papers/LastDiagrams.tex) · [Complete orbit ledger](OrbitLedger.csv)

## English

Fix planar Newtonian masses $(1,1,1,1,1,t)$, with $t>0$. A central configuration is a shape in which each acceleration is proportional to the displacement from the center of mass, with the same proportionality factor for every body. Smale asked whether there are only finitely many such shapes up to similarity for **every** fixed set of positive masses. Tomar’s generic six-body mass theorem leaves every vector with three equal entries in its exceptional algebraic set. The entire five-equal line lies there. The present manuscript works along that line and allows finitely many exceptions in $t$. It uses Tomar’s catalogue and polynomial equations for the possible ends of curves of configurations. [Tomar, §§1 and 6.7](https://hexagonmath.org/pdf/2611.00377v1) · [Chang and Chen’s diagrams](https://arxiv.org/abs/2303.02853)

**The manuscript proves that for every positive mass ratio $t$ outside a finite set of algebraic numbers, the number of real planar Newtonian central configurations for $(1,1,1,1,1,t)$ is finite up to similarity.** The previous paper left 22 possible symmetry classes of singular ends of a hypothetical curve arising from infinitely many real shapes. The present reductions exclude every class. They give neither the number of shapes at a fixed mass nor a list of exceptional values. Moczurad and Zgliczyński previously gave a complete enumeration at $t=1$ and an independent local result for masses sufficiently near equality. [Equal masses](https://doi.org/10.1007/s10569-019-9920-6) · [Neighborhood of equality](https://ww2.ii.uj.edu.pl/~zgliczyn/papers/cc-3d/cc-3d.pdf) The proof depends on the cited prior reductions and is a research manuscript awaiting independent verification. [English proof](../../papers/LastDiagrams.pdf) · [Previous 22 classes](../physical-ends/README.md)

| Catalogue | Previous placements | Current placements | Previous symmetry classes | Current symmetry classes |
| --- | ---: | ---: | ---: | ---: |
| Necessary for a counterexample to real finiteness | 74 | 0 | 22 | 0 |
| Signed complex equations, including components without real configurations | 185 | 7 | 53 | 5 |

The remaining five signed-complex classes comprise one in diagram 88 (two labelled placements with a marked binary) and four in diagram 93 (five placements). The preceding physical energy and mass-derivative arguments already ruled them out as ends needed for a counterexample over the reals. The stronger question of arbitrary signed complex curves has different hypotheses. [How the previous real-component and catalogue arguments imply finiteness](GlobalImplicationAudit.md) [All 55 original orbits and their status](OrbitLedger.csv) · [Placement ledger](PlacementLedger.csv)

### How the list changed

- **Diagram 94.** The mass can lie on an outer quartet body, at the shared body, or in the opposing binary. For an outer mass, valuation at $t=\infty$ leaves three possible order vectors. Exact initial equations and the first eight orders of a power series reject every remaining branch. For the shared body, the torque and the force equations restrict the possible leading geometries, and the higher-order six-body equations prevent their continuation. For a marked binary, finiteness of the projected equal-quartet shapes forces two cancellations and leads to the same continuation tests. These results remove the previous 41 signed classes of diagram 94, including all 19 relevant to real finiteness. [Outer](Outer94.md) · [Shared](Center94.md) · [Binary](BinaryProjection94.md) · [Earlier equilateral continuation test](../physical-ends/Equilateral94.md)
- **Diagram 88 with a zero quartet ordinate.** The quartet satisfies a complete signed four-body system. When the body with zero small projection carries mass $t$, its force and the rank-one stress give two plane equations with only finitely many common zeros, together with a separate equal-cubes case. When the zero occurs at a *unit* mass and $t$ is elsewhere in the quartet, specialize at $t=2$. Two integer resultants and an exact finite-algebra check exclude the distinct-cubes fibre. An independent torque calculation covers equal cubes. The boundary argument shows that a family approaching $t=2$ would give data covered by these tests, even if all the internal distances collapse. The two placements remove the previous representatives $(127,0,3)$ and $(127,0,2)$ and their equivalents. [Marked zero](ZeroProjection88.md) · [Unmarked zero](MixedZeroFibre.md) · [Boundary proof](BoundaryAudit.md)
- **The all-nonzero quartet.** On a hypothetical family at generic mass, it would have no collinear triple and no nontrivial symmetry preserving the masses. Three signed inverse cubes from the marked body are pairwise distinct. Its distance equations can be written in three variables, with a quadratic choice of projection for the torque. At least one marked-body distance ratio must vary on a family with varying $t$. A separate energy inequality valid at each positive $t$ excludes a leading quartet obtained from an ordinary real positive-distance quartet by the common rescaling in the proof. Complex shapes and mixed internal distance signs require the two further arguments below. [Collinear shapes](Collinear88.md) · [Symmetries](Kite88.md) · [Three-collinear proof and distance chart](QuartetChart.md) · [Three-variable reduction](RepeatedStar88.md) · [Varying ratios](ConstantRatios88.md) · [Energy inequality](QuartetEnergy88.md)

### Closing the last class

After the zero-ordinate exclusions, the last physical representative was $(127,6,2)$ with four equivalent labelled placements. Its binary has unit masses, while its quartet has masses $(t,1,1,1)$ and must satisfy both the isolated four-body forces and the equal-binary torque. Two proofs exclude this class.

1. **A complete test in characteristic 65521.** At a valuation with $t$ reducing to 2, every putative algebraic quartet gives a finite projective shape with six distinct nonisotropic pair differences and all four centered high coordinates nonzero. The missing simultaneous collapse gives a zero force multiplier, which is tested as well. The full four-body system with nonzero multiplier has three regular coordinate charts. Exact quotient dimensions are 420, 4 and 102. Rational univariate parametrizations attain each count over the algebraic closure, and no point on any chart passes the torque in either projection. Separate equations cover collinear configurations, configurations with a collinear triple, and zero stress. The counts are chart lengths and should not be added to count physical configurations. [Specialization and boundary proof](FullQuartetSpecialization.md) · [Regular charts, data and solver commands](RegularQuartet88.md) · [Collinear and three-collinear strata](LineFibre88.md) · [Zero-stress calculation](ZeroStress88.py) · [Lean theorem for the planar Gram matrix](../../Lean/ZeroStressGram88.lean)
2. **A separate proof in characteristic zero.** One signed inverse-distance ratio $r$ must vary on any remaining family. At $r=3$ the projected force resultant has degree 4046. The generic degree bound at infinity, intersection multiplicities on forbidden finite divisors and relabelling charts together ensure that a moving solution cannot disappear from the test. The admissible part of the special fibre has 676 simple projected candidates and both choices of the high projection are tested against the torque. Here $r$ is a shape ratio, independent of the mass parameter $t$. [Fixed-ratio calculation](FixedRatio88.md) · [Finite boundary multiplicities](FiniteRatioBoundary88.md) · [Degree bound at infinity](RatioInfinity88.md)

### A four-body result from the boundary calculation

For a noncollinear quartet of masses $(t,1,1,1)$, the force multiplier can vanish in the signed complex Newtonian equations at **exactly two positive mass ratios**. They are $1/\sqrt3$ and the unique positive root of $3t^6-106t^4-97t^2-25=0$, approximately $6.0193086418$. An inversion of a unit equilateral triangle gives explicit real positions and mixed signs realizing each root. For collinear shapes there are exactly four other positive ratios, each realized on the real axis. [Complete four-body paper](../../papers/SignedQuartetEquilibria.pdf) · [Collinear eliminants and converse](CollinearAbsoluteMasses.md) This classifies mass ratios for a four-body boundary system used in the six-body argument. [Classification, constructions and references](AbsoluteQuartet88.md)

### Other trials and reproducibility

The elementary valuation constraints for the quartet at $t=\infty$ are feasible in all three subcases tested. The replay gives rational assignments meeting the minimum-order conditions for the subset forces, force differences, centering, triangle relations and torque. The marked-zero and unmarked-zero exclusions above therefore needed additional equations. In the general distance chart two finite-field slices at $r=2,3$ and prime 1009 reject all 670 and 676 respective interior force candidates under the torque test. A separate [characteristic-zero proof for the slice at $r=3$](FixedRatio88.md) exhausts its admissible branches. That slice alone would leave escape to a boundary possible. The finite-boundary and degree-at-infinity arguments above address that issue. The energy estimate for diagram 94 is recorded separately and does not contribute a second deletion to the ledger. [Valuation witnesses](valuation_probe.py) · [Slice experiments and sixth-power tests](MixedZeroTests.md) · [Independent diagram-94 energy estimate](OpposingPairWindow.md)

Use Python 3.10+, SymPy, python-flint 0.8.0 and either Z3 or its shared library. For the regular quotient dimensions install msolve 0.10.1 or Singular, as described in the regular-chart note. Run from this directory. The ledger replay reads the earlier tables and verifies the SHA-256 digests of both input tables and the two catalogue files. Each placement is checked against its symmetry representative. Detailed certificate commands and any additional dependencies are given in the individual proof notes. Seven Lean 4.28.0 files for the six-body argument and one [separate charge-equilibrium file](../../Lean/CoulombFour.lean) check named algebraic and inequality lemmas, including the pole-order and specialization arguments specified in the Lean index. The catalogue reduction, analytic arguments and the remaining computational certificates have separate proofs and replays. [Pinned catalogue revision](https://github.com/tejasvi/smale6-six-bodies-generic/tree/84bbcf276d029fdf31375c4a21c6a7e136955e51) · [Lean statements and command](../../Lean/README.md)

~~~sh
python3 replay.py /path/to/smale6-six-bodies-generic /tmp/last-diagrams
for file in PlacementLedger.csv OrbitLedger.csv PhysicalRepresentatives.csv; do
    diff "$file" "/tmp/last-diagrams/$file" || exit 1
done
python3 outer94.py
python3 center_shapes.py
python3 collinear.py
python3 ../physical-ends/equilateral94.py
python3 verify_binary_cluster.py
python3 ZeroProjection88.py
python3 EqualFibre88.py
python3 AbsoluteQuartet88.py
python3 CollinearAbsoluteMasses.py
python3 UnitZeroFibre88.py
python3 MixedZeroFibre88.py --workers 3
python3 BoundaryOrders88.py
python3 Collinear88.py
python3 Kite88.py
python3 RepeatedStar88.py
python3 ConstantRatios88.py
python3 quartet_energy88.py
python3 valuation_probe.py
python3 RegularQuartet88.py --engine msolve
python3 CollinearFibre88.py
python3 TripleFibre88.py
python3 ZeroStress88.py
python3 FixedRatio88.py
python3 FiniteRatioBoundary88.py
python3 RatioInfinity88.py
~~~

## 中文

**对五个质量为 1、第六个质量为 $t$ 的平面牛顿六体系统，除了至多有限个代数例外值，对每个正 $t$，实中心构型按相似分类只有有限多个。** Tomar 的六体一般质量定理允许的例外集合包含所有至少三个质量相等的向量，这整条质量线都在其中。本文在这条线上逐类处理了无穷多个实构型可能导致的退化端。证明没有给出例外质量的清单，也没有计算各质量下的构型数。对任意六个正质量证明有限性，以及对这条线证明无例外，仍是更强的问题。六个质量全相等及其充分小的邻域已有独立的有限性结果。[英文论文 PDF](../../papers/LastDiagrams.pdf) · [LaTeX 源稿](../../papers/LastDiagrams.tex)

上一轮留下与实问题有关的 22 个候选对称类，19 个在图 94，3 个在图 88。图 94 在三种变质量位置上全部排除。图 88 中，两个代表各有一个四体成员的小投影首项为零，一个代表的四个小投影均非零。前两类分别通过平面方程消元和带边界控制的 $t=2$ 特化排除。这时最后一个代表为 $(127,6,2)$，仍对应四种带标号放置。[图 94 的三种论证](Outer94.md) · [零投影分支](MixedZeroFibre.md) · [逐项计数](OrbitLedger.csv)

最后的障碍是，一个满足首项受力方程的复四体组是否也能满足六体方程施加的跨组力矩。第一条证明选取使 $t$ 在特征 65521 下化为 2 的赋值，检验整个代数闭包中的形状，包括同时坍缩、符号混合和坐标退化。常规部分分三个坐标图，维数分别为 420、4、102，每个候选都与力矩矛盾。另一条特征零论证固定一个必然变化的距离比 $r=3$，并控制全部有限边界及无穷远，使退化分支无法绕过这次切片。由此，实问题的清单从 **74 种放置、22 类降至 0**。若考虑包括没有实构型的任意带符号复曲线，则仍有 **7 种放置、5 类**。两种计数回答的问题不同。[有限域证明](FullQuartetSpecialization.md) · [特征零证明](FiniteRatioBoundary88.md) · [上一轮实构型的能量约束](../physical-ends/README.md#中文)

四体边界方程还给出一个独立结论。对质量 $(t,1,1,1)$，允许带符号逆距离的非共线复四体零力平衡恰好在两个正质量比存在，即 $1/\sqrt3$ 和约 $6.0193086418$。两个值都能用实坐标、混合距离符号显式实现。若允许四体共线，还恰有另外四个正质量比，都有实轴上的带符号实现。[完整四体分类论文](../../papers/SignedQuartetEquilibria.pdf)这是对该辅助方程的质量分类。通常的牛顿引力取正距离。对于空间中仅受库仑力作用的四个非零点电荷，电量绝对值之比为 $(t,1,1,1)$ 时，适当选择各电荷符号可使四者同时处于静力平衡的正 $t$ 恰好是上述两个非共线值。[精确多项式与显式构造](AbsoluteQuartet88.md)

论文、LaTeX 和说明文档采用 CC BY 4.0，原创 Lean 与计算复验代码采用 MIT。六体论证的七个 Lean 文件与四体伴随论文的一个 Lean 文件均可独立检查，其覆盖范围逐项列在复验指南中。[许可](../../../../LICENSE) · [Lean 复验指南](../../Lean/README.md#中文)
