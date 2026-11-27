# A regular-square quartet cannot lift in diagram 88

**Chatgpt, 27 November 2026**

Assume the four masses of the quartet are one and the binary masses are $1,t$, with $t>0$. Diagram 88 has no complex singular place whose normalized leading quartet is a centered regular square. This holds for both admissible families of signs of its six internal inverse distances, including every positive binary ratio allowed by the first torque condition. Other four-body leading shapes remain possible. The valuations and the isolated four-body equations are those of [Tomar, Lemma 6.16(a)](https://hexagonmath.org/pdf/2611.00377v1).

## Chart and the critical value

Choose the high projection of the quartet as $w$ and that of the binary as $z$. Write the quartet's coordinates as $(h^2Y_k,h^{-2}X_k)$ and the binary's as $(B_j,C_j)$. Use the global complex rotation to fix $B_0=t/(1+t)$ exactly, then choose $h^2$ to fix $X_0=1$ exactly. Both marked high coordinates have nonzero leading coefficient, so these choices can be made after a finite Puiseux extension. The product of the two diverging original projections shows $h\to0$. At the binary limit $B_1=-1/(1+t)$, its internal inverse distance has cube $1/(1+t)$, and $C_j=r_b B_j$ with $r_b^3=(1+t)^2$.

For the square let $\zeta=e^{\pi i/4}$, $X_k=\zeta^{-2k}$ for $0\le k\le 3$, and $Y_k=r_s/X_k$. Its inverse distances on any pair of sides have equal squares. At each vertex the force components perpendicular to the radius require its two adjacent inverse-distance cubes to be equal. Thus all side inverses agree, the radial equation makes both diagonal inverses agree, and the diagonal inverse is $\sigma/\sqrt2$ times the side inverse for $\sigma=\pm1$. Set $D_\sigma=1/\sqrt2+\sigma/4$. The radial equation and squared distances give

$$
p_{\rm side}^3=(2\sqrt2 D_\sigma)^{-1},\qquad
p_{\rm diag}^3=\sigma/(8D_\sigma),\qquad r_s^3=D_\sigma^2 .
$$

Near any one of these limits, inverse distances within each cluster are analytic branches of their inverse square roots. For the cross edges write $p_{jk}=h\,g_{jk}$ with

$$
g_{jk}^2\,(B_j-h^2Y_k)(X_k-h^2 C_j)=-1 .
$$

All arguments of these square roots are nonzero at $h=0$. With $m_0=1,m_1=t$ on the binary, the normalized six-body equations require stationarity of the analytic function

$$
V=\frac12\left(\sum_k X_kY_k+\sum_j m_j B_jC_j\right)
  +\sum_{k<l}p_{kl}+t p_{01}^{\rm bin}
  +h\sum_{j,k} m_j g_{jk}.
$$

Indeed, before the coordinate change, derivatives of $U+I/2$ in each projected position give the corresponding opposite projected force equations. Thus all ten derivatives in the unconstrained chart positions $q$, and the derivative in $h$, vanish along a putative branch. Set $V_0=V|_{h=0}$, $F=\partial_hV|_{h=0}$. Then $V(q,h)=V_0(q)+h F(q)+O(h^3)$.

At the limit let $\alpha^2=-1/B_0$, $\rho=t^{3/2}$, and use signs $a_k,b_k\in\{-1,1\}$. The cross coefficients are $\alpha a_k\zeta^k$ and $\alpha i\sqrt t\,b_k\zeta^k$. Thus $F/\alpha=P+i\rho Q$ with $P=\sum a_k\zeta^k$ and $Q=\sum b_k\zeta^k$. In either sum the squared modulus equals $4\pm2\sqrt2$. The required equality $F=0$ leaves only $\rho=\sqrt2-1,1,\sqrt2+1$. This calculation depends only on $X$, so applies to either $\sigma$.

## The two unequal resonances

Let $H=V_{0,qq}$ be evaluated in the chart omitting $X_0,B_0$. It is the direct sum of the two internal Hessians. At each relevant specialization these blocks are invertible, as checked by the modular Gaussian eliminations below. Thus the ten shape equations have a unique analytic lift $q(h)$ through the limit and $q'(0)=-H^{-1}F_q$. The required scalar derivative on this lift has linear coefficient $-F_q^\mathsf{T} H^{-1}F_q$. Transpose here uses the complex bilinear pairing.

The Hessian of a single edge with coordinate differences $x,y$ and inverse-distance cube $f$ has $xx$, $xy$ and $yy$ entries $m_i m_j f(3y/x,1,3x/y)/4$ in difference coordinates. Add to each single-body $xy$ entry $m_i/2$. First evaluate these matrices with $r_s=r_b=1$ in the positions and keep the true $f$ values above. Denote the two matrices by $H_s^0,H_b^0$. In the original scale $r$, the $xx$, $xy$, $yy$ blocks are multiplied respectively by $r,1,1/r$. In particular the quadratic form on a gradient supported in $x$ scales by $1/r$.

Set $w_k=(a_k+i\rho b_k)\zeta^k$. With the common multiplier $-\alpha/2$ removed, the square gradient has entries $w_k/X_k$ in each free $X_k$, and the binary gradient has entry $i\rho Q/B_1$ in free $B_1$. All opposite projection entries vanish. Call the two quadratic forms obtained by inverting the scale-one Hessians $S,T$. If the linear coefficient vanished, then $S/r_s+T/r_b=0$, and hence

$$
(1+t)^2 S^3+D_\sigma^2 T^3=0.
$$

The first replay reduces $\zeta$ to 30 modulo 241, so $\sqrt2$ reduces to 22. The two nonequal $\rho$ reduce to 21 and 23. All three residues of $t^3=\rho^2$ are available in each case, namely $(61,192,229)$ and $(20,59,162)$. For each combination of a sign $\sigma$, a residue of $t$ and a residue of $\rho$, eight pairs of cross-sign vectors satisfy the initial torque. None satisfies the cubed compatibility equation. All matrix solves in the replay have invertible pivots.

For the characteristic-zero deduction, extend the chosen prime of $\mathbb Q(\zeta)$ to the number field of the initial data. The two possible $t$ are algebraic integers. Every reduction of such a $t$ is among the tested residues; the matrices and all factors inverted have nonzero reductions. Thus a characteristic-zero compatibility identity would reduce to a tested zero. Cubing removes both independent internal scales before reduction.

## Equal binary masses

At $t=1$ the full scalar equation can be expanded directly modulo the splitting primes in the table. Fix $\alpha=i\sqrt2$. Each cross-distance branch is covered by one of the independent sign pairs. For each pair of internal scales and cross signs, recursively determine the shape coefficients through $h^3$. Given $q_0,\ldots,q_{n-1}$, set $q_n=0$ temporarily, evaluate the $h^n$ coefficient $c_n$ of $V_q$, and solve $Hq_n=-c_n$. After inserting $q_n$, check that all ten shape residuals vanish through degree $n$. The exact scalar derivative at fixed $q$ used to test the resulting lift is

$$
\partial_h V=\sum_{j,k} g_{jk}\left[1+h^2\left(
  \frac{Y_k}{B_j-h^2Y_k}+\frac{C_j}{X_k-h^2C_j}\right)\right].
$$

| Diagonal sign | Prime | Residues of $r_s$ | Residues of $r_b$ | Nonzero $h^3$ coefficient of $\partial_h V$ |
| --- | ---: | --- | --- | --- |
| $-1$ | 457 | 191, 268, 455 | 19, 196, 242 | 126, 331, 189, 268 |
| $+1$ | 2113 | 1090, 1141, 1995 | 395, 1857, 1974 | 700, 1413, 1705, 408 |

In each row all $16\cdot3\cdot3=144$ initial data pass the first torque and yield a nonzero coefficient in the table. The replay finds each of the four displayed residues 36 times. The earlier coefficients of $\partial_h V$ vanish in the finite-field computation. The nonzero coefficient suffices, regardless of their characteristic-zero values. Each prime splits the two scale cubics for its chosen embedding of $\mathbb Q(\zeta)$. The same reduction argument now applies to each Taylor coefficient: every division is by a unit and the characteristic-zero shape recursion is unique. Therefore the scalar equation cannot vanish identically along a lift.

## Reproduction

Run the following with Python and SymPy, in this directory.

~~~sh
python square_second_order.py
python square_lift.py
~~~

No branch in a particular cell is assumed to have this square leading quartet. In the eight diagram-88 cells other than catalogue cell 6 the quartet already has some $Y_k=0$ at the four-body scale and every $X_k\ne0$. This rules out every collinear leading quartet $Y=\lambda X$ in those cells, as well as the regular square there. Cell 6 has additional non-square shapes to analyze.
