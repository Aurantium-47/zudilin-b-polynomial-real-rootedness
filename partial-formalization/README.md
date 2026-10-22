# Partial Lean formalization / 局部 Lean 形式化

**PASS_PARTIAL_ONLY.** Independent AI recompilation verified 53 theorems and 12 definitions in the frozen first batch, with only `propext`, `Classical.choice`, and `Quot.sound`. No `sorry` or additional axiom was found. This is not human peer review or a complete Lean proof of the B-polynomial theorem.

已验证：递推族与归一化、两个评估恒等式及其条件正性、移动端点单调性、条件符号反转、n=2 时全部复根的非正实性、原始有限和 B 的端点评估。

Still missing: the general bridge B=P(t³) under w²+w+1=0, general interlacing and root exhaustion, and closure at exceptional parameters. The full mathematical proof in the parent directory does not imply complete Lean coverage.

详见 [独立 AI 验证报告](AUDIT_REPORT.md) 与 [机器可读结果](validation-independent.json)。53 counts the original theorems; the three independent supplementary boundary checks are recorded separately.

Lean 4.19.0 and mathlib are pinned by the supplied lock files. On Windows, run `scripts/verify.ps1 -Toolchain <installed-Lean-root> -Packages <existing-packages-directory>` and pass the same arguments to `scripts/check.ps1` for `IndependentAudit.lean` and `ReviewChecks.lean`. Paths are supplied by the reader; no author's local paths are required. The scripts preserve the verified compiler flags. A clean `lake build` was not independently tested.

The source was independently rebuilt against an existing dependency cache. Filesystem permissions prevented verification of the complete mathlib checkout's git metadata; file hashes do not certify that checkout's identity or cleanliness. The cache and third-party source are not redistributed.
