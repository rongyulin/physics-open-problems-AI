# A mass restriction for signed four-body absolute equilibria

**Chatgpt · 27 November 2026**

Let the four masses be $(t,1,1,1)$, with $t>0$. An absolute equilibrium here is a set of four points in the complex Euclidean plane with nonzero pair squared distances and signed inverse distances $p_{ij}$, satisfying $p_{ij}^2(q_i-q_j)^2=1$ and $\sum_{j\ne i}m_jp_{ij}^3(q_i-q_j)=0$ for all four bodies. These are the projective equations when the force multiplier is zero. They also describe the limit after rescaling a collapsing quartet whose six distances have a common valuation. For a noncollinear quartet an equilibrium exists exactly for $t=1/\sqrt3$ and the unique positive root of $3t^6-106t^4-97t^2-25=0$. The [separate collinear classification](CollinearAbsoluteMasses.md) gives four additional positive mass ratios, all realized. At $t=2$, collinear and noncollinear absolute equilibria are both impossible over $\overline{\mathbb Q}$ and $\overline{\mathbb F}_{65521}$.

## Inversion of the three outer points

Translate the marked point $o$ to the origin. The symmetric force matrix with off-diagonal entries $m_im_jp_{ij}^3$ and zero row sums annihilates the constant vector and both position vectors. For a noncollinear quartet it therefore has rank one. Its off-diagonal entries are all nonzero. Writing this matrix as $c vv^{\mathsf T}$ and comparing its star and outer edges gives one nonzero $L$ such that $p_{ij}^3=L p_{oi}^3 p_{oj}^3$ for outer edges, and $t=-L\sum_i p_{oi}^3$ because $\sum_i v_i=0$. The affine dependence gives $\sum_i p_{oi}^3 q_i=0$. Rescale the inverse distances by $L^{1/3}$ and the positions by its inverse. Denote the resulting signed inverse star distances by $a_i$ and resulting positions by $Q_i$. Then the outer inverse cubes equal $a_i^3 a_j^3$, $t=-\sum_i a_i^3$, and $\sum_i a_i^3 Q_i=0$.

Put $V_i=a_i^2Q_i$. Then $V_i^2=a_i^2$ and $\sum_i a_i V_i=0$. For $i\ne j$ the squared distances satisfy
$$
\eta_{ij}=(V_i-V_j)^2=a_i^2a_j^2(Q_i-Q_j)^2,\qquad \eta_{ij}^3=1.
$$
Set $\eta_{ii}=0$. Dotting the linear relation with $2V_j$ gives the following four cubics in $(a_1,a_2,a_3,t)$:
$$
 (a_1+a_2+a_3)a_j^2-t-\sum_i\eta_{ij}a_i=0\quad(j=1,2,3),\qquad
 a_1^3+a_2^3+a_3^3+t=0.
$$
The three unit points may be permuted. Multiplying all $a_i$ by a cube root $\rho$ and the three $\eta_{ij}$ by $\rho^2$ preserves all equations and $t$. For positive real $t$, complex conjugation also preserves the mass. Thus for a primitive cube root $w$ the three representative edge patterns are $(1,1,1)$, $(1,1,w)$ and $(1,w,w^2)$.

[AbsoluteQuartet88.py](AbsoluteQuartet88.py) directly reduces each stated univariate polynomial to zero modulo the corresponding four cubics and $w^2+w+1$ over the rationals. Removing the factor $t$, the three necessary polynomials are respectively
$$
 (3t^2-1)(3t^6-106t^4-97t^2-25),
$$
$$
 (9t^{12}-33t^{10}+3724t^8+14825t^6+11487t^4-5500t^2+625)
 (243t^{16}-85860t^{14}+14424304t^{12}+13781204t^{10}+17197074t^8+484271t^6+345418t^4-25725t^2+1875),
$$
and $(3t^2+1)^2(t^4+118t^2+25)$. Exact real-root counts give respectively two, zero and zero positive roots. At $t=2$ the script also tests all ten unordered edge patterns over the split prime 65521 and obtains a unit ideal for every pattern. This latter calculation covers the algebraic closure of the finite field without any positivity assumption.

## Realization of both exceptional ratios

Both masses admit explicit real planar positions with *signed* inverse distances. Let $E_1,E_2,E_3$ be the vertices of a real equilateral triangle of unit side. Pick three nonzero numbers $a_i$ with $S=\sum_i a_i\ne0$. Define
$$
 B=\frac{\sum_i a_i E_i}{S},\qquad V_i=E_i-B,\qquad Q_o=0,\qquad Q_i=V_i/a_i^2 .
$$
Suppose $|V_i|^2=a_i^2$ and $t=-\sum_i a_i^3>0$. Take the signed inverse distances $p_{oi}=a_i$ and $p_{ij}=a_i a_j$ for $i,j\ne o$. Euclidean inversion gives $|Q_i-Q_j|^2=|V_i-V_j|^2/(a_i^2a_j^2)=1/(a_i^2a_j^2)$ and $|Q_i|^2=1/a_i^2$. For $v=(t,a_1^3,a_2^3,a_3^3)$, the matrix $vv^{\mathsf T}$ has off-diagonal entries $m_i m_j p_{ij}^3$. It has zero row sums because $\sum v_i=0$, and it annihilates both position columns because $\sum v_i Q_i=\sum a_i V_i=0$. Thus all four force vectors vanish. A line through all four $Q_i$ would contain all three $V_i$, although these form an equilateral triangle.

For $a_i=-1/\sqrt3$ throughout, $B$ is the ordinary centroid and $|V_i|^2=1/3$. This realizes $t=1/\sqrt3$. For the second mass take the unique real root $u$ of
$$
g(u)=u^3+2u^2+3u+3=0
$$
and set $a_1=a_2=a>0$, $a_3=u a$, $a^2=(1+u+u^2)/(2+u)^2$. The derivative $3u^2+4u+3$ is strictly positive and $-7/5<u<-4/3$, so $2+u$ is nonzero and $2+u^3<0$. Choose $E_1=(-1/2,0)$, $E_2=(1/2,0)$, $E_3=(0,\sqrt3/2)$. Subtracting $B$ gives $|V_1|^2=|V_2|^2=a^2$ and $|V_3|^2=3/(2+u)^2=u^2a^2$. The last equality follows from $u^4+u^3+u^2-3=(u-1)g(u)$. The resulting $t=-a^3(2+u^3)>0$ is the positive root of $3t^6-106t^4-97t^2-25$ (approximately $6.0193086418$). Indeed the resultant in $u$ of $g$ and $t^2(2+u)^6-(1+u+u^2)^3(2+u^3)^2$ equals 243 times that polynomial. Descartes' rule of signs and its opposite signs at zero and positive infinity give exactly one positive root.

This is a classification of the **positive mass ratios** admitting a noncollinear signed absolute equilibrium, allowing complex positions and signed distances. Both constructions have real coordinates and some negative inverse distances. Their force cancellation is possible in the algebraic equations. Ordinary Newtonian gravity takes the positive branch for physical distances. For the role of the fully edged four-body limit and the earlier generic stress reduction, see [Albouy and Kaloshin, §5.5](https://annals.math.princeton.edu/wp-content/uploads/annals-v176-n1-p10-p.pdf) and [Tomar, §7.2](https://hexagonmath.org/pdf/2611.00377v1).

## Collinear quartet

Choose an affine coordinate on the non-isotropic line and place the unit bodies at $0,1,x$, the marked body at $y$. Scaling the positions does not affect zero net force. Every signed term is then a choice of sign times the mass divided by the square of the coordinate separation. Fix the sign on the first unit edge by simultaneous reversal. Writing the remaining five signs as $A,B,C,D,E$, three independent necessary force equations are
$$
 (x^2+A)y^2+tBx^2=0,\qquad
 [C-(1-x)^2](1-y)^2+tD(1-x)^2=0,
$$
$$
 [-A(1-x)^2-Cx^2](x-y)^2+t E x^2(1-x)^2=0 .
$$
The mass is determined by the first equation since $Bx^2\ne0$. After this substitution, [AbsoluteLine88.py](AbsoluteLine88.py) verifies that the two remaining bivariate polynomials are coprime over $\mathbb Q$ for each of the 32 sign choices. Hence they have finitely many affine common zeros, giving finitely many masses. At $t=2$ the squarefree common factors of the three pairwise resultants in $y$ divide $x(x-1)$ over both base fields. Collisions are excluded by hypothesis, and no quartet remains. The two scripts use SymPy, with no reliance on numerical root finding.
