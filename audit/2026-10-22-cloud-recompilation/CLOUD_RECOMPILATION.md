# Published phase-1 Lean snapshot: cloud source recompilation

Audit date: 2026-10-22. Result: **PASS_PARTIAL_ONLY**.

This AI-assisted audit independently recompiled the unchanged published phase-1 snapshot on Linux. It rechecks the same **53 theorems and 12 definitions**; it adds no new mathematical coverage and is not human peer review or a complete formalization of the B-polynomial theorem.

## Inputs and reproducibility

The inspected source is commit `bdf93b3006ba8aa5b97290163de169a6376dc31a` of [the public repository](https://github.com/Aurantium-47/zudilin-b-polynomial-real-rootedness/tree/bdf93b3006ba8aa5b97290163de169a6376dc31a/partial-formalization). All seven Lean source files used in this audit are byte-identical to that snapshot.

The compiler is the official Linux x86-64 Lean **4.19.0** release, commit `6caaee842e94`; Lake is **5.0.0-6caaee8**. Mathlib is pinned to `c44e0c8ee63ca166450922a373c7409c5d26b00b`. All nine dependency Git HEADs were checked against the published lockfile, and their tracked source files were unchanged. Exact revisions, URLs, input hashes, and the compiler archive hash appear in `cloud-source-manifest.json`.

The required third-party import closure was rebuilt from pinned sources, rather than taken from a previously inaccessible binary dependency cache. Lean core and Std were supplied by the official compiler distribution. ProofWidgets' JavaScript prerequisites were built from its pinned source and npm lock using the recorded commands. This is not a rebuild of every Mathlib module or validation by a different Lean kernel implementation.

## Results

All seven checks exited with code 0:

1. `Zudilin/Basic.lean`
2. `Zudilin/BaseCase.lean`
3. `Zudilin/OriginalSum.lean`
4. `Zudilin.lean`
5. `AxiomAudit.lean`
6. `IndependentAudit.lean`
7. `ReviewChecks.lean`

The original audit prints axioms for all 53 theorems. The independent audit checks the types and axioms of 65 declarations, comprising those theorems and 12 definitions. The three already-published supplementary boundary checks also pass; they are not added to the original theorem count.

Every audited declaration uses only `propext`, `Classical.choice`, and `Quot.sound`. No `sorryAx` or additional axiom appears. The 53 original axiom-output lines exactly match the published earlier audit after normalizing text encoding and line endings. This establishes agreement of the declaration audits, not byte-for-byte equality of platform-specific compiled artifacts.

Normalized logs are in `logs/`; the machine-readable summary is `cloud-validation.json`. `scripts/check.sh` reruns the seven project checks using an installed matching toolchain and compiled pinned dependencies. It preserves the compiler flags used here. The recorded procedure was direct module compilation; a clean `lake build` is not claimed.

## What remains unproved

This recompile does not close the known mathematical formalization gaps:

- The general bridge between the original finite sum B and the recurrence family P, under `w² + w + 1 = 0`.
- General-degree interlacing, root location, and exhaustion of all complex roots.
- The needed general exceptional-parameter and closure arguments.

The first batch proves the recurrence/normalization and endpoint identities, conditional sign facts, and the complete nonpositive-real-root statement for the **n = 2 recurrence member**, among the explicitly stated results. It does not prove the full general B-polynomial real-rootedness theorem. This report supersedes the earlier audit's uncertainty about dependency checkout identity for this new run only; it does not change or expand the source theorem statements.
