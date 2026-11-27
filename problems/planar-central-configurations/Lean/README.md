# Verification · 复验

[English](#english) · [中文](#中文) · [Manuscripts / 论文](../README.md)

## English

For the generic finiteness theorem, begin with the standalone manuscript. It connects the real Newtonian equations to the singular-end calculations. The modules described below verify particular algebraic identities and implications. The enumerations and polynomial computations have separate exact replays, and the passage from these checks to the global theorem is a mathematical argument in the paper. [Standalone paper (PDF)](../papers/FiveEqualFiniteness.pdf) · [LaTeX](../papers/FiveEqualFiniteness.tex) · [Exact verification archive](../papers/FiveEqualFiniteness-checks.zip) · [Case ledger and replays](../notes/last-diagrams/README.md) · [Guide to the other papers](../papers/README.md)

### Small mass, triangles and Morse indices

Download and extract [SixBodyVerification.zip](SixBodyVerification.zip). Its `SixBodyResearch` directory contains all original certificate inputs, Lean modules, verification scripts, research notes and run transcripts. The [PDFs and LaTeX sources](../papers/) are distributed separately. Use Lean 4.28.0. The main and triangle projects pin mathlib to `8f9d9cff6bd728b17a24e163c9402775d9e6a365`.

- **Small-mass count.** From the extracted `SixBodyResearch/lean` directory run `lake exe cache get`, then `lake build`. The main project checks the branch-gluing and counting deductions under their stated analytic hypotheses. The standalone [RestrictedReplay.lean](RestrictedReplay.lean) verifies the integer local-root conditions for 60 boxes in the kernel. Run `lean --run RestrictedReplay.lean` for the coverage traversal. The independent C++17/GMP verifier and its instructions are in `certificates/restricted/`. The paper gives the compactness and continuation arguments tying those checks to the count of physical shapes.
- **Nonconcentric triangles.** From `SixBodyResearch/certificates/triangles`, run `lake update`, `lake exe cache get`, then `lake build`. The theorem `SixTriangles.physical_six_body_standard` in `Standard.lean` verifies existence, all six force equations and the physical conditions on the narrow interval around 0.875 specified in the paper. For the full interval from 0.87 to 0.88 run `python3 continuation.py 4000` in the same directory and use the analytic argument in the paper.
- **Morse indices.** Run `lean -j4 --run Hampton.lean` on the standalone [Hampton.lean](Hampton.lean). The closed theorems `HamptonReplay.hampton6` and `HamptonReplay.hampton7` certify the interval pivot tests and weighted sums. The root, symmetry and index verification instructions are in `certificates/hampton/README.md`. The interpretation uses the published global catalogue and the reduction to the shape Hessian in the manuscript.

### Five-equal-mass parameter study

Extract [SixBodyParameterResearch.zip](SixBodyParameterResearch.zip). From the extracted `SixBodyParameterResearch` directory run `python3 verify/replay.py` with Python 3.10+ and SymPy. From its `Lean` directory run `lake exe cache get`, then `lake build` with Lean and mathlib v4.28.0. The archive includes all ten Lean modules, certificate inputs, run logs and a SHA-256 manifest.

- **Diagram 98.** The Lean modules check the projected shape identities and root enclosures at $t=3$, the leading signed inequalities, and both cubic-order tests on all 840 remaining cases. The last of these checks is in [DiagramCubic.lean](DiagramCubic.lean). The manuscript supplies the analytic expansion and the passage to general parameters by resultants. The three-parameter witness uses the Python verifiers.
- **Bifurcations.** The integer interval verifiers enclose the Newtonian derivatives. Lean derives the pitchfork counts and a local three-root bound under the stated hypotheses on the reduced scalar equation. The reduction from the planar equations is given in the papers.
- **Collinearity.** [CollinearValuation.lean](CollinearValuation.lean) proves the signed all-collinear finite-set theorem, including the specializations `generic_six_body_line_finite` and `positive_six_body_line_finite`. For five bodies on a line and a sixth off it, the archive verifies the polynomial gcd and finite-field calculations. The paper relates them to the force equations. [Parameter research log (Chinese)](../SixBodyProgress_zh.md)

The papers and original documentation are licensed under CC BY 4.0, the original verification code under MIT. The archive includes the license texts. [Repository licensing](../../../LICENSE) · [Original catalogue](https://doi.org/10.1007/s10569-019-9920-6)

### Further singular diagrams

[TriangleMass.lean](TriangleMass.lean) proves the mass-parameter deduction for both triangle tests used in [diagram 8](../notes/Diagram8.md). Check it with `lake env lean /path/to/TriangleMass.lean` in the same environment.

Use the extracted mass-parameter project’s pinned Lean 4.28.0 and mathlib. From its `Lean` directory, run `lake env lean /path/to/Diagram88Square.lean` and `lake env lean /path/to/Diagram93Algebra.lean`, substituting the paths to these standalone sources. [Diagram 88](Diagram88Square.lean) classifies all positive mass-ratio parameters for the square torque equation in real coordinates. [Diagram 93](Diagram93Algebra.lean) proves the distance-ratio bound, force-residual identity, and root-of-unity facts used in the hand derivation. [Research notes](../notes/README.md)

### Reduction to three candidate diagrams

Four standalone files use the same Lean 4.28.0 and mathlib as the mass-parameter project. Run `lake env lean /path/to/FILE.lean` on each. [NodeTriangle](NodeTriangle.lean) checks the fixed-shape identity. [ClusterTriangle](ClusterTriangle.lean) checks the complex-root mass bound. [RectanglePhase](RectanglePhase.lean) proves the phase contradiction and central-binary arithmetic. [Diagram93Slice](Diagram93Slice.lean) checks the scalar determinant restrictions. The cell enumeration, finite-field calculation and Puiseux expansions are documented separately. [Full scope and replay](../notes/reduction/README.md)

### Physical energy and mass derivative

Run each standalone file with the same Lean 4.28.0/mathlib environment, using `lake env lean /path/to/File.lean`. The six files verify the following statements. [EnergyBounds](EnergyBounds.lean) (finite weighted energy bound, triple energy identity and regular-vertex derivative inequalities) · [Physical93Bounds](Physical93Bounds.lean) (central-vertex energy gap) · [MarkedBinaryEnvelope](MarkedBinaryEnvelope.lean) (marked-binary inequalities) · [Negative93Algebra](Negative93Algebra.lean) (Jacobian and Schur complement) · [FourTermCancellation](FourTermCancellation.lean) (four-radical elimination) · [EquilateralCubic94](EquilateralCubic94.lean) (discriminant of the binary cubic). The analytic reductions and the catalogue are documented in the [paper and replay](../notes/physical-ends/README.md).

### Generic finiteness on the five-equal-mass line

Use the same pinned Lean 4.28.0 and mathlib environment. Each file runs independently with `lake env lean /path/to/File.lean`.

- [CenterForces94.lean](CenterForces94.lean) eliminates the shared body's small coordinate from an outer force equation and recovers the marked mass when two normalized center-edge cubes differ.
- [QuartetTorque88.lean](QuartetTorque88.lean) derives the quartic obstruction from four torque summands, eliminates a common mass from two affine equations, and verifies the two signed-length identities for a reflected quartet.
- [ZeroProjection88.lean](ZeroProjection88.lean) eliminates a common coefficient from two edge equations, gives the identity used to remove the two distance signs, and shows when equality of two center-edge cubes forces equality of the third. Two further theorems link the specialization to the finite-fibre check. The cleared torque polynomial forces all four specialized abscissas to be nonzero when they are pairwise distinct and the signed mass squares remain nonzero. For any evaluation from a rational factor algebra to a field that kills the three force equations, the certified membership of the product of the 13 chart factors in their ideal forces at least one factor to vanish. The supplied rational rank computation establishes this membership separately on the 49 factor pairs.
- [QuartetDistanceChart.lean](QuartetDistanceChart.lean) derives a squared pair distance from affine dependence of the quartet and checks the quadratic determining its projection. It also checks the parity obstruction for a rational square at a simple pole. The AbsoluteInversion88 section verifies inversion of signed quartet distances and force cancellation in the explicit zero-multiplier constructions.
- [OpposingPairWindow.lean](OpposingPairWindow.lean) checks a triangle distance-ratio identity, the exact squared-displacement sum for a trial configuration, and the upper bound for the marked derivative under the stated energy estimates.
- [QuartetEnergy88.lean](QuartetEnergy88.lean) proves the real cube-root comparison used for the strict quartet energy gap, under the displayed polynomial inequality, and the elementary sum identities for the endpoint trial. The angular averaging and the polynomial signs are established in the accompanying proof and replay.
- [ZeroStressGram88.lean](ZeroStressGram88.lean) checks every one of the 243 normalized squared-distance triples of outer edges and two remaining star distances. It proves that the required Gram determinant cannot vanish over any extension of the test field, whereas planar positions force it to vanish.

The finite shape classifications, polynomial gcds, lifting computations, and final exclusion of all physical classes have separate executable or analytic proofs. [Paper (PDF)](../papers/LastDiagrams.pdf) · [Case ledger and verification](../notes/last-diagrams/README.md)

### Signed quartets and the Coulomb specialization

[CoulombFour.lean](CoulombFour.lean) deduces the allowed mass polynomial from the scalar equations for a noncollinear real Coulomb equilibrium. For an ordered collinear quartet it proves that a positive determinant factor contradicts simultaneous field cancellation under the stated inverse-distance inequalities. The companion paper treats the larger signed system and the realization of its exceptional ratios. [Companion paper (PDF)](../papers/SignedQuartetEquilibria.pdf)

## 中文

复验五重等质量线上的一般有限性时，可先读独立论文，了解实牛顿方程怎样导向逐个退化端的计算。本页的 Lean 模块检查指定的代数恒等式与推论。候选枚举及多项式运算有各自的精确复验程序，从这些局部检查到全局定理的推导见论文正文。[独立论文 PDF](../papers/FiveEqualFiniteness.pdf) · [LaTeX 源稿](../papers/FiveEqualFiniteness.tex) · [精确计算复验包](../papers/FiveEqualFiniteness-checks.zip) · [逐项清单与复验](../notes/last-diagrams/README.md#中文) · [其他论文导读](../papers/README.md#中文)

### 小质量、正三角形与 Morse 指标

下载并解压[前期复验包](SixBodyVerification.zip)。其中 `SixBodyResearch` 保留原始目录结构，包括 Lean 工程、区间算术证书、输入、运行记录和研究笔记。[三篇论文的 PDF 和 LaTeX](../papers/) 单独提供。使用 Lean 4.28.0，主工程和三角形工程均固定了 mathlib 的版本。

- **小质量计数。** 在解压后的 `SixBodyResearch/lean` 运行 `lake exe cache get` 和 `lake build`。主工程核查有明确解析假设的局部分支拼接及计数推导。[RestrictedReplay.lean](RestrictedReplay.lean) 中的内核定理核查了 60 个候选根盒的局部整数检验。`lean --run RestrictedReplay.lean` 重放全域覆盖，独立 C++17/GMP 版本见 `certificates/restricted/`。与实际构型数相联系的紧性、延拓等论证见论文。
- **非同心正三角形。** 在 `SixBodyResearch/certificates/triangles` 运行 `lake update`、`lake exe cache get`、`lake build`。在 0.875 附近论文指定的窄区间上，`SixTriangles.physical_six_body_standard` 直接核查构型存在、全部六个天体所受引力及几何与质量条件。对 0.87 至 0.88 的完整区间，在同一目录运行 `python3 continuation.py 4000`，并结合论文的解析论证。
- **Morse 指标。** 对 [Hampton.lean](Hampton.lean) 运行 `lean -j4 --run Hampton.lean`。六体和七体两个内核定理核查区间主元检验及加权和。根、对称性及指标的复验步骤见 `certificates/hampton/README.md`。从整数证书到完整 Morse 计数，还用到已发表构型目录的完备性及论文对形状 Hessian 的推导。

### 五重等质量的参数研究

解压[质量参数研究复验包](SixBodyParameterResearch.zip)。在解压后的 `SixBodyParameterResearch` 目录使用 Python 3.10 或更新版本及 SymPy 运行 `python3 verify/replay.py`。在其 `Lean` 子目录中用 Lean 和 mathlib v4.28.0 依次运行 `lake exe cache get`、`lake build`。包内收录十个 Lean 模块、证书输入、运行日志及 SHA-256 校验清单。

- **图 98。** Lean 核查投影形状恒等式、$t=3$ 处根的包围、首阶带符号不等式，以及 840 个剩余情形的两项三阶检验。三阶检验见 [DiagramCubic.lean](DiagramCubic.lean)。解析展开、局部消元和用结式推广到一般参数的论证见论文。三参数见证点由 Python 程序作精确检验。
- **分岔。** 整数区间程序核查牛顿方程导数的界。Lean 从约化标量方程的假设推出叉形分岔的局部解数与三根上界。从平面方程到标量方程的约化见论文。
- **共线。** [CollinearValuation.lean](CollinearValuation.lean) 证明有符号全共线方程解集有限，含函数域一般参数和每个正实质量比的两个特化定理。对五体共线、一体离轴的情形，复验包检验多项式互素与有限域算术，从这些计算回到引力方程的论证见论文。[质量参数研究日志](../SixBodyProgress_zh.md)

原创论文、LaTeX 源稿与文档使用 CC BY 4.0，原创复验代码使用 MIT。压缩包附两项许可全文。[仓库许可](../../../LICENSE) · [前人构型目录](https://doi.org/10.1007/s10569-019-9920-6)

### 其他退化图

[TriangleMass.lean](TriangleMass.lean) 核查[图 8](../notes/Diagram8.md) 用到的两种三体质量条件都要求 $t=1/4$。在同一环境运行 `lake env lean /path/to/TriangleMass.lean`。

使用上述质量参数工程固定的 Lean 4.28.0 和 mathlib。在解压后工程的 `Lean` 目录运行 `lake env lean /path/to/Diagram88Square.lean` 和 `lake env lean /path/to/Diagram93Algebra.lean`，将路径替换为下载的文件位置。[图 88](Diagram88Square.lean) 完整分类正方形首阶力矩方程的正参数。[图 93](Diagram93Algebra.lean) 核查距离比的模下界、剩余力恒等式及两个单位根性质。图 93 从六体方程到局部极限的论证见[研究笔记](../notes/README.md#中文)。

### 三种候选退化图的清单

用同一 Lean 4.28.0 与 mathlib 环境对下列四个文件分别运行 `lake env lean /path/to/FILE.lean`。[NodeTriangle](NodeTriangle.lean) 核查投影形状恒等式，[ClusterTriangle](ClusterTriangle.lean) 核查三体簇的质量约束，[RectanglePhase](RectanglePhase.lean) 核查复相位矛盾及中心双体的质量算术，[Diagram93Slice](Diagram93Slice.lean) 核查图 93 的行列式条件。单元枚举、有限域计算与从六体方程导出的渐近展开各有独立的复验或书面推导。[方法与范围](../notes/reduction/README.md#中文)

### 实构型的势能与质量导数

本轮六个文件按上面的 Lean 4.28.0 方法分别运行。EnergyBounds、Physical93Bounds 和 MarkedBinaryEnvelope 核查有限求和的能量下界、三体能量恒等式和质量导数所用的不等式，Negative93Algebra 核查雅可比行列式和 Schur 补，FourTermCancellation 核查四个根式的消去，EquilateralCubic94 核查二元三次式判别式的必要条件。从六体方程到这些检验的推导见[英文论文与复验说明](../notes/physical-ends/README.md#中文)。

### 五重等质量线上一般参数的有限性

在同一 Lean 4.28.0 和 mathlib 环境中，对每个独立文件运行 `lake env lean /path/to/File.lean`。

- [CenterForces94.lean](CenterForces94.lean) 从一个外体的引力方程中消去共享体的小投影坐标，并在两条中心边的归一化逆距离立方不等时解出标记质量。
- [QuartetTorque88.lean](QuartetTorque88.lean) 从四项力矩和推出四次必要条件，在两个关于质量的一次方程间消元，并核查反射对称四体组的两条有符号边长恒等式。
- [ZeroProjection88.lean](ZeroProjection88.lean) 消去两个边方程共有的系数，给出消去两个距离符号的恒等式，并证明在所列中心方程下，只要两条中心边的逆距离立方相等，第三条也与它们相等。特化后，只要四个横坐标仍两两不同、有符号质量平方均非零，清除分母后的力矩多项式就保证四个横坐标均非零。另一条定理证明，若 13 个坐标因子的乘积属于三个受力方程生成的理想，则在任何使三个方程为零的域值点，至少一个因子必须为零。49 对因子各自所需的理想成员关系由有理矩阵秩证书检验。
- [QuartetDistanceChart.lean](QuartetDistanceChart.lean) 从四个位置的仿射相关关系推出成对距离的平方，并核查确定投影的二次方程，以及用有理函数平方的零极点阶数奇偶性得到的限制。其中 AbsoluteInversion88 部分核查有符号四体距离反演及零力乘子显式构造中的合力抵消。
- [OpposingPairWindow.lean](OpposingPairWindow.lean) 核查三体距离比恒等式、一个试验构型的位移平方和，以及从给定能量估计推出的标记质量导数上界。
- [QuartetEnergy88.lean](QuartetEnergy88.lean) 证明了四体能量严格间隙用到的立方根比较引理，以及端点试验构型的求和恒等式。比较引理以一个明确的多项式不等式为前提，角度平均和多项式符号分别由书面推导和计算复验给出。
- [ZeroStressGram88.lean](ZeroStressGram88.lean) 检查归一化后一条边以外的五个平方距离的全部 243 种组合，证明在特征 65521 测试域的任何扩域上，它们给出的 Gram 行列式都非零；而四个位置若能在平面实现，该行列式必为零。

形状分类、多项式最大公因式、延拓计算及全部实问题对称类的排除，分别由计算程序和论文中的推导支撑。[英文论文 PDF](../papers/LastDiagrams.pdf) · [清单与复验说明](../notes/last-diagrams/README.md)

### 四体有符号绝对平衡及库仑特例

[CoulombFour.lean](CoulombFour.lean) 从非共线实库仑平衡的标量方程推出质量比必须满足的多项式条件。共线时，从按位置排序得到的逆距离不等式推出一个行列式因子严格为正，因而相应的电场不能在各点同时抵消。更一般的逐边带符号系统及其例外质量比的构造见[配套论文](../papers/SignedQuartetEquilibria.pdf)。
