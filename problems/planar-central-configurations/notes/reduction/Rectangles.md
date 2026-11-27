# The remaining rectangle cells in diagrams 99, 100 and 101

We use zero-based body labels as in Tomar’s data. The original residual keys are the rows of the 738-placement census. The node balance test removes 116 of 142 rows of diagram 100 and 26 of 28 of diagram 101. Here we treat the other 30 rows in diagrams 99–101. For generic positive $t$ this accounts for all original rows in the three diagrams. The conclusion concerns possible singular places in the census. The argument combines Tomar’s equations for a fixed-mass curve, constancy of its signed potential $U=\sum m_i m_j p_{ij}$, the subset torque, and the coordinate-tree rule. [Tomar, Lemma 2.3(b), §2.3 and Lemma 4.2](https://hexagonmath.org/pdf/2611.00377v1)

Normalize the large projections separately as $Z_i=z_i/A$, $W_i=w_i/B$, taking $A,B$ to be half the corresponding differences across the four unit-mass rectangle vertices. A finite Puiseux extension allows $h=(AB)^{-1/2}\to0$. The force equations in each projection keep their original form, and $p_{ij}^2 Z_{ij}W_{ij}=h^2$. The four rectangle vertices have leading positions $(1,1),(1,-1),(-1,1),(-1,-1)$ up to order and coordinate signs. Bodies in the same projected column or row have equal leading coordinates by the tree, and opposing coordinates are negatives by adding the two mass-weighted mutual force equations at a unit binary. The square in these projected coordinates need not be a physical square. The two diagonals always contribute $K=(\pm 1\pm i)/2$ to the coefficient of $h$ in $U$.

## A close column in diagram 100

In each of 12 cells of class 64 (24 placements), exactly one member $u$ of the binary $J=\{2,3\}$ shares a noncentral top-level $z$ child with two rectangle vertices $a,b$. Its sibling inside that node contains both $a,b$. All other $J$-to-rectangle $z$ differences are at the root scale. The leading $w$ positions of the binary members vanish at the rectangle scale; those of $a,b$ equal $W,-W$ with $W\ne0$, by their mutual $w$-binary equations. All binary-to-rectangle $w$ differences have root scale. Thus $p_{ua}$ and $p_{ub}$ have the same valuation, strictly below the valuations of all the other cross inverse distances. Their normalized leading ratio $k$ has $k^2=-1$, since the leading $z$ differences agree and the leading $w$ differences are opposite.

Use the exact torque $\sum_{j\in J,\,l\notin J}m_jm_l p_{jl}^3(Z_j W_l-Z_l W_j)=0$. Each parenthesized factor has nonzero order-zero limit. The two close edges are the only terms of least valuation, so their coefficients must sum to zero. Since $m_a=m_b=1$, this forces $k^3=1$, contradicting $k^2=-1$. The verifier checks the nested child partitions and the required two-body force supports for these cells.

## Separated columns in diagram 100

In class 64 cell 0 the projected binary has limiting coordinates $(y,0)$ and $(-ty,0)$ after assigning the first body mass $t$ and the second mass 1. This follows by adding their two leading $z$ equations. The tree gives $y\ne0$ and all four differences $L=(y-1,y+1,-ty-1,-ty+1)$ nonzero. The five finite inverse distances are those on rectangle sides and inside the binary. The other ten have order $h$ with nonzero normalized limits. On a rectangle side use whichever coordinate separates its two endpoints at order one. The other finite rectangle edge at each endpoint has difference $O(h^2)$ in that coordinate by the distance equation. All far forces are $O(h^3)$. Subtracting the two body equations therefore gives $p_{ij}^3=1/2+O(h^2)$. The mixed binary similarly gives $p_{23}^3=1/(1+t)+O(h^3)$ in $Z$. A nonzero cube root with a specified limiting branch varies by the same order. Consequently none of these five edges contributes at order $h$ in $U$. Constancy of $U$ on the fixed-mass curve forces the sum of the far-edge coefficients to vanish.

For the binary edges into each rectangle column at $Z=1$ or $-1$, the two $W$ values are $1,-1$. The sum of the two inverse-distance coefficients has numerator $d\in\{\pm1\pm i\}$ divided by a chosen square root of the $Z$ difference. Combining the eight binary edges and the two diagonals therefore gives $C(y)=0$ where, after division by $K$,
$$
C(y)/K=1+\sum_{j=1}^4 v_j(y),\qquad
v_j^2=4s_j m_j^2/L_j(y),\qquad
(m_1,m_2,m_3,m_4)=(t,t,1,1),\quad s_j=\pm1 .
$$
Indeed $d^2/K^2=\pm4$. There is a second equation $C'(y)=0$. For a far binary-to-rectangle edge write $g=\lim p/h$, binary endpoint $Z_j=y$ or $-ty$, and rectangle endpoint $(Z_l,W_l)$. Then $g^2 (Z_j-Z_l)(-W_l)=1$. Choosing its local square-root branch near $y$ gives $2y g'(y)=g^3 Z_j W_l$. The subset torque of the binary, divided by $h^3$, is precisely the weighted sum of these limits; the two diagonal terms are constant in $y$. Since $y\ne0$, this proves the derivative condition without differentiating a family of actual six-body solutions.

For each of the 16 sign choices $s$ take
$$
P_s(Y)=\bigl(\prod_j L_j(Y)\bigr)^8
\prod_{\epsilon\in\{-1,1\}^4}\left(1+\sum_j\epsilon_j v_j(Y)\right).
$$
Sign invariance makes the product a polynomial in the $v_j^2$, with each separate exponent at most eight. Thus $P_s\in\mathbb Z[t,Y]$, of $Y$-degree exactly 32 and leading coefficient $t^{16}$ (the unscaled sign product tends to 1 at infinity). A zero of $C$ and $C'$ where the denominators are units gives a multiple root of $P_s$. At $t=2$ each $P_s$ has degree 32 and is coprime to its derivative modulo 1009. This proves that its discriminant is nonzero in $\mathbb Q(t)$. The verifier evaluates the four successive conjugate products, interpolates the polynomial over the prime field, and checks the gcd. No floating-point root finding enters.

## Central binary in diagram 99

In class 8 cell 0 the two mixed-binary bodies both have zero leading projections at the outer scales. Again the only finite edges are the four sides and the binary. The stronger of the two normalized projections of the binary separation has magnitude bounded below by a constant times $|h|$, by its finite nonzero inverse distance and $p^2 Z_{ij}W_{ij}=h^2$. The total error from all far forces is $O(h^3)$, so subtracting the two binary equations in that projection gives $p_{01}^3=1/(1+t)+O(h^2)$. Rectangle side estimates are as before.

For either binary member the four far inverse-distance coefficients to the rectangle sum to an element of $2\mathbb Z[i]$: two corners give a choice of $\pm1$ each and the other two give $\pm i$ each. The order-$h$ energy equation has the form $K+P+tQ=0$ with $P,Q\in2\mathbb Z[i]$ in finite sets. Each real component of $P,Q$ belongs to $\{-2,0,2\}$, while the real component of $K$ is $\pm1/2$. Hence the real part of $Q$ is nonzero and the only possible positive $t$ are $1/4,3/4,5/4$. This also excludes $t=1$. There is just one catalogue cell for diagram 99. For a marked body in the rectangle, the opposing $z$ binary balances on the two equal-position pairs give $m_2m_3=m_4m_5$, which forces $t=1$. At that all-equal point the energy contradiction applies in every placement. Thus diagram 99 cannot supply a nonpositive end at any positive $t$ outside the three displayed candidates. The calculation gives no existence claim at those candidates.

## The attached triple in diagram 101

The last two placements are in class 116 cell 5, with variable mass at 0 or 5. The rectangle is $\{1,2,3,4\}$. Put $r=m_5/m_0$. In the large $Z$ projection the columns satisfy $Z_2,Z_3,Z_5\to1$, $Z_1,Z_4\to-1$, and $Z_0\to-r$ by the $0,5$ binary. The $W$ root contains $W_5,W_0\to0$. Set $B=(w_2-w_3)/2$ and take $A$ so that the two columns have limits $\pm1$. In normalized coordinates the three-child $w$ node at the origin for $0,5$ and their finite distance give $W_5,W_0=O(h^2)$. The seven finite edges are $05,13,24,14,23,25,35$.

For edges $05,13,24$ subtract the two body equations in $Z$; for $14$ subtract them in $W$. Each other finite force occurring at either end has difference $O(h^2)$ in the chosen coordinate, and each far force is $O(h^3)$. Hence their inverse-distance cubes differ from the appropriate binary constants by $O(h^2)$. Adding the two $W$ equations at 1 and 4 gives $W_1+W_4=O(h^2)$. Since $W_2-W_4=O(h^2)$, $W_3-W_1=O(h^2)$ and $W_2-W_3=2$, one has $W_2=1+O(h^2)$ and $W_3=-1+O(h^2)$.

In the $W$ equation at body 5, only the interactions with 2 and 3 can contribute at order one. It gives $p_{25}^3-p_{35}^3=O(h^2)$, hence $p_{35}/p_{25}=q+O(h^2)$ with $q^3=1$. The exact distance identities and $Z_{23}=Z_{25}-Z_{35}$ give
$$
p_{23}^{-2}= (W_2-W_3)\left(\frac{p_{25}^{-2}}{W_2-W_5}-\frac{p_{35}^{-2}}{W_3-W_5}\right)
=2(p_{25}^{-2}+p_{35}^{-2})+O(h^2).
$$
Because $1+q^{-2}\ne0$, the ratio $p_{23}^3/p_{25}^3$ equals a nonzero constant $\gamma$ up to $O(h^2)$. The $W$ equation at 2 now gives $1=(2\gamma+m_5)p_{25}^3+O(h^2)$. Its coefficient is nonzero, since the inverse distance stays finite. All seven finite edges therefore have their limiting values up to $O(h^2)$.

The two diagonal edges of the rectangle give $K$ as before. Edges from 5 to 1 and 4 contribute $m_5(\pm1\pm i)/\sqrt2$. Edges from 0 to the two pairs of rectangle vertices contribute $m_0 (\pm1\pm i)/\sqrt{1-r}$ and $m_0 (\pm1\pm i)/\sqrt{-1-r}$. At $(m_0,m_5)=(1,2)$ the sum consequently lies in $K+\mathbb Z[i]+\sqrt2\,\mathbb Q(i)+\sqrt3\,\mathbb Q(i)$; its rational Gaussian part is nonzero. At $(m_0,m_5)=(2,1)$ it lies in $K+\sqrt2\,\mathbb Q(i)+\sqrt6\,\mathbb Q(i)$, likewise with nonzero rational Gaussian part. These coefficient classes are linearly independent over $\mathbb Q(i)$ by the independent sign changes of $\sqrt2,\sqrt3$ in $\mathbb Q(i,\sqrt2,\sqrt3)$. Thus the order-$h$ energy equation fails for every sign at either specialization. The finite product over the choices of radicals and signs is invariant under the signs of the square roots. It gives a nonzero rational function of $t$ because all terms are defined and nonzero at $t=2$. Its zero set and the previously discarded denominator zeros are finite.

## Replay and scope

Run `python3 rectangle.py /path/to/smale6-source RemainingCorePlacements.csv node_excluded.csv RectangleRemoved.csv` after running the linear-force replay. It checks each selected tree type, the finite-distance lists for the separated calculations, the needed mutual-force supports in the close-column case and the exact squarefreeness certificates. The asymptotic error estimates and the link to the six-body equations are the hand proofs above. These tests do not establish nonexistence at every positive specialization.
