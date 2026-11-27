# Further restrictions on diagram 88

**Chatgpt · 27 November 2026**

The diagram-88 quartet has masses $(t,1,1,1)$, and the two binary masses are one. The first two calculations below concern the case in which a unit quartet body $o$ has zero small projection. Write $1,2,3$ for the other quartet bodies, with masses $t,1,1$, and set $r_i=p_{oi}/p_{o1}$, so $(r_1,r_2,r_3)=(1,r,s)$. The third calculation concerns the general quartet chart in which ratios are measured from the marked body instead. [Quartet force and projection equations](ZeroProjection88.md) · [General quartet chart](QuartetChart.md)

## Pairwise distinct sixth powers at the unmarked zero

For all but finitely many positive $t$, any quartet of the first kind must satisfy
$$
r^6\ne1,\qquad s^6\ne1,\qquad r^6\ne s^6.
$$
In particular no two distances from $o$ can have the same squared length. This is a restriction on the shape within the mixed-zero cell.

Centering and the small-coordinate force at $o$ give $\sum m_iY_i=\sum m_i r_i^3Y_i=0$. All three $Y_i$ are nonzero, hence equality between two of the cubes forces all three equal. That sector occurs for only finitely many $t$ by the separate [equal-cubes argument](ZeroProjection88.md). It remains to check pairs of opposite cubes since these are the other way in which the sixth powers can agree.

With three distinct cubes the relative small coordinates are $((r^3-s^3)/t,s^3-1,1-r^3)$ up to common scale. The three force and distance equations produce integer polynomials $F_{12},F_{13},F_{23}$ in $(r,s,t)$. Interchanging bodies 2 and 3, which have equal mass, reduces the possible relations to four rows. Here $\zeta$ is either primitive sixth root. In the primitive rows replace each restricted polynomial by its norm to $\mathbb Z[s,t]$; for $a+b\zeta$ this is $a^2+ab+b^2$. Any common zero on either conjugate branch is a common zero of the norms. [Polynomial construction](OuterZeroChart88.py)

| Relation | Common divisor removed by exact division | Reason it is nonzero on the chart |
| --- | --- | --- |
| $r=-1$ | $[(s^3-1)t+s^3+1]^2$ | Its vanishing would give $Y_1=Y_2$. |
| $r=\zeta$ | $1$ | No division is needed. |
| $r=-s$ | $s^{14}$ | $p_{o3}$ and $p_{o1}$ are nonzero. |
| $r=\zeta s$ | $s^{28}$ | $p_{o3}$ and $p_{o1}$ are nonzero. |

For each row denote the three resulting polynomials by $G_1,G_2,G_3$. Specializing $s=2$ modulo 1009 preserves the degrees in $t$ of $G_1$ and $G_2+2G_3$ and yields gcd one. Specializing $t=2$ preserves the degrees in $s$ and again yields gcd one. The two Sylvester resultants in characteristic zero are therefore nonzero, one in each coordinate. Only finitely many complex pairs $(s,t)$ can remain. The script constructs the three original polynomials and verifies the divisions, both degree checks and both gcds. [Sixth-power replay](OuterSixth88.py)

## The equal-cubes sector at exactly $t=2$

Suppose $r_i^3=1$. Write $(y_1,y_2,y_3)=(1,x,-2-x)$, $d_i=r_i/y_i$, $D=2d_1+d_2+d_3$. All four centered high coordinates are given, in one common scale, by $X_o=-D$ and $X_i=5d_i-D$. The nonzero conditions include all four $X$, all three $y_i$, all three pairwise differences of $y_i$, and all three pairwise differences of $d_i$.

The stress scalar is $k=1$. For zero stress, $[(y_1-y_2)(d_1-d_2)]^3=1$. For rank-one stress the entire $o$ row vanishes, so the other three positions are affinely dependent. This gives $\det[1,y_i,d_i]_{i=1}^3=0$. Multiply the two corresponding polynomial numerators and remove all factors supported on the forbidden divisors. For every one of the nine choices of $r_2,r_3$, the remaining polynomial is coprime over $\mathbb Q(\sqrt{-3})$ to each of the eight necessary torque polynomials. These polynomials use the squares of the four torque terms, proportional to $\epsilon_i m_i^2/X_i$, with $\epsilon_i\in\{\pm1\}$ and one common sign fixed. This excludes the equal-cubes fibre at this specific mass. This particular fibre computation supplies only the equal-cubes part of the fixed-mass test. Using a fixed mass to eliminate a moving family also requires controlling the limits on the chart boundaries. [Exact quadratic-field gcds](EqualFibre88.py) · [Torque polynomial](Collinear88.md)

## Two finite-field slices of the general quartet equations

Use the marked body as the origin of the distance ratios in this calculation. The [repeated-coefficient argument](RepeatedStar88.md) eliminates the stress scale $L$ from the force equations. The two remaining force numerators $F_1,F_2$ and the signed torque involve $(r,s,k)$, with one quadratic equation for the choice of projection. On the slices $r=2$ and $r=3$ over $\mathbb F_{1009}$, $F_1,F_2$ have respective bidegrees $(82,28),(100,34)$ in $(s,k)$ and their resultant in $k$ has degree $4046$ in $s$.

For each irreducible factor of this resultant, form the residue field containing one $s$ root and compute the common $k$ polynomial. Remove zero masses, $t+3=0$, zero or repeated star cubes, and the other forbidden denominators and zero edge lengths. Each remaining $k$ polynomial is linear. Both possible projections are represented by the quadratic in $h$ from the distance chart. After removing forbidden zero high coordinates, none of the eight torque polynomials has a common root with that quadratic. The counts below are counts of distinct geometric pairs $(s,k)$, allowing field extensions.

| Ratio fixed in the prime field | Degrees of surviving $s$ orbits before the torque | Number of pairs | Passing the torque |
| --- | --- | ---: | ---: |
| $r=2$ | $3,15,20,43,111,478$ | 670 | 0 |
| $r=3$ | $6,670$ | 676 | 0 |

The ratio $r$ varies independently of the mass $t$. These slices do not rule out a component that specializes to a forbidden divisor, has $r$ constant elsewhere, or has no admissible reductions at the test prime. The [moving-ratio theorem](ConstantRatios88.md) ensures that at least one of the two ratios varies on any dominant candidate curve; one can exchange unit labels to call such a ratio $r$. They supply two reproducible tests for further elimination on the full chart. The script reconstructs both force polynomials directly from the distance equations and checks every listed orbit over the indicated finite fields. [Two-slice replay](QuartetFibres88.py)

Run the first two scripts with Python 3.10+ and SymPy, and the last with python-flint 0.8.0. All use the equations in this directory and require no precomputed polynomial data.
