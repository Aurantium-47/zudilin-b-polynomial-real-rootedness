#!/usr/bin/env python3
"""Exact checks for the full-real-parameter Zudilin B-polynomial proof.
Run: python verify_zudilin.py [--extended]
Requires SymPy. No network access or external data is used.
"""
import argparse
import sympy as s

if not __debug__:
    raise RuntimeError("Run verification without Python -O; assertions must be enabled.")

x, a = s.symbols('x a')

def q(n, a):
    return 2*n*n + 3*n*(a+1) + a*a + 3*a + 1

def polys_scaled(alpha, count):
    """C_n=(n!)^2 P_n, 0 <= n <= count, as exact Poly objects."""
    C = [s.Poly(1, x), s.Poly(alpha*alpha, x)]
    for n in range(count-1):
        C.append(q(n, alpha)*C[-1]
                 + s.Poly((n+1)*(x-(n+alpha)**3), x)*C[-2])
    return C[:count+1]

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--extended', action='store_true')
    args = parser.parse_args()

    C = polys_scaled(a, 11)
    # Independently build P from the original recurrence.
    P = [s.Integer(1), a*a]
    for n in range(10):
        P.append(s.expand(((n+1)*q(n,a)*P[-1]
                 +(x-(n+a)**3)*P[-2])/((n+2)**2*(n+1))))
    for n in range(1,12):
        f = C[n].as_expr()
        assert s.expand(f-s.factorial(n)**2*P[n]) == 0
        assert s.expand(f.subs(x,0)-s.rf(a,n)**2) == 0
        t = a+n-1
        assert s.expand(f.subs(x,t**3)
                       -s.prod(k*k-k*t+t*t for k in range(n))) == 0
        assert s.expand(f.subs(x,-a**3)
                       -s.prod(k*k+k*a+a*a for k in range(n))) == 0
        m = n//2
        lc = C[n].LC()
        expected = (s.factorial2(2*m-1) if n%2==0
                    else s.factorial2(2*m+1)
                         *((a+m)**2+s.Rational(m*(3*m+2),5)))
        assert s.expand(lc-expected) == 0
    print('PASS: original/scaled recurrences, endpoints, and leading coefficients, n=1..11')

    for alpha in [s.Rational(-9,4),s.Rational(-49,4),s.Rational(-161,4)]:
        C = polys_scaled(alpha,21)
        for n in range(2,22):
            endpoint = min(0,(alpha+n-1)**3)
            assert C[n].eval(endpoint) > 0
            assert C[n].count_roots(-s.oo,endpoint) == C[n].degree()
        print(f'PASS: all roots below moving endpoint, a={alpha}, n=2..21')

    if args.extended:
        tests = 0
        ns = [5,10,15,20,25,30,35,40,43]
        for p in range(-161,1,2):
            alpha = s.Rational(p,4)
            C = polys_scaled(alpha,43)
            for n in ns:
                assert C[n].count_roots(-s.oo,0) == C[n].degree()
                tests += 1
        print(f'PASS: {tests} extended exact root counts')

if __name__ == '__main__':
    main()
