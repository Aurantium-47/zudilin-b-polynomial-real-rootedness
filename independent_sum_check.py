#!/usr/bin/env python3
"""Check the original defining sum and exceptional parameters exactly.
Run: python independent_sum_check.py. Requires SymPy and the sibling verifier.
"""
import sympy as S
import verify_zudilin as V
a,t,x = V.a,S.symbols('t'),V.x
C=V.polys_scaled(a,10)
for n in range(11):
    # Product pairs eliminate omega directly; no recurrence in this construction.
    direct=S.expand(sum(S.prod(j*j-j*t+t*t for j in range(k))*S.rf(a+t,n-k)*S.rf(a-t+k,n-k)*S.binomial(n,k) for k in range(n+1)))
    assert S.expand(direct-C[n].as_expr().subs(x,t**3)) == 0
    print(f'PASS: direct defining sum equals recurrence, n={n}',flush=True)
for alpha in range(-10,6):
    C=V.polys_scaled(S.Integer(alpha),25)
    for n in range(2,26):
        p=C[n]
        assert p.degree()==n//2
        # count_roots counts distinct roots, so also verify square-free part.
        sf=p.sqf_part()
        assert sf.count_roots(-S.oo,0)==sf.degree()
print('PASS: exceptional and integer parameters a=-10..5, n=2..25 (multiplicities handled)',flush=True)
