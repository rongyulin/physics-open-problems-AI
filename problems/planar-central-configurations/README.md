# Planar Newtonian central configurations · 平面牛顿中心构型

[English](#english) · [中文](#中文) · [Verification / 复验](Lean/README.md)

## English

In a central configuration, the gravitational acceleration of each body points toward the center of mass and is proportional to its distance from that center, with the same constant of proportionality for all bodies. Such a shape can rotate rigidly. Smale’s sixth problem asks whether fixed positive masses permit only finitely many planar shapes after removing translations, rotations and changes of scale. The following three manuscripts by Chatgpt study a mass regime, a geometric family and the distribution of Morse indices.

### Five nearly equal masses and a light sixth body

Moczurad and Zgliczyński rigorously enumerated the five- and six-body equal-mass configurations. Tomar’s generic six-body finiteness theorem has an exceptional set containing every mass vector with three equal entries. In particular, its criterion gives no information anywhere on the line with five unit masses and a sixth mass of size *t*. Near *t* = 0, one can first study a massless test body, but counting the actual positive-mass shapes requires proving that all limiting equilibria are isolated and that every small-mass solution is accounted for. [Equal-mass enumeration](https://doi.org/10.1007/s10569-019-9920-6) · [Tomar, Theorem 1.1](https://hexagonmath.org/pdf/2611.00377v1)

The manuscript obtains **4,104 labelled shapes** for five masses that can vary independently near one and a sufficiently small positive sixth mass. Reflections are counted separately whenever they give different labelled shapes. Identifying reflections gives 2,232. Exact interval certificates isolate 8, 12, 10, 14 and 16 test-body equilibria at the five limiting shapes. Continuation and compactness transfer the count to positive mass. On the five-equal-mass line the count changes between this regime and six equal masses, where it is 3,624. At least one intermediate algebraic mass ratio admits a degenerate noncollinear configuration. The manuscript gives no numerical mass cutoff, and finiteness along the entire line remains open. [Paper (PDF)](papers/SmallMass.pdf) · [LaTeX](papers/SmallMass.tex)

### Two nonconcentric equilateral triangles

Xie, Bhusal and Tahir exhibited numerical configurations of two equilateral triangles sharing a reflection axis and having different centroids. The manuscript gives an exact existence and local uniqueness proof throughout an explicit corridor. For each normalized inner-apex height from 0.87 to 0.88, the corridor contains exactly one solution. An outer-apex mass ratio increases strictly along the analytic family. Different heights therefore yield different masses, so these configurations do not supply a continuous family at fixed masses. [Earlier numerical examples](https://doi.org/10.1016/j.geomphys.2020.103645) · [Paper (PDF)](papers/NonconcentricTriangles.pdf) · [LaTeX](papers/NonconcentricTriangles.tex)

### Hampton’s Newtonian six- and seven-body Morse polynomials

Hampton conjectured how many labelled equal-mass configurations have each Morse index, which measures the number of independent directions in which the shape potential decreases to second order. Earlier work supplied numerical indices and exhaustive catalogues of shapes. The manuscript certifies Hessian inertia and symmetry multiplicities for all nine six-body representatives and all fourteen seven-body representatives. In increasing index order the counts are **384, 840, 1,080, 960, 360** for six bodies and **840, 10,080, 15,840, 12,600, 10,080, 4,200** for seven. These are the Newtonian clause of Hampton’s Conjecture 4 and the seven-body clause of Conjecture 5. [Hampton, §§3.4–3.5](https://arxiv.org/abs/1810.13011) · [Paper (PDF)](papers/HamptonMorse.pdf) · [LaTeX](papers/HamptonMorse.tex)

### Verification and reuse

The verification package includes Lean sources, exact-arithmetic verifiers, their inputs, archived outputs and the research notes. The guide distinguishes the statements checked in the Lean kernel, executable certificate replays, analytic arguments and results taken from the literature. The original papers and documentation are licensed under CC BY 4.0, and original proof and verification code under MIT. Credit the papers to **Chatgpt**. Moczurad and Zgliczyński’s catalogue supplies the numerical starting coordinates and catalogue completeness. Third-party materials and dependencies retain their own terms. [Verification guide](Lean/README.md) · [Chinese research log](ResearchLog_zh.md) · [License and attribution](../../LICENSE)

## 中文

在中心构型中，每个天体的引力加速度都指向质心，加速度的大小与该天体到质心的距离成正比，比例常数对所有天体相同。这样的形状可以刚性旋转。Smale 第六问题问，给定各天体的正质量，扣除平移、旋转和整体缩放后，平面中心构型是否只有有限多个。这里收录 Chatgpt 的三篇研究稿，分别讨论质量扰动、特殊几何构型和 Morse 指标。

### 五个近等质量天体与一个轻天体

Moczurad 与 Zgliczyński 已严格枚举五体、六体全等质量构型。Tomar 的六体一般质量定理留下了一个例外集合，其中包括任意三个质量相等的情形，因此不能直接判定五个质量固定为 1、第六个质量为 *t* 的任何一点。令 *t* 趋于零可得到试验粒子问题，困难在于找全极限平衡点，并证明恢复正质量后每个真实构型都由这些平衡点给出。[全等质量枚举](https://doi.org/10.1007/s10569-019-9920-6) · [Tomar 定理 1.1](https://hexagonmath.org/pdf/2611.00377v1)

研究稿得到，五个质量可在 1 附近各自独立变化，第六个质量为充分小的正数时，保留天体标签并区分镜像，共有 **4,104** 个形状；再合并镜像则有 **2,232** 个。五种极限主构型分别有 8、12、10、14、16 个试验粒子平衡点。论文通过区间证书找全这些点，再用延拓与紧性转到正质量。沿五重等质量射线走到六个质量全等时，计数变为 3,624，因此中间至少有一个实代数质量比出现退化的非共线构型。小质量适用范围的数值阈值、整条射线的有限性仍待确定。[英文论文 PDF](papers/SmallMass.pdf) · [LaTeX 源稿](papers/SmallMass.tex)

### 两个非同心正三角形

Xie、Bhusal 与 Tahir 曾数值找到两个正三角形共用一条反射轴而几何中心不同的六体构型。研究稿证明，在指定的形状带内，归一化的内三角形顶点高度从 0.87 变化到 0.88 时，每个高度恰有一个解，且随高度实解析变化。外三角形顶点的质量比沿分支严格递增，因此这条连续分支上的质量也随形状改变。[前人的数值结果](https://doi.org/10.1016/j.geomphys.2020.103645) · [英文论文 PDF](papers/NonconcentricTriangles.pdf) · [LaTeX 源稿](papers/NonconcentricTriangles.tex)

### Hampton 猜想中牛顿引力下的等质量六体和七体分项

Hampton 猜想了各 Morse 指标的有标签构型数。指标给出形状势在二阶近似下有多少个独立的下降方向。前人已有数值指标及完整的构型目录，本稿逐个认证九种六体和十四种七体代表的 Hessian 惯性及其对称性决定的标号重数。按指标递增，六体各有 **384、840、1,080、960、360** 个，七体各有 **840、10,080、15,840、12,600、10,080、4,200** 个。这给出猜想 4 的牛顿指数分项与猜想 5 的七体分项。[Hampton 原文第 3.4–3.5 节](https://arxiv.org/abs/1810.13011) · [英文论文 PDF](papers/HamptonMorse.pdf) · [LaTeX 源稿](papers/HamptonMorse.tex)

### 复验与许可

复验包提供 Lean 源码、精确算术程序、输入、运行记录及研究笔记。说明中列出 Lean 内核核查的命题、由独立程序重放的证书、论文中的解析论证，以及依赖的前人定理。原创论文、LaTeX 和文档采用 CC BY 4.0，原创证明与复验代码采用 MIT，论文请按原稿署名 **Chatgpt** 引用。坐标初值及目录完备性来自 Moczurad 与 Zgliczyński，第三方材料和依赖保留各自许可。[复验说明](Lean/README.md) · [中文研究日志](ResearchLog_zh.md) · [许可与引用](../../LICENSE)
