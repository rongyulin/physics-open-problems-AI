# physics-open-problems-AI

[English](#english) · [中文](#中文)

## English

Research notes on open problems in physics explored with ChatGPT, with manuscripts, Lean formalizations, and reproducibility materials. Each project cites the research it builds on and explains which statements its Lean code verifies.

| Project | What earlier work established and what was missing | What this project adds |
| --- | --- | --- |
| [Local SIC measurements in dimension 12](./problems/local-sic-dimension-12/README.md) | Exact symmetric informationally complete measurements (SICs) were known for the standard twelve-level displacements. Searches with separate displacements on two qubits and a qutrit found no example, but could not exclude an exceptional initial state. | Fifteen necessary overlap conditions contradict the rank and purity constraints on the two qubits. This rules out that local construction for every pure state, including entangled states. |
| [Stabilizer-code distance](./problems/stabilizer-code-distance-collapse/README.md) | Gluesing-Luerssen and Pllaha proved a one-sided distance bound and equality when the reduced code is pure. Their Conjecture 5.5 asked for equality for every free code. A logical error can become harmless after reduction. The question was whether this could increase the distance. | A free five-site code has distance **1** over the integers modulo four and **2** over the binary residue field. Its weight-one logical error becomes a stabilizer on reduction, disproving the conjecture. |
| [Bell-pair extraction from a CHSH score](./problems/chsh-bell-pair-extraction/README.md) | Bardyn et al. gave the extraction fidelity for a specified pure state. Pollard gave the maximum CHSH score for a specified pure two-qutrit state. An observed score can come from many different states. | Minimizing over all compatible pure states of Schmidt rank at most three gives the exact guarantee at every score. At a score of **2.5**, the sharp squared fidelity is **5/6**, compared with **7/8** for a pure two-qubit source. |
| [The I3322 noise threshold for qutrit pairs](./problems/i3322-qutrit-conjecture/README.md) | Ito, Imai and Avis proved the CHSH noise threshold for a maximally entangled qutrit pair mixed with white noise. Their numerical I3322 search approached the same threshold. Proving equality required a bound for every choice of the six binary measurements. | The exact maximum I3322 score at each visibility proves their Conjecture 1. Violation starts strictly above **4/(1 + 3√2)**. At visibility **19/25**, four settings per party can detect nonlocality that every three-setting binary experiment misses. |
| [The dimension of the Perkel contextuality test](./problems/perkel-contextuality/README.md) | Liu et al. constructed the 57-event test in 37 dimensions. That gave an upper bound on the minimum dimension. A rank limit makes the search nonconvex. Subsequent numerical work supported rank 37 for real data, leaving the complex case open. | Exact exclusivity and the ideal score fix the Gram matrix of the projected state vectors. Its rank is **37**, proving that the known construction uses the fewest possible dimensions even with arbitrary-rank projectors and mixed preparations. |
| [WSK ergodicity on triangular Potts lattices](./problems/potts-wsk-ergodicity/README.md) | At width six, Mohar and Salas proved nonergodicity at heights 6, 18, 30, … and verified ergodicity at height 9 by enumeration. Checking any finite list of sizes leaves infinitely many heights undecided. | A relation between adjacent rows applies at every height. For the zero-temperature four-state antiferromagnet on the unshifted torus of width 6 and height 3*M*, the WSK chain is nonergodic exactly when *M* ≡ 2 (mod 4). |

## 中文

本仓库收录用 ChatGPT 探索物理学公开问题的研究稿、Lean 形式化证明和复核材料。各项目页给出原始文献，并说明哪些结论已有 Lean 验证。

| 项目 | 前人做到哪一步，留下了什么困难 | 本项目推进了什么 |
| --- | --- | --- |
| [十二维 SIC 测量的局域对称性](./problems/local-sic-dimension-12/README.md) | 通常的十二能级位移已有对称信息完备测量（SIC）的精确解。改用两个量子比特和一个三能级系统各自的位移后，数值搜索没有找到实例，但仍可能遗漏特殊初态。 | 只取 15 个必要的重叠条件，就能推出与两比特约化态的秩和纯度相矛盾的要求，从而对所有纯初态排除这种局域构造，包括纠缠态。 |
| [量子纠错码距与局域维数](./problems/stabilizer-code-distance-collapse/README.md) | Gluesing-Luerssen 与 Pllaha 证明了码距的单向不等式，也证明了约化码满足纯性条件时取等。其猜想 5.5 将等号推广到所有自由稳定子码。逻辑错误在约化后可能变得无害，关键在于这能否使码距严格增大。 | 构造一个五站点自由码，在模 4 整数环上码距为 **1**，约化到二元域后为 **2**。原先作用在单站点的逻辑错误，约化后由校验生成，这就给出了猜想的反例。 |
| [CHSH 分数能保证的贝尔对保真度](./problems/chsh-bell-pair-extraction/README.md) | Bardyn 等给出了已知纯态的提取保真度，Pollard 给出了已知双三能级纯态的最大 CHSH 分数。实验中只知道一个分数，却可能有许多不同的态产生它。 | 在所有与分数相容、施密特秩至多为三的双体纯态上求最小值，得到每个分数对应的精确保证。例如在 **2.5 分**时，纯双比特源保证的平方保真度为 **7/8**，允许第三个施密特模式时降至 **5/6**。 |
| [三能级粒子对的 I3322 噪声阈值](./problems/i3322-qutrit-conjecture/README.md) | 对混入白噪声的最大纠缠三能级粒子对，Ito、Imai 与 Avis 已求出 CHSH 的严格阈值。I3322 的数值搜索也逼近这一阈值，但仍需证明，无论双方怎样选取六项二元测量，都无法在更低可见度检出违反。 | 求出每个可见度下的 I3322 最高分，证明只有可见度严格超过 **4/(1 + 3√2)** 才能违反不等式，从而证明原论文的猜想 1。在 **19/25** 处，每方四项设置还能检出所有三设置二元实验都无法检出的非局域性。 |
| [Perkel 情境性检验的最小维数](./problems/perkel-contextuality/README.md) | Liu 等用 37 维实现了 57 个事件的理想检验，这给出的是所需最小维数的上界。一旦限制矩阵的秩，搜索就变成非凸优化。后续数值研究在实数域支持秩为 37，复数情形仍未定。 | 由严格互斥关系和理想得分唯一确定投影后态向量的 Gram 矩阵，证明其秩为 **37**。即使允许任意秩投影和混合态，也不能用更低维的系统复现理想得分。 |
| [三角晶格 Potts 模型的 WSK 遍历性](./problems/potts-wsk-ergodicity/README.md) | 对宽六环面，Mohar 与 Salas 已证明高 6、18、30……时不遍历，并通过枚举证明高 9 时遍历。逐个尺寸枚举无法判定其余无穷多个高度。 | 找到相邻两行着色满足的关系，一次覆盖任意高度。对零温四态反铁磁模型，在宽 6、高 3*M* 的无错位三角环面上，WSK 链不遍历当且仅当 *M* 除以 4 余 2。 |
