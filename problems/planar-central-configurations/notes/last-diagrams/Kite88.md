# Reflection-symmetric quartets in diagram 88

**Chatgpt, 27 November 2026**

For a unit binary and a quartet of masses $(1,1,1,t)$, the leading quartet in diagram 88 cannot have a nontrivial mass-preserving complex Euclidean symmetry at generic positive $t$. The collinear case was separately excluded in [the collinear calculation](Collinear88.md). The result below treats every noncollinear reflection-symmetric quartet. The absence of symmetry does not dispose of a whole cell. The underlying leading equations are Tomar’s $N_4$ and the equal-binary torque. [Tomar, Lemmas 6.16 and 6.17](https://hexagonmath.org/pdf/2611.00377v1)

At $t\ne1$ any symmetry must fix the marked body. The centered high projection of this body is nonzero by the diagram. A nontrivial complex rotation acts by $X\mapsto \lambda X$ with $\lambda\ne1$ and cannot fix it. For a reflection, if all three unit bodies are fixed, they lie on its axis and the quartet is collinear. Otherwise the reflection fixes one unit body and exchanges the other two. The difference of the two fixed positions is nonisotropic by the distance equations. After similarity and translation use the affine positions

$$
q_0=(d,w),\quad q_1=(d,-w),\quad q_2=(0,0),\quad q_3=(1,0),
$$

with the marked body at $q_3$ and $w\ne0$. These are complex Cartesian coordinates with bilinear squared distance. At a fixed body the two forces from the exchanged bodies have equal inverse-distance cubes because their transverse components must cancel. The two squares of these inverse distances also agree and are nonzero, so the signed inverses themselves agree. Thus a geometric reflection forces the internal sign pattern to respect that reflection.

Measure the signed lengths relative to the signed length of the axis edge $23$, so this edge has inverse cube one. Let $R,S$ be the signed lengths from $q_0$ to $q_2,q_3$, respectively. They satisfy $R^2=d^2+w^2$, $S^2=(d-1)^2+w^2$. The signed length of edge $01$ is $2\sigma w$ with $\sigma=\pm1$. There is a rational parametrization of all such configurations, including complex choices of the signs. Set $a=(d+R)/w$, $b=(d-1+S)/w$. Neither vanishes, since $w\ne0$. With $D=(a-b)(ab+1)$ we have

$$
d=\frac{b(a^2-1)}D,\qquad w=\frac{2ab}D,\qquad
R=\frac{b(a^2+1)}D,\qquad S=\frac{a(b^2+1)}D.
$$

Indeed $d=w(a-a^{-1})/2$, $d-1=w(b-b^{-1})/2$, and subtraction gives the formula for $w$ and shows $D\ne0$. Every divisor in the inverse force coefficients $L=R^{-3}$, $U=S^{-3}$ and $M=(2\sigma w)^{-3}$ is nonzero.

Write $\Lambda$ for the force proportionality constant after this choice of scale. The transverse equation of either exchanged body gives $\Lambda=2M+L+tU$. Subtracting the axial equations of the two fixed bodies gives $\Lambda=1+t+2(1-d)U+2dL$. The axial equation of body 2 and the center of mass $c=(2d+t)/(3+t)$ give $(2d+t)\Lambda=(3+t)(2dL+t)$. In particular,

$$
C+tV=0,\qquad
C=2M+L-1-2(1-d)U-2dL,\qquad V=U-1.
$$

The reduced polynomial numerators of $C,V$ are coprime in $\mathbb Q[a,b]$ for either $\sigma$. Thus there are only finitely many shapes with $C=V=0$. When $V\ne0$ substitute the reduced rational expression $t=-C/V=N/T$ into the remaining axial equation. Its numerator $G$ has bidegree $(10,12)$ and the gcd of its coefficients as a polynomial in $b$ is one.

The high projection of the quartet is proportional to the centered form of $(d+iw,d-iw,0,1)$. The two possible choices of the imaginary unit just exchange the identical reflected masses. The equal-binary torque from the collinear note is valid for these positions as well. Define $z=b(a^2-1)$, $h=2ab$ and

$$
Z_i=(3T+N)u_i-(2zT+DN),\qquad u=(z+ih,z-ih,0,D).
$$

Let $A_i=\epsilon_i\prod_{j\ne i}Z_j$ times $T^2$ for a unit mass or $N^2$ for the marked mass. Up to a common multiplier these are the squares of the four torque summands. With the quartic $\Phi$ in [the collinear calculation](Collinear88.md), $G$ and $\Phi(A_0,A_1,A_2,A_3)$ are coprime for every sign pattern. The verifier computes their gcd at $a=2$ over $\mathbb F_{1009}$, using $i=11^{252}$. In all sixteen cases the specialized $G$ retains degree twelve and each gcd is one. The degree-preserving argument works over the Gaussian integers: a common positive-$b$-degree factor must retain its degree in the split reduction and the content computation rules out factors in $a$ alone. The finitely many collision-free intersection points therefore give finitely many masses.

For the finitely many shapes with $V=C=0$, the same fixed-shape torque argument as before applies. The marked centered position is $(3-2d)/(3+t)$. If it vanishes identically, the shape violates the nonzero high-coordinate condition. Otherwise its torque summand grows like $t^{3/2}$ as $t\to+\infty$ and the other three stay bounded: the uncentered high projections differ from the marked projection by the quartet distance equations. Hence no signed torque polynomial vanishes identically in $t$, and only finitely many algebraic masses can occur.

Run `python Kite88.py` in the directory containing its companion `Collinear88.py`. The proof leaves open noncollinear quartets with trivial symmetry.
