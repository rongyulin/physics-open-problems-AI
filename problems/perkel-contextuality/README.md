# Why the Perkel contextuality test needs 37 dimensions · 为什么 Perkel 量子情境性检验需要 37 维？

[English](#english) · [中文](#中文) · [Paper / 论文](./Perkel37.pdf) · [Lean project / Lean 工程](./Lean/Perkel37_Lean.zip)

## English

**Can a 36-dimensional system reproduce the ideal predictions of the 37-dimensional Perkel experiment? No.** For the prescribed 57 events, any complex Hilbert-space realization by projective measurements that attains the ideal score has dimension at least 37. A realization in dimension 37 exists, so this is the exact minimum. The lower bound allows projectors of any rank and mixed preparations.

### Where the question came from

In 2025, Liu and colleagues used time bins of coherent light to reproduce the probabilities of a contextuality test. Its 57 events can be covered by three measurement contexts, each containing 19 mutually exclusive events. Other exclusivity relations connect events in different contexts. With all these constraints, a noncontextual assignment can give value one to at most two events. In the ideal quantum model the probabilities in each context sum to one, giving a total score of three. The authors constructed a 37-dimensional realization and, immediately after Eq. (4), asked whether a smaller one exists. [Liu et al., *Science Advances*, Eq. (4) and the following paragraph][liu]

The public `threecontext` project later examined whether different optimal Gram matrices could have smaller rank. Its computations at tolerance 10⁻⁷ indicated a unique real optimum of rank 37. The authors left the complex case open. The proof here fixes every entry of the complex Gram matrix exactly. [Archived numerical results, §1.6][archive]

### How the dimension is forced

Write *A* for the adjacency matrix of the Perkel graph. Two distinct events must be exclusive when their vertices are **nonadjacent** in this graph. For a pure state ψ and an event projector *Pᵥ*, let *xᵥ* = *Pᵥ*ψ. The squared norm of *xᵥ* is the event probability. When the total score equals three, the vectors in every colour class of every proper three-colouring sum to ψ. Six such colourings supply enough equations to determine all six neighbouring entries in each row of the Gram matrix. The result is

```math
G_{vw}=\langle x_v,x_w\rangle,\qquad G=\frac{3I+A}{57}.
```

This matrix has rank 37, so the projected vectors span 37 dimensions. Conversely, 57 explicit real unit vectors in 37 dimensions give rank-one projectors attaining score three. For a mixed state, every pure component of positive weight must itself attain three to give an average of three. [Proof and construction, §2](./Perkel37.pdf)

### What a score can certify

The dimension bound concerns this particular test, with its full exclusivity graph. It turns the 37 dimensions used in the construction into a requirement on any projective model reproducing the ideal score. The manuscript also proves that a total score of at least **3 − 27/22000** (about **2.99877**) still certifies dimension at least 37 if the prescribed exclusive pairs are exactly orthogonal. Applying this threshold to laboratory data would require a separate estimate for imperfect orthogonality. [Quantitative dimension bound, §4](./Perkel37.pdf)

The [single-file Lean proof](./Lean/PerkelLower37.lean) derives the pure-state and finite-mixture lower bounds from the projectors. In the [complete Lean project](./Lean/Perkel37_Lean.zip), `PerkelModel.minimum_dimension` proves the pure-state lower bound and `Perkel37.attained_by_complex_projectors` constructs the matching 37-dimensional model. The paper gives the spectral proof of the near-ideal threshold and a uniqueness theorem for a broader class of graph optimizations. [English manuscript](./Perkel37.pdf) · [LaTeX source](./Perkel37.tex)

## 中文

**能否用 36 维系统复现原本在 37 维中实现的 Perkel 检验的理想结果？不能。** 对指定的 57 个事件，任何达到理想得分的复希尔伯特空间投影测量模型都至少需要 37 维，而且确有 37 维的模型达到这一得分。因此，最小维数恰为 37。即使允许任意秩的投影或使用混合态，这一下界也成立。

### 这个问题是谁提出的？

Liu 等人在 2025 年发表的实验中，利用相干光的时间模式复现了一项量子情境性检验的事件概率。57 个事件可以分成三组测量情境，每组有 19 个两两互斥的事件，跨组还存在额外的互斥关系。在全部约束下，非情境模型的每个确定性赋值最多只能让两个事件取值为 1。理想量子模型却能让每组的概率和都等于 1，总分达到 3。作者给出了 37 维构造，随后在式（4）后明确提出，是否能用更低维的系统实现同样的结果？[Liu 等，*Science Advances*，式（4）及其后讨论][liu]

后来的公开项目 `threecontext` 搜索了同一检验是否存在秩更低的最优 Gram 矩阵。在 10⁻⁷ 的计算容差下，数值结果提示实数域的最优解唯一、秩为 37。该项目明确将复数情形留作待解问题。本项目从互斥关系和总分出发，严格确定了复 Gram 矩阵的每个元素。[数值研究存档，第 1.6 节][archive]

### 37 维是怎样推出来的？

记 *A* 为 Perkel 图的邻接矩阵。两个不同顶点在这张图上**不相邻**，对应的事件就必须互斥。对纯态 ψ，用 *xᵥ* 表示事件投影 *Pᵥ* 作用于 ψ 得到的向量，其范数平方就是事件概率。总分达到 3 时，图的每一种合法三着色都有一个共同性质：每个颜色类别中的向量之和都等于 ψ。选取六种着色，就能列出足够的方程，确定 Gram 矩阵每一行对应六个邻点的元素。这给出

```math
G_{vw}=\langle x_v,x_w\rangle,\qquad G=\frac{3I+A}{57}.
```

这个矩阵的秩恰为 37，因此投影后的向量一定张成 37 维空间。反过来，论文显式构造了 37 维空间中的 57 个实单位向量，相应的秩一投影确实达到总分 3。若使用混合态，要让平均得分达到 3，每个权重为正的纯态分量都必须达到 3，因而也需要同样的维数。[论文第 2 节的证明与构造](./Perkel37.pdf)

### 这对实验的解释有什么意义？

维数下界针对这 57 个事件及其完整互斥关系。它说明，只要投影测量模型复现理想得分，原构造用到的 37 维就无法再压缩。论文还证明，在规定互斥的投影严格正交时，总分只要达到 **3 − 27/22000**（约 **2.99877**），就足以认证维数至少为 37。若要把这个阈值用于实测数据，还需要估计互斥关系偏离理想正交的程度。[论文第 4 节的定量维数下界](./Perkel37.pdf)

[单文件 Lean 证明](./Lean/PerkelLower37.lean)从投影测量出发，给出纯态和有限纯态混合的维数下界。[完整 Lean 工程](./Lean/Perkel37_Lean.zip)中，`PerkelModel.minimum_dimension` 给出纯态下界，`Perkel37.attained_by_complex_projectors` 构造了达到下界的 37 维模型。接近满分时的定量阈值，以及适用于更广一类图优化问题的唯一性定理，由论文给出谱方法证明。[英文论文](./Perkel37.pdf) · [LaTeX 源码](./Perkel37.tex)

[liu]: https://pmc.ncbi.nlm.nih.gov/articles/PMC11789840/
[archive]: https://archive.softwareheritage.org/browse/content/sha1_git:601b64d894427aee82f13277f681cd6753768448/
