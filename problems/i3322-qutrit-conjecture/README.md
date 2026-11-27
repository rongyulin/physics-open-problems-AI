# The exact I3322 Bell value of isotropic qutrit pairs · 各向同性双三能级态的 I3322 贝尔值

[English](#english) · [中文](#中文) · [Paper / 论文](./IsotropicI3322.pdf) · [Lean project / 完整证明工程](./Lean/IsotropicI3322_Lean.zip)

## English

Can a third measurement setting reveal nonlocality that a two-setting CHSH test misses? For one maximally entangled pair of three-level systems (qutrits) mixed with white noise, I3322 and CHSH have **exactly the same noise threshold**. This proves Conjecture 1 of Ito, Imai and Avis (2006). A fourth setting per party can reveal nonlocality in a state for which every three-setting binary experiment admits a local model. [Original conjecture, §IV C][ito]

### The question and its origin

Alice and Bob each choose one of three measurements with two possible outcomes. The I3322 Bell inequality assigns a score to their joint and single-party outcome probabilities. In the normalization used here, every local hidden-variable model scores at most zero. Collins and Gisin exhibited states that violate I3322 even though they satisfy CHSH. Ito, Imai and Avis asked whether this advantage survives for a maximally entangled qutrit pair mixed with white noise. The visibility α gives the fraction of the maximally entangled state in the following mixture.

```math
\rho_\alpha=\alpha |\Phi_3\rangle\langle\Phi_3|+(1-\alpha)I_9/9,\qquad
|\Phi_3\rangle=(|00\rangle+|11\rangle+|22\rangle)/\sqrt{3}.
```

The authors derived the CHSH threshold. For I3322 they found a violation at α = 0.7629742794 and no numerically significant violation in 50,000 starts at α = 0.7629742793. An unsuccessful search leaves open the possibility of better measurements. The missing step was an upper bound covering every choice of the six measurements. [Collins and Gisin (2004)][cg] · [Ito, Imai and Avis (2006)][ito] · [Liang and Doherty, numerical curve in Fig. 4][ld]

### Exact threshold and optimal measurements

With arbitrary binary local measurements, a positive I3322 score is attainable **if and only if** α exceeds the critical visibility

```math
\alpha_0=\frac{4}{1+3\sqrt{2}}\approx 0.7629742793.
```

The maximum score is zero through the threshold, including equality. Just above it, a strategy with only two nonconstant measurements per party attains the optimum. At a second transition, α ≈ 0.7842529610, a strategy using different two-dimensional subspaces for Alice and Bob catches up and then overtakes it. The paper gives the exact score on all three intervals. At unit visibility it gives 0.2297707835 to ten decimal places, in agreement with the earlier numerical value 0.229771. The optimization fixes one copy of the indicated state at each visibility. The unrestricted I3322 problem also varies the shared state and its dimension. [Exact curve, Theorem 1 and Fig. 1](./IsotropicI3322.pdf) · [Earlier pure-state value][nav] · [Unrestricted problem][pv]

The upper bound comes from the geometry of qutrit measurements. Because the score is affine in each measurement effect, the search can be reduced to projections. Their six ranks give 4,096 cases. The spectra of sums and differences of projection pairs reduce the remaining continuous optimization to two angles. Explicit projectors attain the resulting bounds.

### Why the number of settings matters

Take **α = 19/25 = 0.76**. For any fixed menu of three binary measurements per party, the joint statistics admit a local hidden-variable model. This follows by combining the threshold with the known classification of the three-setting Bell inequalities. Yet four explicit binary measurements per party on the *same state* give the four-setting inequality A₅ a score of **1/16500**, strictly above its local bound of zero. The local model for one menu of three settings can therefore depend on that menu. Ito, Imai and Avis had already exhibited four-setting violations below the CHSH threshold. The exact three-setting bound establishes the separation. [Facet classification][cg] · [Four-setting witness, §5](./IsotropicI3322.pdf)

### Paper and verification

The Lean project starts with the 9 × 9 density matrix and allows arbitrary complex positive measurement effects with positive complements. The theorem `IsotropicI3322.maximum` checks an upper bound for every measurement choice and the existence of measurements attaining it. `violation_iff` gives the strict threshold. `IsoSeparation.strict_separation` checks the I3322 bound at 19/25 and the explicit A₅ violation there. The conclusion about a local model for every three-setting menu also uses the published facet classification. The linked Lean entry file imports the modules in the full project archive. [Paper (PDF)](./IsotropicI3322.pdf) · [LaTeX source](./IsotropicI3322.tex) · [Lean entry file](./Lean/IsotropicI3322.lean) · [Full Lean project and verification logs](./Lean/IsotropicI3322_Lean.zip)

## 中文

在检验贝尔非局域性时，把每一方可选的测量从两种增加到三种，能否让原本被噪声掩盖的非局域性显现出来？对掺入白噪声的最大纠缠三能级粒子对，三设置 I3322 检验与两设置 CHSH 检验的**临界可见度完全相同**。这证明了 Ito、Imai 与 Avis 在 2006 年提出的猜想 1。若进一步增加到每方四种设置，则确实能在所有三设置二元测量实验都容许局域模型的情形下检出非局域性。[原论文第 IV C 节，猜想 1][ito]

### 问题的由来

Alice 和 Bob 在相互分离的两地各自选择三种测量中的一种，每次测量有两种可能结果。I3322 贝尔不等式根据双方的联合概率和各自的边缘概率计算一个分数。按原文的归一化，任何局域隐变量模型的分数至多为零。Collins 与 Gisin 曾找到能违反 I3322、却不能违反 CHSH 的量子态。Ito 等人追问，在最大纠缠的三能级粒子对与白噪声的混合态上，增加一种可选测量是否也有这种优势？用可见度 α 表示最大纠缠态在混合态中的权重，待测状态为

```math
\rho_\alpha=\alpha |\Phi_3\rangle\langle\Phi_3|+(1-\alpha)I_9/9,\qquad
|\Phi_3\rangle=(|00\rangle+|11\rangle+|22\rangle)/\sqrt{3}.
```

原作者推导出了 CHSH 的精确阈值。对 I3322，他们在 α = 0.7629742794 时找到了违反，在 α = 0.7629742793 时从五万个随机初值搜索，均未发现超过数值误差的违反。要把阈值确定下来，还需要一个覆盖双方全部六项测量选择的上界。[Collins 与 Gisin（2004）][cg] · [Ito、Imai 与 Avis（2006）][ito] · [Liang 与 Doherty 的数值曲线，图 4][ld]

### 证明了什么？

允许双方使用任意二元局域测量时，**当且仅当**可见度 α 严格大于下列临界值，I3322 的得分才能超过零：

```math
\alpha_0=\frac{4}{1+3\sqrt{2}}\approx 0.7629742793.
```

在临界值及以下，最高分恰好为零。刚超过临界值时，双方各用两项输出不固定的测量就能达到最优。到 α ≈ 0.7842529610 时，另一种策略追平前者，并在更高可见度下取得更高分数：这时 Alice 与 Bob 的测量分别利用不同的二维子空间。论文给出了全部三个区间的精确最优值。无白噪声时，最优值约为 0.2297707835，与此前数值研究得到的 0.229771 一致。这里对每个可见度固定一份指定的共享态。另一个常被讨论的 I3322 问题还允许改变量子态及其维数。[论文定理 1 和图 1](./IsotropicI3322.pdf) · [此前的纯态数值结果][nav] · [不限维数的问题][pv]

证明上界用到了三能级测量的几何结构。固定其他测量时，贝尔分数是单个测量算符的仿射函数，因此只需考虑投影测量。六个投影的秩共有 4,096 种组合。利用成对投影之和与差的特征值，每种组合只需再优化两个角度；论文给出的显式投影能够达到上界。

### 为什么测量设置的数量重要？

取 **α = 19/25 = 0.76**。结合三设置贝尔不等式的已知分类，可以推出：双方无论各自选定哪三项二元测量，所得统计都存在局域隐变量解释。但对**同一个态**，只要双方各有四项测量可选，论文给出的一组显式测量就让四设置不等式 A₅ 得到 **1/16500** 分，严格超过局域上界零。因此，每组三设置各自有局域模型，所用模型可以随设置组合而变。原作者已经找到了低于 CHSH 阈值的四设置违反；现在有了三设置的精确上界，可以严格区分两类实验的探测能力。[三设置不等式分类][cg] · [论文第 5 节的四设置测量](./IsotropicI3322.pdf)

### 论文与验证

Lean 工程从 9 × 9 密度矩阵和玻恩规则出发，允许每个测量结果由任意复数域上的正算符表示，且其补算符也须为正。`IsotropicI3322.maximum` 同时证明分数上界及其可达到性，`violation_iff` 给出严格的违反条件。`IsoSeparation.strict_separation` 核验了 19/25 处的 I3322 上界和显式 A₅ 违反。从这些结论推及每组三设置实验都存在局域模型，还使用了文献中的贝尔不等式分类。单独列出的 Lean 文件是定理入口，依赖模块与核验记录均在完整工程内。[英文论文 PDF](./IsotropicI3322.pdf) · [LaTeX 源码](./IsotropicI3322.tex) · [Lean 定理入口](./Lean/IsotropicI3322.lean) · [完整 Lean 工程及核验记录](./Lean/IsotropicI3322_Lean.zip)

[ito]: https://arxiv.org/pdf/quant-ph/0508210#page=6
[cg]: https://arxiv.org/abs/quant-ph/0306129
[ld]: https://arxiv.org/pdf/quant-ph/0604045#page=5
[nav]: https://arxiv.org/pdf/1507.07521#page=7
[pv]: https://arxiv.org/abs/1006.3032
