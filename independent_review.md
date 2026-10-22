# Independent AI mathematical review

Date: 22 October 2026.

This is a publication-edited report of a separate AI audit of the proof and exact checks. It is not independent human peer review or Lean/proof-assistant certification. The mathematical findings are preserved; editorial workflow details are omitted.

## Verdict

**Audit verdict: ACCEPT** the ordinary mathematical proof in `full_range_proof.md` for the following precise claim:

For every real parameter a and every integer n >= 2, the nonzero polynomial P_n^a defined by P_n^a(t^3) = B_n^a(t) has all its complex zeros on the real interval (-infinity, 0]. Its degree is floor(n/2). For a outside {0,-1,-2,...}, the stated simple-root and strict-interlacing conclusions also follow.

The initial cases are correctly separated: P_0^a = 1; P_1^a = a^2 is a nonzero constant unless a=0; P_1^0 is the zero polynomial. An unqualified assertion about every zero of that zero polynomial would be false. This review accepts the corrected, intended nonzero-polynomial statement, not that literal degenerate assertion.

No substantive mathematical gap or counterexample was found. This is a separate AI mathematical audit plus exact finite computation, not a proof-assistant certification or a determination of publication priority.

## Source verification

Independently fetched [Zudilin's arXiv v2 paper](https://arxiv.org/html/1504.07696v2#S4). The defining finite sum is equation (8), the recurrence and initial conditions are Lemma 3, and reflection is Lemma 4. The last paragraph of Section 4 expressly concerns real alpha and zeros in the variable x=t^3, including the endpoint zero. All of these match the submitted proof. Nonreal zeros of B_n^a viewed as a polynomial in t do not contradict the claim.

[The arXiv record](https://arxiv.org/abs/1504.07696) gives first submission on 29 April 2015 and v2 on 31 March 2017; the manuscript itself is dated 24 April 2015. [Springer's primary publication page](https://link.springer.com/chapter/10.1007/978-3-030-37031-2_22) gives first online publication on 14 March 2020, pages 621–630. The latter is not the date the problem first appeared.

[OPSFA13 report, Section 7, pages 10–11](https://sigma-journal.com/2016/071/sigma16-071.pdf#page=10) reproduces this family and recurrence and records the experimental negative-root observation. It also discusses different A-polynomials and their partial sums. The submitted B-polynomial proof does not settle those other questions, orthogonality, or a limiting zero distribution.

## Mathematical audit

1. The recurrence is rearranged correctly. Its coefficient multiplying P_n is D_n times (x-(n+a)^3), with D_n positive. Its upper degree bound is floor(n/2).
2. Each endpoint evaluation follows directly from the finite defining sum, without applying a hypergeometric expression at a singular parameter. At t=a+n-1, the last entry in every nonterminal rising factorial (a-t+k)_(n-k) is zero. At t=-a, (a+t)_(n-k) vanishes for k<n. The surviving products are correct.
3. The product factors k^2-ks+s^2 are strictly positive for real s != 0. The zero-endpoint evaluation is positive when a is not a nonpositive integer. Thus P_n(u_n)>0 is justified for the entire nonexceptional real range, not only positive a.
4. The base root is -a^2(a+1)^2. Subtracting (a+1)^3 yields -(a+1)^2(a^2+a+1)<0 for the admitted parameters. This proves the required strict endpoint inequality.
5. The endpoint sequence is nondecreasing because the real cubic function is increasing. Every zero q_i of P_(n+1) lies strictly below (n+a)^3. Consequently evaluating the recurrence there reverses the sign of P_n. No assumption on the sign of A_n(a) is needed.
6. The two interlacing patterns have the correct parity and signs. In the equal-degree case, the leading coefficient of the new polynomial is forced positive and its sign at negative infinity supplies the leftmost root. In the unequal-degree case, the m interior intervals plus the rightmost interval force degree m+1. The latter argument includes the m=0 initial induction step. In both cases the number of disjoint sign-changing intervals exhausts the degree, which proves simplicity and excludes further real or complex roots.
7. Positivity at the new right endpoint fixes the leading coefficient in the unequal-degree case. There is no circular appeal to its sign before it is proved.
8. At nonpositive integer parameters, coefficients converge polynomially in a and degrees are uniformly bounded. A nonzero limit cannot acquire a root outside the closed negative ray: a disk disjoint from the ray, with zero-free boundary for the limiting polynomial, contradicts Rouche's theorem. Nonzeroness is established separately by the endpoint products. Degree loss is not needed to be ruled out for this argument.
9. The optional explicit leading coefficients satisfy the derived recurrence and are strictly positive for n>=2, so degree does not in fact drop. Reflection gives the optional bound min(0,(a+n-1)^3,-a^3); continuity extends it to exceptional parameters.

## Computation actually reproduced

- Independently ran the supplied script with `--extended`: all symbolic tests, three moving-endpoint grids, and all 729 extended exact root counts passed; exit code 0.
- Wrote a separate direct-sum check, eliminating omega by the factor product of j^2-j*t+t^2. This builds the original defining finite sum, not another recurrence. Its symbolic equality with the recurrence passed for n=0..10.
- Added exact checks at all integer a=-10..5 for n=2..25. Degree and negative-ray location passed. Square-free parts were used so that repeated-root counting conventions cannot obscure these checks.

Supporting files: `logs/extended.txt`, `independent_sum_check.py`, and `logs/direct_sum_integer.txt`.

The default and extended runs are recorded separately. These finite computations are corroboration, not the universal proof. The packaged scripts were rerun after portability edits; see [REPRODUCIBILITY.md](REPRODUCIBILITY.md).

## Later literature and novelty limits

A targeted independent search using the exact title, arXiv identifier, real-rootedness, interlacing, zeros and negative-half-line terms did not locate a subsequent proof or disproof. This is a bounded search and cannot certify novelty or current open status.

[Zudilin's June 2015 lecture slides, slide 13](https://carmamaths.org/meetings/mathsandcomputation/pdfs/mathscomp2015-zudilin.pdf#page=13) independently corroborate the all-real-alpha formulation and its 2015 origin.

Long, Dai, Li and Wang, [Asymptotics of orthogonal polynomials with asymptotic Freud-like weights](https://userweb.ucs.louisiana.edu/~xxw6637/papers/SAPM2020.pdf), DOI 10.1111/sapm.12291, explicitly recalls the B-polynomials and expresses them through continuous dual Hahn polynomials. Its subsequent orthogonality and asymptotics use a different fixed-parameter setup. In the displayed identifications of B_n^a, the dual-Hahn parameters depend on t and/or n. Their fixed-parameter zero theorems therefore do not automatically prove this B-family claim. No all-real-a B-family root-location theorem was identified in that paper.

The proof passed this separate AI audit. No earlier resolution was found in the sources checked, but neither full machine verification nor established novelty is claimed.
