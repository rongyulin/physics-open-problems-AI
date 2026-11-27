# Diagram 94 when the unequal mass belongs to the binary

**Chatgpt**

For the Newtonian mass line $(1,1,1,1,1,t)$, place $(t,1)$ or $(1,t)$ on the opposing binary of diagram 94. For all but finitely many positive $t$, the complex six-body equations have no such singular place. The argument below reduces every leading cluster to the two signed geometries covered by the equilateral and collinear cubic obstructions. The geometric and computational parts of that last step are detailed in [the companion proof](Center94.md). The result applies to every compatible order cell. In the zero-based catalogue binary placements are 0 and 4.

## The four equal masses have finitely many projected shapes

Use Tomar’s four-body equations and the cross torque identity for diagram 94, §6.7, Lemmas 6.16(b) and 6.17(b). Write $X_c=0$, $X_1=1$, and $X=(1,x,-1-x)$ for the three outer abscissas. Their sum vanishes by the sum of the four abscissa equations. All $X_i$ and $X_i-X_j$ are nonzero. Put $p=p_{1c}$, $r_i=p_{ic}/p$, $s_i=r_i^3$, $r=(1,v,w)$, $K=p^{-3}$, and
$$
 U_i=p^2(Y_i-Y_c)=1/(X_i r_i^2),\qquad
 E_{ij}=(p_{ij}/p)^3,\qquad E_{ij}^2=D_{ij}^{-3},\quad
 D_{ij}=(X_i-X_j)(U_i-U_j).
$$
The center abscissa equation gives $\sum s_i X_i=0$. The outer equations give, with a common constant $c$,
$$
 \sum_{j\ne i}E_{ij}(X_i-X_j)=(K-s_i)X_i,\qquad
 \sum_{j\ne i}E_{ij}(U_i-U_j)=(K-s_i)U_i+c.
$$
Put $P_i=(X_i,U_i)$. For an affinely independent outer triple, let $\lambda_i$ be the barycentric coordinates of $(0,0)$ relative to $P_i$. With $\bar P=\sum P_i/3$, summing the force equations lets us write their two-component right-hand sides as
$$
 K(P_i-\bar P)-s_iP_i+\tfrac13\sum_j s_jP_j .
$$
Let $S=\sum s_i/3$. The coefficients in this formula sum to $S-s_i$. Subtracting $(S-s_i)\lambda_j$ from each coefficient leaves the vector unchanged and makes their sum zero. Uniqueness of this representation for an affinely independent triple gives, for $i\ne j$,
$$
 E_{ij}=(K-s_j)/3+(S-s_i)\lambda_j.
$$
The centered vectors $(\lambda_i-1/3)_i$ and $(s_i-S)_i$ both have sum zero and pair to zero with $X$. This is a one-dimensional subspace because the three abscissas are distinct. Taking the corresponding vanishing minors now gives
$$
 E_{ij}-E_{ik}=-\lambda_i(s_j-s_k)\quad (i,j,k\text{ distinct}).
$$
For cyclic $(i,j,k)$, put $n_i=X_jU_k-X_kU_j$. Then $\lambda_i=n_i/\sum n_j$.

If $v^3\ne w^3$, the center equation gives $x=(w^3-1)/(v^3-w^3)$. Substitute it in $D_{ij}$ and $\lambda_i$. Put $P(A,B,d)=(A-B)^2-2(A+B)d+d^2$. It vanishes if $A=e^2$, $B=f^2$, and $d=(e-f)^2$. Consequently the following two expressions vanish:
$$
 P(D_{12}^{-3},D_{13}^{-3},\lambda_1^2(v^3-w^3)^2),\qquad
 P(D_{12}^{-3},D_{23}^{-3},\lambda_2^2(1-w^3)^2).
$$
To clear each expression, write its three inputs as factored rational functions and divide them all by their common factor with exponent equal to the minimum of each irreducible factor’s three exponents. Every removed numerator factor divides the first input's numerator; all removed denominator factors occur in the denominators of the original chart coordinates, distances or barycentric coordinates. These factors are units on this chart. The resulting bivariate integer polynomials have bidegrees $(102,102)$ and $(96,102)$, respectively, with 6827 terms each. Their exact polynomial gcd is 1. They therefore have finitely many common zeros over the algebraic closure, and the projected ratios in this chart form a finite set. [Exact polynomial verifier](verify_binary_cluster.py)

If $v^3=w^3$, the center equation makes both cubes 1. For a noncollinear triple the difference identity then makes all $E_{ij}$ equal. For each fixed choice of cube roots $r_i$, the resulting identity $D_{12}^3=D_{13}^3$ is nonidentical in $x$. Indeed at $x=1$, the first distance factor vanishes while $X_3=-2$ and $U_3=-r_3/2\ne U_1=1$. Hence this chart has finitely many projections as well.

If the outer points are affinely collinear, write $U_i=A X_i+B$. Subtract $A$ times the abscissa equations from the ordinate equations and take row differences. This gives $B(s_i-s_j)=0$. If $B=0$, $A=1$, so $r_i=\sigma_i/X_i$ with $\sigma_i=\pm1$; now $\sum_i\sigma_i/X_i^2=0$ by the center equation, a nonidentical rational condition with a pole at $x=0$. If $B\ne0$, all $s_i=1$. For each fixed choice of $r_i$, collinearity of $(X_i,r_i/X_i)$ gives a nonidentical rational condition: as $x\to0$, the second ordinate has a simple pole whose coefficient in the collinearity determinant is multiplied by $X_1-X_3\to2$. This proves finite projection in every case.

## A variable binary selects the regular projection

For each of the finitely many projections and square-root choices, the torque equation has the form $A+\mathrm i\rho B=0$, where $A,B$ are signed sums of $1/\sqrt{X_i}$ and $\rho=(m_6/m_5)^{3/2}$. Since one binary mass varies, this can hold for infinitely many positive $t$ only if $A=B=0$. From the signed sum $A=0$, normalize its terms as $(1,z,-1-z)$. Their inverse squares are $X_1,X_2,X_3$. Multiplying $\sum X_i=0$ by $z^2(1+z)^2$ gives $(z^2+z+1)^2=0$. Thus, up to permutation, $X=(1,a,b)$ with $a^2+a+1=0$ and $b=a^2$.

## On a regular projection every center inverse distance has unit cube ratio

If the outer triple is noncollinear, the center equation now gives $w^3=-a-bv^3$. In the ring $\mathbb Z[v,a,w]/(a^2+a+1,w^3+a+bv^3)$ the three barycentric minors, multiplied by $v^2w^2$, are
$$
 n_1=bv^2-aw^2,\quad n_2=bv^2w^2-av^2,\quad n_3=bw^2-av^2w^2 .
$$
For the edges $(12,13,23)$, write the corresponding $D_i=N_i/T_i$. The three numerators are
$$
 (1-a)(v^2-b),\quad (1-b)(w^2-a),\quad (a-b)(bw^2-av^2),
$$
and the denominators are $v^2,w^2,v^2w^2$. Let $n=\sum n_i$. Use the pairs $(i,j)=(12,13)$ and $(12,23)$ with $(k,F)=(1,v^3-w^3)$ and $(2,1-w^3)$, respectively. Their polynomial relations are
$$
 P\left(T_i^3N_j^3n^2,\ T_j^3N_i^3n^2,\ F^2 n_k^2 N_i^3N_j^3\right)=0 .
$$
For each, take the resultant with $w^3+a+bv^3$ in $w$, reduce modulo $a^2+a+1$, and take the resultant with $a^2+a+1$ in $a$. These two integer polynomials in $v$ have degrees 264 and 312, and their primitive gcd is exactly $(v-1)^4(v^2+v+1)^{21}$. Every original solution must annihilate both, giving $v^3=w^3=1$. [Exact resultant verifier](verify_binary_cluster.py)

For collinear triples with $B\ne0$ this was proved above. If $B=0$, the center equation gives $0=\sum\sigma_i/X_i^2=\sum\sigma_i X_i$. The sole rational relation among $1,a,b$ is proportional to their sum, so all signs are equal. Since $r_1=1$, every cube is again 1.

The equality of these cubes makes the three large-force scales $a_i=\sum_{j\ne i}E_{ij}(X_i-X_j)/X_i$ identical. The common-ordinate equations also give the same $C_i$ as in the center-placement proof. Its finite sign check therefore applies without changing any mass in this cluster. The two remaining patterns have either $U_i=1/X_i$ or $U_i=X_i$, with all $E_{ij}$ equal. The two corresponding six-body lifting obstructions at the all-unit specialization are nonzero for every sheet; both persist for generic varying binary mass. This last inference uses the regularity and all-sign coverage proved in the companion notes. [Two surviving geometries and their lifting obstructions](Center94.md)
