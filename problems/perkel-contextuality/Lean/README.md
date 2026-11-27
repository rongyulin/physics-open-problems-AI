# The Perkel dimension witness · Perkel 检验的维数下界

[English](#english) · [中文](#中文) · [Research overview / 研究说明](../README.md)

## English

For the 57 specified projective events at the ideal score of three, `PerkelModel.minimum_dimension` proves the pure-state lower bound of 37 complex dimensions. `PerkelModel.mixed_minimum_dimension` covers finite mixtures. In the full project, `Perkel37.attained_by_complex_projectors` constructs a matching realization. The near-ideal threshold is proved in the paper.

[Lean source](PerkelLower37.lean) · [Complete project ZIP](Perkel37_Lean.zip)

**Reproduce the proof.** Extract the ZIP and enter the directory containing `lakefile.toml` and `audit.sh`. With elan installed and network access for the pinned dependencies, run the following commands. The project selects Lean 4.28.0.

```sh
lake exe cache get
sh audit.sh
```

The script compiles the project modules and replays their declarations with `leanchecker`. The linked single file collects the lower-bound proof. To check it separately, place it alongside the extracted `lakefile.toml` and run `lake env lean PerkelLower37.lean` after fetching the cache.

Original proof and verification code in this project, including Lean sources and any Python or shell scripts, is available under the [MIT License](../../../LICENSES/MIT.txt). Original explanatory text is available under [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt). When redistributing a source file separately, include the full MIT notice linked here. The ZIP includes both license texts. Third-party dependencies retain their own licenses.

## 中文

对指定的 57 个投影事件，总分达到 3 时，`PerkelModel.minimum_dimension` 证明纯态实现至少需要 37 个复维度，`PerkelModel.mixed_minimum_dimension` 将下界延伸至有限混合态。完整工程的 `Perkel37.attained_by_complex_projectors` 构造了恰好 37 维的实现。接近满分时的定量阈值由论文证明。

[Lean 源文件](PerkelLower37.lean) · [完整工程 ZIP](Perkel37_Lean.zip)

**复验方法。** 安装 elan，解压 ZIP，进入同时包含 `lakefile.toml` 和 `audit.sh` 的目录。工程指定 Lean 4.28.0。首次使用时联网运行 `lake exe cache get` 获取依赖缓存，再运行 `sh audit.sh` 编译工程并使用 `leanchecker` 重新检查各模块的声明。单文件汇集了维数下界证明。若要单独核验，可将它放到解压出的 `lakefile.toml` 旁，取得缓存后运行 `lake env lean PerkelLower37.lean`。

本项目原创的 Lean 证明代码和配套验证脚本（包括 Python 和 shell 脚本，如有）采用 [MIT 许可证](../../../LICENSES/MIT.txt)。原创说明文字采用 [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt)。单独分发源文件时，请随附这里链接的 MIT 许可全文和其中的版权声明。完整工程 ZIP 内附两份许可全文。第三方依赖沿用各自的许可。
