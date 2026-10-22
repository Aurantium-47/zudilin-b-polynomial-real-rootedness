# Reproducibility and verification scope

## Environment

The packaged scripts were executed with Python 3.12.14 and SymPy 1.14.0 on 22 October 2026. Python 3.10 or newer is recommended. `requirements.txt` records the tested external dependency. No network, account, third-party data file, or original paper download is needed to run the checks. All calculations use exact symbolic expressions or rational arithmetic, not floating-point root approximations.

Run from the repository root with dependencies already available. Do not use `python -O`, which disables assertions; the scripts reject that mode.

```sh
python verify_zudilin.py
python verify_zudilin.py --extended
python independent_sum_check.py
```

## Exactly what is checked

1. `verify_zudilin.py` compares the original and factorial-scaled recurrences, verifies the three endpoint evaluations, and verifies the explicit leading-coefficient formula symbolically for n=1,...,11. It also checks the moving-endpoint root count for a=-9/4,-49/4,-161/4 and n=2,...,21, totaling 60 rational instances.
2. With `--extended`, it additionally checks all 81 parameters a=p/4, for odd p=-161,-159,...,-1, at n=5,10,15,20,25,30,35,40,43: exactly 729 negative-ray root counts.
3. `independent_sum_check.py` constructs the original defining sum directly, eliminating the complex cube roots of unity by products of j^2-j*t+t^2. It compares this independent construction to the recurrence for n=0,...,10. It also verifies degree and negative-ray location at each integer a=-10,...,5 and n=2,...,25: 384 instances. It counts the roots of the square-free part, so multiplicities are handled explicitly.

All three packaged commands completed successfully. Their stdout is stored in `logs/default.txt`, `logs/extended.txt`, and `logs/direct_sum_integer.txt`. The supplied proof had already passed a separate AI audit, including an earlier complete extended run. For this release the unused timing code was removed and the direct-sum script's import made portable; the mathematical assertions were retained and the packaged scripts rerun. The logs here are from those release runs, not a claim that the editorial rerun itself was an independent human review.

## What the computation does not establish

Finite checks do not prove the universal statement for all n and all real a. The written proof supplies the interlacing induction, nonzero-limit argument, and full parameter coverage. The audit is an AI review, not independent human peer review. A separately documented partial Lean source companion is included in `partial-formalization/`; it is independently recompiled and audited only in that directory’s stated scope, not the full theorem.

## File integrity

```sh
python check_package.py
```

`PUBLIC_FILES.txt` lists the exact release file set, including the manifest itself. `SHA256SUMS.json` records SHA-256 hashes and byte sizes of every other listed file. Its own hash is necessarily excluded to avoid self-reference. The checker verifies those entries and detects missing files; hashes show file identity, not mathematical correctness or authorship. No third-party full-text papers, caches, or exploratory scripts belong to the release list.
