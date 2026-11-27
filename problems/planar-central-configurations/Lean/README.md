# Verification · 复验

[English](#english) · [中文](#中文) · [Manuscripts / 论文](../README.md)

## English

Download and extract [SixBodyVerification.zip](SixBodyVerification.zip). Its `SixBodyResearch` directory contains all original certificate inputs, Lean modules, verification scripts, research notes and run transcripts. The [PDFs and LaTeX sources](../papers/) are distributed separately. Use Lean 4.28.0. The main and triangle projects pin mathlib to `8f9d9cff6bd728b17a24e163c9402775d9e6a365`.

- **Small-mass count.** From the extracted `SixBodyResearch/lean` directory run `lake exe cache get`, then `lake build`. The main project checks the branch-gluing and counting deductions under their stated analytic hypotheses. The standalone [RestrictedReplay.lean](RestrictedReplay.lean) verifies the integer local-root conditions for 60 boxes in the kernel. Run `lean --run RestrictedReplay.lean` for the coverage traversal. The independent C++17/GMP verifier and its instructions are in `certificates/restricted/`. The paper gives the compactness and continuation arguments tying those checks to the count of physical shapes.
- **Nonconcentric triangles.** From `SixBodyResearch/certificates/triangles`, run `lake update`, `lake exe cache get`, then `lake build`. The theorem `SixTriangles.physical_six_body_standard` in `Standard.lean` verifies existence, all six force equations and the physical conditions on the narrow interval around 0.875 specified in the paper. For the full interval from 0.87 to 0.88 run `python3 continuation.py 4000` in the same directory and use the analytic argument in the paper.
- **Morse indices.** Run `lean -j4 --run Hampton.lean` on the standalone [Hampton.lean](Hampton.lean). The closed theorems `HamptonReplay.hampton6` and `HamptonReplay.hampton7` certify the interval pivot tests and weighted sums. The root, symmetry and index verification instructions are in `certificates/hampton/README.md`. The interpretation uses the published global catalogue and the reduction to the shape Hessian in the manuscript.

The papers and original documentation are licensed under CC BY 4.0, the original verification code under MIT. The archive includes the license texts. [Repository licensing](../../../LICENSE) · [Original catalogue](https://doi.org/10.1007/s10569-019-9920-6)

## 中文

下载并解压[完整复验包](SixBodyVerification.zip)。其中 `SixBodyResearch` 保留原始目录结构，包括 Lean 工程、区间算术证书、输入、运行记录和研究笔记。[三篇论文的 PDF 和 LaTeX](../papers/) 单独提供。使用 Lean 4.28.0，主工程和三角形工程均固定了 mathlib 的版本。

- **小质量计数。** 在解压后的 `SixBodyResearch/lean` 运行 `lake exe cache get` 和 `lake build`。主工程核查有明确解析假设的局部分支拼接及计数推导。[RestrictedReplay.lean](RestrictedReplay.lean) 中的内核定理核查了 60 个候选根盒的局部整数检验。`lean --run RestrictedReplay.lean` 重放全域覆盖，独立 C++17/GMP 版本见 `certificates/restricted/`。与实际构型数相联系的紧性、延拓等论证见论文。
- **非同心正三角形。** 在 `SixBodyResearch/certificates/triangles` 运行 `lake update`、`lake exe cache get`、`lake build`。在 0.875 附近论文指定的窄区间上，`SixTriangles.physical_six_body_standard` 直接核查构型存在、全部六个天体所受引力及几何与质量条件。对 0.87 至 0.88 的完整区间，在同一目录运行 `python3 continuation.py 4000`，并结合论文的解析论证。
- **Morse 指标。** 对 [Hampton.lean](Hampton.lean) 运行 `lean -j4 --run Hampton.lean`。六体和七体两个内核定理核查区间主元检验及加权和。根、对称性及指标的复验步骤见 `certificates/hampton/README.md`。从整数证书到完整 Morse 计数，还用到已发表构型目录的完备性及论文对形状 Hessian 的推导。

原创论文、LaTeX 源稿与文档使用 CC BY 4.0，原创复验代码使用 MIT。压缩包附两项许可全文。[仓库许可](../../../LICENSE) · [前人构型目录](https://doi.org/10.1007/s10569-019-9920-6)
