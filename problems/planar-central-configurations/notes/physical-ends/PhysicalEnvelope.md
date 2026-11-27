# A mass derivative excludes the isolated marked binary in diagram 88

**Chatgpt · Working note · 27 November 2026**

Consider positive planar Newtonian central configurations with five unit masses and marked mass $t>0$. Translate the center of mass to the origin and scale so the acceleration of body $j$ is $-q_j$. Write $r_{ij}=|q_i-q_j|$, $I=\sum m_i|q_i|^2$ and $U=\sum_{i<j}m_i m_j/r_{ij}$. Write $j$ for the marked body. Define

$$
H_j=\sum_{i\ne j}1/r_{ij} + |q_j|^2/2.
$$

For every real normalized central configuration we prove the uniform strict inequality $H_j>3/[2(1+t)^{1/3}]$. For a generic mass parameter, the quantity extending $H_j$ to a component containing physical configurations is constant on each irreducible geometric generic fibre component. In diagram 88 the absolute value of its limit on the isolated binary containing the marked body is at most $3/[2(1+t)^{1/3}]$. Consequently a curve required to contradict **generic real finiteness** cannot have this type of end. This removes the real-compatible representatives $(127,0,1)$ and $(127,6,1)$, with indices (Tomar class, cell, one-based marked slot). The remaining four-body placements require separate arguments. The specialization of a single isolated exceptional mass is not covered by the parameter derivative argument.

## A uniform bound on the inertia

Choose two perpendicular real axes in generic directions so all the projected coordinates on each axis are pairwise distinct. Fix one axis and write its coordinates as $x_i$. For this calculation hold the positive coefficients $a_{ik}=(|x_i-x_k|/r_{ik})^3\le1$ fixed. The projection of the normalized force equations says that $x$ is a stationary point of

$$
V_a(u)=\sum_{i<k}\frac{m_i m_k a_{ik}}{|u_i-u_k|}
       +\tfrac12\sum_i m_i u_i^2 .
$$

On the open convex chamber determined by the ordering of $x$ this function is strictly convex. Thus $x$ is a global minimum on its chamber. Varying along the ray through $x$ gives $V_a(x)=3I_x/2$ with $I_x=\sum_i m_i x_i^2$.

Let $k_i$ denote the rank of body $i$ in this order and use trial coordinates $u_i=s(k_i-k_j)$ for $s>0$. Testing an uncentered trial is allowed because $x$ minimizes on the entire chamber. Replacing $a_{ik}$ by 1 only increases the trial value, so $I_x\le(B^2 C)^{1/3}$ upon minimizing in $s$, where $B=\sum_{i<l}m_i m_l/|k_i-k_l|$ and $C=\sum_{i\ne j}(k_i-k_j)^2\le55$. For the latter inequality, if there are $k$ ranks on the left and $5-k$ on the right, the sum of their squared distances is bounded by $\sum_{l=1}^5 l^2$. The unit-unit portion of $B$ is at most $\sum_{d=1}^4(5-d)/d=77/12$, by deleting the marked rank. The marked terms have sum at most $5t$, hence $B\le (77/12)(1+t)$. Adding the bounds for perpendicular projections gives

$$
I\le 2[55(77/12)^2]^{1/3}(1+t)^{2/3}<27(1+t)^{2/3}.
$$

Since $\sum_i m_i q_i=0$, one has $\sum_{i\ne j}r_{ij}^2=I+(5+t)|q_j|^2$. Jensen's inequality for $v\mapsto v^{-1/2}$ gives $\sum_{i\ne j}1/r_{ij}\ge5\sqrt5/\sqrt{I+(5+t)|q_j|^2}$. Put $y=|q_j|^2(1+t)^{1/3}$. If $y\ge3$, the marked inertia term alone supplies at least $3/2$ after rescaling by $(1+t)^{1/3}$, and all inverse distances are strictly positive. If $0\le y<3$, the rescaled inverse-distance sum exceeds $5\sqrt5/\sqrt{27+5y}\ge5\sqrt5/\sqrt{42}>3/2$. This proves the stated inequality.

## A second first integral on the generic mass line

In the signed complex coordinates $z_i,w_i,p_{ik}$ used by Tomar, set $I=\sum m_i z_iw_i$ and $U=\sum_{i<k}m_im_kp_{ik}$. We use centered coordinates and retain the algebraic distance equations $p_{ik}^2(z_i-z_k)(w_i-w_k)=1$. Consider an irreducible component dominating the $t$-line, with function field $L$ in characteristic zero, and an extension of the derivation $d/dt$ to $L$. More generally allow any derivation $D$ of $L$ over the constant field. Direct differentiation gives

$$
D p_{ik}=-\tfrac12p_{ik}^3\{(w_i-w_k)D(z_i-z_k)+(z_i-z_k)D(w_i-w_k)\}.
$$

When differentiating $U+I/2$, every coordinate-derivative coefficient vanishes by the normalized force equations. Consequently

$$
D(U+I/2)=D(t)\,H_j,\qquad H_j=\sum_{i\ne j} p_{ij}+z_jw_j/2 .
$$

This identity uses the symmetric complex bilinear form. The real slice gives its positive-distance interpretation. The force equations also imply $U=I$. Applying the displayed formula to all derivations over $\mathbb C(t)$ (or the chosen constant field) shows that $U$ is algebraic over the parameter field, by separability. Choosing any derivation with $D(t)=1$ gives $H_j=(3/2)D(U)$ algebraic over that field, since differentiation extends uniquely through a finite algebraic extension. Thus both quantities are constant on irreducible geometric generic fibre components.

To state the physical specialization precisely, stratify the finite-type total algebraic solution family by smooth irreducible locally closed pieces dominating the $t$-line or mapping to a point. On each dominant closure the preceding argument supplies a polynomial relation for $H_j$ over $\mathbb C(t)$. After clearing denominators, omit the finitely many parameters where it becomes identically zero. For each other parameter $H_j$ takes values in a finite set on that component, hence it is constant on an irreducible fibre component and on any irreducible curve in one. For infinitely many physical shapes at a fixed such real parameter, choose a component containing infinitely many real normalized shapes and a nontrivial curve in its closure as in the real-origin argument. Its value of $H_j$ obeys the same strict lower bound as any of those shapes. This construction allows exclusions at generic positive parameter even when the infinitely many real shapes are known at only one such parameter. The omitted special values are algebraic when the total system and its components are taken over $\overline{\mathbb Q}$.

## The isolated binary

In the numbering of Tomar's §6.7, diagram 88 has a binary $B=\{5,6\}$ and a four-body cluster $K=\{1,2,3,4\}$. In the two-color valuations, the $z$-coordinates of $B$ have order $-2$, their $w$-coordinates order at least $2$, and $\zeta_{56}=-2$, $\omega_{56}=2$. Between $B$ and $K$ one has $\zeta=\omega=-2$, hence $e(p)=2$ and each cross force in either coordinate has order $4$. Therefore the order $-2$ and $2$ force equations on $B$ in the respective coordinates involve only its internal force. With $m_j=t$ at the marked endpoint and the other mass one, put $Z_i=[z_i]_{-2}$ and $W_i=[w_i]_2$ for $i\in B$, and $b=[p_{56}]_0\ne0$. Then $tZ_j+Z_k=tW_j+W_k=0$, and subtracting the internal equations gives $b^3=(1+t)^{-1}$. The distance equation gives

$$
Z_jW_j=\frac{1}{(1+t)^2 b^2}=\frac{b}{1+t}.
$$

The four cross inverse distances at $j$ tend to zero. Hence the constant $H_j$ must equal $b(1+1/[2(1+t)])$ along the curve. This yields $|H_j|\le3/[2(1+t)^{1/3}]$, contradicting the real lower bound. The conclusion also holds for the exchanged colors and every relabelling. It excludes a candidate type of infinity on a physically relevant curve, not the existence of an arbitrary signed complex solution family with this limit.

[Tomar, §§2.1–2.3 and 6.7](https://hexagonmath.org/pdf/2611.00377v1) · [Previous reduction and orbit convention](https://github.com/rongyulin/physics-open-problems-AI/tree/main/problems/planar-central-configurations/notes/reduction)

## Scope and replay

The orbit convention in the previous reduction gives 90 real-compatible placements in 29 orbits. Ten of these placements are the marked binary in diagram 88 and occupy exactly the two representatives stated above. The script checks this overlap from the original two CSV files. Run `python3 marked_binary.py --previous /path/to/notes/reduction --output MarkedBinary.csv`. This deduction removes two physical orbits; it leaves the list for unrestricted complex curves unchanged. [Placement replay](marked_binary.py) · [Selected rows](MarkedBinary.csv)

The Lean file checks the dimensionless bound obtained from the inertia and Jensen hypotheses, the numerical projection constant, the elementary mass inequalities, and the leading binary product from its distance and force equations. Run `lake env lean /path/to/MarkedBinaryEnvelope.lean` from a Lean 4.28.0 project with matching mathlib. The analytic projection argument, algebraic-family specialization, and reconstruction of the leading binary equations are proved in the text. [Lean source](../../Lean/MarkedBinaryEnvelope.lean)

## Optional sharper physical bound

Centering each trial at its projected center of mass instead gives the uniform inertia bound $I<16(1+t)^{2/3}$. For the three possible ranks of the marked body up to reversal (numbered 0, 1, 2), the pair $(60 B,(t+5) C)$ becomes respectively
$(137t+385,55t+50)$, $(185t+337,31t+74)$, and $(200t+322,19t+86)$. In each case the difference $3600\cdot512(1+t)^2(t+5)-(60B)^2((t+5)C)$ has positive coefficients. The coefficients from cubic to constant are respectively $(810905,6162000,6848325,1804750)$, $(782225,6504360,7527501,811894)$ and $(1083200,7015200,7228404,299176)$. Thus $I_x<8(1+t)^{2/3}$ for each axis.

Jensen's inequality now gives $(1+t)^{1/3}H_j\ge y/2+5\sqrt5/\sqrt{16+5y}$. The derivative of the right side is $1/2-25\sqrt5/[2(16+5y)^{3/2}]>0$ for $y\ge0$, because $25\sqrt5<64$. Hence $H_j>5\sqrt5/[4(1+t)^{1/3}]$. This sharper version uses more detail about the six ranks and gives the same isolated-binary exclusion.
