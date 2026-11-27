# Planar Newtonian central configurations · 平面牛顿中心构型

[English](#english) · [中文](#中文) · [Verification / 复验](Lean/README.md)

## English

In a central configuration, the gravitational acceleration of each body points toward the center of mass and is proportional to its distance from that center, with the same constant of proportionality for all bodies. Such a shape can rotate rigidly. Smale’s sixth problem asks whether fixed positive masses permit only finitely many planar shapes after removing translations, rotations and changes of scale. The ten manuscripts by Chatgpt study mass perturbations, geometric families, Morse indices, and finiteness along the five-equal-mass line.

### Five nearly equal masses and a light sixth body

Moczurad and Zgliczyński rigorously enumerated the five- and six-body equal-mass configurations. Tomar’s generic six-body finiteness theorem has an exceptional set containing every mass vector with three equal entries. In particular, its criterion gives no information anywhere on the line with five unit masses and a sixth mass of size *t*. Near *t* = 0, one can first study a massless test body, but counting the actual positive-mass shapes requires proving that all limiting equilibria are isolated and that every small-mass solution is accounted for. [Equal-mass enumeration](https://doi.org/10.1007/s10569-019-9920-6) · [Tomar, Theorem 1.1](https://hexagonmath.org/pdf/2611.00377v1)

The manuscript obtains **4,104 labelled shapes** for five masses that can vary independently near one and a sufficiently small positive sixth mass. Reflections are counted separately whenever they give different labelled shapes. Identifying reflections gives 2,232. Exact interval certificates isolate 8, 12, 10, 14 and 16 test-body equilibria at the five limiting shapes. Continuation and compactness transfer the count to positive mass. On the five-equal-mass line the count changes between this regime and six equal masses, where it is 3,624. At least one intermediate algebraic mass ratio admits a degenerate noncollinear configuration. The manuscript gives no numerical mass cutoff, and finiteness along the entire line remains open. [Paper (PDF)](papers/SmallMass.pdf) · [LaTeX](papers/SmallMass.tex)

### Two nonconcentric equilateral triangles

Xie, Bhusal and Tahir exhibited numerical configurations of two equilateral triangles sharing a reflection axis and having different centroids. The manuscript gives an exact existence and local uniqueness proof throughout an explicit corridor. For each normalized inner-apex height from 0.87 to 0.88, the corridor contains exactly one solution. An outer-apex mass ratio increases strictly along the analytic family. Different heights therefore yield different masses, so these configurations do not supply a continuous family at fixed masses. [Earlier numerical examples](https://doi.org/10.1016/j.geomphys.2020.103645) · [Paper (PDF)](papers/NonconcentricTriangles.pdf) · [LaTeX](papers/NonconcentricTriangles.tex)

### Hampton’s Newtonian six- and seven-body Morse polynomials

Hampton conjectured how many labelled equal-mass configurations have each Morse index, which measures the number of independent directions in which the shape potential decreases to second order. Earlier work supplied numerical indices and exhaustive catalogues of shapes. The manuscript certifies Hessian inertia and symmetry multiplicities for all nine six-body representatives and all fourteen seven-body representatives. In increasing index order the counts are **384, 840, 1,080, 960, 360** for six bodies and **840, 10,080, 15,840, 12,600, 10,080, 4,200** for seven. These are the Newtonian clause of Hampton’s Conjecture 4 and the seven-body clause of Conjecture 5. [Hampton, §§3.4–3.5](https://arxiv.org/abs/1810.13011) · [Paper (PDF)](papers/HamptonMorse.pdf) · [LaTeX](papers/HamptonMorse.tex)

### Five equal masses and a variable sixth mass

Tomar’s diagram 98 describes a possible escape to infinity in the complex equations, with the six bodies splitting into two triples. When three masses coincide, the leading force condition can vanish identically. The manuscript derives a further necessary condition by expanding the potential to cubic order. It excludes diagram 98 on the line $(1,1,1,1,1,t)$ for all positive $t$ outside a finite set of algebraic candidates, and individually at $t=3$. It also excludes that diagram on a nonempty Zariski open subset of $(1,1,1,a,b,c)$ containing $(a,b,c)=(2,3,7)$. Other diagrams remain to be controlled before one can conclude that the full generic fibre over $\mathbb{Q}(t)$ is finite. [Paper (PDF)](papers/FiveEqualSixBody.pdf) · [LaTeX](papers/FiveEqualSixBody.tex)

### Six local bifurcations along the mass line

The endpoint counts of 4,104 and 3,624 imply a transition but do not locate it. The two manuscripts isolate three folds (where two nearby shapes meet) and three pitchforks (where a reflected pair meets a symmetric branch) for $0<t<1$. The companion paper treats the pitchforks near $t=0.089353633682$ and $t=0.175165824530$. As the mass increases through either value, three nearby labelled, oriented shapes give way to one. Splitting the masses of a reflected pair realizes a cusp at each of these points. The six events account for the net change of 480 labelled shapes between the endpoints. Further events could cancel in that count. [Main paper](papers/FiveEqualSixBody.pdf) · [Pitchfork paper (PDF)](papers/Pitchfork.pdf) · [LaTeX](papers/Pitchfork.tex)

### Collinearity in the signed complex equations

The Newtonian orderings of bodies on a real line describe the physical collinear solutions. Algebraic elimination also encounters complex solutions, with a choice of square-root sign for each distance. The manuscript proves finiteness for the normalized, signed all-collinear equations whenever every nonempty subset of masses has nonzero sum. This includes every positive $t$ and the geometric generic parameter on the five-equal-mass line. Five unit bodies on a line with the sixth off it are impossible at every positive $t$. At the geometric generic parameter any placement of five bodies on one line and the sixth off it is excluded. After permuting the equal labels, the remaining generic configurations can be studied in one chart where three specified unit bodies form a triangle. [Paper (PDF)](papers/SignedCollinear.pdf) · [LaTeX](papers/SignedCollinear.tex)

The supplementary notes specialize 1,928 published certificate polynomials on this line and analyze leading configurations or necessary conditions for diagrams 8, 52, 63, 64, 66, 88, 93 and 94. [Singular diagrams](notes/README.md)

### Three candidate diagrams for generic positive mass ratio

The later census reduces 14 candidate diagram classes to 88, 93 and 94. Of the original 738 core-certified placements, 76 remain. Among the 114 placements of the separate 19 core-free cells, 111 remain. The two lists combine into 55 orbits under relabelling and exchange of the complex projections. Of these, 29 also satisfy a necessary condition for an infinite family of real configurations. The new paper derives the exclusions and distinguishes the finite Python replays and checked Lean lemmas from the analytic arguments. [Paper](papers/ReducedSixBodyList.pdf) · [LaTeX](papers/ReducedSixBodyList.tex) · [Case lists and reproduction](notes/reduction/README.md)

### Energy bounds for physical ends

The eighth paper uses energy and mass-derivative bounds to identify 22 symmetry classes relevant to an infinite real six-body family, three in diagram 88 and nineteen in diagram 94. Diagram 93 still has four candidates in the unrestricted signed-complex problem. The accompanying local results exclude a regular-square quartet in diagram 88 and the specified equilateral leading solution of diagram 94 at generic mass ratio. [PDF](papers/PhysicalSixBodyEnds.pdf) · [LaTeX](papers/PhysicalSixBodyEnds.tex) · [Case lists](notes/physical-ends/README.md)

### Generic finiteness on the five-equal-mass line

For five unit masses and a sixth mass *t* > 0, the ninth manuscript establishes that the real planar central configurations up to similarity form a finite set for every *t* outside a finite algebraic set. Previous generic finiteness in the full six-dimensional mass space excluded every mass vector with three equal entries from its scope. A reduction using the real potential and its marked-mass derivative left 22 possible types of complex ends in diagrams 88 and 94. Projected-shape classification, a lift through the coupled six-body equations and an expansion at infinite mass exclude all three possible mass positions of diagram 94.

In diagram 88 the four-body forces and the torque exerted by the binary must vanish in compatible projections. For a quartet containing the variable mass, a valuation at mass 2 in residue characteristic 65521 covers finite and collapsing shapes. The three regular charts have 420, 4 and 102 points over the algebraic closure. Every ordering and both orientations fail the signed torque. A second proof uses the degree-4046 distance-ratio resultant and accounts for escaping branches. All 74 placements in the 22 real-finiteness classes are excluded. Seven signed-complex placements remain in five classes, one in diagram 88 and four in diagram 93. Their existence remains open. The proof does not determine the exceptional *t* or give a count for each nonexceptional *t*. This research manuscript has not undergone peer review; Lean covers selected lemmas, and the full proof also uses analytic deductions and separate exact computations. [Case ledger and verification](notes/last-diagrams/README.md) · [English paper (PDF)](papers/LastDiagrams.pdf) · [LaTeX source](papers/LastDiagrams.tex)

### Signed four-body absolute equilibria

With three unit masses and one mass *t*, the signed four-body system can have zero net force at each of the four distinct positions. Exactly two positive ratios admit a noncollinear equilibrium and four admit a collinear equilibrium. Every listed ratio has a realization at real positions with mixed signs on the inverse distances. This signed system occurs in the rescaled limit of a simultaneous four-body collapse. Ordinary positive-distance Newtonian gravity on positive masses has positive potential and cannot have zero net force at every body. [Paper (PDF)](papers/SignedQuartetEquilibria.pdf) · [LaTeX source](papers/SignedQuartetEquilibria.tex)

### Verification and reuse

The verification package includes Lean sources, exact-arithmetic verifiers, their inputs, archived outputs and the research notes. The guide distinguishes the statements checked in the Lean kernel, executable certificate replays, analytic arguments and results taken from the literature. The original papers and documentation are licensed under CC BY 4.0, and original proof and verification code under MIT. Credit the papers to **Chatgpt**. Moczurad and Zgliczyński’s catalogue supplies the numerical starting coordinates and catalogue completeness. Third-party materials and dependencies retain their own terms. [Verification guide](Lean/README.md) · [Initial research log (Chinese)](ResearchLog_zh.md) · [Mass-parameter research log (Chinese)](SixBodyProgress_zh.md) · [License and attribution](../../LICENSE)

## 中文

在中心构型中，每个天体的引力加速度都指向质心，加速度的大小与该天体到质心的距离成正比，比例常数对所有天体相同。这样的形状可以刚性旋转。Smale 第六问题问，给定各天体的正质量，扣除平移、旋转和整体缩放后，平面中心构型是否只有有限多个。这里收录 Chatgpt 的十篇研究稿，讨论质量扰动、特殊几何构型、Morse 指标，以及五重等质量线上的有限性。

### 五个近等质量天体与一个轻天体

Moczurad 与 Zgliczyński 已严格枚举五体、六体全等质量构型。Tomar 的六体一般质量定理留下了一个例外集合，其中包括任意三个质量相等的情形，因此不能直接判定五个质量固定为 1、第六个质量为 *t* 的任何一点。令 *t* 趋于零可得到试验粒子问题，困难在于找全极限平衡点，并证明恢复正质量后每个真实构型都由这些平衡点给出。[全等质量枚举](https://doi.org/10.1007/s10569-019-9920-6) · [Tomar 定理 1.1](https://hexagonmath.org/pdf/2611.00377v1)

研究稿得到，五个质量可在 1 附近各自独立变化，第六个质量为充分小的正数时，保留天体标签并区分镜像，共有 **4,104** 个形状；再合并镜像则有 **2,232** 个。五种极限主构型分别有 8、12、10、14、16 个试验粒子平衡点。论文通过区间证书找全这些点，再用延拓与紧性转到正质量。沿五重等质量射线走到六个质量全等时，计数变为 3,624，因此中间至少有一个实代数质量比出现退化的非共线构型。小质量适用范围的数值阈值、整条射线的有限性仍待确定。[英文论文 PDF](papers/SmallMass.pdf) · [LaTeX 源稿](papers/SmallMass.tex)

### 两个非同心正三角形

Xie、Bhusal 与 Tahir 曾数值找到两个正三角形共用一条反射轴而几何中心不同的六体构型。研究稿证明，在指定的形状带内，归一化的内三角形顶点高度从 0.87 变化到 0.88 时，每个高度恰有一个解，且随高度实解析变化。外三角形顶点的质量比沿分支严格递增，因此这条连续分支上的质量也随形状改变。[前人的数值结果](https://doi.org/10.1016/j.geomphys.2020.103645) · [英文论文 PDF](papers/NonconcentricTriangles.pdf) · [LaTeX 源稿](papers/NonconcentricTriangles.tex)

### Hampton 猜想中牛顿引力下的等质量六体和七体分项

Hampton 猜想了各 Morse 指标的有标签构型数。指标给出形状势在二阶近似下有多少个独立的下降方向。前人已有数值指标及完整的构型目录，本稿逐个认证九种六体和十四种七体代表的 Hessian 惯性及其对称性决定的标号重数。按指标递增，六体各有 **384、840、1,080、960、360** 个，七体各有 **840、10,080、15,840、12,600、10,080、4,200** 个。这给出猜想 4 的牛顿指数分项与猜想 5 的七体分项。[Hampton 原文第 3.4–3.5 节](https://arxiv.org/abs/1810.13011) · [英文论文 PDF](papers/HamptonMorse.pdf) · [LaTeX 源稿](papers/HamptonMorse.tex)

### 五个单位质量与一个可变的第六质量

Tomar 的图 98 描述六体复方程在无穷远的一种可能退化方式，其中六个天体分成两个三元组。三个质量相等时，首阶力矩条件可能恒等成立。论文将势展开到三阶，得到一个额外的必要条件。对于质量线 $(1,1,1,1,1,t)$，除了有限多个实代数候选值，所有正 $t$ 都能排除图 98，$t=3$ 也得到单独验证。对于 $(1,1,1,a,b,c)$，在包含 $(a,b,c)=(2,3,7)$ 的一个非空 Zariski 开集上也可排除该图。要证明有理函数域 $\mathbb{Q}(t)$ 上整个几何一般纤维有限，还需处理其他退化图。[英文论文 PDF](papers/FiveEqualSixBody.pdf) · [LaTeX 源稿](papers/FiveEqualSixBody.tex)

### 质量线上的六处局部分岔

由两端的 4,104 和 3,624 个构型可以推知中途会发生分岔，具体质量比还需定位。两篇论文在 $0<t<1$ 内定位了三处折叠分岔（两支相遇）和三处叉形分岔（一对镜像构型与对称分支相遇）。其中，配套论文处理 $t$ 约为 0.089353633682 和 0.175165824530 的两处叉形分岔。分别越过这两个临界质量比时，该形状附近的有标签且区分镜像的解都由三个变为一个。让一对原本互为镜像的天体取不同质量，在两处都能得到尖点展开。六处事件对应的标签重数恰好解释两端相差的 480 个构型，仍可能有净贡献互相抵消的其他事件。[主论文](papers/FiveEqualSixBody.pdf) · [叉形分岔论文 PDF](papers/Pitchfork.pdf) · [LaTeX 源稿](papers/Pitchfork.tex)

### 有符号复方程中的共线构型

经典实共线理论按天体在直线上的顺序描述物理解。做代数消元时，还要考虑复坐标和各距离平方根的符号选择。论文证明，只要每个非空质量子集的质量和均非零，归一化的有符号全共线方程就只有有限个解。这覆盖五重等质量线上每个正 $t$ 以及几何一般参数。五个单位质量共线且第六体在直线外，对每个正 $t$ 均不可能。对几何一般参数，任选五体共线而余下一体在轴外均不可能。于是，对余下的一般参数构型，重新排列等质量标签后，只需研究三个指定单位质量不共线的一个坐标图。[英文论文 PDF](papers/SignedCollinear.pdf) · [LaTeX 源稿](papers/SignedCollinear.tex)

补充研究笔记记录了同一质量线上 1,928 个原始证书多项式的筛查和图 8、52、63、64、66、88、93、94 的分析，给出可以直接排除的情形、通过首阶检验的显式构型和仍需检验的边界。[退化图研究笔记](notes/README.md#中文)

### 一般正质量比下的三种候选退化图

通过节点力平衡、恒定势能与局部力矩检验，原先的 14 个图类缩至图 88、93、94。旧表中的 738 个带证书组合剩下 76 个，另列的 19 个无证书单元在展开标记位置之后由 114 个组合缩至 111 个。两部分合计 55 个对称代表，针对无限实构型族所需的曲线，还有 29 个代表满足原点相容性。剩余情形的实际存在性及该质量族的完整有限性仍有待证明。[论文 PDF](papers/ReducedSixBodyList.pdf) · [LaTeX](papers/ReducedSixBodyList.tex) · [清单和复验](notes/reduction/README.md#中文)

### 实中心构型的能量约束

对于一般正质量比，能量及其质量导数把实六体有限性所需的候选由 29 类缩至 22 类，图 88 有 3 类，图 94 有 19 类。若考虑任意有符号复曲线，图 93 仍有 4 类候选。局部计算还排除了图 88 的等质量正方形首项以及图 94 的一个等边首项。[论文 PDF](papers/PhysicalSixBodyEnds.pdf) · [LaTeX](papers/PhysicalSixBodyEnds.tex) · [逐项清单](notes/physical-ends/README.md#中文)

### 五重等质量线上一般质量比的实中心构型有限性

固定五个单位质量和一个正质量 *t*，第九篇研究稿得到，除有限多个代数质量比外，平移、旋转和整体缩放意义下的实平面牛顿中心构型只有有限多个。前人针对六个一般质量的有限性定理留下的例外集合，包含每一个具有三个相等质量的向量。沿这条线，此前利用实构型势能及其质量导数，把反证需要考察的复退化压缩到图 88、94 的 22 类。图 94 的三种变质量位置分别用投影分类、完整六体方程的局部延拓，以及质量比趋于无穷的展开排除。

图 88 的四体组若含有变质量，除了满足孤立四体的引力方程，还须满足双体组施加的首阶力矩条件。一条证明把质量特化到 2，在特征 65521 的有限域中处理所有有界与塌缩极限。三个常规坐标图在代数闭包中分别有 420、4、102 个点，所有可能的标记顺序与投影方向均未通过力矩检验。另一条证明研究距离比函数域中的 4046 次结式，并计入各项边界重数。实构型有限性所需的 74 个带标号候选、22 个对称类全部排除。任意有符号复曲线仍有 7 种放置、5 个对称类，其中图 88 有 1 类，图 93 有 4 类。它们的存在性尚未确定。第九篇研究稿没有确定例外质量值，也没有给出一般参数下的具体构型数。研究稿未经同行评审，Lean 检查其中若干引理，完整论证还依赖书面推导和独立的精确计算。[最新清单与复验](notes/last-diagrams/README.md) · [英文论文 PDF](papers/LastDiagrams.pdf) · [LaTeX 源稿](papers/LastDiagrams.tex)

### 四体有符号绝对平衡的质量比

对三个单位质量和一个质量 *t*，第十篇论文分类了四个不同位置同时合力为零时可能出现的正质量比。允许带符号的逆距离时，非共线平衡恰有两个正质量比，共线平衡恰有四个。所有质量比都能以实坐标及混合符号实现。这组方程来自六体退化时四体同时塌缩后的重标度极限。通常的正质量牛顿引力采用正逆距离，其正势能阻止所有天体同时合力为零。[英文论文 PDF](papers/SignedQuartetEquilibria.pdf) · [LaTeX 源稿](papers/SignedQuartetEquilibria.tex)

### 复验与许可

复验包提供 Lean 源码、精确算术程序、输入、运行记录及研究笔记。说明中列出 Lean 内核核查的命题、由独立程序重放的证书、论文中的解析论证，以及依赖的前人定理。原创论文、LaTeX 和文档采用 CC BY 4.0，原创证明与复验代码采用 MIT，论文请按原稿署名 **Chatgpt** 引用。坐标初值及目录完备性来自 Moczurad 与 Zgliczyński，第三方材料和依赖保留各自许可。[复验说明](Lean/README.md) · [前期研究日志](ResearchLog_zh.md) · [质量参数研究日志](SixBodyProgress_zh.md) · [许可与引用](../../LICENSE)
