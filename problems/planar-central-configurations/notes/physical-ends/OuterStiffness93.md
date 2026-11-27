# Excluding all negative special exponents for the marked central vertex of diagram 93

This argument strengthens the preceding [two-cell calculation](Negative93.md). Fix $m_4=t>0$, $m_5=m_6=1$ in its paper labelling. Use its ambient rotation chart, and suppose that $a<0$. Then $v=o(s)$ and $x=s^2$, while $h=sv=o(x)$. The earlier outer torque forces the symmetric outer limit $q=1$, $W_4\to0$. The claim is that no complex place in this placement can have $a<0$.

## Small forcing of the entire outer triangle

Repeat the first regular-variable elimination of the inner unit triangle as in the preceding calculation. At the collinear lift the genuinely nonzero quartic in its remaining variable $e$ gives
$$
e=O(\sqrt{|v|}+|sv|^{1/3}).
$$
It follows that $e^2=o(s)$ whenever $v=o(s)$, since $|sv|^{2/3}/|s|=(|v|^2/|s|)^{1/3}\to0$. At the noncollinear lift there is no soft variable. The derivative in $v$ therefore gives $F(Y_0,L)=0$ by the same proof, and all three rows of signs factor. After elimination of the regular variables the rank-one critical potential takes the form
$$
V_A+\text{constant}+e^2 H(s,v,Y,e)+v^3 J(s,v,Y,e).
$$
All coefficients are analytic, $H(s,0,Y,e)$ is independent of $s,Y$, and $H_v(0,0,Y_0,0)\ne0$. The $v$-derivative implies $e=O(v)$ as before. At the noncollinear lift omit $e$ and $H$. Thus the derivatives of the two perturbation terms in either $s$ or any $Y$ are $O(v^3)$: the derivatives $H_s,H_Y$ are $O(v)$, the derivatives of $J$ are bounded, and $s,v,Y,e$ are independent ambient variables for partial differentiation.

Write $S=(Z_5+Z_6)/2$, keeping $Z_5-Z_6=1$, so the four outer variables other than $s$ are $Y=(S,W_4,W_5,W_6)$. In the isolated outer potential the $W$ derivatives give the three $z$-residuals up to nonzero mass factors. The $S$ derivative gives the sum of the two regular $w$-residuals up to the fixed common factor. Finally the $s$ derivative gives $2s$ times the $Z_4$ derivative, which detects the $w$-residual at vertex 4. The full critical equations therefore force all three $z$-residuals, the sum of the regular $w$-residuals and the special $w$-residual to be $o(x)$; for the special $w$-residual we used $v^3/s=o(s^2)=o(x)$. This also follows at a noncollinear lift without using the cubic test.

## Linear response of the outer triangle

Retain the notation of the previous calculation, including $D=(W_5-W_6)/2\to D_0\ne0$. Let $A=1+t/2$, $d=x-S$, $u=\lim p_{45}^3$, and $y=(W_4-(W_5+W_6)/2)/D_0$. The three small $z$ residuals imply $d=Ax+o(x)$, and the special $z$ equation gives $y=O(x)$. Set $w=W_4/D_0$. The special $z$ and averaged regular $w$ equations to first order give
$$
 (1+uA)x+(3u/2)y=o(x),\qquad
 w=3tuAx+(1+tu/2)y+o(x).
$$
These equations result by expanding $(1/2-d)(D-D_0 y)$ and $(1/2+d)(D+D_0 y)$ for the two squared distances, as in the previous note. Unlike the two exact-origin cells, here $w$ can be nonzero at this order. The special $w$ equation supplies one more identity: its internal force divided by $D_0$ equals $-6uAx-uy+o(x)$. Indeed the sum is $(p_{45}^3+p_{46}^3)D_0 y-(p_{45}^3-p_{46}^3)D$. Its residual is $o(x)$, so $w+6uAx+uy=o(x)$. Eliminating $w$ and then $y$ gives
$$
\frac{2}{3u}(2uA-1)(4uA+1)x=o(x).
$$
This is impossible. The closing regular $z$ equation gives $1=(t+\sigma/4)u$ with $\sigma\in\{-1,1\}$. Consequently $2uA-1=(2-\sigma/4)u$ and $4uA+1=(4+3t+\sigma/4)u$, both nonzero for positive $t$.

Thus every putative remaining place with marked special vertex satisfies $a\ge0$. Cells 60 and 62 are removed as in the earlier calculation; the negative part of the exponent region in cells 43 and 61 and in core-free cell 53 is also excluded for this placement. No additional entire catalogue cell is removed by this strengthening.
