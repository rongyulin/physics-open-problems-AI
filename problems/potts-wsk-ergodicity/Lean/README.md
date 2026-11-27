# Width-six Potts–WSK ergodicity · 宽六 Potts–WSK 遍历性

[English](#english) · [中文](#中文) · [Research overview / 研究说明](../README.md)

## English

On a periodic triangular lattice six sites wide and 3*M* sites tall, `PottsSix.degree_six_mod_twelve_iff` proves that a proper four-colouring of degree 6 modulo 12 exists exactly when *M* ≡ 2 (mod 4). The final theorem `PottsSix.wsk_classification_from_corollary_3_5` uses the published equivalence between this obstruction and zero-temperature WSK nonergodicity as an explicit hypothesis. The [Chinese report](../PottsSix_report_zh.md) gives the reference and physical interpretation.

**Reproduce the proof.** Download [PottsSix.lean](PottsSix.lean) and [check_potts_rows.py](check_potts_rows.py) to the same directory. With Lean 4.28.0 and Python 3 on the path, run

```sh
lean PottsSix.lean
python3 check_potts_rows.py
```

The Lean proof uses only the standard library. The independent Python calculation reconstructs the certificate on all 732 legal rows and 3,960 compatible ordered row pairs. Lean checks the obstruction for arbitrary height by induction.

Original proof and verification code in this project, including Lean sources and any Python or shell scripts, is available under the [MIT License](../../../LICENSES/MIT.txt). Original explanatory text is available under [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt). When redistributing a source file separately, include the full MIT notice linked here. Third-party dependencies retain their own licenses.

## 中文

对宽 6、高 3*M* 的周期三角晶格，`PottsSix.degree_six_mod_twelve_iff` 证明，存在映射度模 12 余 6 的合法四色着色，当且仅当 *M* 模 4 余 2。最终定理 `PottsSix.wsk_classification_from_corollary_3_5` 把该障碍与零温 WSK 不遍历的等价关系作为显式文献前提。[中文报告](../PottsSix_report_zh.md)给出了该判据的出处及其物理含义。

**复验方法。** 将 [Lean 源文件](PottsSix.lean) 和 [Python 核验脚本](check_potts_rows.py) 下载到同一目录。使用 Lean 4.28.0 运行 `lean PottsSix.lean` 即可核验形式化证明，只依赖 Lean 标准库。另运行 `python3 check_potts_rows.py` 可独立复算 732 种合法行与 3,960 种有序相容行对的证书。Lean 再用归纳法将结论推广至任意高度。

本项目原创的 Lean 证明代码和配套验证脚本（包括 Python 和 shell 脚本，如有）采用 [MIT 许可证](../../../LICENSES/MIT.txt)。原创说明文字采用 [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt)。单独分发源文件时，请随附这里链接的 MIT 许可全文和其中的版权声明。第三方依赖沿用各自的许可。
