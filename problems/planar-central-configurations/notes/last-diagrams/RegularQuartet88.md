# The regular four-body fibre over the algebraic closure of the test field

**Chatgpt · 27 November 2026**

Work over $K=\overline{\mathbb F}_{65521}$, with quartet masses $(2,1,1,1)$. Assume nonzero squared pair distances, nonzero force multiplier, rank-one stress with four nonzero entries in its image generator, and four nonzero high coordinates for the cross torque. No such quartet satisfies both the isolated force equations and the equal-binary torque of diagram 88. The calculation below treats all signs, including those whose leading geometric configuration has no real form. The [verifier](RegularQuartet88.py) and its [rational parametrizations](RegularQuartet88.json) give an exact finite-field calculation.

## Shape equations

Put the marked point at the origin, and use the complex bilinear squared norm in the residue field. With nonzero force multiplier the common offset in the rank-one equation is $\lambda/(t+3)$. Multiply all inverse distances by a common scalar and divide the coordinates by the same scalar to normalize this offset to one. Write $b_i$ for the resulting inverse distances from the marked point to the three outer points, $\alpha_i=b_i^3-1$, and $T=\sum_i\alpha_i$. The [stress identities](QuartetChart.md) now give
$$
\sum_i\alpha_i Q_i=0,\qquad p_{ij}^3=1-2\alpha_i\alpha_j/T .
$$
Here $T$ and all $b_i,\alpha_i$ are nonzero. Choose a nonzero $B$ and write $u_i=b_i/B$, $s=B^3$. In the additional coordinate scale $BQ_i$, the star squared lengths are $R_i=u_i^{-2}$ and the outer squared edge lengths are
$$
 D_{ij}=\frac{(\alpha_i+\alpha_j)(\alpha_iR_i+\alpha_jR_j)-\alpha_k^2R_k}{\alpha_i\alpha_j}.
$$
The original inverse cubes imply $(T-2\alpha_i\alpha_j)^2D_{ij}^3=T^2s^2$. With $g=u_1u_2u_3$ define
$$
 N_{ij}=(\alpha_i+\alpha_j)(\alpha_i u_j^2+\alpha_j u_i^2)u_k^2-\alpha_k^2 u_i^2u_j^2 .
$$
The three distance equations are then
$$
 (T-2\alpha_i\alpha_j)^2 N_{ij}^{3} - T^2s^2(g^2\alpha_i\alpha_j)^3=0 .
$$
Only their necessity is used.

If $B=b_1+b_2+b_3$ is nonzero and the $b_i$ are distinct, then $\sum_i u_i=1$. Put $f=\sum_{i<j}u_i u_j$. The roots of $Q(z)=z^3-z^2+fz-g$ are the three $u_i$. For a root $z=u_k$, let $U=1-z$, $V=z^2-z+f$, $C=sz^3-1$, $T=s(1-3f+3g)-3$. The other two ratios have sum $U$ and product $V$. Consequently for the opposite edge,
$$
 J=\alpha_i\alpha_j=s^2V^3-s(U^3-3UV)+1,\qquad
 N=(T-C)\big(sUg^2-(U^2-2V)z^2\big)-C^2 V^2 .
$$
Reduce $(T-2J)^2N^3-T^2s^2g^6J^3$ modulo the monic $Q(z)$. Each of the three remainder coefficients must vanish because $Q$ has three distinct roots. The auxiliary equation $v s g T\,\mathrm{disc}(Q)\,\mathrm{Res}_z(Q,C)=1$ restricts the computation to the intended chart.

For zero sum of the three $b_i$, take $B=b_1$ and use ordered ratios $(1,x,-1-x)$. When two $b_i$ agree, relabel and take $B=b_1$, with ordered ratios $(1,1,x)$. For both of these charts the three original edge equations and $vsgT\alpha_1\alpha_2\alpha_3=1$ suffice. These charts cover repeated inverse-cubes with unequal inverse distances, in addition to the case of coincident ratios. Every possible shape in the hypotheses is examined by at least one chart.

## Completeness of the finite list

Over $\mathbb F_{65521}$ the three quotient rings have vector-space dimensions 420 (unordered), 4 (zero sum), and 102 (repeated ratio). The dimension step uses deterministic Gröbner basis linear algebra with msolve 0.10.1 and counts the standard monomials from its leading ideal. This is an upper bound on the number of geometric points, including points over arbitrary extensions. For the reverse bound the JSON file describes one squarefree univariate polynomial of the stated degree for each chart and explicit residue polynomials giving its coordinates. The program verifies that every such point satisfies every defining polynomial and its auxiliary inverse equation. The parameter is $g$ in the first chart, $-(v+x+s)$ in the second, and $s$ in the third. Its value therefore recovers the univariate root from the listed coordinates, proving the points distinct. The upper and lower bounds then agree, including scheme length. The dimension counts apply to three separate coordinate charts and no disjointness assertion between them is needed.

## Both projections and all signs

For each point in the first chart, adjoin an ordered first root of $Q$ and then a second root of the residual monic quadratic. This finite free algebra of rank six covers all orderings. For ordered charts the three ratios are already available. Normalize the relative high projections to $(0,1,h,H_3)$, with the marked body first. The first relative difference is invertible since its squared length is nonzero. The opposite projections at bodies 1 and 2 are $R_1$ and $R_2/h$. Thus
$$
 h^2-\frac{R_1+R_2-D_{12}}{R_1}h+\frac{R_2}{R_1}=0,\qquad
 H_3=-(\alpha_1+\alpha_2 h)/\alpha_3.
$$
Adjoin the roots by using the corresponding quadratic algebra. Translate the four relative positions $Z$ to centered coordinates multiplied by five, $X_i=5Z_i-(1+h+H_3)$. The square of each equal-binary torque term is proportional to $\epsilon_i m_i^2/X_i$ with $\epsilon_i=\pm1$. Multiplying by $\prod X_i$ and fixing a common sign gives four polynomial entries $A_i=\epsilon_i m_i^2\prod_{j\ne i}X_j$. All eight sign patterns are checked. A vanishing torque implies
$$
 \left[(A_0+A_1-A_2-A_3)^2-4A_0A_1-4A_2A_3\right]^2-64A_0A_1A_2A_3=0 .
$$
Take the determinant of multiplication by this element, successively along each quadratic or cubic extension, down to the finite field of each irreducible univariate factor. All determinants are nonzero. These norms test all orderings and both projections simultaneously. The use of the algebra, rather than root extraction, also covers nonreduced quadratic fibres. The five irreducible factors in the 420-point chart have degrees 2, 5, 17, 156 and 240.

## Reproduction

Use Python with python-flint 0.8.0 and msolve 0.10.1 on the executable search path. Keep the Python and JSON files together. Run `python3 RegularQuartet88.py --engine msolve` for all three Gröbner dimensions, the verification of all listed solutions and the torque norms. `--points-only` verifies the parametrizations and the torque without the dimension upper bound. `--engine singular` asks Singular for the same dimensions via `slimgb` and `vdim`; its runtime depends on the chart. The remaining force-multiplier and affine-rank cases and the specialization argument are separate from this regular-fibre calculation.

The independent [OpenF4 dimension verifier](OpenF4Dimension88.py) exports the pinned source tree into a temporary directory and makes its array-height cache mutable for C++14. It constructs the same chart generators directly, computes the bases in OpenF4, and counts monomials outside the three leading ideals. The numbers of leading generators are 165, 3 and 36. The quotient dimensions are 420, 4 and 102, respectively. On x86 with SSE4.2, a C++14 compiler, OpenMP and python-flint 0.8.0, run the following commands. [OpenF4 source revision](https://github.com/nauotit/openf4/tree/7155c6ec4e5f776e0e12202716dc7da58469e77b)

```sh
git clone https://github.com/nauotit/openf4.git /tmp/openf4
git -C /tmp/openf4 checkout 7155c6ec4e5f776e0e12202716dc7da58469e77b
python3 OpenF4Dimension88.py /tmp/openf4
```
