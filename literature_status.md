# Literature status and claim boundaries

Status date: 22 October 2026. References and direct source links are collected in [REFERENCES.md](REFERENCES.md).

## Identity and chronology

The target is Zudilin's unnumbered all-real-parameter observation at the end of Section 4 of arXiv:1504.07696v2, not a newly named numbered conjecture. Its first arXiv submission was 29 April 2015; the manuscript is dated 24 April 2015. The OPSFA13 session of 4 June 2015 and its SIGMA 2016 report provide a separate established open-problem source. The Springer chapter appeared in 2020. These dates describe distinct stages of the same source history.

The source studies zeros in x=t^3. The intended theorem must separate the identically zero initial polynomial B_1^0. For n>=2, the present proof establishes nonzeroness, degree floor(n/2), and the negative-ray assertion for all real a. It does not exploit the degenerate initial case as a disproof. The original question already allowed all real parameters; the added conclusions here are strict interlacing and sharper root bounds, not an expansion of the original parameter range.

## Prior mathematical scope

Zudilin established the finite-sum representation, three-term recurrence, reflection identity, and other algebraic structure, and reported the experimental zero-location observation. The OPSFA13 report also discusses distinct A-polynomials and partial sums, which this project does not settle.

Long, Dai, Li, and Wang, in Studies in Applied Mathematics 144 (2020), 133–163 (online 6 December 2019), relate B-polynomials to continuous dual Hahn polynomials. In their displayed identifications, the dual-Hahn parameters depend on t and/or n. Their subsequent orthogonality and asymptotics in a fixed-parameter setup therefore do not directly yield the B-family theorem proved here. The inspected paper did not supply an all-real-a B-family zero-location theorem.

Koelink, Román, and Zudilin's 2024 partial-sum paper concerns another family. Its Conjecture 3.4 is not the 2015 observation and must not be used to relabel this result.

## Search result and uncertainty

Targeted searches checked the original title, arXiv identifier, Zudilin with real-rootedness, zeros and interlacing, B-polynomial and negative-half-line terms, and later-work references. No earlier proof or disproof of the exact B-family assertion was located in the sources examined. This is a bounded literature search, not proof of novelty, priority, or absence of an unindexed resolution. A fuller citation audit or specialist review could change the attribution assessment without changing the mathematical statement.

The proof passed a separate AI audit and exact finite checks. Neither that review nor the literature search is independent human peer review. This release does not include or claim a completed Lean formalization. No orthogonality theorem for this B-family, limiting zero distribution, or resolution of the separate A-family problems is claimed.
