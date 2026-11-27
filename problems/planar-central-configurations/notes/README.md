# Singular diagrams on the five-equal-mass line

**Chatgpt · Working notes · 27 November 2026**

## English

For the full argument on the five-equal-mass line, read the standalone manuscript. This directory preserves the intermediate candidate lists, local algebra, and exact scripts that readers can use to inspect individual steps. [Standalone paper (PDF)](../papers/FiveEqualFiniteness.pdf) · [LaTeX](../papers/FiveEqualFiniteness.tex) · [Exact verification archive](../papers/FiveEqualFiniteness-checks.zip) · [Guide to all papers](../papers/README.md)

The **physical candidate list is empty for generic positive mass ratio** on the line with five equal masses. The previously surviving asymmetric quartet in diagram 88 is excluded both by a test at sixth mass 2 in residue characteristic 65521 and over a distance-ratio function field. This completes the physical finiteness argument outside a finite algebraic set. The unrestricted signed-complex ledger has seven placements in five classes, one in diagram 88 and four in diagram 93. [Case ledger and verification](last-diagrams/README.md) · [English paper (PDF)](../papers/LastDiagrams.pdf) · [LaTeX source](../papers/LastDiagrams.tex)

The first reduction after the census left diagrams 88, 93 and 94 at generic positive mass ratio. That shortlist contains 55 symmetry representatives, 29 of which satisfy the additional origin requirement for real finiteness. [Three-diagram paper](reduction/README.md)

The zero-multiplier quartet at a simultaneous collapse also leads to a complete classification for masses $(t,1,1,1)$. A separate manuscript establishes the two positive noncollinear mass ratios and the four positive collinear ratios allowed by the signed equations. [Paper (PDF)](../papers/SignedQuartetEquilibria.pdf) · [LaTeX source](../papers/SignedQuartetEquilibria.tex)

An intermediate energy and mass-derivative argument identified 22 symmetry classes relevant to an infinite real six-body family, three in diagram 88 and nineteen in diagram 94. Diagram 93 still has four candidates in the unrestricted signed-complex problem. [Energy-bound ledger](physical-ends/README.md)

Fix positive masses proportional to $(1,1,1,1,1,t)$. An infinite family of distinct real central configurations at fixed masses gives a nontrivial curve in the normalized complex equations. A singular diagram records the relative orders of its coordinates and pair distances at a place on that curve. The following deductions supplement the [diagram 98 manuscript](../papers/FiveEqualSixBody.pdf).

- **Census of published core identities.** Restricting 1,928 published certificate polynomials to all six placements of the distinguished mass retains a nonzero obstruction in 203,119 of 232,788 cell–placement pairs. One diagram-8 cell loses its assigned obstruction for every placement. The individual certificate for diagram 63 equals a sum of two positive masses and excludes it as an end with nonpositive total distance order for any positive masses. [Inputs, counts and replay](CoreCensus.md)
- **Diagram 8.** Two of Tomar’s triangle criteria cover all 1,866 listed cells. Only $t=1/4$ can pass the required mass tests. At that value the existence of a diagram-8 end remains open. Across all diagrams the first triangle test reduces the 29,669 pairs left by the core census to 1,532 pairs at generic $t$. The 43 cells without an assigned core are counted separately. [Diagram 8](Diagram8.md) · [All-class triangle test](TriangleCover.md)
- **Diagrams 64 and 66.** Tomar’s Theorems 7.12 and 7.13 require the four ordered cluster masses to lie in one of two Zariski-closed sets defined over the rationals. The paragraph following Theorem 7.13 excludes $(1,1,1,1)$ from both sets. For each permitted placement of the distinguished mass, pull back the appropriate closed set to the affine $t$-line. Its inverse image misses $t=1$, so it is a proper closed subset of a line and consists of finitely many algebraic points. There are finitely many placements. Consequently the two diagrams are excluded for every positive $t$ outside one finite set, and also at $t=1$. If the variable mass lies outside the four-body cluster, the tuple is constant and the exclusion holds for every $t$. Determining the exceptional values would require more information about these closed sets. This deduction uses the published mass conditions. [Tomar, §7.4](https://hexagonmath.org/pdf/2611.00377v1)
- **Diagram 93.** A torque identity bounds the exponent at the fourth vertex when a particular limiting force is nonzero. At positive exponent the cross-cluster signs factor into row and column signs. The accompanying derivation identifies the cases still open. [Derivation](Diagram93.md) · [Algebra checked in Lean](../Lean/Diagram93Algebra.lean)
- **Diagrams 88 and 94.** The square with positive internal distances in diagram 88 passes the leading torque test at exactly three positive binary mass ratios. In diagram 94 an equilateral triangle with a central fourth body solves the listed four-body conditions and passes the first torque test at every positive binary mass ratio. The latter family identifies where an additional six-body equation is needed. [Leading configurations and calculations](Diagrams88and94.md)

After applying the additional positive-mass, clique and whole-diagram tests in the census, 738 core-certified cell/placement pairs remain for generic $t$. Separately, 19 of the 43 cells without an assigned core remain in diagrams 88, 93 and 94. Together the two lists involve 14 diagram classes. Each surviving entry is a case to investigate. [Census and exact replay](CoreCensus.md) · [738 placements](RemainingCorePlacements.csv)

### A global test to try

Write $x_{ij}(P)$ for the normalized order of the squared distance $r_{ij}^2$ at a singular place $P$. Tomar’s Lemma 2.6 gives $\sum_P d_P x_{ij}(P)=0$ for each pair, with positive weights $d_P$. For the five unit masses set $A=\sum_{1\le i<j\le5}x_{ij}$ and $B=\sum_{i=1}^5x_{i6}$. A pair of rational weights $\alpha,\beta$ with $\alpha A+\beta B>0$ at every remaining possible singular place would contradict those balances and exclude a nontrivial curve. Symmetry under permutations of the five unit labels allows any strictly separating linear functional on edges to be averaged to this two-weight form, provided that the candidate set includes all such permutations. [Tomar, Lemma 2.6 and Corollary 2.7](https://hexagonmath.org/pdf/2611.00377v1)

Changing weights requires reconsidering cells previously discarded solely because $A+B>0$. The seven diagram classes in the last step of Tomar’s generic-mass proof follow earlier mass-dependent exclusions. Those exclusions must be checked on this mass line. A useful preliminary calculation is to choose each of the six possible distinguished vertices in turn for a fixed valuation vector of total sum $L$. The average projection $(A,B)$ is $(2L/3,L/3)$, because each edge is incident to precisely two vertices. If $L=0$ and every placement survives, no such functional can be strictly positive on all six. Local exclusions of particular placements can therefore be decisive. A successful global separation on this family remains open. [Tomar, §§5 and 8](https://hexagonmath.org/pdf/2611.00377v1)

## 中文

若要了解五重等质量线上的完整有限性论证，可从独立论文读起。本目录保留各阶段候选清单、局部代数推导和精确计算程序，供逐步复核。[独立论文 PDF](../papers/FiveEqualFiniteness.pdf) · [LaTeX 源稿](../papers/FiveEqualFiniteness.tex) · [精确计算复验包](../papers/FiveEqualFiniteness-checks.zip) · [论文导读](../papers/README.md#中文)

五重等质量线上，**一般正质量比下与实构型有限性有关的候选已全部排除**。最后的图 88 非对称四体组，用特征 65521 下质量取 2 的特化和距离比函数域消元分别排除，从而得到有限多个代数例外值之外的实中心构型有限性。有符号复曲线仍有 7 种放置、5 个对称类，其中图 88 有 1 类，图 93 有 4 类。[最新清单与复验](last-diagrams/README.md#中文) · [英文论文 PDF](../papers/LastDiagrams.pdf) · [LaTeX 源稿](../papers/LastDiagrams.tex)

本页记录第一轮筛查。随后一般正质量比下的清单已缩至图 88、93、94，合并对称性后有 55 个代表，针对实构型有限性进一步剩下 29 个。[三种图的论文与复验](reduction/README.md#中文)

四体同时塌缩时会出现力乘子为零的有符号极限。对质量 $(t,1,1,1)$，独立论文分类了这种极限方程可能允许的正质量比，非共线与共线时分别有两个和四个。[英文论文 PDF](../papers/SignedQuartetEquilibria.pdf) · [LaTeX 源稿](../papers/SignedQuartetEquilibria.tex)

在此前的能量约束阶段，能量及其质量导数把一般正质量比下实六体有限性所需的候选由 29 类缩至 22 类，图 88 有 3 类，图 94 有 19 类。若考虑任意有符号复曲线，图 93 仍有 4 类候选。[能量约束阶段的清单](physical-ends/README.md#中文)

固定质量 $(1,1,1,1,1,t)$。若某个固定的正质量比有无穷多个不同的实中心构型，归一化后的复方程会有一条非平凡代数曲线。退化图记录这条曲线趋向边界时，各坐标和体间距离以什么相对速度变化。

- **原始证书的逐项筛查。** 将 1,928 个证书多项式分别限制到标记质量的六种放置方式。232,788 个“单元与放置”组合中，203,119 个仍得到非零的函数域证书。图 8 有一个单元的证书在全部放置下失效。图 63 需要的证书直接等于两个正质量的和，对任意正质量都能排除该图充当总距离阶数非正的退化端点。[计算口径、原始材料与复验](CoreCensus.md)
- **图 8。** 两种三体条件覆盖全部 1,866 个列出的单元。对每个 $t>0$ 且 $t\ne 1/4$，它都不能充当有限性反证所需的退化端点，唯一候选值是否真能出现仍未确定。在全部图中，只叠加第一种三体条件，就能把原始证书未解决的 29,669 个组合缩至一般参数上的 1,532 个，另有 43 个原本就没有分配证书的单元单独计数。[图 8 的论证](Diagram8.md) · [全图三体检验](TriangleCover.md)
- **图 64、66** 有一个直接推论。两图的四体簇质量必须落在 Tomar 给出的代数闭集内，而两个闭集都不含 $(1,1,1,1)$。无论把标记质量 $t$ 放在哪里，取 $t=1$ 就落在闭集外。因此这条质量线只有有限多个代数参数有待检查，且 $t=1$ 本身可以排除。若 $t$ 在四体簇之外，则所有正 $t$ 都可排除。这里尚未求出有限例外候选的具体数值。[原文定理 7.12、7.13](https://hexagonmath.org/pdf/2611.00377v1)
- **图 93** 中，第四个顶点多出一个中间尺度。用三体簇的精确力矩恒等式可以排除一部分负指数情形。正指数又迫使两个簇之间的九个符号分解为行符号与列符号的乘积。边界指数、对称例外和满足这些条件后能否延拓都留待处理。[推导和例外情形](Diagram93.md) · [经 Lean 核查的代数引理](../Lean/Diagram93Algebra.lean)
- **图 88、94** 说明对称性对首阶力矩检验有不同影响。图 88 的四体正方形且内部取正距离时，只在三个候选质量比通过。图 94 的三个外体全为单位质量时，正三角形加中心体能对任意正的双体质量比通过现有的四体及首阶力矩检验。可以从这一显式解出发，恢复第四体含有次阶项的六体力方程，检查它能否延拓。[显式构型与符号计算](Diagrams88and94.md)

再叠加正质量条件、完全子图的条件及整图排除，一般参数上，带原始证书的单元中还剩 738 个“单元与放置”组合。单独计数的 43 个无证书单元中还剩 19 个，属于图 88、93、94。两份名单合计涉及 14 个图类。清单标记的是尚待研究的情形。[筛查与复验](CoreCensus.md) · [738 项清单](RemainingCorePlacements.csv)

若逐图排除遇到困难，可按是否接触标记体，把十五条边分成十条和五条，分别对距离的消失阶求和。只要找到一组权重，使两类和的加权值在所有可能的退化处都严格为正，就与每条边在整条曲线上的赋值平衡矛盾。改变权重时，先前仅凭旧权重舍去的情形也要重新纳入。当前仍缺少覆盖整个质量族的证明。[原文引理 2.6、推论 2.7](https://hexagonmath.org/pdf/2611.00377v1)
