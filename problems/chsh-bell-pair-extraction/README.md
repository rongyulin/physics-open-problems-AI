# How much Bell-pair fidelity does a CHSH score certify? · CHSH 分数能保证多高的贝尔对保真度？

[English](#english) · [中文](#中文) · [Paper / 论文](./RankThreeCHSH.pdf) · [Lean project / 完整工程](./Lean/RankThreeCHSH_Lean.zip)

## English

At a CHSH score of **2.5**, a pure two-qubit source guarantees an extractable Bell pair with squared fidelity at least **7/8**. If the source can occupy a third Schmidt mode, the sharp guarantee drops to **5/6**. This project gives the exact guarantee for every score from 2 to 2√2, assuming a pure bipartite source of Schmidt rank at most three. The Schmidt rank counts how many terms are needed to express the state as a sum of product states.

### Where the question comes from

In a CHSH Bell test, each of two observers independently chooses between two measurements with outcomes ±1. The classical upper bound on the score is 2. At the quantum maximum, 2√2, the correlations certify a perfect Bell pair up to local isometries. What can an intermediate violation certify? In 2009, Bardyn and colleagues formulated this as a quantitative state-certification problem. They calculated the optimal extraction fidelity for a given pure state. Assuming the Gisin–Peres conjecture about optimal measurements, they also derived a straight-line lower bound and pointed out that ordering the Schmidt probabilities imposes additional constraints at fixed dimension. Pollard later gave a public proof of the maximum CHSH score for a given pure two-qutrit state. [Bardyn et al., Eqs. (14)–(16)][bardyn] · [Pollard’s proof on GitHub][pollard]

### The sharp guarantee

For each state, allow both observers to choose their best local extraction operations, without communication. The fidelity is the squared overlap with a Bell pair and an arbitrary auxiliary pure state after local isometries. An observed score gives only a lower bound on that state’s maximum CHSH score. A source capable of a larger violation can produce the observed score by changing its measurements. The remaining task is to minimize the extraction fidelity over *every* ordered Schmidt spectrum compatible with that observation. This project solves that constrained minimum. From low to high scores, the minimum can be attained by spectra with the two smallest probabilities equal, then all three equal, then the two largest equal.

The curve first rises, stays **exactly at 5/6** throughout the interval below (approximately 2.468 to 2.552), and then rises linearly to 1. Each value on the curve is attained.

```math
\frac{1+\sqrt{41}}{3} \le S \le \frac{2(1+2\sqrt{2})}{3}.
```

A maximally entangled qutrit pair has three equal Schmidt probabilities. Its best extracted Bell pair has squared fidelity 5/6, and changing the measurements lets it produce every score on the plateau. The proof shows that every compatible state does at least this well. In the interior, the uniform spectrum is the only one attaining the minimum. Thus a higher score in this interval certifies no additional Bell-pair fidelity. The full three-branch formula and its attaining spectra appear in [§3 and Figure 1 of the paper](./RankThreeCHSH.pdf).

McKague’s 2010 thesis proposed a family that would attain a straight-line bound. For a product-branch weight of 2/3, sorting the three Schmidt probabilities gives a fidelity of **5/6** where that construction predicted **2/3**. This corrects the proposed equality example. The straight-line lower bound remains consistent with the rank-three result. The assumptions of purity and Schmidt rank at most three are essential here. Arbitrary mixed sources and the general Gisin–Peres conjecture at higher rank are separate questions. [McKague, §5.4.1, Eq. (5.59)][mckague] · [Kaniewski on dimension-independent self-testing][kaniewski]

### Paper and formal proof

The Lean 4.28.0 entry points `RankThreeCHSH.sharp` and `RankThreeCHSH.plateau` check the full boundary and the constant interval for normalized complex 3 × 3 amplitude matrices, binary measurement effects, and local isometries. The linked source imports modules in the complete project. The archive includes build and kernel-replay logs for 49 modules. [English paper (PDF)](./RankThreeCHSH.pdf) · [LaTeX source](./RankThreeCHSH.tex) · [Lean entry point](./Lean/RankThreeCHSH.lean) · [Complete Lean project](./Lean/RankThreeCHSH_Lean.zip)

## 中文

一次 CHSH 实验得到 **2.5** 分。若已知源产生的是两个量子比特的纯态，则提取出的贝尔对的平方保真度至少为 **7/8**。若允许源多占据一个施密特模式，这个精确保证降至 **5/6**。本项目求出了在 CHSH 分数从 2 到 2√2 的整个区间内，**施密特秩至多为三的双体纯态**能够保证的最佳提取保真度。施密特秩表示把这个纯态写成乘积态之和至少需要多少项。

### 问题从哪里来？

在 CHSH 贝尔检验中，两名观察者各自从两种测量中选择一种，每次得到 ±1 两种结果之一。经典局域模型的分数最高为 2。达到量子上限 2√2 时，即使不了解测量装置的内部实现，也可以确认双方能通过局域等距变换提取一个完美贝尔对。如果只测得介于两者之间的分数，还能保证多高的质量？Bardyn 等人在 2009 年系统研究了这个定量认证问题。他们求出给定纯态的最优提取保真度，又在假设关于最优测量的 Gisin–Peres 猜想成立时推出一条直线下界，并指出维数固定时，施密特概率的排序会带来额外约束。此后 Pollard 在 GitHub 上公开了给定双三能级纯态时最大 CHSH 分数的证明。[Bardyn 等，式（14）–（16）][bardyn] · [Pollard 的公开证明][pollard]

### 最差情况下仍能保证什么？

对每个给定的态，先允许双方在没有通信的情况下各自选取最优局域等距变换，计算所得状态与“贝尔对和某个辅助纯态的张量积”之间最大的重叠模平方。观测分数只给出了这个态所能达到的最高 CHSH 分数的下界。一个本可以得到更高分的态，也能通过改变测量给出同样的观测分数。剩下的困难是，在与该分数相容的所有有序施密特谱中，找到提取保真度最低的情形。本项目求出了这个受约束的最小值。随分数升高，三个区间依次可由最小的两个施密特概率相等、三个概率全部相等、最大的两个概率相等的态达到下界。

这条曲线先上升，随后在下列整个区间（约 2.468 到 2.552）内**恒等于 5/6**，最后线性上升至 1。每一点都有相应的态和测量取到等号。

```math
\frac{1+\sqrt{41}}{3} \le S \le \frac{2(1+2\sqrt{2})}{3}.
```

两个三能级粒子的最大纠缠态具有三个相等的施密特概率，从中提取贝尔对的最优平方保真度恰为 5/6。仅改变测量方式，这同一个态就能给出平台上的每一个分数。证明的另一个方向表明，所有与这些分数相容的态都至少能做到 5/6。在区间内部，只有均匀施密特谱能取到这个最小值。因此分数在区间内上升时，对贝尔对质量的保证并不提高。完整的三段公式和各段取等的态见[论文第 3 节和图 1](./RankThreeCHSH.pdf)。

McKague 在 2010 年博士论文中给出了一个据称能取到直线下界的态族。乘积态分支的权重为 2/3 时，将三个施密特概率正确排序后，最优保真度是 **5/6**，原构造给出的值为 **2/3**。这个修正针对的是取等例子，直线下界本身与本项目的结论相容。本文的精确曲线以纯态和施密特秩至多为三为前提。任意混态的认证，以及更高施密特秩下的一般 Gisin–Peres 猜想，仍需分别研究。[McKague，第 5.4.1 节、式（5.59）][mckague] · [Kaniewski 关于不限制维数的自检界][kaniewski]

### 论文与形式化证明

Lean 4.28.0 的 `RankThreeCHSH.sharp` 和 `RankThreeCHSH.plateau` 分别验证了完整的三段边界及其平台。定理直接涉及归一化的 3 × 3 复数振幅矩阵、二元测量效应和局域等距变换。入口文件依赖的模块均在完整工程内，压缩包附有 49 个模块的构建和内核重检日志。[英文论文 PDF](./RankThreeCHSH.pdf) · [LaTeX 源码](./RankThreeCHSH.tex) · [Lean 定理入口](./Lean/RankThreeCHSH.lean) · [完整 Lean 工程](./Lean/RankThreeCHSH_Lean.zip)

[bardyn]: https://arxiv.org/pdf/0907.2170#page=3
[pollard]: https://github.com/cluesurf/vibe/blob/6f3d9c6e2e069f0296ab6f84a62fc857da19293f/test/experiment/quantum/tsirelson-closed-form.ts#L4-L17
[mckague]: https://arxiv.org/pdf/1006.2352#page=131
[kaniewski]: https://doi.org/10.1103/PhysRevLett.117.070402
