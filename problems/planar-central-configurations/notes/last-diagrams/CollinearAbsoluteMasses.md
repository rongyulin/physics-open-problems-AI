# Four positive masses admitting signed absolute equilibria on a line

**Chatgpt · 27 November 2026**

For the four masses $(1,1,1,t)$ there are exactly four positive values of $t$ admitting a collision-free collinear signed absolute equilibrium in the complex Euclidean plane. In each case all positions can be chosen on a real line. The inverse distances carry mixed signs. An ordinary positive-distance configuration with positive masses cannot be stationary, since its leftmost body feels a strictly rightward force.

Define
$$
 P(t)=t^8-116t^6-4810t^4-1044t^2+81,
$$
$$
 Q(t)=t^8-32t^7+300t^6-864t^5-5098t^4-4320t^3+7500t^2-4000t+625 .
$$
The four masses are the unique roots in the intervals below.

| Polynomial | First interval | Second interval |
| --- | --- | --- |
| $P$ | $(16/65,49/199)$ | $(1060/87,1523/125)$ |
| $Q$ | $(16/63,63/248)$ | $(1929/98,2303/117)$ |

Place the three unit bodies at $0,1,x$ and the marked body at $y$. The line direction cannot be isotropic, since all pair squared distances are nonzero. Normalizing the signed distance on edge $01$ and dividing its common sign out, the remaining five independent edge signs are $a,b,c,d,e\in\{1,-1\}$. At the three unit positions write the zero-force equations as $n_i+t d_i=0$, where
$$
\begin{aligned}
 n_0&=(x^2+a)y^2, &d_0&=bx^2,\\
 n_1&=[c-(1-x)^2](1-y)^2, &d_1&=d(1-x)^2,\\
 n_2&=[-a(1-x)^2-cx^2](x-y)^2, &d_2&=e x^2(1-x)^2 .
\end{aligned}
$$
The mass-weighted sum of the four forces is zero by antisymmetry, so the marked-body equation follows from these three when $t\ne0$. The three equations can therefore test both necessity and existence on the collision-free chart.

Set $g=n_1d_0-d_1 n_0$ and $h=b n_2-e(1-x)^2 n_0$. They are quadratic in $y$. Factor their $y$-resultant in $\mathbb Q[x]$. For every factor $f$ other than the collision factors, the coefficient of $y$ in $\mathrm{lc}(g)h-\mathrm{lc}(h)g$ is nonzero modulo $f$. This fixes $y$ as an element of the number field $K=\mathbb Q[x]/(f)$. Discard $y=0,1,x$ and $t=0$, and use $t=-n_0/d_0$ in $K$. Substitution verifies all three original equations for each surviving factor. Taking the minimal polynomial of this element of $K$ over all 32 patterns gives precisely $P(t),Q(t),Q(-t)$ and the following three further polynomials:
$$
3t^2+1,\qquad t^4+118t^2+25,\qquad
6561t^8+6156t^6-2698t^4+1900t^2+625.
$$
In each occurrence the degree of the minimal polynomial of $t$ equals $[K:\mathbb Q]$. Hence $K=\mathbb Q(t)$ and all the axial coordinates are rational functions of the resulting mass with rational coefficients. Any positive conjugate gives a real embedding of $K$ and a real-axis solution with the corresponding signed distances. The collisions already excluded in $K$ stay excluded under every embedding. Exact Sturm counts and rational sign brackets give the four positive roots in the table; the other four polynomials have no positive root. The result classifies the isolated signed quartet equations. A six-body end imposes additional coordinate and torque conditions.

[Complete SymPy verification](CollinearAbsoluteMasses.py)

## Consequence for four electric point charges

The four ratios above describe independent signs attached to edges. For electric point charges with nonzero real values $q_i$, the sign of each pair coupling is instead the product of two vertex signs, up to a common convention for the force direction. In fact no four nonzero electric point charges can all be in static equilibrium on a real line, for any magnitudes. In position order $u_1<u_2<u_3<u_4$, form the skew-symmetric matrix with $K_{ij}=(u_j-u_i)^{-2}$ for $i<j$. Dividing each force by its own charge gives $Kq=0$. Its Pfaffian is
$$
 K_{12}K_{34}-K_{13}K_{24}+K_{14}K_{23}>0
$$
because $K_{12}>K_{13}$ and $K_{34}>K_{24}$. Therefore its determinant is positive. This argument is the four-body case of known positivity results for the Albouy–Moeckel matrix. [Ferrario, *Pfaffians and the inverse problem for collinear central configurations*](https://arxiv.org/abs/2006.13049)

A separate triangular elimination of the 32 signed ideals gives the same positive roots. [Independent Gröbner-basis replay](AbsoluteLineMass88.py)
