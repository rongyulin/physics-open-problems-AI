# A valuation bound and a sign constraint for six-body diagram 93

**Chatgpt · Research note · 27 November 2026**

Consider a singular place of the complexified planar Newtonian central-configuration equations with positive masses proportional to $(1,1,1,1,1,t)$. In Tomar's diagram 93 the fully $w$-circled triangle is $B=\{1,2,3\}$. The other triangle is $A=\{4,5,6\}$, and vertex 4 lacks a $z$-circle. Write $a_4$ for the valuation of its original $z$-coordinate in Tomar's normalization. Tomar obtains $-2<a_4<2$.

Two restrictions follow from the torque of $A$.

1. Write $b=m_5$, $c=m_6$, and $q$ for the limiting ratio of the squared distances $D_{46}/D_{45}$. Then $q^3=1$. A negative $a_4$ requires **both** $b=c$ and $q=1$. In particular, when $t\ne 1$ lies at vertex 5 or 6, one must have $a_4\ge 0$.
2. If $a_4>0$, the three rows of leading inverse-distance signs between $A$ and $B$ factor as a row sign times a column sign. This holds for either placement of $t$ in $A$.

These are necessary conditions. The case $a_4=0$, the symmetric branch $b=c$, $q=1$ at negative valuation, and possible lifts at positive valuation are open in this argument. The derivation below is a mathematical calculation. Its two restrictions have not been formalized in Lean.

## Input and coordinates

Tomar's Theorem 6.15 gives a three-body shape equation and a signed torque equation for $B$. On a positive triple with two equal masses, the common-root test forces all three masses to coincide, and the projected shape $x$ then satisfies $x^2-x+1=0$. Thus on the stated mass line the three bodies of $B$ can be taken to have unit mass. Their centered, nonzero leading $w$-coordinates are proportional, in some order, to $(1,\omega,\omega^2)$ with $\omega$ a primitive cube root of unity. This assertion concerns a single complex projection. The two inputs are documented in the sources below.

Use the difference convention $z_{ij}=z_i-z_j$, and likewise for $w$. With inverse distances $p_{ij}=p_{ji}$, the normalized equations are

$$
z_i=\sum_{k\ne i}m_k p_{ik}^3(z_i-z_k),\qquad
w_i=\sum_{k\ne i}m_k p_{ik}^3(w_i-w_k),\qquad
p_{ij}^2 z_{ij}w_{ij}=1 .
$$

Take the original local scale to be $\varepsilon$. Rotate the complex coordinates by $(z,w)\mapsto(\lambda z,\lambda^{-1}w)$ so that $z_{56}=1$. In these rotated coordinates choose $h^2=1/w_{12}$ and write

$$
(z_j,w_j)=(Z_j,W_j)\quad(j\in A),\qquad
(z_l,w_l)=(h^2 Z'_l,h^{-2}W'_l)\quad(l\in B).
$$

All the displayed capital-letter coordinates stay bounded. The limits of $Z_5,Z_6$ and all $W'_l$ are nonzero. Each internal squared distance of either triangle has a finite nonzero limit. These facts follow from the valuations in the proof of Theorem 6.15. Before rotation $z_{56}$ and $w_{12}$ both have valuation $-2$. After rotation $h$ has valuation $2$ and $Z_4$ has valuation $2+a_4$. Choose $s^2=Z_4$ and $v=h/s$, allowing a finite Puiseux extension. Both $s$ and $v$ tend to zero. All order estimates below refer to absolute values along the place.

The distance equations give $p_{jl}=O(h)$ for $j=5,6$ and $p_{4l}=O(v)$ for $l\in B$. More precisely, with a bar denoting a limit, the nonzero leading coefficients satisfy

$$
g_{jl}=\lim p_{jl}/h,\qquad g_{jl}^2=-1/(\bar Z_j\bar W'_l)\quad(j=5,6),\qquad
g_{4l}=\lim p_{4l}/v,\qquad g_{4l}^2=-1/\bar W'_l .
$$

Indeed $Z_4-h^2 Z'_l=s^2(1-v^2 Z'_l)$. Tomar's leading torque reads $\sum_{l\in B}g_{4l}=0$ in this normalization.

## The missing force equation at vertex 4

For $j\in A$ let $R_j^Z$ be $Z_j$ minus the sum of the two internal $z$-forces from $A$. Define $R_j^W$ using $W$ in the same way. Each residual equals its force from $B$ along the place. Directly from the scales above,

$$
R_j^Z=O(h^3),\quad R_j^W=O(h)\quad(j=5,6),\qquad
R_4^Z=O(s^2 v^3).
$$

Thus all three internal $z$-equations and the two internal $w$-equations for 5 and 6 hold at the limit. The remaining residual $R_4^W$ has a finite limit because its internal expression does. In the next three displays all coordinates and inverse distances denote their limits.

Summing the internal $z$-equations with the mass weights gives $bZ_5+cZ_6=0$. As $Z_5-Z_6=1$ and $Z_4=0$, one obtains $Z_5=c/(b+c)$ and $Z_6=-b/(b+c)$. The $z$-equation at 4 therefore gives $p_{45}^3=p_{46}^3$. Set $u=p_{45}^3$, $k=p_{56}^3$, $D_{ij}=Z_{ij}W_{ij}$ and $q=D_{46}/D_{45}$. The inverse-distance equation gives $q^3=1$. With $\delta=W_5-W_4\ne 0$ one obtains

$$
W_6-W_4=-qc\delta/b,\qquad
\frac{D_{56}}{D_{45}}=\frac{(b+c)(b+qc)}{bc},\qquad
1=m_4u+(b+c)k .
$$

The last equality is the $z$-equation at 5. Substituting it into the $w$-equation at 5, then evaluating the internal residual at 4, gives

$$
W_4=k(-b+qc^2/b)\delta,\qquad
\lim R_4^W=(u-k)(b-qc^2/b)\delta.
$$

Here $u\ne k$. Equality would give $(D_{56}/D_{45})^3=1$. For $q=1$ this distance ratio is at least $4$. For either primitive $q$, putting $x=b/c>0$ yields

$$
\left|D_{56}/D_{45}\right|^2=x^2+x+x^{-1}+x^{-2}\ge 4 .
$$

Consequently $\lim R_4^W=0$ exactly when $b=c$ and $q=1$.

## The torque forces the valuation bound

Return to the varying chart coordinates. Pairing the two terms from each internal edge gives the exact identity

$$
\sum_{j\in A}m_j(W_jR_j^Z-Z_jR_j^W)=0 .
$$

If $\lim R_4^W\ne0$, boundedness of $W_4$ and the residual estimates imply $|s|^2\le C(|h|+|s|^2|v|^3)$ for some constant $C$. Absorb the last term for small $v$. Since $s^2=Z_4$ has valuation $2+a_4$ and $h$ has valuation $2$, it follows that $a_4\ge0$.

## The regular rows at positive valuation

Suppose $a_4>0$. Then $s^2/h\to0$. After dividing the exact torque identity by $h$, both terms at vertex 4 tend to zero. For $j=5,6$ the $z$-residual term tends to zero, while

$$
\lim R_j^W/h=-\sum_{l\in B} g_{jl}^3 \bar W'_l
=\frac{1}{\bar Z_j}\sum_{l\in B}g_{jl}.
$$

The resulting relation is $b\sum_l g_{5l}+c\sum_l g_{6l}=0$. To resolve the signs, put $L_l=\bar W'_l$. The three numbers $L_l^3$ have the same nonzero value $L_*$. For $j=5,6$ choose $d_j$ with $d_j^2=-1/(\bar Z_j L_*)$. Then $g_{jl}=d_j\sigma_{jl} L_l$ with $\sigma_{jl}\in\{1,-1\}$. Since $\sum_l L_l=0$, a signed sum of the $L_l$ is either zero or $\pm 2L_l$ for one index. Any ratio of two nonzero such sums is a sixth root of unity. But $(d_6/d_5)^2=\bar Z_5/\bar Z_6=-c/b$, so $c d_6/(b d_5)$ is purely imaginary and nonzero. No sixth root of unity is purely imaginary. The two row sums must therefore vanish separately.

For row 4 use $d_4^2=-1/L_*$. Its row sum already vanishes by the leading torque. In each row vanishing requires its three signs to agree in this choice of column radicals. Changing the reference sign of any column flips that entire column. Thus in any such reference system the sign matrix has the form $\sigma_{jl}=\alpha_j\beta_l$ and has rank one.

## Sources

- T. S. Tomar, *Smale's sixth problem for six bodies in the plane*. The diagram, coordinate valuations, and leading torque are in §6.6, Theorem 6.15 and its proof. [Preprint, version 1](https://hexagonmath.org/pdf/2611.00377v1)
- The calculation on the two-equal-mass slice is `SixBody.Diagram93.zero_locus` in `SixBodyResearch/certificates/diagram93/lean/Diagram93.lean`. The original archive also contains its research note. [Verification archive](../Lean/SixBodyVerification.zip)
- Four algebraic lemmas used above can be replayed separately. The passage from the six-body equations to the limiting forces and the use of torque are proved in this note. [Lean source](../Lean/Diagram93Algebra.lean)
