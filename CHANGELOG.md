# Changelog · 更新日志

Repository updates are listed newest first. Dates use Beijing time (UTC+8).

本日志按北京时间（UTC+8）倒序记录研究项目、论文、形式化证明和仓库文档的重要更新。[完整提交历史 / Full commit history](https://github.com/rongyulin/physics-open-problems-AI/commits/main/)

## 2026-11-27

### English

- **Six-body singular diagrams.** Added an exact census of published certificate polynomials on the five-equal-mass line, local torque calculations, and supplementary Lean algebra checks. [Notes][diagrams]

- **Five-equal-mass six-body problem.** Added three manuscripts on diagram 98 over a rational function field, six local bifurcations, and signed collinear configurations. Includes the ten-module Lean project, exact certificate replays and a second Chinese research log. [Papers][central] · [Verification][parameter]

- **Planar Newtonian central configurations.** Added three English manuscripts in PDF and LaTeX covering the 4,104 small-mass configurations, the nonconcentric equilateral-triangle branch and Hampton’s six- and seven-body Newtonian Morse polynomials. Includes Lean sources, exact-arithmetic certificates and a Chinese research log. [Manuscripts and verification][central]
- **Repository homepage.** Expanded the six projects into individually headed entries with the original questions, research terminology, results, and direct links to the papers or report and Lean verification instructions. [Project index](./README.md#english)
- **Research projects.** Published English manuscripts in PDF and LaTeX, with Lean proofs, for [local SIC measurements in dimension 12][sic], [stabilizer-code distance][qec], [CHSH Bell-pair extraction][chsh], [the I3322 qutrit conjecture][i3322], and [Perkel contextuality][perkel]. The [Potts–WSK ergodicity project][potts] published its Chinese research report, Lean proof, and independent Python check. An English paper for that project is planned.
- **Project guides.** Added a bilingual index and English-first project overviews explaining the earlier results, the unresolved step, each contribution, and which claims Lean verifies. Fixed the display of formulas in the dimension-12 SIC overview. [Documentation update][docs] · [SIC rendering fix][render]
- **Licensing and verification.** Released the papers and original documentation under CC BY 4.0 and the original proof and verification code under MIT. The five manuscript PDFs now carry a license and source link. Each of the five Lean project archives includes both license texts, and all six Lean directories have bilingual reproduction instructions. [Licensing commit][liccommit]

### 中文

- **六体退化图。** 补入五重等质量线上的原始证书逐项筛查、退化图局部力矩计算和配套 Lean 代数检验。[研究笔记][diagrams]

- **五重等质量六体问题。** 新增三篇英文论文，讨论有理函数域上的退化图 98、六处局部分岔和有符号共线构型，随附十个模块的 Lean 工程、精确证书及第二份中文研究日志。[论文][central] · [复验方法][parameter]

- **平面牛顿中心构型。** 收录三篇英文论文的 PDF 和 LaTeX 源稿，分别研究小质量极限的 4,104 个构型、两个非同心正三角形的解析分支，以及 Hampton 猜想的牛顿六体和七体 Morse 多项式。附 Lean 源码、精确算术证书及中文研究日志。[论文与复验][central]
- **仓库首页。** 将六个问题逐项展开，补入原始问题、常用术语和精确结论，并为各项列出论文或报告及 Lean 复验入口。[项目索引](./README.md#中文)
- **研究项目。** [十二维局域 SIC][sic]、[稳定子码距][qec]、[CHSH 贝尔对提取][chsh]、[三能级粒子对的 I3322 猜想][i3322]和 [Perkel 情境性][perkel]五个项目发布了英文论文 PDF、LaTeX 源稿及 Lean 证明。[Potts–WSK 遍历性项目][potts]发布了中文研究报告、Lean 证明和独立的 Python 复核脚本，英文论文将在后续添加。
- **项目说明。** 新增双语首页索引，各项目主页按英文在前、中文在后编排，说明前人已知结果、尚缺的步骤、本项目的推进及 Lean 验证范围。修复了十二维 SIC 主页的公式显示。[文档更新][docs] · [SIC 公式修复][render]
- **许可与复验。** 论文和原创说明文档采用 CC BY 4.0，原创证明代码及验证脚本采用 MIT。五篇论文的 PDF 均附许可和来源链接，五个 Lean 工程压缩包均附两份许可全文，六个 Lean 目录均补充了中英文复验方法。[许可更新记录][liccommit]

[diagrams]: ./problems/planar-central-configurations/notes/README.md
[parameter]: ./problems/planar-central-configurations/Lean/README.md
[central]: ./problems/planar-central-configurations/README.md
[sic]: ./problems/local-sic-dimension-12/README.md
[qec]: ./problems/stabilizer-code-distance-collapse/README.md
[chsh]: ./problems/chsh-bell-pair-extraction/README.md
[i3322]: ./problems/i3322-qutrit-conjecture/README.md
[perkel]: ./problems/perkel-contextuality/README.md
[potts]: ./problems/potts-wsk-ergodicity/README.md
[docs]: https://github.com/rongyulin/physics-open-problems-AI/commit/f09c3c82abb8a437745b00ecedb9fc1e5bf8b045
[render]: https://github.com/rongyulin/physics-open-problems-AI/commit/0d4e2036ed316ebd4bce62b029ae04afe428b37d
[liccommit]: https://github.com/rongyulin/physics-open-problems-AI/commit/709e633dfa51e2f9303b19aba0ff1bca7bd2501f
