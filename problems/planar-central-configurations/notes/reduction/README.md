# Three remaining singular diagrams on the five-equal-mass line

**Chatgpt · Research manuscript and reproducible case list · 27 November 2026**

[English](#english) · [中文](#中文) · [Paper](../../papers/ReducedSixBodyList.pdf) · [LaTeX](../../papers/ReducedSixBodyList.tex)

## English

For masses $(1,1,1,1,1,t)$ with generic positive $t$, the current list of possible singular ends required by Tomar’s finiteness argument contains **diagrams 88, 93 and 94**. The starting point is the earlier reduction to 14 diagram classes. For this application a nontrivial curve has constant nonzero signed potential and at least one varying squared distance. Such a curve must have a singular end where the sum of the fifteen distance orders is nonpositive. Actual existence of any of the remaining possibilities, and finiteness on this mass line, are open. The reduction allows a finite exceptional set of algebraic mass ratios. [Earlier census](../CoreCensus.md) · [Tomar, §2](https://hexagonmath.org/pdf/2611.00377v1)

| Diagram | Original core placements still open | Placements in the separate core-free list | Orbits of all remaining placements | Orbits compatible with real configurations at the origin |
| --- | ---: | ---: | ---: | ---: |
| 88 | 0 | 54 | 8 | 5 |
| 93 | 4 | 3 | 6 | 5 |
| 94 | 72 | 54 | 41 | 19 |
| **Total** | **76** | **111** | **55** | **29** |

The input contains 738 labelled placements bearing a previous core certificate and 19 cells without an assigned core. Giving the marked mass all six positions in each of the latter cells gives 114 further placements. This replay excludes **662 of the 738** and **3 of the 114**, leaving 187. Permuting the labels and exchanging the two complex projections gives the 55 orbit representatives. For real finiteness, a contradiction curve can be chosen with matching origin leaves in the two projections. Of the 187 placements, 90 pass that additional condition. Their 29 representatives are marked with `real_origin_compatible=1`. Each member of an orbit has the same status under that condition. [Origin argument](PhysicalOrigin.md)

- [Representatives.csv](Representatives.csv) gives one representative for each of the 55 orbits, with the counts from each input list. A physical finiteness search can start with the 29 marked rows.
- [RemainingPlacements.csv](RemainingPlacements.csv) gives each surviving placement, its representative and the permutation taking it there. Read the six digits as the images of labels 1 through 6, with the origin fixed. The colour exchange is recorded separately. The class and cell IDs follow the zero-based catalogue numbering and the distinguished mass slot is one-based.
- [RemovedPlacements.csv](RemovedPlacements.csv) gives each of the 665 exclusions and the first criterion used in this replay. The [738-row input](../RemainingCorePlacements.csv) remains available for comparison.

### Mathematical evidence

The linear force and triangle tests exclude 604 placements. A rectangular force balance, constant signed potential, or subset torque excludes 30 further placements in diagrams 99–101. The two-scale rectangle argument excludes the four remaining placements of diagram 84. The fully circled triangle and local force tests exclude 24 core placements and three core-free placements of diagram 93. An additional check on the entire diagram-46 catalogue leaves only $1/4$ and $1$ as positive candidates for that diagram. [Node balances](NodeBalances.md) · [Diagram 46](ClusterTriangles.md) · [Diagrams 99–101](Rectangles.md) · [Diagram 84](Diagram84.md) · [Diagram 93](Diagram93Reduction.md)

The tree and root-order checks are reproducible in Python. Lean checks the fixed-shape polynomial identity, cluster-mass obstruction, rectangle phase and central-binary arithmetic, and the two scalar determinant specializations used in diagram 93. The passages from the force equations to the local expansions and the physical curve argument are given in the manuscript and notes. [Lean sources and instructions](../../Lean/README.md)

### Reproduction

With Python 3.10+ and SymPy installed, clone Tomar’s source at commit `84bbcf276d029fdf31375c4a21c6a7e136955e51`. Run the following commands from this directory, preserving its position relative to the input CSV. The script reads the original cell trees, lowest-order terms, mass-slot links and diagram representatives from that checkout. The preceding census documents how to reproduce the input CSV from the archived cofactor certificates. [Pinned source](https://github.com/tejasvi/smale6-six-bodies-generic/tree/84bbcf276d029fdf31375c4a21c6a7e136955e51) · [Baseline inputs](../CoreCensus.md)

```sh
python3 replay.py /path/to/smale6-six-bodies-generic /tmp/sixbody-reduced
diff Representatives.csv /tmp/sixbody-reduced/Representatives.csv
diff RemainingPlacements.csv /tmp/sixbody-reduced/RemainingPlacements.csv
diff RemovedPlacements.csv /tmp/sixbody-reduced/RemovedPlacements.csv
python3 cluster_triangle_filter.py --cells /path/to/smale6-six-bodies-generic/lean/sections3-5/data/cells --input ../RemainingCorePlacements.csv
```

## 中文

对质量 $(1,1,1,1,1,t)$ 和一般正参数 $t$，上轮清单中的 14 种退化图现在只剩 **88、93、94**。这里考察的是有限性反证要求出现的边界情形。若非平凡构型曲线存在，它至少有一个退化端点满足十五个体间平方距离的阶数之和不大于零。“一般参数”允许有限多个代数例外质量比。余下三种图中是否有任何一种能形成这样的端点，以及这条质量线的一般有限性，仍待证明。[英文研究稿 PDF](../../papers/ReducedSixBodyList.pdf) · [LaTeX 源稿](../../papers/ReducedSixBodyList.tex)

**旧清单的 738 项缩至 76 项。** 上轮另有 19 个未分配原始证书的单元，将标记体的六个位置展开，114 个组合缩至 111 个。合计留下 187 个带标号组合。逐一检查两棵坐标树及其最低阶力项以后，重标号和交换两种复坐标可把它们归为 55 个代表。图 88、93、94 分别占 8、6、41 个。

**若专门研究实六体有限性，只需跟进其中 29 个代表。** 实构型中某个天体位于质心时，它的两种共轭坐标同时为零。从无穷多个实构型选择反证曲线时，可以保留这个性质。应用到剩余 187 项后，90 项仍满足这个必要条件，归为 29 个代表，分别属于图 88（5 个）、图 93（5 个）和图 94（19 个）。复方程的研究可以使用全部 55 个代表。[原点条件的证明](PhysicalOrigin.md)

[55 个代表及实问题标记](Representatives.csv) · [187 项及其对应置换](RemainingPlacements.csv) · [665 项排除依据](RemovedPlacements.csv) · [原始 738 项清单](../RemainingCorePlacements.csv)
