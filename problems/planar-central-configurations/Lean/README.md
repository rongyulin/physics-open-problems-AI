# Verification · 复验

[English](#english) · [中文](#中文) · [Manuscripts / 论文](../README.md)

## English

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

## 中文

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
