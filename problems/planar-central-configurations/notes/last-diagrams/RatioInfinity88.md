# Degree at infinity of the universal quartet resultant

**Chatgpt · 27 November 2026**

For the [three-variable quartet chart](RepeatedStar88.md), let $F,G$ be the cleared force numerators with coordinates $(r,s,k)$ and the edge order $12,13,23$. With $r$ transcendental the polynomial $\mathrm{Res}_k(F,G)$ in $s$ has degree at most **4046**. The [fixed fibre](FixedRatio88.md) reaches this degree at $r=3$. This upper bound uses the entire chart over $\mathbb Q(r)$, including complex places at infinity. The degree count is one ingredient in controlling specialization of the force equations.

Use $A=\alpha_1\alpha_2$, $B=\alpha_1\alpha_3$ and $C=\alpha_2\alpha_3$ as in the distance chart. Before clearing denominators, write $f=(k+LA)^2-e_{12}$, $g=(k+LC)^2-e_{23}$. A third polynomial of lower degree is the reduced numerator $H$ of the rational function

$$
h=C^2f-A^2g=k^2(C^2-A^2)+2kAC(C-A)L-C^2e_{12}+A^2e_{23}.
$$

Write $u/v=\mathrm{den}(g)/(A^2\mathrm{den}(h))$ in reduced form. On roots of $F$, $G=-Hu/v$ whenever the denominators of this identity are nonzero. Equivalently a polynomial multiple of $F$ equals $vG+uH$ after localization at those denominators. To justify the resulting root evaluation without assumptions on individual roots, one can also use the explicit identity
$A^2\mathrm{den}(h)\mathrm{den}(f)G- C^2\mathrm{den}(h)\mathrm{den}(g)F=-\mathrm{den}(f)\mathrm{den}(g)H$.
The replay checks that $F$ is coprime to these denominators in $\mathbb Q(r,s)[k]$. The $k$-degrees of $F,G,H,u,v$ are $28,34,22,14,2$. By the product formula for univariate resultants (including leading coefficients) this gives, up to sign, $\mathrm{Res}(F,G)=\mathrm{Res}(F,H)\mathrm{Res}(F,u)/\mathrm{Res}(F,v)$. Compute the last two resultants factor by factor. The four numerator factors give $s$-degrees $64,56,236,232$ with multiplicities $2,1,3,3$. The denominator contributes degree $82$ at multiplicity two. Thus the total correction is $1424$.

For a Puiseux series at $s=\infty$, call its largest exponent of $s$ its degree. The upper Newton polygon of $H$ as a polynomial in $k$ gives degrees $-3,0,1,2,3$ for its roots, with multiplicities $2,2,6,6,6$. For any possible degree $b$ of $k$, $\deg_s F(k)$ is at most $\max_i(\deg_s F_i+ib)$, where $F_i$ is the $k^i$ coefficient. A translation of $k$ before taking this maximum detects cancellation. The resulting bounds are as follows.

| Degree of root $k$ | Condition | Number of roots of $H$ | Bound for $\deg_s F(k)$ |
| ---: | --- | ---: | ---: |
| $-3$ | All | 2 | 70 |
| $0$ | All | 2 | 82 |
| $1$ | Leading coefficient different from 1 | 3 | 86 |
| $1$ | $k=s+O(1)$ | 3 | 80 |
| $2$ | Two choices of $c$, three choices of the coefficient of $s^{2/3}$ for each | 6 | 81 |
| $3$ | Leading coefficient different from $r^2/(2r^2-1)$ | 3 | 118 |
| $3$ | $k=(r^2/(2r^2-1))s^3+O(s^2)$ | 3 | 112 |

For the fourth and seventh rows, translate by $s$ and by $r^2s^3/(2r^2-1)$ respectively. In both cases the upper Newton polygon of the translated $H$ counts exactly three roots at the stated lower degree. Applying the coefficient bound to the corresponding translated $F$ gives the table entries.

For the fifth row set $w=s^{-1/3}$ and

$$
k=cw^{-6}-c^2w^{-3}+vw^{-2},\qquad c^2=\frac{r^2}{2(r^2+1)}.
$$

The polynomial $w^{207}H$ has ordinary powers of $w$ and at $w=0$ its polynomial in $v$ is a cubic with only the constant and cubic coefficients nonzero. Each of its three simple roots lifts, and the two signs of $c$ give the six roots in this group. The polynomial $w^{264}F$ likewise has ordinary powers. In $\mathbb Q(r,c)[v,w]/(w^{21})$ the first normalized polynomial divides the second. To verify divisibility, map the coefficient field into the rational function field $\mathbb Q(z)$ by

$$
r=\frac{z^2-4z+2}{z^2-2},\qquad c=\frac{z^2-4z+2}{-2z^2+4z-4}.
$$

These functions obey the quadratic relation and $r$ is transcendental. The map is injective since $r^2/[2(r^2+1)]$ is not a square in $\mathbb Q(r)$. After clearing scalar denominators, divide at each order $w^0$ through $w^{20}$ by the leading cubic in $v$. All 21 remainders vanish identically over $\mathbb Q(z)$. Thus every lifted root satisfies $\deg_s F(k)\le (264-21)/3=81$.

The leading $k^{22}$ coefficient of $H$ has $s$-degree 23. The resultant product over the 22 roots gives

$$
\deg_s\mathrm{Res}_k(F,H)
\le 28\cdot 23+2\cdot70+2\cdot82+3\cdot86+3\cdot80+6\cdot81+3\cdot118+3\cdot112=2622 .
$$

Adding the correction gives $2622+1424=4046$. [RatioInfinity88.py](RatioInfinity88.py) checks the low-degree resultants, all Newton polygons, all twenty-one exact remainders and the degree arithmetic. [InfinityChart88.py](InfinityChart88.py) constructs the universal force numerators. Run `python3 RatioInfinity88.py` with python-flint 0.8.0 in the same directory.
