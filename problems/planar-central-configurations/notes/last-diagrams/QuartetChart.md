# A distance chart for the remaining diagram-88 quartets

Suppose the four-body cluster of diagram 88 has masses $(t,1,1,1)$ and its binary has two unit masses. Denote the distinguished quartet body by $o$. The projective shape uses two centered complex projections. Write $X$ for the projection in which all four positions are nonzero and distinct; all opposite-projection pair differences are nonzero as well. For each pair the signed inverse distance satisfies $p_{ij}^2(X_i-X_j)(Y_i-Y_j)=1$. The torque with equal binary masses requires a choice $c_i\in\{\pm1\pm i\}$ with $\sum_i c_i m_i/\sqrt{X_i}=0$. This chart describes necessary polynomial equations and inequations for the two-dimensional shapes in diagram 88. [Tomar, Lemmas 6.16 and 6.17](https://hexagonmath.org/pdf/2611.00377v1)

## Three collinear bodies

For generic $t$, no genuinely two-dimensional quartet passing the torque can contain three collinear bodies. To prove this, translate, rotate and scale a proposed complex shape so that the line has second Cartesian coordinate zero and the point off the line is $(0,h)$. Complex similarity is available because the line direction has nonzero squared length; an isotropic line would give a zero squared distance. Write $u_i$ for the coordinate along the line and let $M=t+3$. In any translation the normalized force equations read $\sum_{j\ne i}m_j(p_{ij}^3-1/M)(q_i-q_j)=0$ for the vector $q_i$. Taking the direction perpendicular to the line at each line member gives $p_{io}^3=1/M$, where in this paragraph the second subscript denotes the off-line point regardless of its mass. Scale all lengths by $M^{-1/3}$. The cross inverse cubes are now one, and the line positions satisfy $u_i^2=B+\zeta_i$, with $B=-h^2$ and each $\zeta_i^3=1$.

Choose line index $i$ so the other two line masses, at $j,k$, are one. This is always possible with three unit masses and one variable mass. Its line equation becomes
$$
2u_i-u_j-u_k=\frac{\epsilon_{ij}}{(u_i-u_j)^2}+\frac{\epsilon_{ik}}{(u_i-u_k)^2},\qquad \epsilon_{ij},\epsilon_{ik}\in\{-1,1\}.
$$
For fixed roots of unity and signs this equation cannot hold identically on any collision-free branch above $B$. At a point above infinity set $w^2=B$. Each $u_l$ has leading term $s_l w$, with $s_l=\pm1$. If both other signs are opposite to $s_i$, the left side grows as $w$ and the right is $O(w^{-2})$. If exactly one agrees, its term on the right grows as $w^2$, while the left is $O(w)$. For matching signs the corresponding roots of unity must be distinct to avoid collision. If all signs agree, all three roots of unity are distinct and the two leading terms of order $w^2$ on the right cannot cancel: $[(\zeta_i-\zeta_j)/(\zeta_i-\zeta_k)]^2$ is a primitive cube root of unity and cannot equal $\pm1$. Thus the line equation has only finitely many shapes, independently of $t$. This argument on the finite square-root cover does not require real positions.

Finally, no fixed collision-free shape with all four projected positions distinct meets the equal-binary torque for a continuum of $t$. For fixed relative positions $Z_o=0,Z_1,Z_2,Z_3$, set $D=Z_1+Z_2+Z_3$. After centering, $X_o=-D/M$ and $X_i=Z_i-D/M$. If $D=0$ the marked position vanishes, contrary to the diagram. Otherwise as $t\to+\infty$ the marked term has magnitude of order $t^{3/2}$, while the other three remain bounded, uniformly in the signs. Clearing the finitely many radical choices gives a nonzero polynomial constraint. This only uses large $t$ to show that an algebraic identity for a fixed shape is nonzero. Combining these observations excludes the three-collinear sector generically. [Related collinear quartet](Collinear88.md)

## Four unknowns before the torque test

Assume no three quartet positions are collinear. Use body $o$ for the marked body again. Set $P=p_{o1}$, $r_1=1$, $r_2=r$, $r_3=s$, $k=1/(MP^3)$, and $\alpha_i=r_i^3-k$. Define the symmetric matrix with off-diagonal entries $m_i m_j(p_{ij}^3/P^3-k)$ and diagonal chosen to make row sums zero. By the isolated force and center equations, its kernel contains $\mathbf 1,X,Y$, three independent vectors. If the matrix is zero, all six inverse cubes agree; up to scale all squared distances then belong to the three cube roots of unity. These finitely many distance tuples give finitely many shapes up to complex orthogonal equivalence (the two independent relative vectors have nonsingular Gram matrix). The fixed-shape torque argument above excludes their generic occurrence.

Otherwise the matrix has rank one, so it is proportional to $vv^{\mathsf T}$. Its image generates the affine dependence on the four positions. All four entries of $v$ are nonzero because no three positions are collinear. Comparing the entries on the three edges out of $o$ and then the remaining entries gives a nonzero $L$ satisfying
$$
 \alpha_i\ne0,\qquad t=-L\sum_{i=1}^3\alpha_i,\qquad b_{ij}:=(p_{ij}/P)^3=k+L\alpha_i\alpha_j.
$$
In detail, write $v_i=m_iT_i$ and the matrix as $c vv^{\mathsf T}$. Then $\alpha_i=cT_oT_i$, $L=1/(cT_o^2)$, and $\sum_i m_i T_i=0$. The affine dependence on the positions also gives $\sum_{i=1}^3\alpha_i Q_i=0$ for relative vectors $Q_i=P(q_i-q_o)$. With the complex Euclidean bilinear form write $R_i=Q_i^2=1/r_i^2$ and $D_{ij}=(Q_i-Q_j)^2$. For distinct $i,j,l$ in the outer triple,
$$
 D_{ij}=\frac{(\alpha_i+\alpha_j)(\alpha_iR_i+\alpha_jR_j)-\alpha_l^2R_l}{\alpha_i\alpha_j},\qquad
 (k+L\alpha_i\alpha_j)^2 D_{ij}^{3}=1.
$$
Indeed, squaring $\alpha_iQ_i+\alpha_jQ_j=-\alpha_lQ_l$ determines the pairwise bilinear product. Thus the three distance constraints use just $(r,s,k,L)$; all values compatible with the signed force and distance equations are retained. A valid chart requires $r s k L\prod_i\alpha_i\ne0$ and $t>0$ in physical specializations.

To impose the remaining torque, use the relative high projection $(0,1,h,H_3)$ in this distance scale, with $H_3=-(\alpha_1+\alpha_2 h)/\alpha_3$. The relative opposite components of bodies 1,2,3 are $1, R_2/h,R_3/H_3$. The first pair distance requires
$$
 h^2-(1+R_2-D_{12})h+R_2=0 .
$$
Translate both projections to their mass centers. For the high projection subtract $(1+h+H_3)/M$ from its four entries, obtaining $X'_i$. Use the nonzero chart with distinct entries in both projections, and $X'_i\ne0$. For each sign pattern set $A_i=\epsilon_i m_i^2/X'_i$ with $\epsilon_i=\pm1$; one common sign is redundant. The necessary torque equation without square roots is
$$
 \big[(A_o+A_1-A_2-A_3)^2-4A_oA_1-4A_2A_3\big]^2-64 A_oA_1A_2A_3=0 .
$$
For a cell specifying $Y_j=0$, also require $M W_j=\sum_{i=1}^3W_i$, where $W=(0,1,R_2/h,R_3/H_3)$. Both this condition and the torque must refer to the same choice of $h$. All equations are rational with explicit nonzero denominators. Eliminating $h$ cannot increase its degree above two on an individual projected shape. The [repeated-cube exclusion](RepeatedStar88.md) reduces the number of independent unknowns to three. The [specialization proof](FullQuartetSpecialization.md) and the [characteristic-zero argument](FiniteRatioBoundary88.md) complete its exclusion at generic mass. Clearance of denominators in a Gröbner-basis test must retain the stated nonzero restrictions.
