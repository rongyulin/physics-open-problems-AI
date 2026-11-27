# Specializing the quartet with an unmarked zero projection

**Chatgpt · 27 November 2026**

Consider the isolated quartet in diagram 88 with two unit binary masses. Its mass vector in the order $(o,1,2,3)$ is $(1,t,1,1)$. Its centered low coordinate satisfies $Y_o=0$, whereas its centered high coordinates are all nonzero. On each projection the six pairwise differences are nonzero. This note proves the specialization needed to exclude the mixed zero-projection case for generic $t$. A check in a single ordinary affine fibre can miss a family escaping to its boundary. At $t=2$ the complete test here also includes the normalized **zero force multiplier**, which accounts for a simultaneous four-body collapse. [Four-body diagrams, Albouy and Kaloshin, §§3–5](https://annals.math.princeton.edu/wp-content/uploads/annals-v176-n1-p10-p.pdf) · [Six-body quartet and torque equations, Tomar, §6.7](https://hexagonmath.org/pdf/2611.00377v1)

## A place over the test mass

Suppose the necessary quartet and torque equations hold over $\overline{\mathbb Q(t)}$. Take a finite algebraic extension containing a solution and its square-root choices and a valuation above $t-2$. Its residue field is of characteristic zero and embeds into $\overline{\mathbb Q}$. All masses and all nonempty partial mass sums are valuation units. Write $z,w$ for the two projections, $p_{ij}^2(z_i-z_j)(w_i-w_j)=1$ for the signed inverse distances, and $F^a_{ij}=p_{ij}^3(a_i-a_j)$ for each projection $a=z,w$. The isolated quartet has force multiplier one.

For each projection take the minimum of the valuations of its four positions and its six $F^a_{ij}$. By a reciprocal scaling $z\mapsto b z$, $w\mapsto w/b$, balance these two minima after a finite extension. This is a complex orthogonal change of coordinates and preserves both the forces and the vanishing of the torque. Call their common value $v_*$. It is nonpositive. If it were positive, all coordinate differences in both projections would have positive valuation, forcing a negative valuation for each $F^a_{ij}$ by the distance equation.

If $v_*=0$, all positions and all force terms in both projections are integral. For any pair, write $A=v(z_i-z_j)$, $B=v(w_i-w_j)$. Then $A,B\ge0$, $2v(F^z_{ij})=-A-3B\ge0$ and $2v(F^w_{ij})=-3A-B\ge0$. Consequently $A=B=0$ on every pair.

If $v_*<0$, the diagram after balancing is one of the five in Albouy–Kaloshin's Fig. 8. Their §§3–4 combinatorial classification uses order comparisons, the signed distance equations and the leading coefficient balances with nonzero cluster masses. These conditions still hold when $t$ varies and reduces to 2. The bounded-potential rule 2h, which would need extra justification for varying masses, is not used in their §4 enumeration. An independent exact linear-arithmetic check is given below.

For the first diagram the limiting masses would have to consist of two equal pairs by (13). The second would have two equal products of disjoint pairs by (14). In the third a reciprocal square root of one of three masses would equal the sum of the other two by (16). For $(1,2,1,1)$ all three tests fail under all relabellings. In the fourth, (20) requires $m_1^2(m_2+m_3)^4=m_2^3m_3^3$. For the three possible placements of the mass 2 relative to this expression, the two sides are $16,1$; $64,1$; or $81,8$. The mass identities come from taking leading terms as in the authors' §§5.1–5.4. Each only uses the residues of the masses, including for a Puiseux branch with varying $t$.

In the fifth diagram every pair is a double edge, meaning that $v(F^z_{ij})=v(F^w_{ij})=v_*$ for each pair. The two formulas for their valuations give $A=B=-v_*/2>0$ and $v(p_{ij})=v_*/2$. Thus every coordinate difference in both projections has the same order of collapse. There is no smaller internal cluster in the resulting projective shape.

## The projective shape and all its possible denominators

Set $P=p_{o1}$, divide $z$ by $z_1-z_o$, divide $w$ by $w_1-w_o$ and divide the six inverse distances by $P$. These changes are compatible because $P^2(z_1-z_o)(w_1-w_o)=1$. All pair differences in each rescaled projection and all six rescaled inverse distances are valuation units. Centering gives, for example, $z_i=M^{-1}\sum_j m_j(z_i-z_j)$ with $M=3+t$, so all four rescaled centered entries in each projection are integral. In either coordinate $q$ the resulting force equations read
$$
\lambda q_i=\sum_{j\ne i}m_j(p_{ij}/P)^3(q_i-q_j),\qquad \lambda=P^{-3}.
$$
In the bounded case $\lambda$ reduces to a nonzero number. In the fully edged case it reduces to zero. Both give a legitimate finite projective shape with six nonisotropic edges. Write $X,Y$ for the residues of the rescaled high and low coordinates.

The equal-binary torque has the form $\sum_i m_i\gamma_i/\sqrt{z_i}=0$ with $\gamma_i\in\{\pm1,\pm\mathrm i\}$ after one common nonzero rescaling. It is homogeneous under rescaling $z$. If one of the centered high coordinates had zero residue, the other three would be units since all pair differences are units. The corresponding single term of negative valuation cannot cancel. Hence *all four* $X_i$ are nonzero, and both the square-root torque and its polynomial consequence specialize. We still have $Y_o=0$ identically and the other three $Y_i$ nonzero. A collinear reduced quartet with these nonzero pair differences would have $Y=aX+b$ with $a\ne0$; centering gives $b=0$, contradicting $Y_o=0$, $X_o\ne0$.

Let $a_i$ be the cubes of the three reduced inverse-distance ratios on edges $oi$, ordered so $a_1=1$. The two equations $\sum m_iY_i=0$ and $\sum m_i a_iY_i=0$ sum over the three bodies $i\ne o$. They imply that the $a_i$ are either all equal or pairwise distinct. A choice with exactly two equal would force the remaining $Y_i$ to vanish. In the distinct case the low and relative high coordinates can be written as in [the mixed chart](ZeroProjection88.md). Its denominator $D=\sum_{i\ne o}m_i d_i$ is nonzero because $X_o=-D/M$ in that scale. The reduced stress matrix obtained by subtracting $k=\overline\lambda/M$ from each normalized inverse cube, multiplying by the two masses and taking zero row sums, annihilates $\mathbf1,X,Y$. It has rank at most one since the three kernel vectors are independent. In the distinct case its row at $o$ is nonzero. Writing the symmetric rank-one stress as a scalar multiple of $vv^{\mathsf T}$ gives
$$
 b_{ij}=k+L(a_i-k)(a_j-k),\qquad 1=-L\sum_{i\ne o}m_i(a_i-k).
$$
In particular $L$ and the weighted sum on the right are nonzero. The three distance equations in the mixed chart remain valid with $k=0$. At an all-equal-cube limit the reduced force at $o$ gives $k=1$ since $D\ne0$. The zero-stress or rank-one alternatives and the polynomial torque in [EqualFibre88.py](EqualFibre88.py) apply there as well.

Consequently, excluding the equal and pairwise-distinct projective fibres at $t=2$, allowing $k=0$, excludes every solution over $\overline{\mathbb Q(t)}$. The equations and their nonzero conditions are algebraic. The constructible image in the affine parameter line then consists of finitely many algebraic points. The [exact projective fibre calculation](MixedZeroFibre.md) therefore rules out the mixed zero-projection placement outside a finite parameter set.

## Independent checks of the boundary reduction

[BoundaryOrders88.py](BoundaryOrders88.py) normalizes $v_*=-2$. It encodes the triangle inequalities as repeated minimum conditions, and the balances on every nonempty set $S$ of quartet bodies as
$$
 \Big(\sum_{i\in S}m_i\Big)q_a+\sum_{i\in S}m_i(q_i-q_a)
 =\sum_{i\in S,\,j\notin S}m_i m_j F^q_{ij}
$$
with each possible anchor $a$, including the origin. The doubled edge-force orders are $-A-3B$ and $-3A-B$. The differences of individual force equations also give repeated minima; the coefficient of the common edge is $m_i+m_j$, a unit. After excluding all relabellings and color exchanges of the five diagrams, the remaining rational linear constraints are inconsistent in Z3. This check works for a fixed identically vanishing low coordinate and also for four generically nonzero low coordinates.

[Boundary88.py](Boundary88.py) checks the first four diagrams directly at residue characteristic 65521 without appealing to positivity of elements in a finite field. For diagram I it evaluates every sign in the equation after (12); for diagrams II and III it uses (14) and the fourth-root relation preceding (16). For diagram IV set $\eta=r_{13}/r_{12}$ for the *distances*, so $\eta^3=1$ by (18). Eliminating $r_{12}/r_{23}$ between (18) and (19) gives
$$
 m_1^2(m_2+m_3)(\eta m_2+m_3)^3=(m_2m_3)^3.
$$
All phases required split at 65521, and none of the four necessary relations holds. The script also repeats the nine equal-cube fibre computations and eight choices of squared torque signs over this field. The positive-characteristic arithmetic provides a separate check. The proof over $\overline{\mathbb Q(t)}$ above uses the characteristic-zero special fibre and the positive masses $(1,2,1,1)$.
