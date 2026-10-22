# Zudilin 的 B 多项式实根性

**作者：Aurantium。** [English](README.md) · [完整证明](full_range_proof.md) · [参考文献](REFERENCES.md) · [复现说明](REPRODUCIBILITY.md)

对每个实参数 $a$ 和整数 $n\ge2$，由 $P_n^a(t^3)=B_n^a(t)$ 定义的非零多项式，次数为 $\lfloor n/2\rfloor$，全部零点均在 $(-\infty,0]$。这里讨论的是变量 $x=t^3$ 的零点，不是原变量 $t$ 的零点。

## 原题与研究沿革

Wadim Zudilin 在 *On a family of polynomials related to ζ(2,1)=ζ(3)* 第 4 节提出全实参数范围的零点位置观察。论文于 **2015 年 4 月 29 日首次提交 arXiv**，手稿标注日期为 4 月 24 日，v2 日期为 2017 年 3 月 31 日；后收入 **Periods in Quantum Field Theory and Arithmetic，Springer Proceedings in Mathematics & Statistics 314（2020），621–630 页**。该问题也收录于 H. S. Cohl 整理的 **OPSFA13 开放问题报告，SIGMA 12（2016），071，第 7 节**。

Zudilin 已给出有限和定义、三项递推、反射恒等式及实验性的零点观察。Wen-Gao Long、Dan Dai、Yu-Tian Li、Xiang-Sheng Wang 后续在 **Studies in Applied Mathematics 144（2020），133–163 页**中将其与连续对偶 Hahn 多项式联系起来，并研究另一种参数设置下的渐近性质；那里的结论并不直接证明本项目所处理的全实参数断言。具体范围和出处见[文献核查](literature_status.md)。

## 本次证明与附加结论

[完整证明](full_range_proof.md)使用移动端点与根交错归纳处理非例外实参数，再以连续性处理非正整数。覆盖的是原题已有的完整实参数范围，不应表述为把原本仅限正参数的猜想推广到全实数。

- 当 $a\notin\{0,-1,-2,\ldots\}$ 时，根均为严格负实单根，相邻多项式按证明中依奇偶区分的次序严格交错。
- 对每个实参数及每个零点 $r$，进一步有 $r\le\min\{0,(a+n-1)^3,-a^3\}$。
- 明确排除零多项式 $B_1^0=0$；其余 $n=0,1$ 情形为非零常数。例外参数允许零根及重根。

本项目不解决另外的 A 多项式部分和问题，也不声称证明 B 多项式族的正交性或极限零点分布。

## 验证等级与复现

通常数学证明已通过[另一次 AI 数学审查](independent_review.md)。精确 SymPy 检查覆盖恒等式、原始有限和、例外参数和 729 项扩展根计数。这些有限计算只是对证明的辅助核查，不能代替全称命题的证明。**不声称经过独立人类同行评审，也不声称完成全 Lean 或其他证明助手认证。** 有限文献检索未找到此前解答，但不保证新颖性或全球优先权。

使用 Python 3.10 及以上版本和 `requirements.txt` 中记录的依赖版本，不使用 `-O`：

```sh
python verify_zudilin.py
python verify_zudilin.py --extended
python independent_sum_check.py
python check_package.py
```

前三项检查数学计算，最后一项只检查文件完整性。[复现说明](REPRODUCIBILITY.md)列出精确范围和日志；[PUBLIC_FILES.txt](PUBLIC_FILES.txt)与[SHA256SUMS.json](SHA256SUMS.json)列出全部文件、大小及哈希。证明与代码有 AI 辅助，署名、原有成果归属及复用状态见[RIGHTS.md](RIGHTS.md)。

## 已独立验收的局部 Lean 附件

[partial-formalization](partial-formalization/README.md) 收录首批 53 个定理和 12 个定义，已独立重编译及公理审计，仅依赖标准三公理。尚缺 B=P(t³) 连接、一般交错及例外参数闭包，不能称为完整 Lean 证明。精确范围、缓存认证限制见[独立 AI 验证报告](partial-formalization/AUDIT_REPORT.md)。通常数学证明通过不等于完整形式化通过。

2026 年 10 月 22 日的[独立 Linux 云端源码重编译](audit/2026-10-22-cloud-recompilation/CLOUD_RECOMPILATION.md)再次通过同一批 53 条定理、12 个定义，附精确依赖版本和规范化日志。这是补充复现证据，不增加数学覆盖范围，也不代表完成全部形式化。
