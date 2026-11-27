# Local SIC measurements in dimension 12 · 十二维局域 SIC 测量

[English](#english) · [中文](#中文) · [Research overview / 研究说明](../README.md)

## English

`SicNoGo.no_local_hw_sic_dim12` rules out a symmetric informationally complete (SIC) orbit under the separate displacements of two qubits and a qutrit, for every pure state. The full project also verifies the attained minimum deviation of 15 Pauli expectation magnitudes and the entropy upper bound. The classification of abelian transitive symmetries is proved in the paper.

[Lean source](LocalSIC12.lean) · [Complete project ZIP](LocalSIC12_Lean.zip)

**Reproduce the proof.** Extract the ZIP and enter the directory containing `lakefile.toml` and `audit.sh`. With elan installed and network access for the pinned dependencies, run the following commands. The project selects Lean 4.28.0.

```sh
lake exe cache get
sh audit.sh
```

The script compiles the project modules and replays their declarations with `leanchecker`. The linked single file collects the nonexistence proof and imports mathlib. To check that file on its own, place it alongside the extracted `lakefile.toml` and run `lake env lean LocalSIC12.lean` after fetching the cache.

Original proof and verification code in this project, including Lean sources and any Python or shell scripts, is available under the [MIT License](../../../LICENSES/MIT.txt). Original explanatory text is available under [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt). When redistributing a source file separately, include the full MIT notice linked here. The ZIP includes both license texts. Third-party dependencies retain their own licenses.

## 中文

`SicNoGo.no_local_hw_sic_dim12` 证明，对任意纯态，两个量子比特和一个三能级系统各自的位移都无法生成对称信息完备（SIC）轨道。完整工程还验证了 15 个泡利期望值的模偏离目标的可达最小值，以及熵上界。阿贝尔传递对称群的分类由论文给出证明。

[Lean 源文件](LocalSIC12.lean) · [完整工程 ZIP](LocalSIC12_Lean.zip)

**复验方法。** 安装 elan，解压 ZIP，进入同时包含 `lakefile.toml` 和 `audit.sh` 的目录。工程指定 Lean 4.28.0。首次使用时联网运行 `lake exe cache get` 获取依赖缓存，再运行 `sh audit.sh` 编译工程并使用 `leanchecker` 重新检查各模块的声明。单文件汇集了不存在性证明，依赖 mathlib。若只核验该文件，可将其放到解压出的 `lakefile.toml` 旁，取得缓存后运行 `lake env lean LocalSIC12.lean`。

本项目原创的 Lean 证明代码和配套验证脚本（包括 Python 和 shell 脚本，如有）采用 [MIT 许可证](../../../LICENSES/MIT.txt)。原创说明文字采用 [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt)。单独分发源文件时，请随附这里链接的 MIT 许可全文和其中的版权声明。完整工程 ZIP 内附两份许可全文。第三方依赖沿用各自的许可。
