# A moving-endpoint proof of real-rootedness for Zudilin's B-polynomials

**Author: Aurantium.** Version dated 22 October 2026. This ordinary mathematical proof covers every real parameter and passed a separate AI mathematical audit. It is not a proof-assistant certification, independent human peer review, or a claim of publication priority. See [independent_review.md](independent_review.md) and [literature_status.md](literature_status.md).

## 1. Original problem and notation

Let $\omega=e^{2\pi i/3}$, and let $(z)_k=z(z+1)\cdots(z+k-1)$, with $(z)_0=1$. Zudilin's original polynomials are

$$
 B_n^a(t)=\frac1{n!}\sum_{k=0}^n
 \frac{(\omega t)_k(\omega^2t)_k(a+t)_{n-k}(a-t+k)_{n-k}}
 {k!(n-k)!}.
 \tag{1}
$$

They depend on $t$ only through $x=t^3$. To avoid confusing zeros in $t$ with zeros in $x$, write

$$
 P_n^a(t^3)=B_n^a(t).
$$

The defining recurrence, equivalently the recurrence satisfied by (1), is

$$
 P_{n+2}^a(x)=A_n(a)P_{n+1}^a(x)
       +D_n\bigl(x-(n+a)^3\bigr)P_n^a(x),\qquad n\ge0,
 \tag{2}
$$
where
$$
 A_n(a)=\frac{2n^2+3n(a+1)+a^2+3a+1}{(n+2)^2},
 \qquad D_n=\frac1{(n+2)^2(n+1)}>0,
$$
and $P_0^a=1$, $P_1^a=a^2$.

Sources:

1. Wadim Zudilin, *On a family of polynomials related to ζ(2,1)=ζ(3)*, dated 24 April 2015, revised 31 March 2017, arXiv:1504.07696v2, Section 4, equation (8), Lemmas 3–4, and its final paragraph. [Original paper](https://arxiv.org/html/1504.07696v2#S4).
2. H. S. Cohl (ed.), *Report from the Open Problems Session at OPSFA13*, SIGMA 12 (2016), 071, Section 7, pp. 10–11. [Published open-problem report](https://sigma-journal.com/2016/071/sigma16-071.pdf#page=10).

The precise real-root assertion established below is: for every real $a$ and $n\ge2$, every zero of the nonzero polynomial $P_n^a(x)$ belongs to $( -\infty,0]$. The initial polynomials are constants, except that $P_1^0\equiv0$. That identically zero initial polynomial must be excluded from any literal assertion about its zero set.

The report describes a negative half-line, while the original paper includes its endpoint. The closed half-line is necessary: $P_n^a(0)=0$ for $a\in\{0,-1,\ldots,1-n\}$.

## 2. Two elementary evaluations

Setting $t=0$ in (1), only $k=0$ survives. Thus

$$
 P_n^a(0)=\frac{(a)_n^2}{(n!)^2}.
 \tag{3}
$$

More importantly, put $s=a+n-1$ and $t=s$. For every $k<n$, the factor

$$
 (a-t+k)_{n-k}=(k+1-n)_{n-k}
$$
contains zero. Therefore only $k=n$ survives, and

$$
 P_n^a\bigl((a+n-1)^3\bigr)
 =\frac{(\omega s)_n(\omega^2s)_n}{(n!)^2}
 =\frac1{(n!)^2}\prod_{k=0}^{n-1}(k^2-ks+s^2).
 \tag{4}
$$

For real $s\ne0$, this is strictly positive: $k^2-ks+s^2=(k-s/2)^2+3s^2/4>0$.

For completeness, putting $t=-a$ in (1) kills all $k<n$ via $(a+t)_{n-k}=0$, giving

$$
 P_n^a(-a^3)=\frac1{(n!)^2}\prod_{k=0}^{n-1}(k^2+ka+a^2)>0
 \quad(a\ne0).
 \tag{5}
$$

Consequently $P_n^a$ is not identically zero for any real $a$ and $n\ge2$: use (5) when $a\ne0$, and (4) with $s=n-1\ne0$ when $a=0$.

## 3. The stronger inductive assertion

First fix $a\notin\{0,-1,-2,\ldots\}$. Define the nondecreasing real endpoints

$$
 u_n=\min\{0,(a+n-1)^3\}.
 \tag{6}
$$

Equations (3)–(4) show

$$
 P_n^a(u_n)>0 \qquad(n\ge1).
 \tag{7}
$$

Indeed, if $u_n=0$, none of the factors in $(a)_n$ is zero. Otherwise $a+n-1\ne0$, and (4) applies.

We prove simultaneously that:

- $\deg P_n^a=\lfloor n/2\rfloor$, with positive leading coefficient;
- all its zeros are simple and strictly smaller than $u_n$;
- consecutive polynomials have the following strict interlacing, always with the next polynomial's rightmost zero farther to the right:
  - if $\deg P_n=\deg P_{n+1}=m$, then
    $p_1<q_1<p_2<q_2<\cdots<p_m<q_m$;
  - if $\deg P_n=m$, $\deg P_{n+1}=m+1$, then
    $q_1<p_1<q_2<\cdots<p_m<q_{m+1}$.

Empty root lists have their natural vacuous meaning. The recurrence immediately supplies the upper degree bound $\deg P_n\le\lfloor n/2\rfloor$.

### Base case

$P_1=a^2>0$, and

$$
 P_2(x)=\frac{x+a^2(a+1)^2}{4}.
$$

Its root is $r=-a^2(a+1)^2<0$. Moreover

$$
 r-(a+1)^3=-(a+1)^2(a^2+a+1)<0.
$$

(The excluded parameters include $a=0,-1$.) Thus $r<u_2$, and the pair $(P_1,P_2)$ satisfies the assertion.

### Inductive step

Let $P=P_n$, $Q=P_{n+1}$, and $R=P_{n+2}$, where $n\ge1$, and suppose the assertion holds for $(P,Q)$. Write the zeros of $Q$ as $q_1<\cdots<q_d$. Their strict endpoint bound gives

$$
 q_i<u_{n+1}\le(n+a)^3.
$$

Hence (2), evaluated at $q_i$, gives the crucial sign identity

$$
 \operatorname{sgn}R(q_i)=-\operatorname{sgn}P(q_i).
 \tag{8}
$$

No sign condition on $A_n(a)$ is needed. This is the point that permits arbitrarily negative $a$.

All the $q_i$ are less than $u_{n+2}$, since $u_n$ is nondecreasing. The rightmost $q_d$ lies to the right of every zero of $P$, so $P(q_d)>0$ and

$$
 R(q_d)<0<R(u_{n+2}).
 \tag{9}
$$

Thus a root of $R$ lies strictly in $(q_d,u_{n+2})$.

There are two degree patterns:

**Case I: $\deg P=\deg Q=m$.** Here $\deg R=m+1$, and its leading coefficient is $D_n$ times the positive leading coefficient of $P$. Since the assumed order is $p_1<q_1<\cdots<p_m<q_m$,
$$
 \operatorname{sgn}R(q_i)=(-1)^{m-i+1}.
$$
These signs supply a root in each $(q_i,q_{i+1})$. Also the sign at $-\infty$ is $(-1)^{m+1}$, opposite to the sign $(-1)^m$ at $q_1$, so a further root lies left of $q_1$. Together with (9), these are $m+1$ roots in disjoint intervals. They exhaust the degree, are simple, lie below $u_{n+2}$, and satisfy
$$
 r_1<q_1<r_2<\cdots<q_m<r_{m+1}.
$$

**Case II: $\deg P=m$, $\deg Q=m+1$.** Now $\deg R\le m+1$. The assumed order is $q_1<p_1<\cdots<p_m<q_{m+1}$, and (8) yields alternating nonzero signs at the $m+1$ points $q_i$. Hence there are $m$ roots in the intervals $(q_i,q_{i+1})$. Equation (9) supplies one more root in $(q_{m+1},u_{n+2})$. These $m+1$ roots force the degree to be exactly $m+1$, exhaust it, and are simple. Their order is
$$
 q_1<r_1<q_2<\cdots<q_{m+1}<r_{m+1}.
$$
Since $R(u_{n+2})>0$ and every zero is less than $u_{n+2}$, its leading coefficient is positive as well.

Both cases prove the assertion for $(Q,R)$. This completes the induction.

In particular, for every nonexceptional real $a$, all zeros of every $P_n^a$, $n\ge2$, are real and strictly negative.

## 4. Exceptional real parameters

Fix $a_0\in\{0,-1,-2,\ldots\}$ and $n\ge2$. Choose nonexceptional real $a_j\to a_0$. The recurrence shows that the coefficients of $P_n^a$ are polynomials in $a$, so $P_n^{a_j}\to P_n^{a_0}$ coefficientwise and locally uniformly.

Every polynomial in this sequence has all its zeros in the closed set $( -\infty,0]$. A nonzero coefficientwise limit of polynomials of bounded degree with this property has the same property. For example, if the limit had a zero outside this closed set, a small disk around that zero disjoint from the set would, by Rouché's theorem, contain a zero of every sufficiently close polynomial, a contradiction. The limit is nonzero by (4)–(5).

Therefore every zero of $P_n^{a_0}$ lies in $( -\infty,0]$. This proves the real-root assertion for all real parameters. □

## 5. Optional explicit degree check and further bound

The proof did not need an explicit leading-coefficient calculation. One is nevertheless useful as an independent check. For $C_n=(n!)^2P_n$,

$$
 [x^m]C_{2m}=(2m-1)!!,
$$
$$
 [x^m]C_{2m+1}=(2m+1)!!
 \left((a+m)^2+\frac{m(3m+2)}5\right).
 \tag{10}
$$

For $m\ge1$, both are positive for every real $a$. To verify (10), scaling (2) gives
$$
 C_{n+2}=
 \bigl(2n^2+3n(a+1)+a^2+3a+1\bigr)C_{n+1}
 +(n+1)\bigl(x-(n+a)^3\bigr)C_n.
$$
The even leading coefficients follow immediately. Writing $O_m=[x^m]C_{2m+1}$, the odd ones obey
$$
 O_m=(a^2+6ma+8m^2-2m)(2m-1)!!+2mO_{m-1},
 \qquad O_0=a^2,
$$
which (10) satisfies by substitution. Thus the degree does not drop at exceptional parameters either.

The original reflection identity $P_n^a=P_n^{1-n-a}$, together with the proved moving endpoint bound, also gives the optional stronger bound
$$
 r\le\min\{0,(a+n-1)^3,-a^3\}
$$
for every zero $r$ and every real $a$. The proof's strict versions apply away from the relevant exceptional parameters.

## 6. Exact computational verification

The accompanying `verify_zudilin.py` uses rational arithmetic and SymPy's exact polynomial root counting, not floating-point root finding. It:

1. checks (3)–(5) and (10) symbolically for $1\le n\le11$;
2. checks equality of the original recurrence and its factorial-scaled form;
3. certifies the moving-endpoint root bound for $a=-9/4,-49/4,-161/4$, $2\le n\le21$;
4. with `--extended`, performs 729 exact negative-root counts: all 81 parameters $a=p/4$, with odd $p=-161,-159,\ldots,-1$, and degrees indexed by $n=5,10,15,20,25,30,35,40,43$.

The symbolic identities and small tests were executed successfully. The full 729-test grid was also executed successfully on 22 October 2026. These checks support auditing and are not substitutes for the proof.
