# Exact exclusion at the mass ratio two for the unmarked zero projection

**Chatgpt · 27 November 2026**

In diagram 88 the isolated quartet has masses $(1,2,1,1)$ in the local order $(o,1,2,3)$. Assume its projective limit is collision-free, with $Y_o=0$, all four centered $X_i$ nonzero and both sets of pair differences nonzero. The isolated forces, distance relations and the equal-binary torque give a contradiction, even if the relative shape is an absolute equilibrium (zero force multiplier). This note is the fixed-fibre calculation. The implication for a varying mass uses the [boundary proof at $t=2$](BoundaryAudit.md).

Use the notation of the [mixed-mass chart](ZeroProjection88.md). In a projectively normalized quartet the scalar $k$ denotes the force multiplier after scaling the squared distances and the total mass. An absolute equilibrium has $k=0$. The rank-at-most-one stress argument remains valid for this value. Centering and the force at $o$ give the same expression $k=\sum m_i r_i^3 d_i/\sum m_i d_i$ as in the ordinary chart. Indeed the force at $o$ equates the two mass-weighted sums after multiplication by $k$. The denominator is nonzero because $X_o\ne0$. The sum and weighted sum of the nonzero $m_iY_i$ vanish for weights $1,r_i^3$, so the star cubes are either pairwise distinct or all equal.

## Distinct cubes

Set $m=(2,1,1)$, $a=(1,r^3,s^3)$ and

$$
y=((r^3-s^3)/2,s^3-1,1-r^3),\qquad d_i=1/(r_i^2 y_i).
$$

With $D=\sum m_i d_i$, $\alpha_i=a_i-k$, and $W=\sum m_i\alpha_i$, all three outer edge equations are

$$
(k-\alpha_i\alpha_j/W)^2[(y_i-y_j)(d_i-d_j)]^3=1.
$$

Here $W\ne0$ follows from $1=-LW$ for the rank-one stress scale $L$. Distinct star cubes ensure a nonzero stress with nonzero generator at $o$. Collinearity would give proportional centered projections and hence $X_o=0$. Neither the derivation nor the calculation divides by $k$. The three integer polynomials $F_1,F_2,F_3$ are obtained by exact cancellation of common numerator and denominator factors on this chart and substitution of $t=2$ in [OuterZeroChart88.py](OuterZeroChart88.py). Their degrees in $(r,s)$ are $(50,54),(54,50),(50,50)$. All cancelled factors divide a product of quantities known to be nonzero on the chart, as follows from the construction using the denominators $W,D$, the $r_i,y_i$ and the pair differences.

The [characteristic-zero replay](MixedZeroFibre88.py) computes $R_i=\mathrm{Res}_s(F_i,F_3)$ for $i=1,2$. It uses 63 distinct primes greater than $2^{58}$, checking the degrees in $s$ at every prime. To certify the reconstruction, let $H_i$ be the sum of the absolute integer coefficients of $F_i$. Every coefficient of $R_i$ has absolute value at most $H_i^{\deg_s F_3}H_3^{\deg_s F_i}$. Indeed the determinant of the Sylvester matrix is a signed sum over permutations. The coefficient norm of entry products is submultiplicative, and the permanent of the matrix of entry norms is bounded by the product of its row sums. The larger bound has bit length 3619. The product of the 63 primes exceeds twice that bound. Symmetric Chinese remainders therefore give the exact integer coefficients, including zeros. The two degrees in $r$ are 3892 and 3936. Their rational gcd has degree 3172 and its primitive squarefree part has degree 26. All factors, with multiplicity one in the latter, are

$$
\begin{aligned}
 &r,\quad r-1,\quad r^2+r+1,\quad r+1,\quad 2r^2+2r-1,\quad 3r^3-1,\\
 &2r^4-2r^3-4r^2+4r-1,\quad 2r^4+2r^3+4r^2+4r+1,\\
 &r^4+4r^3+5r^2+2r+2,\quad 2r^4+2r^3+5r^2+4r+1.
\end{aligned}
$$

Exchanging the two outer unit masses exchanges $r,s$. The script also checks this symmetry directly on the three polynomials. Thus each coordinate belongs to the same finite root set. The first three factors are forbidden since $r,s\ne0$ and their cubes differ from one. For each of the remaining 49 ordered pairs of factors $P,Q$, form the rational algebra $A=\mathbb Q[r,s]/(P(r),Q(s))$ of dimension at most 16. Let $d'_i$ denote $d_i$ multiplied by $J=\prod r_i^2y_i$, $D'=2d'_1+d'_2+d'_3$, and $H=(-D',5d'_1-D',5d'_2-D',5d'_3-D')$. These are the four centered abscissas up to a common nonzero multiplier. Let

$$
\Delta=J\,\prod_{i=0}^3H_i\prod_{1\le i<j\le3}(y_i-y_j)(d'_i-d'_j).
$$

The replay expresses residue classes in the monomial basis for $A$. Compute the span of the products of $F_1,F_2,F_3$ with all basis elements using rational matrix arithmetic. In all 49 algebras adjoining the vector of $\Delta$ to this span leaves its rank unchanged. Hence $\Delta$ belongs to the ideal of the three equations in $A$. Any admissible configuration would evaluate those three elements to zero and $\Delta$ to a nonzero value, a contradiction. This distinct-cube calculation needs no additional torque test once all centered abscissas are nonzero.

## Equal cubes

Here $r_i^3=1$ for every $i$, and $D\ne0$ implies $k=1$. Normalize the ordinates to $(1,x,-2-x)$ and put $y=(1,x,-2-x)$. The relative abscissas are $d_i=r_i/y_i$ with $r_1=1$. If the stress vanishes, all edge cubes equal one and the edge joining bodies 1 and 2 gives $[(y_1-y_2)(d_1-d_2)]^3=1$. If the stress has rank one, its row at $o$ vanishes, so the affine dependence is supported on the three outer bodies. Their determinant $\det(1,y_i,d_i)_{i=1}^3$ then vanishes. Multiplying the two necessary-equation numerators gives a univariate seed for each of the nine star-root patterns. Remove every factor of this seed supported on a zero denominator, a vanishing centered abscissa or a pair collision. With centered abscissas $H_i$ up to common scale, set $A_i=\epsilon_i m_i^2/H_i$ and fix one sign by common rescaling. The necessary equal-binary torque is

$$
[(A_o+A_1-A_2-A_3)^2-4A_oA_1-4A_2A_3]^2-64A_oA_1A_2A_3=0.
$$

[EqualFibre88.py](EqualFibre88.py) works over $\mathbb Q(\sqrt{-3})$. On each of the nine cube-root charts, the remaining seed has gcd one with all eight signed torque numerators. This rules out the equal-cubes fibre as well.

From this directory run `python3 MixedZeroFibre88.py` (optionally add `--workers 5`) and `python3 EqualFibre88.py`. The first calculation uses SymPy and python-flint 0.8.0 and the second uses SymPy.
