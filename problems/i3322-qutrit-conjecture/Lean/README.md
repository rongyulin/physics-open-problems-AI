# The I3322 threshold for qutrit pairs · 双三能级态的 I3322 阈值

[English](#english) · [中文](#中文) · [Research overview / 研究说明](../README.md)

## English

For one maximally entangled qutrit pair mixed with white noise, `IsotropicI3322.maximum` proves the maximum score at each visibility over arbitrary binary local measurements, including attainability. `IsotropicI3322.violation_iff` gives the strict threshold 4/(1 + 3√2). The archive also checks an explicit four-setting violation at visibility 19/25. The inference of locality for every three-setting menu uses the published facet classification cited on the project page.

[Lean source](IsotropicI3322.lean) · [Complete project ZIP](IsotropicI3322_Lean.zip)

**Reproduce the proof.** Extract the ZIP and enter the directory containing `lakefile.toml` and `audit.sh`. With elan installed and network access for the pinned dependencies, run the following commands. The project selects Lean 4.28.0.

```sh
lake exe cache get
sh audit.sh
```

The script compiles the project modules and replays their declarations with `leanchecker`. The entry file imports other modules in the archive. For independent numerical checks, run `python3 check_rank_cases.py` and `python3 check_a5.py` from the same directory.

Original proof and verification code in this project, including Lean sources and any Python or shell scripts, is available under the [MIT License](../../../LICENSES/MIT.txt). Original explanatory text is available under [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt). When redistributing a source file separately, include the full MIT notice linked here. The ZIP includes both license texts. Third-party dependencies retain their own licenses.

## 中文

对掺入白噪声的一份最大纠缠双三能级态，`IsotropicI3322.maximum` 给出任意二元局域测量在每个可见度下的最高得分，并证明可以达到。`IsotropicI3322.violation_iff` 证明只有可见度严格超过 4/(1 + 3√2) 才有违反。完整工程还核验了可见度 19/25 处的显式四设置违反；关于每组三设置实验都容许局域模型的推论另用项目页引用的不等式分类。

[Lean 源文件](IsotropicI3322.lean) · [完整工程 ZIP](IsotropicI3322_Lean.zip)

**复验方法。** 安装 elan，解压 ZIP，进入同时包含 `lakefile.toml` 和 `audit.sh` 的目录。工程指定 Lean 4.28.0。首次使用时联网运行 `lake exe cache get` 获取依赖缓存，再运行 `sh audit.sh` 编译工程并使用 `leanchecker` 重新检查各模块的声明。入口文件依赖压缩包中的其他模块。要独立复算秩分类与四设置例子，可在同一目录运行 `python3 check_rank_cases.py` 和 `python3 check_a5.py`。

本项目原创的 Lean 证明代码和配套验证脚本（包括 Python 和 shell 脚本，如有）采用 [MIT 许可证](../../../LICENSES/MIT.txt)。原创说明文字采用 [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt)。单独分发源文件时，请随附这里链接的 MIT 许可全文和其中的版权声明。完整工程 ZIP 内附两份许可全文。第三方依赖沿用各自的许可。
