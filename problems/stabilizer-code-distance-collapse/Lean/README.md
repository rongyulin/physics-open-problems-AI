# Stabilizer-code distance under a change of local dimension · 稳定子码距与局域维数

[English](#english) · [中文](#中文) · [Research overview / 研究说明](../README.md)

## English

`distance_collapse_examples` gives the exact distances of the five-, seven- and eight-site examples. The five-site code has distance one over the integers modulo four and distance two after reduction to the binary field. In the archive, `UniversalTorus.universal_gap` proves that at every side length L ≥ 4 the binary toric code has distance L and its specified signed lift has distance four at every cyclic local dimension above two.

[Lean source](DistanceCollapse.lean) · [Complete project ZIP](DistanceCollapse_Lean.zip)

**Reproduce the proof.** Extract the ZIP and enter the directory containing `lakefile.toml` and `audit.sh`. With elan installed and network access for the pinned dependencies, run the following commands. The project selects Lean 4.28.0. Use Bash 4 or newer and Python 3.11 or newer for the audit script.

```sh
lake exe cache get
bash audit.sh
```

The script compiles the project modules and replays their declarations with `leanchecker`. To check only the three finite examples, run `lake env lean standalone/DistanceCollapse.lean` in the extracted project after fetching the cache. The archive README also lists the independent Python calculations.

Original proof and verification code in this project, including Lean sources and any Python or shell scripts, is available under the [MIT License](../../../LICENSES/MIT.txt). Original explanatory text is available under [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt). When redistributing a source file separately, include the full MIT notice linked here. The ZIP includes both license texts. Third-party dependencies retain their own licenses.

## 中文

`distance_collapse_examples` 验证五、七、八站点反例的精确码距。其中五站点码在模四整数环上的码距为 1，约化到二元域后为 2。完整工程的 `UniversalTorus.universal_gap` 证明，对任意边长 L ≥ 4，二元环面码的码距为 L，指定的带符号提升在每个大于二的循环局域维数上码距均为 4。

[Lean 源文件](DistanceCollapse.lean) · [完整工程 ZIP](DistanceCollapse_Lean.zip)

**复验方法。** 安装 elan，解压 ZIP，进入同时包含 `lakefile.toml` 和 `audit.sh` 的目录。工程指定 Lean 4.28.0。首次使用时联网运行 `lake exe cache get` 获取依赖缓存，再运行 `bash audit.sh` 编译工程并使用 `leanchecker` 重新检查各模块的声明。该脚本需要 Bash 4 或更新版本及 Python 3.11 或更新版本。若只核验三个有限反例，在解压后的工程中取得缓存后运行 `lake env lean standalone/DistanceCollapse.lean`。压缩包内的 README 还列出了独立的 Python 复算程序。

本项目原创的 Lean 证明代码和配套验证脚本（包括 Python 和 shell 脚本，如有）采用 [MIT 许可证](../../../LICENSES/MIT.txt)。原创说明文字采用 [CC BY 4.0](../../../LICENSES/CC-BY-4.0.txt)。单独分发源文件时，请随附这里链接的 MIT 许可全文和其中的版权声明。完整工程 ZIP 内附两份许可全文。第三方依赖沿用各自的许可。
