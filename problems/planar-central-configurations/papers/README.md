# Papers on planar central configurations · 平面中心构型论文导读

[English](#english) · [中文](#中文) · [Project / 专题首页](../README.md) · [Verification / 复验](../Lean/README.md)

## English

### Start with the finiteness theorem

**Five equal masses and one variable mass.** Fix $(1,1,1,1,1,t)$. For every positive $t$ outside a finite set of algebraic numbers the manuscript gives a computer-assisted proof that the real planar Newtonian central configurations form a finite set up to similarity. It takes the reader from the normalized equations and the external six-body catalogue through the successive exclusions, without requiring the original project papers. This eleventh manuscript brings the proof of the earlier theorem into one paper. Whether any positive ratio on this line actually admits infinitely many shapes remains open. The equal-mass case $t=1$ is already finite by a separate enumeration. Finiteness for arbitrary positive six-body masses also remains open. [PDF](FiveEqualFiniteness.pdf) · [LaTeX](FiveEqualFiniteness.tex) · [Exact verification archive](FiveEqualFiniteness-checks.zip)

### Counting, geometry and bifurcations

These seven papers contain results that can be read for their own questions.

- **An exact count near the restricted five-body limit**. Five heavy masses may vary independently near one. For a sufficiently light positive sixth body there are exactly 4,104 labelled, oriented shapes, or 2,232 if reflections are identified. Interval isolation of every test-body equilibrium and a compactness argument turn the singular limit into an exhaustive count. [PDF](SmallMass.pdf) · [LaTeX](SmallMass.tex)

- **Hampton’s equal-mass Morse polynomials**. For six and seven equal Newtonian masses, the paper certifies the number of shapes at each Morse index using Hessian inertia and symmetry multiplicities in the exhaustive catalogues. This settles the Newtonian six-body clause of Hampton’s Conjecture 4 and the seven-body clause of Conjecture 5. [PDF](HamptonMorse.pdf) · [LaTeX](HamptonMorse.tex)

- **A classification of signed four-body equilibria**. For masses $(t,1,1,1)$ the signed zero-force equations admit collision-free solutions at precisely two positive mass ratios for noncollinear shapes and four more for collinear shapes. All six have real-coordinate realizations. When signs must come from four individual electric charges, exactly the two noncollinear ratios remain. [PDF](SignedQuartetEquilibria.pdf) · [LaTeX](SignedQuartetEquilibria.tex)

- **Two nonconcentric equilateral triangles**. Earlier numerical examples suggested shapes with distinct triangle centers and a common reflection axis. This paper proves existence, uniqueness within a specified corridor, and analytic dependence for normalized inner-apex heights from 0.87 to 0.88. A mass ratio varies strictly along the branch. [PDF](NonconcentricTriangles.pdf) · [LaTeX](NonconcentricTriangles.tex)

- **A collinear theorem for any number of bodies**. For any number of bodies in the normalized signed complex equations, the all-collinear solution set is finite if every nonempty subset of masses has nonzero sum. The paper also rules out five collinear unit bodies with the sixth off their line for every positive $t$, and every placement of five collinear bodies at the geometric generic parameter. [PDF](SignedCollinear.pdf) · [LaTeX](SignedCollinear.tex)

- **Diagram 98 and six bifurcations**. Expanding the potential to cubic order gives an obstruction to diagram 98 for generic $t$, individually at $t=3$, and on a nonempty Zariski open subset of $(1,1,1,a,b,c)$ containing $(1,1,1,2,3,7)$. The bifurcation analysis and its companion identify three folds and three pitchforks whose labelled multiplicities account for a net change of 480 between the endpoint counts. Extra events with cancelling contributions remain possible. [PDF](FiveEqualSixBody.pdf) · [LaTeX](FiveEqualSixBody.tex)

- **Two symmetry-breaking pitchforks**. Near $t=0.089353633682$ and $t=0.175165824530$, the local number of labelled, oriented shapes changes from three to one as $t$ increases. Splitting a reflected pair of masses produces a versal cusp unfolding at each point. Read this paper for the certified local geometry of these two events. [PDF](Pitchfork.pdf) · [LaTeX](Pitchfork.tex)

### The earlier papers on the finiteness proof

These three papers explain successive stages of the same proof. The first two counts describe intermediate case lists. The last paper also contains an alternative calculation for the asymmetric quartet.

- **From fourteen candidate diagrams to three**. Tree equations and potential coefficients reduce the list to diagrams 88, 93 and 94. There are 55 orbits under symmetry in the signed catalogue. The necessary compatibility condition at the origin for curves coming from real configurations leaves 29. The paper also restricts diagram 46 to the candidate positive ratios $1/4$ and $1$. [PDF](ReducedSixBodyList.pdf) · [LaTeX](ReducedSixBodyList.tex)

- **Energy and the derivative with respect to the marked mass**. Bounds inherited from real configurations eliminate diagram 93 and the isolated marked binary in diagram 88. The real-finiteness list falls from 29 to 22 classes, three in diagram 88 and nineteen in diagram 94. The argument explains why a signed complex curve need not satisfy the same bounds. [PDF](PhysicalSixBodyEnds.pdf) · [LaTeX](PhysicalSixBodyEnds.tex)

- **The original closing argument and a second elimination**. Starting from those 22 classes, the paper treats the possible positions of the marked mass in diagram 94 and the four-body torques in diagram 88. The asymmetric quartet admits two exclusions. Readers seeking the characteristic-zero alternative will find a degree-4046 distance-ratio resultant and the analysis of its boundary multiplicities here. Five orbits remain possible in the unrestricted signed-complex problem. [PDF](LastDiagrams.pdf) · [LaTeX](LastDiagrams.tex)

## 中文

### 先读五重等质量线上的有限性主定理

**五个相等质量和一个可变质量。** 固定 $(1,1,1,1,1,t)$。研究稿给出计算机辅助证明，说明除了至多有限个代数数以外，每个正 $t$ 都只有有限多个相似意义下的实平面牛顿中心构型。全文从归一化方程和已有的六体退化图分类写起，逐步导出候选清单并排除，无需按发表顺序阅读项目旧稿。这是专题第十一篇论文，集中证明的是此前得到的同一定理。这条质量线上究竟有没有正质量比容许无限多个构型，仍然未知；其中全等质量点 $t=1$ 已由已有的枚举工作证明为有限。任意六个正质量下的有限性也仍是公开问题。 [PDF](FiveEqualFiniteness.pdf) · [LaTeX 源稿](FiveEqualFiniteness.tex) · [精确计算复验包](FiveEqualFiniteness-checks.zip)

### 计数、几何与分岔

以下七篇各自回答一个可独立研究的问题。

- **五重一轻时的精确计数。** 五个重质量可在 1 附近各自变化，第六个正质量充分小时，有标签、区分镜像的构型恰有 4,104 个，合并镜像后为 2,232 个。论文先用区间计算找全试验粒子平衡点，再用紧性证明恢复正质量后没有遗漏。 [PDF](SmallMass.pdf) · [LaTeX 源稿](SmallMass.tex)

- **Hampton 的等质量 Morse 多项式。** 对牛顿引力下的等质量六体和七体，论文以完备构型目录为起点，逐项认证 Hessian 惯性及对称重数，得到每个 Morse 指标对应的构型数。这回答了 Hampton 猜想 4 的牛顿六体分项与猜想 5 的七体分项。 [PDF](HamptonMorse.pdf) · [LaTeX 源稿](HamptonMorse.tex)

- **四体有符号零力平衡的分类。** 对于质量 $(t,1,1,1)$，各对逆距离可独立选取正负号时，非共线零力平衡恰好允许两个正质量比，共线零力平衡另有四个。六者均可用实坐标实现。如果符号必须来自四个点电荷各自的电性，则恰好只允许上述两个非共线比值。 [PDF](SignedQuartetEquilibria.pdf) · [LaTeX 源稿](SignedQuartetEquilibria.tex)

- **两个非同心正三角形。** 前人已给出两个正三角形中心不同、共用一条反射轴的数值构型。本文证明，归一化的内三角形顶点高度在 0.87 至 0.88 之间时，每个高度在指定形状带内都有唯一构型，且沿分支解析变化，并有一个质量比严格单调。 [PDF](NonconcentricTriangles.pdf) · [LaTeX 源稿](NonconcentricTriangles.tex)

- **任意体数的有符号共线定理。** 在归一化的有符号复方程中，任意多个天体只要每个非空质量子集的质量和都不为零，全共线解集就有限。在五重等质量线上，对每个正 $t$ 都可排除恰有五个单位质量共线、余下一体在直线外的构型。在几何一般参数处，还可排除恰有五体共线的任意标记位置。 [PDF](SignedCollinear.pdf) · [LaTeX 源稿](SignedCollinear.tex)

- **图 98 与六处分岔。** 势能的三阶展开给出排除图 98 的障碍，适用于五重等质量线的一般 $t$、单独检验的 $t=3$，以及 $(1,1,1,a,b,c)$ 中含有 $(1,1,1,2,3,7)$ 的一个非空 Zariski 开集。论文与配套分岔稿定位三处折叠、三处叉形分岔，其标签重数解释了两端的构型数差 480。仍可能存在净贡献互相抵消的其他事件。 [PDF](FiveEqualSixBody.pdf) · [LaTeX 源稿](FiveEqualSixBody.tex)

- **两处对称破缺叉形分岔。** 在 $t$ 约为 0.089353633682 和 0.175165824530 的两处，当 $t$ 增大并越过临界值时，局部有标签、区分镜像的构型均从三个变为一个。把一对互为镜像的天体赋以不同质量，两处都得到尖点的通用展开。这篇稿件给出局部几何及其认证。 [PDF](Pitchfork.pdf) · [LaTeX 源稿](Pitchfork.tex)

### 有限性证明的三篇早期论文

三篇稿件记录同一证明的不同阶段。前两篇的候选数是当时的中间结果。最后一篇还保留了排除非对称四体组的另一条消元路线。

- **从十四种候选图缩至三种。** 利用树方程和势能的系数，候选缩至图 88、93、94，共有 55 个有符号对称类。来自实构型的曲线还须满足原点相容条件，应用后剩 29 类。论文还证明，图 46 只可能出现在两个正质量比 $1/4$ 或 $1$。 [PDF](ReducedSixBodyList.pdf) · [LaTeX 源稿](ReducedSixBodyList.tex)

- **能量与对变质量的导数。** 利用从实构型继承的估计，可以在实有限性问题中排除图 93 以及图 88 中变质量位于孤立双体的情形。29 个对称类缩到 22 个，图 88 有 3 类，图 94 有 19 类。文中解释了为何任意有符号复曲线未必受这些估计限制。 [PDF](PhysicalSixBodyEnds.pdf) · [LaTeX 源稿](PhysicalSixBodyEnds.tex)

- **早期的收尾证明与另一条消元路线。** 这篇论文从此前的 22 类出发，处理图 94 中变质量的位置以及图 88 中四体组的力矩。对于最后一个非对称四体组，文中给出两条排除路线。想了解特征零下的另一条路线，可读本文关于 4046 次距离比结式及各边界重数的论证。任意有符号复曲线仍有五个尚未排除的对称类。 [PDF](LastDiagrams.pdf) · [LaTeX 源稿](LastDiagrams.tex)
