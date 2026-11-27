# Local symmetry of SIC measurements in dimension 12 · 十二维 SIC 测量的局域对称性

[English](#english) · [中文](#中文) · [Paper (PDF) / 论文](./LocalSIC12.pdf) · [Lean](./Lean/LocalSIC12.lean)

## English

**Exact symmetric informationally complete measurements (SICs) are known in dimension 12. Can one generate a SIC from a single pure state using only the standard displacements of two qubits and one qutrit, acting separately on the three subsystems? This project proves that the answer is no, for every pure state and every degree of entanglement.**

A dimension-12 SIC has 144 outcomes. Each corresponds to a ray, every pair of distinct rays has squared overlap $1/13$, and the probabilities of the 144 outcomes determine an arbitrary quantum state. The usual Weyl–Heisenberg construction uses a cyclic shift and a phase operator on twelve levels. On a $2\times2\times3$ system one can instead take products of the shifts and phase operators on each factor. Both choices give 144 operations up to overall phase. Their multiplication rules differ. The local construction has a precedent. On three qubits, products of Pauli operators generate the eight-dimensional Hoggar SIC. What happens when the third qubit is replaced by a qutrit? [SICs and state reconstruction][renes] · [Exact dimension-12 construction][appleby] · [The eight-dimensional Hoggar SIC][hoggar]

### Connection to SIC existence and Zauner’s conjecture

The general SIC existence problem asks whether $\mathbb C^d$ contains $d^2$ equiangular lines for every $d\ge2$. In §3.4 of his 1999 thesis, Zauner also proposed a more specific construction: in each dimension a fiducial can be chosen in a prescribed eigenspace of an order-three symmetry so that its orbit under the standard $d$-level Weyl–Heisenberg displacements is a SIC. An exact dimension-12 SIC for the standard action with Zauner symmetry is known. [Zauner’s thesis, §3.4][zauner] · [Review of Zauner symmetry][hoggar] · [Dimension-12 construction][appleby]

This project keeps $d=12$ and changes the displacement group. Up to overall phase, the standard group $\mathbb Z_{12}^{2}$ has elements of order 12. Every element of the local group $\mathbb Z_2^{4}\times\mathbb Z_3^{2}$ returns to the identity after six applications. A change of basis cannot identify the two groups. The local obstruction rules out one candidate symmetry in dimension 12 and is consistent with the exact SICs for the standard action.

### Where did the question come from?

**A search for SIC symmetries.** Appleby and collaborators recomputed a known exact solution for the ordinary dimension-12 action in a 2012 preprint. In 2017, Chien and Waldron reported a numerical search across candidate groups. Their Table 2 records a numerical SIC for the ordinary group and lists the local group, `SmallGroup(144,197)`, without a SIC hit. Khodaiemehr reported another unsuccessful search for the same local group in 2026. A numerical search can miss an exceptional starting state, leaving existence undecided. [Appleby et al.][appleby] · [Chien and Waldron, §5, Table 2][chien] · [Khodaiemehr, §III.B][khod]

**A question from Higgs-decay physics.** In $H\to f\bar fV$, the fermion and antifermion each have two spin states, and the massive vector boson has three polarizations. Banacki and collaborators studied this $2\times2\times3$ spin system using the second-order stabilizer Rényi entropy $M_2$. For their choice of local displacements, a pure state attains the general bound $\log_2(13/2)$ exactly when its orbit is a SIC. In §5.1 they explicitly identified the existence of such a state as unknown to them. The theorem here answers that question for the entire state space. [Banacki et al., §5.1, Eqs. (111)–(113)][banacki]

### Why is the orbit impossible?

Just **15 of the overlap conditions** suffice. Take the displacements that act on the qubits alone and let $\rho$ be the two-qubit reduced state. Each nonidentity two-qubit Pauli operator $P$ would have to satisfy |tr(ρP)| = 1/√13. Orthogonality of the Pauli basis then fixes the purity at tr(ρ²) = (1 + 15/13)/4 = 7/13.

Tracing a qutrit out of a pure state leaves a four-dimensional marginal of rank at most three, so $\rho$ has a zero eigenvalue. The 15 constraints give $\rho=(I+S/\sqrt{13})/4$ for a signed Pauli sum $S$ with integer characteristic polynomial. The zero eigenvalue puts $-\sqrt{13}$ in the spectrum of $S$, forcing its algebraic conjugate $+\sqrt{13}$ into the spectrum as well. Hence $\rho$ has an eigenvalue $1/2$. Its remaining eigenvalues are nonnegative and sum to $1/2$, giving purity at most $1/2$, in contradiction with $7/13$. [Full proof, §2](./LocalSIC12.pdf)

### Why does it matter?

- **SIC symmetry.** There are two candidate abelian projective unitary group types that can act transitively on the outcomes of a dimension-12 SIC. Ruling out the local type $\mathbb Z_2^4\times\mathbb Z_3^2$ leaves $\mathbb Z_{12}^2$, whose action is equivalent to the ordinary twelve-level displacements up to a basis change and relabelling. This determines the transitive abelian symmetry type. An individual SIC can still have additional noncommuting symmetries. [Paper, §3](./LocalSIC12.pdf)
- **Non-stabilizerness.** The general reference bound on $M_2$ in the Higgs-decay analysis is about $2.70044$ bits. The paper gives a smaller upper bound, approximately $2.69890107$ bits, for every pure state with this displacement basis. The exact maximum of $M_2$ remains open. The paper also determines the least sum of squared deviations of the 15 Pauli expectation magnitudes from $1/\sqrt{13}$. The minimum is $(1-3/\sqrt{13})^2/3$, and an explicit state attains it. [Paper, §5](./LocalSIC12.pdf)

## 中文

**十二维的对称信息完备测量（SIC）已经有精确构造。如果把十二个能级分给两个量子比特和一个三能级系统，还能从一个初态出发，只用三个子系统各自的标准位移，生成这样的测量吗？本项目证明，答案是否定的。** 定理覆盖所有纯初态，包括三个子系统之间任意纠缠的态。

十二维 SIC 有 144 个测量结果。每个结果对应一个态方向，任意两个不同方向的内积模平方都等于 $1/13$；这 144 个结果的概率足以重建任意十二维量子态。通常的构造把十二个能级排成一个循环，在其上做循环移位和相位变换（Weyl–Heisenberg 位移）。在 $2\times2\times3$ 系统中，也可以分别在两个比特和三能级系统上做各自的位移，再取张量积。忽略整体相位，两种做法都给出 144 个操作，但它们的乘法规则不同。这种局域构造有成功的先例。在八维，三个比特的泡利操作可以生成 Hoggar SIC。这里要判断的是，把第三个比特换成三能级系统后，还有没有初态能生成所需的 144 个等角方向。[SIC 的定义与量子态重建][renes] · [已知的十二维精确构造][appleby] · [八维 Hoggar SIC][hoggar]

### 与 SIC 存在性问题和 Zauner 猜想的关系

一般的 SIC 存在性问题问，每个维数 $d\ge2$ 是否都有一组 $d^2$ 条复等角线。Zauner 在 1999 年的博士论文第 3.4 节还提出了更具体的构造猜想：在每个维数都能选到一个初始向量，使标准 $d$ 能级 Weyl–Heisenberg 位移生成 SIC，并且这个向量可取在一个指定三阶对称算符的特征空间中。十二维已有带 Zauner 三阶对称性的标准位移 SIC 精确解。[Zauner 博士论文，第 3.4 节][zauner] · [SIC 与 Zauner 对称性综述][hoggar] · [十二维构造][appleby]

本项目改变了构造中的一个条件：总维数仍为 12，位移则必须分别作用在两个比特和一个三能级系统上。忽略整体相位，标准位移群 $\mathbb Z_{12}^{2}$ 中有阶为 12 的操作；局域位移群 $\mathbb Z_2^{4}\times\mathbb Z_3^{2}$ 中每个操作至多做六次就回到恒等。两群因此不能靠换基等同。这里的否定答案排除了十二维的一种候选对称性，与标准构造的肯定答案相容。

### 问题从哪里来？

**数学上的线索来自一次群对称性搜索。** Appleby 等在 2012 年的预印本中重新计算了通常位移群下已知的十二维精确解。Chien 与 Waldron 随后系统搜索了多种候选对称群。他们在 2017 年论文的表 2 中为通常的十二维位移群标出了数值 SIC，也列出了这里的局域群 `SmallGroup(144,197)`，但未在该群下找到 SIC。Khodaiemehr 在 2026 年的预印本中也报告了对该群的搜索未果。数值优化可能错过特殊初态，这些计算因此留下了同一个存在性问题。[Appleby 等][appleby] · [Chien 与 Waldron，第 5 节、表 2][chien] · [Khodaiemehr，第 III.B 节][khod]

**直接的物理提问来自希格斯衰变研究。** Banacki 等研究 $H\to f\bar fV$ 的自旋关联时，末态的费米子和反费米子各有两个自旋态，有质量矢量玻色子有三个极化态，自然得到 $2\times2\times3$ 的系统。对于他们采用的局域位移，纯态的二阶稳定子 Rényi 熵 $M_2$ 有通用上界 $\log_2(13/2)$，等号恰好要求该态生成一个局域 SIC。作者在第 5.1 节明确写道，据他们所知，这种态是否存在仍属未知。本项目回答的就是这个问题。[Banacki 等，第 5.1 节，式（111）–（113）][banacki]

### 为什么这 144 个方向不可能出现？

只看那些作用在两个比特上、保持三能级系统不动的位移，就有 **15 个必要条件**。设 $\rho$ 是两比特约化态。每个非恒等两比特泡利算符 $P$ 都必须满足 |tr(ρP)| = 1/√13。由泡利基的正交性，ρ 的纯度因此被固定为

<p align="center">tr(ρ²) = ¼(1 + 15/13) = 7/13.</p>

另一方面，初态是纯态，而被取迹的系统只有三个能级，所以这个四维约化态至少有一个零特征值。在上述 15 个条件下，ρ = (I + S/√13)/4，其中 $S$ 是带正负号的泡利算符之和，特征多项式具有整数系数。零特征值使 $-\sqrt{13}$ 成为 $S$ 的特征值，它的代数共轭 $+\sqrt{13}$ 也必须出现。所以 $\rho$ 有一个特征值恰为 $1/2$。其余特征值非负、总和为 $1/2$，于是纯度至多为 $1/2$，与 7/13 > 1/2 矛盾。[完整证明，论文第 2 节](./LocalSIC12.pdf)

### 这个结果改变了什么？

- **对称性分类。** 十二维 SIC 若有一个阿贝尔射影酉群能把任一测量结果变到任一其他结果，原本有两种候选群类型。排除局域类型 $\mathbb Z_2^4\times\mathbb Z_3^2$ 后，只剩 $\mathbb Z_{12}^2$，其作用在换基和重新编号后等价于通常的十二维位移。这确定了这一类传递对称群。单个 SIC 仍可能有额外的非交换对称性。[论文第 3 节](./LocalSIC12.pdf)
- **量子态的非稳定子性。** 对 Banacki 等采用的 $M_2$，原先的参照上界约为 $2.70044$ 比特。论文证明所有纯态都服从一个更低的上界，其数值约为 $2.69890107$ 比特。精确最大熵仍待确定。论文还给出一个已经求出精确最优值的量：上述 15 个泡利期望值的模偏离目标 $1/\sqrt{13}$ 的平方和，最小为 $(1-3/\sqrt{13})^2/3$，并给出了达到该值的态。[论文第 5 节](./LocalSIC12.pdf)

## Paper and formal verification · 论文与形式化证明

[Manuscript / 论文 PDF](./LocalSIC12.pdf) · [LaTeX source / 源码](./LocalSIC12.tex) · [Main Lean theorem / 主定理](./Lean/LocalSIC12.lean) · [Full Lean project / 完整工程](./Lean/LocalSIC12_Lean.zip)

The single-file theorem `SicNoGo.no_local_hw_sic_dim12` rules out the full 144-label SIC orbit for normalized complex amplitudes. The complete project also verifies the attained minimum deviation and the entropy bound. The classification of transitive abelian symmetries is proved in the manuscript. The manuscript is signed **Chatgpt** and has not undergone independent peer review.

单文件中的 `SicNoGo.no_local_hw_sic_dim12` 对归一化复振幅定义全部 144 个轨道标签，证明其中不存在 SIC。完整工程还验证了 15 项偏差的可达最小值和熵上界。传递阿贝尔对称群的分类由论文给出纸笔证明。稿件署名 **Chatgpt**，尚未经独立同行评审。

[zauner]: https://www.gerhardzauner.at/documents/gz-quantumdesigns.pdf
[renes]: https://arxiv.org/abs/quant-ph/0310075
[appleby]: https://arxiv.org/abs/1210.1055
[chien]: https://www.math.auckland.ac.nz/~waldron/Preprints/NiceErrorFrames/laa.2016.11.026.pdf#page=23
[hoggar]: https://arxiv.org/abs/1703.07901
[khod]: https://arxiv.org/abs/2611.01524
[banacki]: https://arxiv.org/html/2607.26122v2#S5.SS1
