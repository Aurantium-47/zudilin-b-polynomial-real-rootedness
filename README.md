# Zudilin's B-polynomial real-rootedness

**Author: Aurantium.** [中文](README.zh.md) · [Proof](full_range_proof.md) · [Sources](REFERENCES.md) · [Verification](REPRODUCIBILITY.md)

For every real parameter $a$ and integer $n\ge2$, the nonzero polynomial defined by $P_n^a(t^3)=B_n^a(t)$ has degree $\lfloor n/2\rfloor$ and all zeros in $(-\infty,0]$. The theorem concerns the variable $x=t^3$, not the zeros in the original variable $t$.

## Origin and previous work

Wadim Zudilin stated the all-real-parameter root-location observation in Section 4 of *On a family of polynomials related to ζ(2,1)=ζ(3)*, first submitted to arXiv on **29 April 2015**. The manuscript is dated 24 April 2015; v2 is dated 31 March 2017. The work later appeared in **Periods in Quantum Field Theory and Arithmetic**, Springer Proceedings in Mathematics & Statistics **314 (2020), 621–630**. The problem also appears in Section 7 of H. S. Cohl's **OPSFA13 open-problem report, SIGMA 12 (2016), 071**.

Zudilin supplied the defining finite sum, recurrence, reflection identity, and experimental zero-location observation. Wen-Gao Long, Dan Dai, Yu-Tian Li, and Xiang-Sheng Wang subsequently connected the family to continuous dual Hahn polynomials and studied asymptotics in a different parameter setting in **Studies in Applied Mathematics 144 (2020), 133–163**. That work does not directly give the all-real-$a$ assertion addressed here. See the [literature audit](literature_status.md) for the precise distinction and links.

## Result and additional conclusions

The [proof](full_range_proof.md) gives a moving-endpoint interlacing induction for every nonexceptional real parameter, then passes to nonpositive integers by continuity. It establishes the full parameter range already present in the original question, not an enlargement from an originally positive-only conjecture.

- If $a\notin\{0,-1,-2,\ldots\}$, roots are simple, strictly negative, and consecutive polynomials strictly interlace in the stated parity-dependent order.
- Every root $r$, for every real $a$, satisfies $r\le\min\{0,(a+n-1)^3,-a^3\}$.
- The zero polynomial $B_1^0=0$ is explicitly excluded. The other $n=0,1$ cases are nonzero constants. Repeated roots and zero roots are allowed at exceptional parameters.

This does not settle the separate A-polynomial partial-sum problems, establish orthogonality of this B-family, or determine its limiting zero distribution.

## Validation and reproduction

The ordinary proof passed a [separate AI mathematical audit](independent_review.md). Exact SymPy checks cover identities, the defining sum, exceptional parameters, and 729 extended root counts. These finite checks support the proof; they do not prove its universal quantifiers. **No independent human peer review or full Lean/proof-assistant certification is claimed.** No earlier resolution was located in the bounded literature search, but novelty and worldwide priority are not certified.

Use Python 3.10 or newer with the version in `requirements.txt`, without `-O`:

```sh
python verify_zudilin.py
python verify_zudilin.py --extended
python independent_sum_check.py
python check_package.py
```

The first three commands check mathematics; the last checks file integrity only. [REPRODUCIBILITY.md](REPRODUCIBILITY.md) defines the test coverage and logs. [PUBLIC_FILES.txt](PUBLIC_FILES.txt) lists every release file; [SHA256SUMS.json](SHA256SUMS.json) records hashes and byte sizes. The manuscript and code were prepared with AI assistance. Attribution and reuse status are in [RIGHTS.md](RIGHTS.md).

## Independently checked partial Lean companion

The [partial formalization](partial-formalization/README.md) contains the frozen first batch: 53 theorems and 12 definitions independently recompiled and axiom-audited, using only the three standard axioms. It does not prove the full theorem: B=P(t³), general interlacing and exceptional-parameter closure remain missing. See the [precise independent AI audit](partial-formalization/AUDIT_REPORT.md). No human peer review or full Lean certification is claimed.

A [fresh Linux cloud-source recompilation](audit/2026-10-22-cloud-recompilation/CLOUD_RECOMPILATION.md), dated 22 October 2026, independently passes the same 53-theorem/12-definition snapshot with exact dependency pins and normalized logs. This is additional reproducibility evidence, not new theorem coverage or a completed formalization.
