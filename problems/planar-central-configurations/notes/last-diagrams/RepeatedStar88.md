# Repeated force coefficients from the marked quartet body in diagram 88

**Chatgpt, 27 November 2026**

Consider the diagram-88 placement with quartet masses $(t,1,1,1)$ and a unit binary. For generic positive $t$, the three cubes of the internal inverse distances from the marked quartet body to its three unit companions are pairwise distinct in every surviving shape. The calculation refines the remaining distance chart and does not remove a complete catalogue cell. It uses the earlier exclusions for collinear and reflection-symmetric quartets and for any collinear triple in the quartet, as well as the rank-one stress in the distance chart. The input for the quartet forces and the binary torque is [Tomar, §6.7](https://hexagonmath.org/pdf/2611.00377v1).

If the stress vanishes, all six cubes agree and there are only finitely many projective distance shapes. The fixed-shape torque excludes their generic occurrence. Otherwise write its off-diagonal entries, after division by the masses and the common normalization, as $c T_iT_j$. All four $T_i$ are nonzero since there is no collinear triple. If the cubes from the marked body to two unit bodies agree, those two have equal $T_i$. Their cubes to the third unit body therefore also agree. The affine dependence $\sum m_i T_i q_i=0$ with $\sum m_i T_i=0$ places their midpoint on the line of the other two bodies.

Put the fixed unit body at $(0,0)$ and the marked body at $(1,0)$ in normalized complex Cartesian coordinates. The other two unit bodies have positions $(d+\ell,w)$ and $(d-\ell,-w)$. All squared distances are nonzero. The exclusions already obtained imply $w\ne0$, $d\ne0,1$, and $\ell\ne0$: the midpoint cannot be a fixed body, and $\ell=0$ would give a reflection. Set $J=\ell^2+w^2$. The two squared distances to either fixed body differ by a cube root of unity, say $\eta$ for the unit fixed body and $\theta$ for the marked one. If either root is one then $4d\ell=0$ or $4(d-1)\ell=0$, which is impossible. Thus both roots are primitive. Write

$$
U=2(\eta+1)/(\eta-1),\qquad V=2(\theta+1)/(\theta-1).
$$

The squared-distance ratios give $d^2+J=Ud\ell$ and $(d-1)^2+J=V(d-1)\ell$. Consequently

$$
(Ud-V(d-1))\ell=2d-1,\qquad J=Ud\ell-d^2.
$$

This expresses $\ell,J$ rationally in $d$ except when the multiplier of $\ell$ vanishes. At such a point $d=1/2$ and $U=-V$, and $J=U\ell/2-1/4$. These are six rational parameter families altogether: four ordered pairs of primitive roots parametrized by $d$, and the two exceptional families parametrized by $\ell$.

Normalize the inverse cube on the edge between the fixed bodies to one. Let $r,s$ be the common inverse cubes from the pair to the fixed unit and marked bodies, respectively, and $m$ the inverse cube within the pair. These three numbers satisfy

$$
r^2=[(d+\ell)^2+w^2]^{-3},\qquad
s^2=[(d-1+\ell)^2+w^2]^{-3},\qquad
m^2=(4J)^{-3}.
$$

Subtract the vector equations of the two members of the pair; the scalar force multiplier is $\Lambda=2m+r+ts$. The same fixed-body equations as in [the kite calculation](Kite88.md) give $\Lambda=1+t+2(1-d)s+2dr$ and $(2d+t)\Lambda=(3+t)(2dr+t)$. Thus, wherever $s\ne1$, the first equation determines $t$ as a rational function on the square-root cover. The second equation then supplies a further scalar compatibility test.

[RepeatedStar88.py](RepeatedStar88.py) reduces the two primitive cube roots to 374 and 634 modulo 1009. For the four $d$ families the test fibre is $d=2$. For the two midpoint families it takes $\ell=11$ or $13$, as specified by the replay. At each test point all three square-root pairs exist and are nonzero in the prime field. On every one of the eight sheets, $s-1$ and the remaining scalar residual are nonzero. All denominators of the chart are units at these points. This rules out an identical equality on any characteristic-zero sheet of a parameter family: above the chosen point every sheet of this finite square-root cover has a specialization after a finite local field extension, and all reductions have been tested. It also shows $s=1$ occurs only at finitely many parameter values. Each family thus permits only finitely many geometries, with finitely many choices of the sign of $w$. Any such fixed geometry with varying $t$ is excluded generically by the fixed-shape torque argument, including the exceptional points with $s=1$.

## Eliminating an auxiliary variable

In the distance chart write $\alpha_i=r_i^3-k$, $A=\alpha_1\alpha_2$, $B=\alpha_1\alpha_3$, $C=\alpha_2\alpha_3$ and $e_{ij}=D_{ij}^{-3}$. For the remaining shapes $AB(B-A)k\ne0$ by the distinctness result. The equations for edges 12 and 13 eliminate the stress scale:

$$
L=\frac{B^2(e_{12}-k^2)-A^2(e_{13}-k^2)}{2kAB(B-A)}.
$$

The remaining force equations are $(k+LA)^2=e_{12}$ and $(k+LC)^2=e_{23}$. Together with the torque on its quadratic projection cover they now use only three independent variables $(r,s,k)$, and $t=-L\sum_i\alpha_i$. The [finite-boundary argument](FiniteRatioBoundary88.md) closes this chart after the [degree estimate at infinity](RatioInfinity88.md).
