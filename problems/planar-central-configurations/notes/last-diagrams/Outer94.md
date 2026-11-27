# The outer marked mass in diagram 94

**Chatgpt · 27 November 2026**

**Proposition.** In the six-mass family with five unit masses and a variable mass $t$, suppose the two-body pair of diagram 94 has unit masses, its shared center has unit mass, and $t$ occupies one of the other three quartet vertices. The necessary four-body shape equations and cross-edge torque have no solution over $\overline{\mathbb Q(t)}$. Thus only finitely many complex values of $t$ can support a singular place of this type. The proposition determines no list of exceptional masses. It permits neither an assertion about each fixed positive $t$ nor an exclusion of the other mass placements.

## Projection forced at infinity

Relabel the quartet $0,1,2,3$ with $0$ marked, $3$ its shared center, and masses $(t,1,1,1)$. Use $X_0=1$, $X_3=0$. Tomar’s definition of $KC$ immediately before Lemma 6.16 includes the four $X$-force equations and the three outer $Y$-force equations, and gives $t+X_1+X_2=0$. Lemma 6.17 supplies the signed cross-edge torque. For equal binary masses its coefficients $d_j$ satisfy $d_j^2=\pm 2i$. Put $x=v_1/v_0$ with $v_j=d_jm_j/\sqrt{X_j}$, so $v_2/v_0=-1-x$. Then
$$
 X_1=\frac{\delta_1}{t^2x^2},\qquad
 X_2=\frac{\delta_2}{t^2(1+x)^2},\qquad
 t^3x^2(1+x)^2+\delta_1(1+x)^2+\delta_2x^2=0,
$$
where $\delta_j=d_j^2/d_0^2\in\{1,-1\}$. At infinity its roots tend to $0$ or $-1$: after dividing by $t^3$ this is a monic quartic over the local valuation ring with reduction $x^2(1+x)^2$. Exchange the two equal masses if necessary so that $x\to0$. Write $\nu(t)=-1$, $s=t^{-1/2}$, and $\delta=\delta_2$. Then
$$
 X_1\sim-t,\qquad X_2\sim\delta t^{-2},\qquad
 X_2=\frac{\delta s^4}{(1+x)^2},\qquad
 x=\frac{\lambda s^3}{\sqrt{1+s^2 X_2}},\qquad
 \lambda^2=-\delta_1.
$$
The square root in this last expression has constant term one. These relations determine a unique power series for each $(\delta,\lambda)$ by formal substitution. [Tomar, §§6.7 and 10](https://hexagonmath.org/pdf/2611.00377v1)

## Three possibilities for the second projection

Write $x_{ij}=X_i-X_j$, $y_{ij}=Y_i-Y_j$, $p_{ij}^2 x_{ij}y_{ij}=1$. All six differences in either projection and all six inverse distances are nonzero. Set $a_{ij}=\nu(x_{ij})$, $b_{ij}=\nu(y_{ij})$, $w_i=\nu(m_i)$. The six $a_{ij}$ are $(-1,0,0,-1,-1,2)$ in lexicographic edge order $01,02,03,12,13,23$.

Use the four additive triangle equations $y_{ij}-y_{ik}+y_{jk}=0$, the four $X$-force equations, and the three differences of the outer $Y$-force equations. An $X$-force from $j$ has doubled order $2w_j-a_{ij}-3b_{ij}$, and a $Y$-force from $j$ has doubled order $2w_j-3a_{ij}-b_{ij}$. In the difference of the $i,j$ outer $Y$ equations the single force on edge $ij$ has coefficient $m_i+m_j$. Each equation requires its minimum term order to occur at least twice. These eleven conditions in rational linear arithmetic force the following three vectors.

| Case | $b_{01}$ | $b_{02}$ | $b_{03}$ | $b_{12}$ | $b_{13}$ | $b_{23}$ |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| A | 0 | −2 | 0 | −2 | 1 | −2 |
| B | 1/3 | −2 | −2 | −2 | −2 | −2 |
| C | 0 | 0 | −4 | 1 | −4 | −4 |

The replay encodes the eleven conditions, excludes the three displayed vectors and gets **unsatisfiable** over the real numbers. This tests unbounded and fractional valuations together. For each listed vector let $P_{ij}$ denote the nonzero leading coefficient of $p_{ij}$. The distance equation gives $\mathrm{lc}(y_{ij})=1/(\mathrm{lc}(x_{ij})P_{ij}^2)$. Retain the least-order terms in the same eleven equations and clear denominators. The replay computes their Gröbner basis over $\mathbb Q$ with a variable enforcing $\prod P_{ij}\ne0$. The basis is $[1]$ for both signs of $\delta$ in A and B and for $\delta=-1$ in C.

For C with $\delta=1$ the leading assignments in edge order are
$$
(P_{01},P_{02},P_{03},P_{12},P_{13},P_{23})=
(\epsilon A,A,-A,B,\eta A,A),
\qquad A^3=B^3=1,\quad \epsilon^2=1,\quad\eta^2=-1.
$$
Indeed, the $X_0,X_1$ forces give $P_{02}^3=P_{12}^3=1$ and the outer $Y$ difference $02$ gives $P_{23}=P_{02}$. Triangles $012,023,013$ give $P_{01}^2=P_{02}^2$, $P_{03}^2=P_{23}^2$, $P_{13}^2=-P_{03}^2$. The $X_3$ force fixes $P_{03}=-P_{23}$. These steps give exactly 36 initial assignments; the replay checks every initial residual at each assignment.

## The shared-center force at higher order

Use $s$ as uniformizing parameter in the coefficients. In case C write $p_{ij}=s^{k_{ij}}u_{ij}$ in lexicographic edge order, where
$$
(k_{ij})=(1,0,4,0,5,2).
$$
Use all changes as exact equations: set $D_{ij}=s^{-2a_{ij}}x_{ij}$ and $y_{ij}=s^{2b_{ij}}/(D_{ij}u_{ij}^2)$. Divide each force or additive relation by its least common power of $s$. Every resulting equation is regular at $s=0$ and the relevant denominators are units. Solve six equations consisting of triangles $012,013,023$, the forces $X_0,X_1$, and the $02$ outer $Y$-force difference. At each assignment their Jacobian in the six $u$'s is invertible. This follows successively from the powers, squares and linear equations in the previous paragraph, or from exact modular row operations in the replay. Thus the formal implicit function theorem determines a single lift in ordinary powers of $s$, even if the original solution was sought in a further Puiseux extension.

For each of the 36 assignments and each of the four $\lambda\in\{1,-1,i,-i\}$, the replay evaluates the normalized equations through order eight. At each order it divides by the same shape Jacobian, substitutes the recovered coefficients, and checks the six residuals. In the unused $X_3$ equation it detects the following failures.

| Prime | First nonzero coefficient at $s^3$ | First nonzero coefficient at $s^8$ |
| --- | ---: | ---: |
| 97 | 108 | 36 |
| 193 | 108 | 36 |

These are first nonzero orders in the indicated residue fields. For instance, at 97 the $s^8$ coefficient is 50 in each of those 36 cases. The initial constants belong to $\mathbb Q(\zeta_{12})$, each prime splits there, and the replay includes the reductions of all cube and fourth roots of unity. The Jacobians, leading differences and radical-expansion denominators used through order eight are invertible modulo each prime. Consequently the Taylor recurrence reduces coefficientwise. A nonzero residue proves that the corresponding characteristic-zero coefficient is nonzero. Either prime suffices.

Any solution over $\overline{\mathbb Q(t)}$ has a Puiseux expansion at a place over $t=\infty$ after extending constants. The preceding exhaustive argument rules out every such expansion, including those where original inverse distances or coordinates escape to infinity. Finally, the projection to the mass line of the algebraic necessary equations, with their nonvanishings imposed, is constructible. An infinite constructible subset of the line contains a nonempty open subset and has a nonempty generic fibre. The exceptional set is therefore finite.

Run `python outer94.py` with SymPy and either a Z3 executable or the Z3 shared library. Both `outer94.py` and `lift.py` are required. To export the rational linear query, use `python outer94.py --emit-smt outer94.smt2`.
