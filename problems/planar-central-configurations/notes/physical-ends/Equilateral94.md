# A cubic obstruction for the equilateral leading configuration of diagram 94

**Chatgpt · 27 November 2026**

At positive masses $(1,1,1,1,1,t)$ consider diagram 94 when the three outside bodies in its four-body cluster all have mass 1. Thus the distinguished mass is at the shared body or in the two-body cluster. The explicit equilateral-triangle-plus-center leading solution with positive internal distances, described in the earlier note, passes the first cross-torque equation for every positive ratio of the two binary masses. The calculation below excludes **lifts of this seed for all but finitely many positive $t$**, across all binary internal signs and both possible triangle orientations. This excludes one family of leading data. Other solutions of the four-body leading equations can occur in the same catalogue cell and remain to be investigated. [Earlier seed and torque](https://github.com/rongyulin/physics-open-problems-AI/blob/2f639b089053cf17fc6fce7274c06991119621ef/problems/planar-central-configurations/notes/Diagrams88and94.md) · [Tomar, §6.7](https://hexagonmath.org/pdf/2611.00377v1)

## A shape chart with a shared body

Use the paper labels. Write $s=4$, $A=\{5,6\}$ and $B=\{1,2,3\}$, $S=m_s$, $m=m_5+m_6$, $n=3$, and $M=m+n+S$. In coordinates relative to $s$, write the positions as

$$
(z_i-z_s,w_i-w_s)=(hU_i,h^{-1}(v_i+h^2b)),\quad i\in A,
$$
$$
(z_j-z_s,w_j-w_s)=(h^{-1}(x_j+h^2a),hY_j),\quad j\in B.
$$

Choose $\sum_A m_i v_i=\sum_B x_j=0$, $v_5-v_6=1$ and $x_1=1$. The two difference scales can be chosen after a common complex rotation and a finite square-root extension of the local parameter: the leading binary separation in $w$ and the large $z$-projection of the first ternary body relative to its cluster mean are nonzero. Their product determines $h^{-2}$. In particular $v_5=m_6/m$, $v_6=-m_5/m$, and $x_3=-1-x_2$. The orders from diagram 94 imply $h\to0$ and bounded small coordinates $U_i,Y_j$. The actual centered coordinates of $s$ are $O(h)$ in both projections. Summing all six absolute positions with the mass weights shows that their relative large-cluster means are $O(h^2)$ in the displayed scaled coordinates, so $a,b$ are bounded too. Distinct internal edges have nonzero limiting squared distances. All choices of signed internal inverse distances continue analytically near each leading solution.

Write $I$ for the centered mass-weighted sum of the products of the two absolute coordinates. Subtracting the square-product of the relative center of mass gives the exact formula
$$
I=\sum_A m_i U_i v_i+\sum_B x_jY_j+
 h^2\left[bU_A+aY_B-\frac{(U_A+na)(mb+Y_B)}{M}\right],
\quad U_A=\sum_A m_iU_i,\quad Y_B=\sum_B Y_j.
$$
For the signed potential $V=\sum_{i<j}m_i m_jp_{ij}$, the force equations with unit multiplier give stationarity of $L=V+I/2$. This follows by differentiating each $p_{ij}=[(z_i-z_j)(w_i-w_j)]^{-1/2}$ on its own local branch. Every genuine solution in the chart with $h\ne0$ therefore satisfies all its partial derivatives, including those in $a,b,h$.

At fixed chart coordinates expand $L=F+hG+h^2 H+h^3 J+O(h^4)$. The function $F$ is the sum of the two isolated internal potentials (each includes the shared mass) and the first two terms of $I/2$. Write $g_{ij}^2=-1/(x_jv_i)$ with the signed branches determined by the distant edges. Then
$$
G=\sum_{i\in A,j\in B}m_i g_{ij},\qquad
J=\frac12\sum_{i,j}m_i g_{ij}
\left(\frac{U_i-a}{x_j}+\frac{Y_j-b}{v_i}\right).
$$
These follow by scaling the exact squared distances on cross edges. All internal distances depend only on $h^2$ at fixed chart coordinates. If $D_A=\sum_A m_i p_{si}/v_i$ and $D_B=\sum_B p_{sj}/x_j$ denote their internal expressions evaluated at $h=0$, then
$$
2H=b(U_A-SD_A)+a(Y_B-SD_B)-(U_A+na)(mb+Y_B)/M.
$$

## Reducing to two variables

The equilateral leading solution is $x=(1,\omega,\omega^2)$ with $\omega^2+\omega+1=0$, $Y_j=\beta/x_j$, $\beta=R^2$, $R^3=S+1/\sqrt3$. Its internal inverse distances are $1/R$ on center edges and $1/(\sqrt3 R)$ on triangle sides. Here $Y_B=D_B=0$. It solves the stationarity equations of $F$ for group $B$. The binary leading data must solve the remaining $F$-equations for $U_i$. At the equilateral projection, $g_{ij}=d_i\sigma_{ij}x_j$, where $d_i^2=-1/v_i$ and $\sigma_{ij}=\pm1$. A nonzero signed sum of $1,\omega,\omega^2$ is twice a sixth root of unity. The ratio $m_6d_6/(m_5d_5)$ is purely imaginary. Hence $G=0$, the necessary $h$-stationarity condition at zero, implies *each* row sum vanishes, with constant signs in each row; absorb these signs in $d_i$. For infinitesimal centered shape changes one has $\sum_j dx_j=0$, and $dg_{ij}=-(d_i/2)dx_j$ at the seed. Thus $G=0$ and $dG=0$ there.

Solve $\partial_aL/h^2=\partial_bL/h^2=0$ for $a,b$ by the analytic implicit function theorem. At $h=0$ the diagonal of their Jacobian is zero and its off-diagonal is $-mn/(2M)\ne0$. At the seed, the unique solution is
$$
b_0=0,\quad \lambda=(U_A-SD_A)/m,\quad a_0=(M\lambda-U_A)/n.
$$
For fixed $x_2$, the Hessians of $F$ in the two $U_i$ and the three $Y_j$ are invertible at the all-equal witness, as checked below. This holds outside finitely many $t$ on each algebraic family of these seeds. Eliminate these five variables by their stationary equations. At fixed $x_2$ their first derivatives in $h$ vanish at zero because $G$ depends only on $x$. Consequently the reduced coefficients of $h^2$ and $h^3$ are $H$ and $J$ evaluated at the unperturbed transverse stationary values (with $a,b$ stationary for $H$). Their $h$-variations contribute first at order four. In particular the coefficient $H$ at the seed is zero.

Let $k=x_2-\omega$. The reduced germ has no linear terms. Its only possible quadratic term is a multiple of $k^2$. Denote the homogeneous cubic part by
$$
P(k,h)=f k^3+g hk^2+e h^2k+jh^3.
$$
If the quadratic coefficient is nonzero, $\partial_kL=0$ forces $k=O(h^2)$ near the seed, and $\partial_hL=0$ then requires $j=0$. If the quadratic coefficient vanishes, a nonconstant stationary branch requires the two first derivatives of $P$ to have a common projective zero. Indeed normalize $(k,h)$ by its largest absolute coordinate and take a limiting direction in complex projective space in the two gradient equations. A nonzero discriminant excludes such a direction. Thus it suffices to show that both $j$ and the discriminant are nonzero for generic $t$.

## Coefficients at six equal masses

Set $t=1$, so $m=2,n=3,S=1,M=6$, and write $u=p_{s5}^3=p_{s6}^3$, $r=p_{56}^3/u$, $q=(v_6 U_6)/(v_5 U_5)$. The binary equations and distance equations imply
$$
q^3=1,\quad 8(1+q)^3 r^2=1,\quad u=(1+2r)^{-1},
\quad U_5=\alpha,\quad U_6=-q\alpha,\quad \alpha^3=8/u^2.
$$
In fact the center is in the large binary coordinate's origin child, so $\sum_A m_i v_i=0$, and $v_5=-v_6=1/2$. The equations for $U_5,U_6$ (equivalently, the large-coordinate force equations) give equal inverse-distance cubes on center edges and $1=u+2p_{56}^3$. The ratio of the squared lengths $D_{56}/D_{s5}=2(1+q)$ gives the equation for $r$. More generally, for positive $b_5=m_5,b_6=m_6$ the binary quantities satisfy $q^3=1$, $U_6=-q b_6 U_5/b_5$, $D_{56}/D_{s5}=m(b_5+q b_6)/(b_5 b_6)$, $r^2=(D_{56}/D_{s5})^{-3}$ and $1=(S+mr)u$. These equations and a cube root for $U_5$ give finite algebraic families; all denominators and internal distances stay nonzero above $t=1$. The $U$-Hessian at $1$, divided by the common nonzero factor $3p_{s5}/(4\alpha^2)$, is $\mathrm{diag}(1,q^{-1})+2r(1+q)^{-1}\left(\begin{smallmatrix}1&-1\\-1&1\end{smallmatrix}\right)$. Its determinant is $(1+2r)/q\ne0$.

Put $s_3=\sqrt3$, $d=d_5$, $l=d_6/d_5$; then $d^2=-2$, $l^2=-1$, $\beta^3=(1+1/s_3)^2$. Write $Y_j=\beta y_j$ in the following coefficient computations. The $B$ part of $F/\beta$ has inertia term $\sum x_j y_j/2$. At the seed $y_j=1/x_j$, its edge values of the normalized potential are $p_0=(1+1/s_3)^{-1}$ on center edges and $p_0/s_3$ on triangle sides. For an edge, put $A=\dot x_{ij}/x_{ij}$ and $B=\dot y_{ij}/y_{ij}$; the center has reference coordinates and variations zero. Its potential along a straight perturbation is its initial value times $(1+k A)^{-1/2}(1+k B)^{-1/2}$. This gives the edge contributions to the Hessian and to the third derivative explicitly.

Use $\dot x=(0,1,-1)$ and solve the three small-coordinate Hessian equations for $\dot y$ to obtain the tangent to the transverse stationary manifold. Write $b_1=\sum\dot y_j$ and $c_1=p_0\sum_j x_j^{-1}(-3\dot x_j/x_j-\dot y_j/y_j)/2$. They are the derivatives of $Y_B/\beta$ and $D_B/\beta$. The coefficient $f$ is $\beta$ times the sum of the normalized edge values times $[-5(A^3+B^3)-3AB(A+B)]/16$; the quadratic inertia gives no straight-line cubic. Corrections from the curvature of the stationary manifold vanish by the differentiated small-coordinate stationarity equations and the choice of $x_2$ as parameter. Put $L_0=(1-q)r u$ and $A_0=(6L_0-1+q)/3$, so $\lambda=\alpha L_0$ and $a_0=\alpha A_0$. The remaining three cubic coefficients are
$$
g=-3d(1+l)/8,\qquad
e=\alpha\beta\big[(A_0-L_0)b_1-A_0c_1\big]/2,
$$
$$
j=(3d/2)\big[(1-lq-(1+l)A_0)\alpha+2(1-l)\beta\big].
$$
In particular $e$ is the derivative of $H$, with no contributions from varying the two stationary variables of $H$. The formula for $g$ uses $\sum_j\dot x_j^2/x_j=-1$.

## Exact replay

The standalone check uses the prime 73. The equations for $\omega,s_3,q,r,l,d$ split with distinct roots modulo 73. It checks every such root and, over the cubic field extension, all three cube roots for each of $\alpha,\beta$. It verifies the two transverse Hessian determinants, $j\ne0$, and
$$
g^2e^2-4fe^3-4g^3j-27f^2j^2+18fgej\ne0
$$
for all 864 combinations. The algebraic values at $t=1$ satisfy monic equations after inverting the displayed denominators; these denominators are units on every residual tuple tested. If any value were zero in characteristic zero, its reduction at a place above 73 would give one of the zero tuples tested. Equivalently take the product over all roots, after clearing all denominators. Its reduction is nonzero. The same product argument on the finite algebraic families in $t$, regular over $1$, allows at most finitely many positive parameter exceptions for either mass allocation. This argument certifies this specialization at $t=1$ itself as well. This is a local analytic obstruction with finite-field arithmetic replay. [Python verifier](equilateral94.py)

[Lean certificate](../../Lean/EquilateralCubic94.lean) proves over every characteristic-zero field that a nonzero stationary direction of a binary cubic forces its discriminant to vanish. The chart, asymptotic reduction and finite-field enumeration above are separate analytic and arithmetic arguments.
