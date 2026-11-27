# WSK ergodicity for the four-state Potts antiferromagnet · 四态反铁磁 Potts 模型在宽六环面上的 WSK 遍历性

[English](#english) · [中文](#中文) · [Chinese report / 中文报告](./PottsSix_report_zh.md) · [Lean](./Lean/PottsSix.lean)

## English

On a periodic triangular lattice six sites wide, the zero-temperature Wang–Swendsen–Kotecký (WSK) algorithm can reach every ground state of the four-state Potts antiferromagnet at height 12. At height 18, some ground states are unreachable from any given starting state. This project gives the exact rule for every positive height divisible by three, with ordinary periodic boundaries and no shift across either seam.

**The chain on the torus of width 6 and height *H* = 3*M* is nonergodic exactly when *M* ≡ 2 (mod 4).** The exceptional heights are 6, 18, 30, 42, and so on. At every other positive multiple of three the chain is ergodic.

### What was left open?

At zero temperature each ground state is a proper four-colouring of the lattice: every pair of neighbours has different colours. A WSK update picks two colours and can swap them on a connected component formed by those colours. The sampling question is whether a sequence of such moves can connect any two proper colourings.

In 2009, Bojan Mohar and Jesús Salas proved nonergodicity for the triangular tori of size 3*L* × 3*M* with 3 ≤ *L* ≤ *M*. Width six behaved differently. The authors proved nonergodicity for heights 6, 18, 30, …, and showed that the 6 × 9 torus is ergodic by enumerating nearly 300 million proper colourings. Their width-three result also covers 6 × 3 after exchanging the lattice directions. Their 2010 paper again identified the restriction at width six. The result here supplies the missing converse: **every remaining admissible height is ergodic**. Combined with the published results for width three and for widths of at least nine, this completes the classification of unshifted triangular tori with both side lengths divisible by three. [Mohar and Salas (2009), Proposition 5.5 and §6](https://arxiv.org/pdf/0901.1010#page=34) · [2010 follow-up, discussion after Theorem 2.12](https://arxiv.org/pdf/1002.4279#page=9)

### Why the rule holds for arbitrarily tall lattices

Represent the four colours by the vertices of a tetrahedron. Each triangular face of the lattice maps to a face of the tetrahedron. Counting how many times the torus covers one chosen face, with a sign for orientation, gives the integer degree *D* of the colouring. Mohar and Salas proved that on a three-colourable triangulated torus, the WSK chain is nonergodic exactly when some four-colouring has *D* ≡ 6 (mod 12). [Mohar and Salas (2009), Corollary 3.5](https://arxiv.org/pdf/0901.1010#page=12)

One colouring of degree 6 modulo 12 suffices to prove nonergodicity at a given height. Proving the converse requires ruling out that degree for every colouring at infinitely many heights. At width six, all these tori can be built from the same 732 legal rows and 3,960 ordered pairs of compatible rows. The proof assigns a label *c*, either 0 or 1, to each row. The label stays constant between compatible rows. The degree contributed by a pair equals *c* modulo four up to a difference of row potentials. Around a periodic stack the differences cancel, giving *D* ≡ *Hc* (mod 4). A degree of 6 modulo 12 therefore requires *H* ≡ 2 (mod 4). At each exceptional height, alternating the rows `010101` and `232323` produces a periodic colouring of degree −3*H*, which is 6 modulo 12.

The classification tells a Monte Carlo practitioner when a simulation started in one ground state necessarily misses part of the ground-state ensemble, however long it runs. For ergodic sizes, the time needed to obtain representative samples remains a separate mixing-time question.

### Report and verification

**An English paper will be added to this directory.** The Chinese report contains the full argument and a second geometric proof. In Lean 4.28.0, `degree_six_mod_twelve_iff` proves the exact degree criterion for every height 3*M*. The final theorem, `wsk_classification_from_corollary_3_5`, takes the published equivalence between the degree obstruction and nonergodicity as an explicit hypothesis. The Python script independently reconstructs and checks the row certificate. [Chinese report](./PottsSix_report_zh.md) · [Lean proof](./Lean/PottsSix.lean) · [Python verification](./Lean/check_potts_rows.py)

### License and attribution

The original Chinese report and README text are licensed under [CC BY 4.0][doc-license]. Original Lean code and verification scripts use the [MIT License][code-license]. Third-party material retains its own terms. [Repository license scope][lic-scope]

Suggested report citation — *宽六三角晶格上零温四态反铁磁 Potts 模型的 WSK 遍历性*, rongyulin/physics-open-problems-AI (2026), [original project][project-source], [CC BY 4.0][doc-license]. When sharing a translation or another adaptation, identify the changes.

## 中文

在宽度为六、采用周期边界的三角晶格上，用零温 Wang–Swendsen–Kotecký（WSK）算法模拟四态反铁磁 Potts 模型，格子高 12 时，可以从任一基态走到其他所有基态；高 18 时，无论从哪个基态出发，总有一部分基态无法到达。本项目给出所有三的正倍数高度的精确判别，条件是晶格沿两个方向均直接周期拼接、没有错位。

**对宽度为 6、高度为 *H* = 3*M* 的环面，WSK 链不遍历当且仅当 *M* ≡ 2（模 4）。** 不遍历的高度依次为 6、18、30、42……，其余三的正倍数高度全部遍历。

### 前人留下了什么问题？

在零温下，基态恰好是晶格的合法四色着色，即相邻格点的颜色都不同。一次 WSK 更新选定两种颜色，可以在这两种颜色构成的某个连通分量上互换颜色。遍历性所问的是，从任意一个合法着色出发，能否靠这种更新到达其他所有合法着色。

2009 年，Bojan Mohar 与 Jesús Salas 证明，对尺寸为 3*L* × 3*M* 且 3 ≤ *L* ≤ *M* 的三角环面，WSK 不遍历。宽六是一个例外。作者证明高 6、18、30……时不遍历，又通过枚举近三亿个合法着色证明 6 × 9 的环面遍历。交换宽、高后，6 × 3 也由他们的宽三结论覆盖。两人在 2010 年的后续论文中再次指出宽六结果的局限。本项目补齐了反向命题：**其余所有符合条件的高度都遍历**。将这一结果与已有的宽三及宽度至少为九的结论合在一起，就得到两边均为三的倍数、周期边界无错位的全部三角环面的分类。[Mohar 与 Salas（2009），命题 5.5 和第 6 节](https://arxiv.org/pdf/0901.1010#page=34) · [2010 年后续论文，定理 2.12 后的说明](https://arxiv.org/pdf/1002.4279#page=9)

### 为什么有限次核验能覆盖任意高度？

把四种颜色看成四面体的四个顶点，晶格中的每个三角形就映到四面体的一个面。选定一个目标面，按取向正负计数整个环面对它的覆盖次数，得到着色的整数映射度 *D*。Mohar 与 Salas 已证明，对可三色着色的三角环面，WSK 不遍历当且仅当存在一个四色着色，使 *D* ≡ 6（模 12）。[Mohar 与 Salas（2009），推论 3.5](https://arxiv.org/pdf/0901.1010#page=12)

证明某个高度不遍历，只需找出一个映射度模 12 余 6 的着色。要证明反向命题，却要同时排除无穷多个高度上的每一个这类着色。固定宽度为六后，所有这些环面都可由同样的 732 种合法行及 3,960 种有序相容行对组成。证明为每行着色赋予一个取 0 或 1 的标签 *c*，相容行的标签相同。在模四意义下，每一对相邻行对映射度的贡献等于 *c* 加上两个行势函数值之差。绕环面一周，势函数差逐项抵消，得到 *D* ≡ *Hc*（模 4）。因此，要得到模 12 余 6 的映射度，高度 *H* 必须模 4 余 2。在每个例外高度，把 `010101` 和 `232323` 两种着色逐行交替排列，便得到一个能首尾相接的构型，其映射度为 −3*H*，恰好模 12 余 6。

这给蒙特卡罗模拟划出了明确的尺寸限制：在哪些高度上，从单一基态出发，即使无限延长模拟时间，也必定遗漏一部分基态。对于遍历的高度，获得有代表性的样本需要运行多久，还取决于链的混合速度。

### 报告与验证

**本目录后续会添加英文论文。** 现有中文报告给出了完整论证和另一种几何证明。Lean 4.28.0 定理 `degree_six_mod_twelve_iff` 对任意高度 3*M* 证明了上述映射度存在的充要条件。最终定理 `wsk_classification_from_corollary_3_5` 将文献中关于该映射度与 WSK 不遍历等价的推论作为显式前提。Python 脚本独立重建并核验了逐行计算所用的证书。[中文研究报告](./PottsSix_report_zh.md) · [Lean 证明](./Lean/PottsSix.lean) · [Python 复核脚本](./Lean/check_potts_rows.py)

### 许可与署名

本项目原创的中文研究报告和 README 正文采用 [CC BY 4.0][doc-license]。原创 Lean 代码和验证脚本采用 [MIT 许可][code-license]。第三方材料沿用各自的许可。[仓库授权范围][lic-scope]

中文报告的推荐署名为《宽六三角晶格上零温四态反铁磁 Potts 模型的 WSK 遍历性》，rongyulin/physics-open-problems-AI（2026），[原项目][project-source]，[CC BY 4.0][doc-license]。发布译本或其他改编版本时，请注明所作修改。

[doc-license]: https://creativecommons.org/licenses/by/4.0/
[code-license]: ../../LICENSES/MIT.txt
[lic-scope]: ../../LICENSE
[project-source]: https://github.com/rongyulin/physics-open-problems-AI/tree/main/problems/potts-wsk-ergodicity
