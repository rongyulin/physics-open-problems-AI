# An energy gap for a positive-distance real quartet at an end of diagram 88

**Chatgpt · 27 November 2026**

For every $t>0$, any real planar Newtonian central configuration with positive distances and masses $(t,1,1,1)$, normalized to acceleration $-q_i$ in center-of-mass coordinates, has potential $E_4$ satisfying
$$
 E_4+2^{-1/3}<\frac{10+5t}{(5+t)^{1/3}}.
$$
The right side is a lower bound on the normalized potential of every physical six-body central configuration with masses $(t,1,1,1,1,1)$. Consequently a component containing such a six-body configuration cannot have a diagram-88 end whose quartet is the positive-distance normalized real four-body solution after a complex orthogonal change of coordinates and a single common cube-root-of-unity rescaling. This includes every shape of that type, with arbitrary symmetry, for each fixed positive mass. The proof uses the unsigned six-body potential invariant and requires no generic-mass exclusion.

In the representative $(127,6,2)$ all four leading quartet projections can be nonzero. This restriction therefore supplies a condition on the surviving quartet in that case. In cells where a quartet member has a vanishing low projection and a nonvanishing high projection, a real shape is already impossible. Mixed *internal* signs on an otherwise real quartet can change the force equations and are outside the argument. The signs on the two-body cluster are unrestricted. This excludes one kind of leading quartet, while the full orbit is addressed in the [quartet specialization proof](FullQuartetSpecialization.md). [Leading-cluster equations and the exponent cells](../physical-ends/Diagram88Cluster.md) · [Tomar, §6.7](https://hexagonmath.org/pdf/2611.00377v1)

## An upper bound on the four-body potential

For a physical four-body configuration write $r_{ik}=|q_i-q_k|$ and $I=\sum_i m_i|q_i|^2$. Multiplying the normalized equations by $m_i q_i$ and summing yields $E_4=I$. Pick a direction at angle $\theta$ in which the four scalar projections $x_i$ are distinct. Put $a_{ik}=|\cos(\theta-\phi_{ik})|^3$, where $\phi_{ik}$ is the direction of the $ik$ edge. The projected equations make $x$ stationary for
$$
 V(u)=\sum_{i<k}\frac{m_i m_k a_{ik}}{|u_i-u_k|}
      +\tfrac12\sum_i m_i u_i^2
$$
in the convex chamber with the order of the $x_i$. Its strict convexity makes $x$ a minimum there. Variation along the ray through $x$ gives $V(x)=3I_\theta/2$ for $I_\theta=\sum m_i x_i^2$. For any trial positions in the same order, let $B_\theta$ be their weighted inverse-distance sum (with the $a_{ik}$) and $C_\theta$ their moment of inertia. Minimizing the trial value on its scaling ray gives $I_\theta\le (B_\theta^2 C_\theta)^{1/3}$.

For $0<g\le1$, place the marked body at zero. On each side place the unit bodies in their required order at displacements of absolute values $1,1+g,1+2g,\ldots$. Translate the trial to its mass center; this leaves $B_\theta$ unchanged. With $M=t+3$, its centered inertia is either
$$
 C_{\mathrm{end}}=3+6g+5g^2-\frac{9(1+g)^2}{M},\qquad
 C_{\mathrm{mid}}=2+(1+g)^2-\frac{(1+g)^2}{M}.
$$
The first expression covers three unit masses on one side and the second covers an interior marked rank. All three marked–unit gaps are at least one, and all three unit–unit gaps are at least $g$. The angular mean of $|\cos(\theta-\phi)|^3$ equals $4/(3\pi)$ independently of $\phi$. Consequently $\langle B_\theta\rangle\le(4/\pi)(t+1/g)$. Since $\langle I_\theta\rangle=I/2$, concavity of $x^{2/3}$ gives
$$
 E_4^3\le8\max(C_{\mathrm{end}},C_{\mathrm{mid}})\left[\frac4\pi(t+1/g)\right]^2.
$$

## A rational certificate for the strict separation

Take $g=1$ for $0<t<2$ and $g=1/2$ for $t\ge2$. For either trial rank type set
$$
 A=8C\,(32/25)^2(t+1/g)^2,\qquad B=1/2,\qquad D=(10+5t)^3/(5+t).
$$
Here $4/\pi<32/25$. In each of the four cases $(D-A-B)^3-27DAB>0$. For direct verification substitute $t=2u/(1+u)$ on the first interval and $t=2+u$ on the second. In each case the reduced rational expression has a numerator of degree 12 with nonnegative coefficients and positive constant term. Its denominator also has nonnegative coefficients and positive constant term. The [Python certificate](quartet_energy88.py) checks these polynomial identities and coefficient signs over the rationals.

For nonnegative $x=A^{1/3},y=B^{1/3},z=D^{1/3}$ the polynomial inequality implies $z^3-x^3-y^3>3xyz$. The identity
$$
 z^3-x^3-y^3-3xyz=(z-x-y)(z^2+zx+zy+x^2-xy+y^2)
$$
therefore gives $x+y<z$. Taking the larger of the two rank costs proves the required bound. The [Lean file](../../Lean/QuartetEnergy88.lean) verifies this implication and the endpoint trial arithmetic. The convexity and angular averaging arguments are given above.

## At a six-body end

At a physical six-body configuration let $S=\sum_{i<j}m_im_j=10+5t$, $M_6=5+t$. The pairwise identity $\sum_{i<j}m_im_j r_{ij}^2=M_6 I_6$ and Jensen's inequality for $v^{-1/2}$ imply $U_6/S\ge (M_6 I_6/S)^{-1/2}$. Using $U_6=I_6$ gives $U_6\ge S/M_6^{1/3}$. The signed continuation of $U_6$ is constant on a fixed-mass irreducible component of normalized configurations by stationarity of $U_6+I_6/2$ and $I_6=U_6$.

At a diagram-88 end, the eight intercluster inverse distances tend to zero; all internal inverse distances have finite nonzero limits. The two endpoint equations in the unit binary give $p_{56}^3=1/2$, so its limiting potential has modulus $2^{-1/3}$. The remaining six terms give the normalized four-body potential in the isolated quartet equations. If its distances and coordinates come from a physical positive-distance quartet up to the transformations stated above, the modulus of this potential is $E_4$. Indeed an orthogonal change leaves the squared distances unchanged; multiplying the coordinates by a cube root of unity and the inverse distances by its reciprocal preserves the signed distance and force equations and multiplies the quartet potential by that reciprocal. The triangle inequality and the strict bound contradict the six-body lower bound. Arbitrary mixed signed four-body solutions and general complex quartet geometries are not included in this conclusion.
