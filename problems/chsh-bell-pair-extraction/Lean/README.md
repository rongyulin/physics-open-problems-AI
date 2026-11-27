# Bell-pair extraction from a CHSH score · CHSH 分数与贝尔对提取

[English](#english) · [中文](#中文) · [Research overview / 研究说明](../README.md)

## English

For a pure bipartite source of Schmidt rank at most three, `RankThreeCHSH.sharp` gives the smallest attainable optimal squared Bell-pair fidelity for each observed CHSH expectation from 2 to 2√2. `RankThreeCHSH.plateau` identifies the interval where that guarantee is exactly 5/6. The calculation includes arbitrary binary measurement effects and local extraction isometries.

[Lean source](RankThreeCHSH.lean) · [Complete project ZIP](RankThreeCHSH_Lean.zip)

**Reproduce the proof.** Extract the ZIP and enter the directory containing `lakefile.toml` and `audit.sh`. With elan installed and network access for the pinned dependencies, run the following commands. The project selects Lean 4.28.0.

```sh
lake exe cache get
sh audit.sh
```

The script compiles the project modules and replays their declarations with `leanchecker`. The linked entry file imports other modules in the archive.

Original proof and verification code in this project, including Lean sources and any Python or shell scripts, is available under the [MIT License](../../../LICENSES/MIT.txt). Original explanatory text is available under [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt). When redistributing a source file separately, include the full MIT notice linked here. The ZIP includes both license texts. Third-party dependencies retain their own licenses.

## 中文

对施密特秩至多为三的双体纯态，`RankThreeCHSH.sharp` 给出每个 CHSH 期望分数（从 2 到 2√2）能保证的最优贝尔对提取保真度，其定义采用重叠模平方。`RankThreeCHSH.plateau` 给出保证值恰为 5/6 的区间。定理允许任意二元测量效应和局域提取等距变换。

[Lean 源文件](RankThreeCHSH.lean) · [完整工程 ZIP](RankThreeCHSH_Lean.zip)

**复验方法。** 安装 elan，解压 ZIP，进入同时包含 `lakefile.toml` 和 `audit.sh` 的目录。工程指定 Lean 4.28.0。首次使用时联网运行 `lake exe cache get` 获取依赖缓存，再运行 `sh audit.sh` 编译工程并使用 `leanchecker` 重新检查各模块的声明。入口文件需要压缩包中的其他模块。

本项目原创的 Lean 证明代码和配套验证脚本（包括 Python 和 shell 脚本，如有）采用 [MIT 许可证](../../../LICENSES/MIT.txt)。原创说明文字采用 [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt)。单独分发源文件时，请随附这里链接的 MIT 许可全文和其中的版权声明。完整工程 ZIP 内附两份许可全文。第三方依赖沿用各自的许可。
