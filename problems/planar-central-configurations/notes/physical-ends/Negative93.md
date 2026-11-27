# The sector of diagram 93 with special exponent at most `-2/3`

**Chatgpt · Working note · 27 November 2026**

For positive masses with five entries equal to one and the sixth equal to $t$, consider a complex place of diagram 93 with the marked mass at the partially circled vertex (paper vertex 4, catalogue slot 2). Write $a$ for its original $z$ exponent. The conclusion here is **$a>-2/3$**. This removes the previously open placements in catalogue cells 60 and 62. The result is independent of real positivity of any configuration or of its potential. The two masses at the regular outer vertices are assumed positive and equal to one.

## Chart and the outer triangle

Use the two-triple chart of the earlier diagram-93 note. Write $Z_4=s^2$, $v=h/s$. In this chart $Z_5-Z_6=W'_1-W'_2=1$, inner positions are $(h^2 Z'_l,h^{-2}W'_l)$, and outer positions are $(Z_j,W_j)$. Up to an unramified change of branches and a finite Puiseux extension, $s$ and $v$ are independent ambient chart coordinates away from their zeros. Original $z,w$ exponents imply
$$
\mathop{\rm ord}(s)=1+a/2,\qquad
\mathop{\rm ord}(v)=1-a/2.
$$
In particular at $a\le-2/3$ we have $v=O(s^2)$ and $h=o(s^2)$. The other outer coordinates, denoted collectively by $Y$, stay bounded. We differentiate at fixed $s,Y$ when taking the $v$-derivative of the normalized potential. Gauge fixing does not affect the implication from the original six-body force equations to stationarity in all these variables.

The outer $z$ and regular $w$ force equations and the earlier exact torque calculation show that negative $a$ implies $q=D_{46}/D_{45}=1$, $W_4\to0$, $Z_5\to1/2$, $Z_6\to-1/2$, and $W_5,W_6\to D_0,-D_0$ for some nonzero $D_0$. In fact we will need $W_4=O(s^2)$, even when $W_4$ is not identically zero. Put $x=Z_4=s^2$, $d=x-(Z_5+Z_6)/2$, $\eta=W_4-(W_5+W_6)/2$. The outer $z$ equations give $d=(1+t/2)x+o(x)$, since the $z$ force from the other cluster at 4 has order $O(xv^3)$ and the two regular external $z$ forces are $O(h^3)$. The expansion about the antipodal outer pair gives
$$
(1+u(1+t/2))x+\frac{3u}{2D_0}\eta=o(|x|+|\eta|),
$$
where $u=p_{45}^3=p_{46}^3\ne0$ denotes the limiting inverse cube. This follows by expanding the two squared distances $(1/2-d)(D-\eta)$ and $(1/2+d)(D+\eta)$ for $D=(W_5-W_6)/2\to D_0$ in the $z$ equation of body 4. Consequently $\eta=O(x)$. The average of the regular $w$ equations has internal right side $O(d,\eta)$: the force of the regular edge cancels and those from the special vertex cancel for $d=\eta=0$, for every $D$ near $D_0$. Its external force is $O(h)$. This gives $(W_5+W_6)/2=O(x)$ and thus $W_4=O(s^2)$.

## Inner critical equations

The inner unit masses have limiting projected coordinates $W'_l=L_l$ proportional to the three cube roots of one. Their two possible lifts are the noncollinear lift with $I_B^3=9$, and the complex collinear lift $Z'_l=\lambda L_l$ with $I_B=0$. All three limiting internal inverse cubes equal $1/3$. Fix the individual square-root branches analytically near this cluster. The inverse distances to 4 and to the regular outer vertices $j=5,6$ respectively are
$$
\begin{split}
p_{4l}&=v\,(-W'_l)^{-1/2}
(1-v^2Z'_l)^{-1/2}(1-s^2v^2W_4/W'_l)^{-1/2},\\
p_{jl}&=sv\,(-Z_j W'_l)^{-1/2}
(1-s^2v^2 Z'_l/Z_j)^{-1/2}(1-s^2v^2 W_j/W'_l)^{-1/2}.
\end{split}
$$
Signs in the radicals can vary by edge. The leading torque at 4 chooses a signed sum $b(W')$ of three terms $(-W'_l)^{-1/2}$ which vanishes at $L$; the individual radical values are $c L_l$ for a common nonzero $c$. In particular the three derivatives of this sum at $L$ are all $-c/2$.

Write $V_A,V_B$ for the isolated normalized potentials. Initially keep the two regular rows' signs arbitrary. The complete analytic potential then has the local expression
$$
V=V_A+V_B+t v b(W')+sv F(Y,W')+v^3 G(s,v^2,Y,Z',W').
$$
The function $F$ is the sum of the leading radicals of the two regular rows. The exact truncation $V_B+t v b(W')$ has a critical point with $W'=L$ for every small $v$; only a common translation of $Z'$ by a multiple of $v$ is required. This holds at each lift because the three derivatives of $b$ are equal and the limiting center is zero. The truncated value at this critical point is constant.

At the noncollinear lift all five independent inner variables are regular. At the collinear lift write the centered shape variables of the two projections as $p+e,p-e$ and their scale product as $d_0$. With $e=0$ the common shape is a root $r$ of $r^2-r+1=0$. Four variables are regular (the two centers, $p$, $d_0$), leaving one soft coordinate $e$. Here is a detail needed for this application: **the first nonconstant term of the isolated reduced potential is a nonzero multiple of $e^4$.** The three distance coordinates are
$$
(d_0,\ d_0(p^2-e^2),\ d_0((p-1)^2-e^2)).
$$
Their Jacobian in $(d_0,p,e^2)$ is nonsingular (its determinant is $-2d_0^2$). The isolated centered potential in these coordinates is $\sum f_{ij}(D_{ij})$ with $f'_{ij}=0$, $f''_{ij}=1/(4D_{ij})\ne0$. Its Hessian in $(d_0,p,e^2)$ is therefore nonsingular. The $2\times 2$ block in $(d_0,p)$ is nonsingular as well (the diagonal $d_0d_0$ entry is zero and the $d_0p$ entry is $(2r-1)/2\ne0$). Eliminating that block gives a nonzero Schur complement in $e^2$, proving the asserted quartic.

Eliminate the regular variables by the analytic implicit function theorem, treating $s,v,Y$ and any $e$ as independent. For the truncation the reduced potential is constant at $e=0$ and stationary there. Its $e$ derivative has form $c_4 e^3+O(e^4+v e)$ with $c_4\ne0$. The $svF$ and $v^3G$ perturbations contribute $O(sv+v^3)$ to this derivative. More explicitly, introduce two independent coefficients multiplying $F,G$, eliminate the regular variables and Taylor expand in these coefficients before substituting $sv,v^3$; this also justifies differentiating the expansion in $v$. Thus in the collinear case
$$
|e|^3\le C(|v e|+|sv|+|v|^3),\qquad
|e|=O(\sqrt{|v|}+|sv|^{1/3}).
$$
For $v=O(s^2)$ this implies $e^2=o(s)$. In the noncollinear case set $e=0$ throughout. The truncation has $v$ derivative $O(e^2)$, since its value at $e=0$ is constant and it is stationary there. Differentiating the full reduced potential with respect to $v$ at fixed $s,Y,e$ accordingly gives
$$
0=O(e^2)+s(F(Y_0,L)+o(1))+O(v^2).
$$
It follows that $F(Y_0,L)=0$. In a regular row the radicals at the limit are $d_j\epsilon_{jl}L_l$ where $d_j^2=-1/(Z_j L_l^3)$ (the cube $L_l^3$ is independent of $l$). A nonzero signed sum of the $L_l$ equals $\pm2L_l$ for some $l$, and the ratio of any two such nonzero sums is a sixth root of one. Since $(d_6/d_5)^2=-1$, the two regular rows cannot cancel each other unless each vanishes separately. The special row also vanishes. Thus all three signed rows are proportional to the same signed column in the chosen system of radicals. Local analytic continuation preserves that factorization of the leading radicals near their limiting values.

## The cubic coefficient after the sign reduction

The full potential can now be expressed in the form
$$
V=V_A+V_B+v K(s,Y)b(W')+v^3G(s,v^2,Y,Z',W'),\qquad K(0,Y_0)=t\ne0.
$$
Use the exact truncation with the $v K b$ term and denote its regular critical variables by $T$. As before, at $e=0$ the point $T$ is the limiting lift with only a common $Z'$ translation of size a multiple of $vK$. After eliminating the regular variables, the full potential becomes
$$
V_A+\text{constant}+e^2 H(s,v,Y,e)+v^3 J(s,v,Y,e).
$$
For the noncollinear lift omit the $e$ term and variable. Relative to the truncation the shift in the regular critical variables is divisible by $v^3$. Hence $J=G(s,v^2,Y,T)+O(v^3)$ analytically, since the corresponding error in the truncated value is quadratic in the shift.

For the collinear lift $H(s,0,Y,e)=O(e^2)$ and $H_v(s,0,Y,0)$ is bounded away from zero close to the limit. Indeed at $v=0$ the centered projected shape $p+e=r+e+O(e^2)$ (up to interchanging the sign of $e$), and the signed radical sum $b$ on centered triples has a zero of order exactly two there. The product of its four signed choices is a nonvanishing local factor times $9(p^2-p+1)^2$ when expressed in the projected shape, and the other three signed choices are nonzero. Multiplication by the nonzero $K$ preserves this order. This is the double-zero argument from the diagram-98 manuscript with the equal triple now taken in the opposite projection.

Stationarity in $v$ gives $e^2=O(v^2)$, and stationarity in $e$ then gives $e=O(v^2)$. For the latter, $H$ has a first $v$-term with nonzero coefficient and $H(s,0,Y,e)=O(e^2)$; the $e$ derivative is therefore $2H_v(s,0,Y,0)ve+O(e^3+ve^2+v^2e+v^3)$. The estimates hold uniformly in nearby $s,Y$. In both lifts we have the stronger necessary equation
$$
J(s,0,Y,0)=O(v^2).
$$
To check the error, at $e=0$ the first $v$ derivative of $G(s,v^2,Y,T)$ at $v=0$ is zero. The explicit dependence is even, while the common $Z'$ translation acts on $G(s,0,Y,T)$ via a sum of the three $L_l$, and that sum vanishes in each row. Thus $J(s,v,Y,e)=J(s,0,Y,0)+O(v^2+e)$ and $J_v=O(v+e)$ uniformly. Divide the stationary $v$-equation by $v^2$ and use $e=O(v^2)$.

At $s=0$ the cubic coefficient $J(0,0,Y_0,0)$ is a nonzero multiple of $t\sum_l L_l Z'_l=tI_B$. This contradicts the necessary equation for the noncollinear lift. For the collinear lift $Z'_l=\lambda L_l$, so $\sum L_l Z'_l=0$. The $W_j$ terms of the cubic coefficient remain. For analytic nonzero $d_j$ and common constant $c$ as in the leading radical normalization we obtain
$$
2J(s,0,Y,0)=3tc\,s^2 W_4+3s^3(d_5W_5+d_6W_6).
$$
Here $d_5,d_6$ absorb the row signs of the regular rows; at the limit $d_6/d_5=\pm i$. It follows that the last parentheses have nonzero limit $D_0(d_5-d_6)$, whereas $s^2W_4=O(s^4)$. Hence $J(s,0,Y,0)/s^3$ has nonzero limit. This contradicts $J=O(v^2)=O(s^4)$.

## Catalogue and scope

In the original $w$-equation of the special vertex the two regular internal forces have order $2$, and the force from each fully circled vertex has order $1-3a/2$. The presence of the regular forces among the minimal terms thus implies $a\le-2/3$. This occurs in both cells 60 and 62 in the residual core list, with the marked vertex in catalogue slot 2. Cell 60 has all five forces minimal; in 62 only the regular pair is minimal. This criterion uses exact recorded argmin sets. It does not use a sampled exponent. Cells 43, 61, 53 have only the three far forces minimal and remain outside this exclusion as whole cells.

The analytic argument and catalogue specialization are given here. The companion Lean source checks the nonzero change-of-variables determinant and the Schur-complement criterion. The Python replay verifies the compressed input digest and identifies the two cells from their exact minimal force sets. The full analytic reduction has not been formalized. Prior ingredients: [Tomar, §6.6](https://hexagonmath.org/pdf/2611.00377v1), [two-triple potential and equal-triple lifts](https://github.com/rongyulin/physics-open-problems-AI/blob/2f639b089053cf17fc6fce7274c06991119621ef/problems/planar-central-configurations/papers/FiveEqualSixBody.tex), [outer diagram-93 chart and limiting equations](https://github.com/rongyulin/physics-open-problems-AI/blob/2f639b089053cf17fc6fce7274c06991119621ef/problems/planar-central-configurations/notes/Diagram93.md).
