# Diagram 94 with a variable mass at the shared body

**Chatgpt · 27 November 2026**

**Theorem.** For the planar Newtonian masses $(1,1,1,t,1,1)$ in the paper's order, diagram 94 has no complex singular place for all but finitely many positive $t$. Body 4 is the shared body. This result applies to every exponent cell and every distance-sign choice in this mass placement. For the other placements see the [outer-mass argument](Outer94.md) and the [binary-mass argument](BinaryProjection94.md). The exceptional set is not computed.

Use the four-body leading system $KC$ and the signed torque equation in [Tomar, §6.7, Lemmas 6.16(b) and 6.17(b)](https://hexagonmath.org/pdf/2611.00377v1). Let $i=1,2,3$ denote its three unit outer masses, $c$ denote the shared central body of mass $t$, and $5,6$ denote the opposing unit binary. Normalize the center's large coordinate to $0$ and $X_1=1$. All $X_i$ and $X_i-X_j$ are nonzero. Summing the four large-coordinate force equations gives $X_1+X_2+X_3=0$.

## Fixed projections and a finite curve test

With the two equal binary masses, the torque equations and center relation give just fourteen possible labelled triples $X$. Indeed write the torque terms as $v_i=d_i/\sqrt{X_i}$, with $d_i=\pm(1\pm\mathrm i)$, put $z=v_2/v_1$ and $e_i=d_i^2/d_1^2\in\{1,-1\}$. Then
$$
z^2(1+z)^2+e_2(1+z)^2+e_3 z^2=0,\qquad
X=(1,e_2/z^2,e_3/(1+z)^2).
$$
The $(+,+)$ polynomial is $(z^2+z+1)^2$; the other three quartics each have four distinct roots. Modulo 673 these polynomials split completely, with fourteen distinct admissible projected triples. This verifies the corresponding distinctness and count in characteristic zero. Every projection is independent of $t$.

Put $p_*=p_{1c}$, $r_i=p_{ic}/p_*$, $q_{ij}=p_{ij}/p_*$, $v=p_*^{-3}$, $y_i=p_*^2(Y_i-Y_c)$, and $c_0=p_*^2Y_c$. The distances, the center $X$ equation, and the outer $X$ and $Y$ equations give
$$
r_1=1,\quad \sum X_i r_i^3=0,\quad y_i=(X_i r_i^2)^{-1},\quad
q_{ij}^2=[(X_i-X_j)(y_i-y_j)]^{-1},
$$
$$
a_i=\sum_{j\ne i}q_{ij}^3(X_i-X_j)/X_i,\quad
v=t r_i^3+a_i,\quad
C_i=\sum_{j\ne i}q_{ij}^3(X_jy_i/X_i-y_j)=v c_0 .
$$
To see the last identity, the outer $Y$ equation reads $v(y_i+c_0)=t r_i^3y_i+\sum q_{ij}^3(y_i-y_j)$. Subtract the outer $X$ equation multiplied by $y_i$. If some $r_i^3\ne1$, subtracting the outer $X$ equations determines $t=(a_i-a_1)/(1-r_i^3)$ uniquely at that geometry.

For each prescribed $X$, the diagonal cubic $\sum X_i r_i^3=0$ in projective ratio coordinates is smooth and geometrically irreducible, since all its coefficients are nonzero. Restrict its $r_1=1$ chart to the open set with nonzero ratios and collision-free $y$'s. Adjoining the three $q_{ij}$ gives a finite étale cover there, so each irreducible component maps onto this open curve. To show the simultaneous equations $C_1=C_2=C_3$ cut out only finitely many points, a single base point whose entire fibre violates at least one equality suffices for each $X$.

[Exact shape verifier](center_shapes.py) constructs such a fibre modulo 673 for each of the fourteen shapes. If a square root lies outside the prime field it uses a quadratic extension. It checks all eight sign choices, using simultaneous inversion of the three signs. For the transfer, choose a place over 673 for each algebraic shape. The modular value of $r_2$ lifts as an ordinary nonzero integer, and the cubic for $r_3$ has the tested simple nonzero residual root. Thus it has a lift over a finite extension of the 673-adic numbers. Every denominator at this point is a unit. The reductions of its square-root sheets occur among the tested sheets. Hence no lift of the test point has both required equalities. A component supporting both equalities identically would have to meet that fibre. Consequently there are finitely many sign-and-ratio tuples with the required equalities for each $X$. Outside $r_i^3=1$ for every $i$, this also makes $t$ finite.

## The two geometries that can persist in the center mass

If all $r_i^3=1$, the force scales allow variable $t$ only if $a_1=a_2=a_3$. The parameters $r_2,r_3$ now range over nine ordered pairs. The same verifier tests both sets of equalities and the three edge signs for every such pair and every projected triple modulo 673. The only survivors are $X=(1,\omega,\omega^2)$ in either orientation, with every $q_{ij}^3$ equal, and
$$
(r_1,r_2,r_3)=(1,1,1),\quad y_i=X_i^{-1},
\qquad\text{or}\qquad
r_i=X_i^{-1},\quad y_i=X_i .
$$
Reduction is injective on the fourteen possible projected triples and on the cube roots of unity; on any fixed collision-free tuple, the two signs of each nonzero square root also remain distinct. In the exceptional tuples, a collision $y_i=y_j$ modulo 673 requires $X_i/X_j$ to be a cube root of unity modulo 673. Since $X_1+X_2+X_3=0$ and the three coordinates are distinct, this implies the equilateral projection there. That projection lifts uniquely as a projected triple, all its coordinates are cube roots of unity, and the residual collision is a genuine collision in characteristic zero. For both surviving patterns the three squared edge cube values are equal in characteristic zero, so equality of their cubes modulo the odd prime forces the same signs there and in characteristic zero. In either pattern $C_i=0$, hence $Y_c=0$.

The first pattern is the equilateral leading geometry. Its uniform outer cubes can have either sign relative to the center cubes. The two values of $\sqrt3$ in the [equilateral cubic obstruction](../physical-ends/Equilateral94.md) cover both signs since $q_{ij}^3=\pm1/(3\sqrt3)$. All common scales and cross signs are included in that calculation. It therefore rules out both uniformly signed equilateral lifts generically in $t$.

## The second pattern is collinear

Here $y_i=X_i$ and the three normalized center inverse distances are $1/X_i$. The outer cubes have a common value $\kappa$, where $\kappa^2=-1/27$ because $(X_i-X_j)^6=-27$ for every outer pair. The stationary scale is $v=t+3\kappa$. Let $Y_i^{\rm rel}=\beta X_i$ be the relative small projection in the shape chart of the equilateral obstruction. Then $\beta=p_*^{-2}$, $\beta^3=(t+3\kappa)^2$. The three outer $X$ sum to zero, $Y_B=0$, and $D_B=\sum p_{ic}/X_i=p_*\sum X_i^{-2}=0$. The proof reducing the six-body shape chart to two variables in the equilateral note therefore applies. Its cross signs have the same form $g_{ij}=d_i X_j$, since they only involve the large projections, and hence $G=dG=0$.

For clarity the following are exactly the substitutions needed in its arithmetic at $t=1$. Set $s^2=-3$, $\kappa=1/(3s)$, and $p_0=1/(1+3\kappa)$. For $F/\beta$ the normalized center weights are $p_0/X_i$ and the outer weights are $p_0\kappa(X_i-X_j)^2$. The first follows from the center ratios, the second from $q_{ij}=q_{ij}^3(X_i-X_j)^2$. Use $y_i=X_i$ in the straight-line second and third derivatives and multiply each center summand of $c_1$ by $X_i^{-1}$. In the cubic coefficient $j$, the term involving $\beta$ vanishes because $\sum X_i y_i=\sum X_i^2=0$, giving
$$
j=(3d/2)\big[1-lq-(1+l)A_0\big]\alpha .
$$
The formula for $g$ and the binary Hessian are unchanged. The general formula for $e$ in terms of $b_1,c_1$ is unchanged. The same collinear calculation also applies when a binary mass varies while the shared mass equals one: the formulas used at the all-equal specialization are identical, the signed binary equations defining the sheets are regular there, and the cross torque still forces a constant sign in each row for every positive binary ratio. All surviving sheets have finite algebraic parameters, and all denominators in these chart formulas are nonzero above $t=1$. The transverse Hessians at $1$ are nonsingular.

[Collinear branch verifier](collinear.py) checks all 864 algebraic tuples at $t=1$ at the prime 97. On every tuple the two transverse Hessian determinants, $j$ and the binary cubic discriminant are nonzero. In this reduction the coefficients $f,e$ both vanish, so the discriminant is $-4g^3j$. As in the equilateral calculation the witnesses certify nonzero algebraic functions on every sheet, outside finitely many $t$. If the reduced quadratic coefficient is nonzero, the stationary branch would require $j=0$. If it vanishes, the homogeneous cubic would have a stationary projective direction and its discriminant would vanish. Thus neither persistent geometry can lift for generic $t$. The finite projection/ratio alternatives above account for all remaining possibilities and complete the proof.

[Lean algebraic checks](../../Lean/CenterForces94.lean) prove the elimination of the center coordinate and the formula determining the mass from a distinct cube in every field. The supporting cubic criterion is proved in [EquilateralCubic94.lean](../../Lean/EquilateralCubic94.lean). The full analytic and arithmetic proof is given here and in the two arithmetic programs.
