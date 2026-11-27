# Diagram 88 with the varying mass at the vanishing quartet projection

**Chatgpt**

For quartet masses $(t,1,1,1)$, place $t$ at body $o$, where $Y_o=0$ and $X_o\ne0$. The two binary masses are one. Such a diagram-88 end can occur for at most finitely many positive $t$, even when the internal distance choices and coordinates are complex. In particular this removes the physically compatible representative $(127,0,3)$ in the (class, cell, one-based slot) catalogue. We use the necessary quartet equations and first torque of [Tomar, Lemmas 6.16–6.17](https://hexagonmath.org/pdf/2611.00377v1). The remaining three quartet bodies are denoted $1,2,3$ within this note.

## The shape chart

Write $M=t+3$, let $P=p_{o1}$, and set $(r_1,r_2,r_3)=(1,r,s)$ with $r_i=p_{oi}/P$. All inverse distances are nonzero. The signed quartet equations give $\sum m_iX_i=\sum m_iY_i=0$, and in each coordinate $u$ the force equation is $u_i=\sum_{j\ne i}m_j p_{ij}^3(u_i-u_j)$. All $X_i$ are nonzero and distinct, and the four $Y_i$ are distinct. The quartet cannot be collinear: any line containing these points would give $Y=aX+b$ with $a\ne0$, and centering forces $b=0$.

Centering and the $Y$ force at $o$ yield $\sum_{i=1}^3Y_i=\sum_{i=1}^3r_i^3Y_i=0$. Since no outer $Y_i$ vanishes, the three cubes are either all equal or pairwise distinct. In the distinct case we can rescale the opposite projections reciprocally so that
$$
y=(Y_1,Y_2,Y_3)=(r^3-s^3,s^3-1,1-r^3).
$$
Define $d_i=1/(r_i^2 y_i)$, so $X_i-X_o=P^{-2}d_i$. Let $D=\sum d_i$ and $k=\sum r_i^3d_i/D$. Centering and the $X$ force at $o$ give
$$
X_o=-P^{-2}D/M=-P\sum_i r_i^3 d_i,\qquad k=(MP^3)^{-1}.
$$
Thus $D$ and $k$ are nonzero. For $i,j\ne o$ put $b_{ij}=(p_{ij}/P)^3$. The distance identities imply
$$
b_{ij}^2=E_{ij}:=[(y_i-y_j)(d_i-d_j)]^{-3}.
$$

## Rank-one stress and two planar equations

Form the symmetric $4\times4$ matrix whose off-diagonal entries are $m_i m_j(p_{ij}^3/P^3-k)$, with diagonal chosen for zero row sums. It annihilates the three independent columns $\mathbf1,X,Y$ by centering and the force equations. Its rank is at most one. When nonzero, write its entries $c m_i T_i m_j T_j$ for some $c\ne0$ and $T$ with $\sum m_iT_i=0$. In the distinct-cubes case the stress is nonzero and $T_o\ne0$, since its edges from $o$ have coefficients $\alpha_i=r_i^3-k$ that cannot all vanish. Therefore
$$
b_{ij}-k=L\alpha_i\alpha_j,\qquad L=1/(cT_o^2),\qquad t=-L\sum_{i=1}^3\alpha_i.
$$
For either $(i,j,k')=(1,2,3),(2,1,3)$ this gives
$$
\alpha_{k'}b_{ij}-\alpha_j b_{ik'}=k(\alpha_{k'}-\alpha_j).
$$
For each relation, put $a_1=\alpha_{k'}^2 E_{ij}$, $a_2=\alpha_j^2 E_{ik'}$ and $a_3=k^2(\alpha_{k'}-\alpha_j)^2$. Then $(a_1+a_2-a_3)^2-4a_1a_2=0$. The [exact replay](ZeroProjection88.py) clears denominators and cancels common factors before squaring. These cancellations do not remove a shape: all edge denominators and numerators are nonzero, and $\alpha_{k'},\alpha_j$ cannot vanish simultaneously because $r_{k'}^3\ne r_j^3$. In particular both triples simplified by `cancel_triple` have at least one of their first two entries nonzero on the chart.

The resulting two integer polynomials $F_1,F_2$ each have degree 100 in $r$ and 100 in $s$. At $s=2$ modulo 1009 they retain $r$-degree 100 and have monic gcd one. Their Sylvester resultant in $r$ is therefore a nonzero element of $\mathbb Z[s]$. The same certificate at $r=2$ proves the resultant in $s$ is nonzero. Thus every common complex zero belongs to a finite set. This checks both projections and allows coordinates to approach the boundary under specialization. For any fixed admissible $(r,s)$ at least two $\alpha_i$ are nonzero. The corresponding $b_{ij}$ has only two values, so the displayed equations give only finitely many values of $L$ and $t$.

## Equal cubes

Now $r_i^3=1$ and $k=1$. Normalize $Y_1=1$ and write $(Y_1,Y_2,Y_3)=(1,x,-1-x)$. The coordinates relative to $o$, up to reciprocal scaling and the common factor $P^{-2}$ in $X$, are $(d_i,Y_i)=(r_i/Y_i,Y_i)$.

If the stress is zero, all $b_{ij}=1$. In particular $[(1-x)(1-r_2/x)]^3=1$. This nonconstant rational function condition gives finitely many $x$. If the stress has rank one, every off-diagonal entry at $o$ is zero, so the zero row sums force its entire $o$ row to vanish. Its nonzero kernel relation $\sum m_i T_i(1,X_i,Y_i)=0$ is therefore supported on the outer three. Those three are collinear, hence $\det[1,Y_i,r_i/Y_i]_{i=1}^3=0$. As $x\to0$ the summand containing $r_2/x$ has nonzero residue (of magnitude $2$), whereas the others remain bounded. This too gives only finitely many $x$. The triples $d$ form a finite set; $D=\sum d_i\ne0$ as before.

For each fixed triple the centered $X$ positions, up to common scale, are $x_o=-D/(t+3)$ and $x_i=d_i-D/(t+3)$. The first torque for an equal binary requires
$$
\frac{t c_o}{\sqrt{x_o}}+\sum_{i=1}^3\frac{c_i}{\sqrt{x_i}}=0,\qquad c_i\in\{1+i,1-i,-1+i,-1-i\}.
$$
For positive $t\to\infty$ the first term grows in modulus as a nonzero constant times $t^{3/2}$ while all other terms stay bounded, uniformly in signs. Multiplying all conjugates over the square-root signs gives a rational function of $t$ with no zero for sufficiently large positive $t$. Each fixed shape and sign choice therefore permits at most finitely many positive $t$. This completes the equal-cubes branch.

## Varying mass at an outer body in the equal-cubes branch

Place $t$ at outer body 1 and let $m_o=m_2=m_3=1$. The following additional exclusion assumes $r_i^3=1$. The force at $o$ again gives $k=1$ because $\sum m_i d_i\ne0$. For zero stress normalize $Y_1=1$. The test $[(1-Y_j)(1-r_j/Y_j)]^3=1$ gives finitely many $Y_j$ independently for $j=2,3$; centering gives $t=-Y_2-Y_3$.

For rank-one stress the three outer bodies are collinear as above. Write $d_i=aY_i+b$ with $a\ne0$. The distance equation $Y_i d_i=r_i$ yields, with $u_i=\sqrt a Y_i+\beta$ and $\beta=b/(2\sqrt a)$,
$$
u_i^2=B+r_i,\qquad B=\beta^2.
$$
Their mutual squared lengths in normalized coordinates are $(u_i-u_j)^2$. The vanishing stress applied to the $Y$ coordinate at body 1, whose two outer neighbors have mass one, becomes
$$
\frac{\epsilon_2}{(u_1-u_2)^2}+\frac{\epsilon_3}{(u_1-u_3)^2}=2u_1-u_2-u_3,\qquad \epsilon_2,\epsilon_3\in\{1,-1\}.
$$
This fails identically on every collision-free component of the radical cover of the $B$-line. At a place over $B=\infty$ each $u_i$ has leading term $\delta_i\sqrt B$ with $\delta_i=\pm1$. If both other signs are opposite to $\delta_1$, the left side is $O(B^{-1})$ and the right has a nonzero term of order $\sqrt B$. If only one matches, the matching difference is asymptotic to a nonzero multiple of $B^{-1/2}$, since equal radicands and matching signs would collide identically. Thus the left has order $B$ while the right has order $\sqrt B$. If all match, the three $r_i$ are distinct cube roots of unity. The two terms of order $B$ on the left cannot cancel because $[(r_1-r_2)/(r_1-r_3)]^2$ is a nonreal cube root of unity. The right tends to zero. For any remaining $B$ there are finitely many $u_i,\beta$, and $t=-(u_2+u_3-2\beta)/(u_1-\beta)$ by centering. The denominator is nonzero because $Y_1\ne0$. Thus this branch permits only finitely many $t$. The distinct-cubes branch in this outer placement requires a separate analysis.

## A three-equation chart for the remaining mixed-mass branch

Continue with the mass at outer body 1 and assume the three cubes are distinct. Write $(a_1,a_2,a_3)=(1,r^3,s^3)$. Then $y=((r^3-s^3)/t,s^3-1,1-r^3)$, $d_i=1/(r_i^2 y_i)$, $m=(t,1,1)$, and $k=\sum m_i a_i d_i/\sum m_i d_i\ne0$. The rank-one identities give, with $\alpha_i=a_i-k$ and $W=\sum m_i\alpha_i$, the relation $1=-LW$. Hence $W\ne0$ and each edge inverse cube is rational in three variables:
$$
b_{ij}=k-\frac{\alpha_i\alpha_j}{W},\qquad b_{ij}^2[(y_i-y_j)(d_i-d_j)]^3=1.
$$
[The symbolic reduction](OuterZeroChart88.py) gives three polynomials whose degrees in $(r,s,t)$ are $(50,54,14)$, $(54,50,14)$ and $(50,50,8)$. The restrictions are nonzero $r,s,t,k,W,\sum m_i d_i$, distinct cubes, and nonzero pair differences in $y$ and $d$. The quartet projection, in the same relative $X$ scale, is $x_o=-\sum m_i d_i/(t+3)$, $x_i=d_i+x_o$. All four must be nonzero. The equal-binary torque then applies to these same four centered entries. This chart reduces the mixed-mass case to three scalar variables, and supplies the input for the [fixed-mass exclusion](MixedZeroFibre.md) and its [boundary argument](BoundaryAudit.md).

[Lean checks of the ring identities](../../Lean/ZeroProjection88.lean) cover the equal-cubes dichotomy, elimination of the common stress coefficient, and removal of square-root signs in the marked-zero computation.
