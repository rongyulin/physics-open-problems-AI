# The four-body projection and sign branches in diagram 88

**Chatgpt · 27 November 2026**

The Chang–Chen diagram 88 corresponds to Tomar class 127. In the catalogue's zero-based labelling its fully circled quartet is $K=\{1,2,3,4\}$ and its binary is $\{0,5\}$. The catalogue interchanges the two projection colours relative to Tomar’s §6.7 representative. Write $X_l$ for the large quartet projection and $Y_l$ for the coefficient of its opposite projection at the internal quartet scale. Tomar’s Lemma 6.16(a) gives a complete, centered signed four-body system, with $X_l\ne 0$ and pairwise distinct $X_l$ and $Y_l$. Its torques are necessary conditions for a six-body singular place. [Tomar, Lemmas 6.16 and 6.17](https://hexagonmath.org/pdf/2611.00377v1)

## Generic binary mass forces two independent cancellations

Suppose $t$ is in the binary, so the quartet masses are all one. Up to complex rotation and reflection the signed four-body leading systems have only finitely many shapes. For noncollinear quadruples the mutual distances satisfy the six Albouy–Chenciner and three Dziobek equations used by Hampton and Moeckel, up to their fixed change of scale. The derivations of these polynomial equations use bilinear dot products and hold with complex coordinates and signed distances. They prove finiteness **in the complex algebraic torus**. The six squared distances determine a centered noncollinear realization up to the complex orthogonal group: the centered Gram matrix is determined and the rank is two. The signed collinear case is covered by the finite-set theorem for positive masses in the repository's signed collinearity manuscript. Alternatively, finiteness for the real, positive-distance subset follows from the classical four-body result. [Hampton and Moeckel, §6.2, opening paragraph](https://www-users.cse.umn.edu/~rmoeckel/research/FinitenessRE4BP.pdf) · [Signed collinearity manuscript](https://github.com/rongyulin/physics-open-problems-AI/blob/main/problems/planar-central-configurations/papers/SignedCollinear.pdf)

Choose a common scale for $X$ and branches $b_l=1/\sqrt{X_l}$. Write $S=\sum\epsilon_l b_l$ and $T=\sum\delta_l b_l$ for the two signed rows. The torque is $S+i\rho T=0$ with $\rho=(m_6/m_5)^{3/2}$ in Tomar's one-based binary notation. For any fixed quartet shape and signs, this equation gives at most one positive $\rho$ unless both $S$ and $T$ vanish. Thus for generic $t$ the **two sums vanish separately**. This uses a finite set of quartet shapes independent of the binary masses; allowing a different quartet shape at each $t$ does not evade it.

Two vanishing sign rows are proportional. Otherwise their difference and sum produce cancellations on two nonempty complementary sets of indices. Neither set can have one member, so both have two. A two-term cancellation would give $b_j^2=b_k^2$, contrary to the distinct $X_l$. Thus the $2\times4$ sign matrix has rank one. For any given projected shape there is at most one admissible row up to sign. In particular, an antipodal projection $(a,-a,b,-b)$ with all four entries distinct never gives a vanishing row. Its two antipodal pairs contribute $(\pm1\pm i)/\sqrt a$ and $(\pm1\pm i)/\sqrt b$; cancellation would require $b/a\in\{1,-1\}$. More generally any real collinear projection after a common rotation fails the same test: both signs of real $X$ must occur by centering, the positive and negative groups must cancel separately, and the only possible $2+2$ split would repeat an $X$.

These criteria treat signed, genuinely complex shapes as well. They leave complex non-antipodal shapes whose four reciprocals admit a signed relation. They do not decide whether such shapes lift.

## An algebraic test on the quartet alone

The necessary condition for rank-one signs admits an inexpensive, permutation-invariant expression in the projected coordinates. Put $b_i^2=1/X_i$. Pair the four indices as $12|34$, and set $d=b_1^2+b_2^2-b_3^2-b_4^2$, $u=b_1^2b_2^2$, $v=b_3^2b_4^2$. A signed zero sum requires that the squared sums of the two pairs coincide. Eliminating the signs gives
$$
H=(d^2-4u-4v)^2-64uv=0.
$$
Conversely over $\mathbb C$, factoring the two conjugate quadratic equations, then taking either sign of the resulting equality of squared sums, recovers a signed zero-sum row. Although this expression uses a pair partition, its zero locus is independent of the partition. It is a polynomial condition after clearing the four nonzero $X_i$. It removes the binary parameter and all eight cross radicals from this branch. For binary placements a whole-cell exclusion can now be attempted through the isolated equal-four equations with the single additional equation $H=0$.

## Five candidates for every ordinary equal-four seed

Suppose the quartet leading configuration is, up to complex rotation and scale, an ordinary real positive-distance four-body central configuration. The four equal-mass types up to similarity and relabelling are the square, symmetric collinear configuration, equilateral triangle with its center occupied, and one other concave kite. [Albouy, *The symmetric central configurations of four equal masses*](https://perso.imcce.fr/alain-albouy/Albouy_Zygeng_ams4.pdf)

The equilateral-triangle type has a quartet body at the center and violates $X_l\ne0$. The square was treated in the earlier diagram-88 note. Its first torque permits $\rho\in\{1,\sqrt2-1,\sqrt2+1\}$.

For the ordinary collinear type let the centered positions be $\pm a,\pm b$ with $b>a>0$ and $q=b/a$. Equality of the accelerations per unit coordinate at $a,b$ gives
$$
q^7-2q^5-25q^4+q^3-6q^2-1=0.
$$
There is a unique $q>1$: after writing $q=1+x$ this polynomial is $x^7+7x^6+19x^5-84x^3-152x^2-112x-32$, with one sign change. With positive real $A=a^{-1/2}$, $B=b^{-1/2}$, the real and imaginary parts of a signed sum are independently in $\{\pm(A+B),\pm(A-B)\}$. Hence $S+i\rho T=0$ admits signs precisely at $\rho=1$, $\kappa$, or $\kappa^{-1}$, where $\kappa=(\sqrt q+1)/(\sqrt q-1)$. Necessity follows from the ratio of real and imaginary components. Sufficiency follows by choosing both components of each row to have the matching absolute values and then choosing their signs. This tests the first torque only.

For the nontrivial concave kite put the two off-axis unit bodies at $(0,\pm1)$ and write the two axial coordinates as $u,v$. The center of mass is $c=(u+v)/4$. With $A=(1+u^2)^{-3/2}$, $B=(1+v^2)^{-3/2}$ and $L=1/4+A+B$, the two axial equations are
$$
2Au-(v-u)^{-2}=L(u-c),\qquad 2Bv+(v-u)^{-2}=L(v-c).
$$
The off-axis vertical equation determines $L$ and its horizontal equation then follows from mass-weighted force cancellation. The [interval replay](verify_equal_four.py) uses a radius-$10^{-6}$ box centered at $(0.650378472,1.817239400)$. With the nonsingular rational preconditioner in the script, the fixed-point map has sup-norm derivative below $1/10$ on the box and moves its center by less than a tenth of its radius. The resulting root is a nontrivial concave kite and therefore represents the unique type from the classification. Throughout this box $0<u-c<1/25$, whereas the three other radii exceed 1. Thus $1/\sqrt{|X_{\rm inner}|}>5$ exceeds the sum of the other three reciprocal square roots, which is below 3 in this normalization. Tomar's Lemma 6.17(a) excludes the kite for **every positive binary mass ratio**.

In total the possible positive mass ratios $t$ for an ordinary equal-four seed belong to
$$
\big\{1,(\sqrt2-1)^{2/3},(\sqrt2+1)^{2/3},\kappa^{-2/3},\kappa^{2/3}\big\}.
$$
The set is invariant under reversing the two binary masses. These candidates express compatibility with the first torque on the square or collinear seeds, not existence of a six-body singular place.

## Mapping these restrictions to the catalogue

The nine listed cells are all class 127. In cells 0, 1, 7 and 8 a single quartet body has smaller opposite projection than the ordinary quartet scale, so its $Y_l$ vanishes. The affected zero-based body is respectively 2, 1, 4 and 3. In cells 2, 3, 4 and 5 body 1, 2, 3 and 4 respectively shares the origin leaf in this projection, also giving $Y_l=0$. In cell 6 all four $Y_l$ are nonzero. These facts follow from strict descent in the opposite-projection tree. Thus all eight exceptional-projection cells, for **every** placement, require a genuinely noncollinear complex four-body shape: a complex collinear configuration would have $Y=\lambda X$ after centering, with $\lambda\ne0$. An ordinary real shape also cannot have $Y_l=0$ while $X_l\ne0$. The physical classification is needed only for the all-nonzero cell. The remaining marked placements inside the quartet require a variable four-body system. None of these restrictions alone removes a row without accounting for the complex quartet alternatives.

The optional catalogue check is `python3 verify_equal_four.py --cells /path/to/c127.jsonl.xz` (place the upstream decompressed-file SHA-256 manifest alongside the archive). [Four-radical algebra in Lean](../../Lean/FourTermCancellation.lean)
