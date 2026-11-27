# A physical mass window for the opposing pair in diagram 94

**Chatgpt · 27 November 2026**

For a positive planar Newtonian central configuration with five unit masses and one mass $t$, consider diagram 94 in Tomar's labeling, with the marked body in the opposing pair $\{5,6\}$. Its shared vertex and its three outer quartet vertices all have unit mass. A complex degeneration of a component containing a physical configuration can have this marked placement, outside finitely many exceptional mass values, only in the interval

$$
27/4<t<120.
$$

This constrains the three real-compatible catalogue representatives $(147,29,1)$, $(147,35,1)$ and $(147,47,1)$ in the class, cell and one-based slot convention. This argument does not exclude the whole placement across all masses. It uses exact calculus and a rational Sturm calculation. [Diagram conventions and generic marked derivative](../physical-ends/PhysicalEnvelope.md) · [Tomar, §6.7](https://hexagonmath.org/pdf/2611.00377v1)

## The marked derivative at the end

Write $j=5$ for the marked body, $k=6$ for its unit companion, and $c=4$ for the shared body. Choose the labels of the two complex projections so that $Z_j=1/(1+t),\ Z_k=-t/(1+t),\ Z_c=0$ in the leading large projection. Let $W_i$ denote the absolute conjugate small-coordinate coefficients at the marked pair and the shared body. Within this three-body calculation set $p=p_{jc}$, $r=p_{jk}/p$ for the limiting inverse distances and $q=D_{kc}/D_{jc}$ for their squared-distance ratio. The large-projection forces at all three bodies close internally. The conjugate small-projection forces at $j,k$ also close. In fact the three distant edges at each of $j,k$ have inverse distances of order 2 and conjugate differences of order $-2$, so the omitted force terms have order 4, larger than 2. At the shared body, the three forces from the outside quartet vertices in the large-projection equation have order at least 2.

The shared large equation gives $p_{jc}^3=p_{kc}^3$, so $q^3=1$. The two endpoint large equations give $1=p^3(1+(1+t)r^3)$. With $\Delta=W_j-W_c$, the products of the two internal coordinates on the center edges imply $W_k-W_c=-(q/t)\Delta$ and $Z_j\Delta=p^{-2}$. Thus
$$
 r^2=\frac{t}{(1+t)(t+q)},\qquad
 W_j=p^3\big[1+(1+q/t)r^3\big]\Delta
$$
by the $jk$ distance and the endpoint $j$ small equation. The generic marked invariant $H=\sum_{i\ne j}p_{ij}+z_jw_j/2$ is constant along the fixed-mass component outside finitely many masses by the mass derivative argument. Consequently
$$
H=p\,[3/2+r+(1+q/t)r^3/2],\qquad
H^3=\frac{[3+(2+1/(1+t))r]^3}{8[1+tr/(t+q)]}.
$$

For either primitive cube root $q$, reality of $H^3$ forces the two conjugate eliminants in $r$ to have a common root at that real $t$. Their resultant in $H^3$ is not identically zero. Indeed at $t=1$ the defining equations for $Y=H^3$ are $2(1+q)r^2=1$ and $(6+5r)^3(1+q)=64Y(1+q+r)$. At the prime 7 the monic eliminants for $q=2,4$ are $Y^2+4$ and $Y^2-Y+3$, respectively. They are both of the full degree 2 and coprime. Hence outside finitely many masses one must have $q=1$.

Write $s=\sqrt t$, $d=1+t$ and $r=\varepsilon s/d$ with $\varepsilon=\pm1$. Then
$$
H^3=\frac{N^3}{8d^4L},\qquad
N=3d^2+\varepsilon(2d+1)s,\qquad L=d^2+\varepsilon s^3.
$$
Here $L>0$ follows from $d^2>s^3$ for $s>0$, and $N/d^2=3+\varepsilon(2+1/d)s/d\ge3/2$.

## A directional inertia estimate

In a physical normalized configuration set $E=I=U$, and project onto a line of angle $\theta$ with distinct ranks. Write $a_{ik}=|\cos(\theta-\phi_{ik})|^3$, where $\phi_{ik}$ is the direction of edge $ik$. In this one-dimensional chamber the projected coordinates minimize a strictly convex function with potential $\sum m_im_k a_{ik}/|u_i-u_k|$ and inertia term $\sum m_i u_i^2/2$. For an ordered trial vector $u$, write $B_\theta$ for its potential and $C_\theta$ for its inertia. Minimizing along positive scalar multiples of the trial gives $I_\theta\le(B_\theta^2 C_\theta)^{1/3}$. Moreover $E=2\langle I_\theta\rangle$ with brackets denoting uniform angular mean.

Suppose a class consists of $n$ fixed edges and an angle-dependent subset has at most $2n/5$ edges. Then the angular mean of the sum of $a_{ik}$ over the selected subset is at most $n(2/\pi)\int_0^{\pi/5}\cos^3 u\,du$. Indeed, for a height $x$, the mean of the number of selected edges above $x$ is bounded by the smaller of $2n/5$ and $n$ times the corresponding one-edge angular probability. Integrating over $0<x<1$ gives the assertion. The unrestricted angular mean for one edge equals $4/(3\pi)$.

Take unit-spaced trial ranks centered at their mass center. Among the five marked edges at most two are adjacent. Among the ten unit–unit edges at most four are adjacent. All other inverse gaps are at most $1/2$. Thus for either class of $n$ edges the unweighted mean cost is at most $Kn$, where
$$
K=\frac12\left[\frac{4}{3\pi}+\frac2\pi
 (v-v^3/3)\right]<\frac{19}{50},\qquad v=\sin(\pi/5).
$$
For the strict numerical bound use $\pi>157/50$, $v^2=(5-\sqrt5)/8$ and $v<147/250$. For $t\ge1$, the preceding rank computation bounds $C_\theta\le(55t+50)/(t+5)$. Concavity of $x^{2/3}$ now gives
$$
E^3 < A/B,\qquad A=722(t+2)^2(55t+50),\quad B=25(t+5).
$$

A different trial gives a sharper large-mass estimate. Put the mark at zero and put the unit bodies on each side in their required order, at absolute trial displacements $1,1+1/12,1+2/12,\ldots$ from zero. The sum of five squares is at most $55/8$, attained when all units are on one side. The angular mean cost of the five marked edges is at most $20/(3\pi)<17/8$ before multiplying by $t$. Any two trial ranks are separated by at least their rank gap divided by 12. For the ten unit–unit edges the preceding bound yields mean cost at most $12\cdot10\cdot19/50=228/5$. Therefore
$$
E^3< 55(85t+1824)^2/1600 .
$$

## Comparing physical values with the two signed branches

Put $Q=|q_j|^2$. Jensen's inequality and centering give $H\ge Q/2+5\sqrt5/\sqrt{E+(t+5)Q}$. For $t\ge1$ one has $A/B>125(t+5)^2$. Replacing $E$ in this lower bound by $\bar E=(A/B)^{1/3}$ makes the resulting right-hand side strictly increasing in $Q\ge0$, since $\bar E^{3/2}>5\sqrt5(t+5)$. In particular $H^6>125^3 B/A$. On the upper side, positivity of all fifteen physical distances and the center-of-mass relation give
$$
t\sum_{i\ne j}p_{ij}\le E,\qquad t(t+5)Q\le5E,
\qquad H\le \frac{(2t+15)E}{2t(t+5)} .
$$
The second inequality follows from $tq_j=-\sum_{i\ne j}q_i$ and Cauchy–Schwarz.

The [exact verifier](physical_windows.py) clears positive denominators and applies Sturm's theorem to rational univariate polynomials for each sign. On $1\le s\le515/198$ the cluster value violates the stated lower bound. On $s\ge4371/400$ it violates the upper bound using the second trial. These rational cutoffs respectively cover $1\le t\le27/4$ and $t\ge120$. When $0<t\le1$, the earlier bound $d^{1/3}H>5\sqrt5/4$ suffices and the script checks both signs there as well. The [Lean supplement](../../Lean/OpposingPairWindow.lean) checks the ratio simplification, trial inertia arithmetic and upper estimate from its two physical premises. The angular argument, specialization and Sturm intervals are documented and checked separately above.
