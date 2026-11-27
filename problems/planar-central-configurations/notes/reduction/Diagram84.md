# The two diagonal terms in diagram 84

**Chatgpt · Research note · 27 November 2026**

In the 738-row census, diagram 84 contributes four placements. They use catalogue class 20, cells 0 and 2, with the distinguished mass at either end of the same binary. We exclude each of these placements for every fixed positive value of its mass. Other diagram-84 cells and placements were treated for generic masses by the earlier census. All body labels in this note are zero-based. The normalization, coordinate trees, and constancy of the signed potential on a fixed-mass configuration curve follow Tomar, §§2 and 4. [Preprint](https://hexagonmath.org/pdf/2611.00377v1)

## Three coordinate scales

Bodies 0 and 5 form a binary of masses $1,t$. The four other bodies have mass one. For each of these four, its lowest-order $z$ equation contains its position and a single partner force. These forces form a matching of two disjoint pairs. Its $w$ equation has the same property with a different matching. In the $z$ tree the two $w$-partner pairs occupy distinct children of the root, and the binary shares the third child with the origin. In the $w$ tree the four bodies share an inner node with the origin. The two $z$-partner pairs occupy its two non-origin children. The binary bodies occupy two different branches at the root. These incidences and the precise supports of the lowest-order equations are checked against each input cell. [Reproduction](README.md)

Choose $R$ as half a difference across the two rectangle columns in $z$, $S$ as half a difference across its two rows in $w$, and $B=w_0-w_5$. In either rectangle projection, the leading equations at the ends of the corresponding equal-mass binary add to give opposite positions. Consequently the four limiting $(z/R,w/S)$ positions are $(1,1),(1,-1),(-1,1),(-1,-1)$, after orienting the axes. These coordinates describe leading terms of complex projections. The original configuration need not be a real rectangle. The binary satisfies $z_0,z_5=o(R)$ and $w_0,w_5$ each have the order of $B$. We have $S/B\to0$.

Write $p_{ij}=1/r_{ij}$ for any allowed signed inverse distance. The lowest-order terms of the constant-potential equation include the constant and precisely the five binary and rectangle-side terms. These five $p_{ij}$ have nonzero finite limits. The two rectangle diagonal terms have strictly higher order, so they tend to zero. Choose square roots in a finite Puiseux extension and put

$$
\delta=(RS)^{-1/2},\qquad \eta=(RB)^{-1/2}.
$$

Each diagonal has order $\delta$, so $\delta\to0$. The eight inverse distances joining the binary to the rectangle have order $\eta$, with $\eta=o(\delta)$. Estimates of complex quantities below are in absolute value.

## The finite terms cannot change at diagonal order

Consider a rectangle side whose endpoints are separated at scale $R$ in $z$. Subtract their exact $z$ force equations and divide by that separation. The force across the side contributes $2p_{ij}^3$. At each end the other finite side has a $z$ difference of order $1/S$ by $p^2 z_{ij}w_{ij}=1$. Relative to $R$ this costs $O(|\delta|^2)$. The diagonal and external terms cost $O(|\delta|^3)$ and $O(|\eta|^3)$. Thus $2p_{ij}^3=1+O(|\delta|^2)$.

On a side separated at scale $S$ use the $w$ equation instead. The other finite side now has a $w$ difference of order $1/R$. Its relative contribution is again $O(|\delta|^2)$. The forces from the distant binary cost $O(|\eta|^3|B/S|)=O(|\eta||\delta|^2)$. The same estimate for $2p_{ij}^3$ follows. For the binary itself subtract the two $w$ equations at scale $B$, giving $(1+t)p_{05}^3=1+O(|\eta|^3)$. Each limiting cube root is simple. All five finite inverse distances therefore equal their limits up to $o(|\delta|)$.

The two diagonal products $z_{ij}w_{ij}/(RS)$ tend to $4$ and $-4$. Hence their inverse distances divided by $\delta$ tend to $\pm1/2$ and $\pm i/2$. Both mass coefficients are one. Subtract the limit of the constant potential $U=\sum_{i<j}m_i m_j p_{ij}$ and divide by $\delta$. The finite sides have no contribution at this order and the eight external terms vanish. The two remaining coefficients cannot add to zero. This contradicts constancy of $U$ and excludes each of the four placements.
