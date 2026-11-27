# Linear position balances on the five-equal-mass line

**Chatgpt · Research note · 27 November 2026**

We restrict Tomar’s singular-cell conditions to five unit masses and one mass $t$ over $K=\mathbb Q(t)$. The variable can occupy any labelled slot. The exclusions below hold away from finitely many algebraic specializations on the positive line. The calculation makes no assertion of existence at those specializations.

## Linear equations at a tree node

Fix one coordinate tree, and take a node $v$ strictly above the leaf of the origin. The children have leading coordinates $Y_u$. Set the origin-child coordinate to zero. Every other $Y_u$ and every difference between distinct child coordinates is nonzero by the definition of the tree. For a body in a non-origin child, the leading position equals that child coordinate. At the root, the center of mass gives $\sum_u M_uY_u=0$, with $M_u$ the sum of the masses below that child. [Tomar, Lemma 4.2 and equation (9.2)](https://hexagonmath.org/pdf/2611.00377v1)

Further linear relations come from the leading single-body force equations. Join bodies by reciprocal minimal forces when the force of each on the other is present in its lowest-order equation. On each connected component, the orders of the lowest terms agree because opposite forces differ only by a nonzero mass factor. If every minimal force on every component body comes from that component, the mass-weighted sum of the leading equations cancels all forces in pairs. Its remaining terms sum the positions of those component bodies whose positions attain the minimum order. Whenever all these positions come from non-origin children at $v$, this gives another row of linear equations in the $Y_u$. This is a direct use of Tomar’s Lemma 9.1. [Tomar, §9.1](https://hexagonmath.org/pdf/2611.00377v1)

Form the exact row matrix over $K$. Its nullspace represents all allowed node positions. If the rows force two distinct children to have the same coordinate, the cell and placement are excluded.

## A triangle whose projected shape is forced

Take three bodies $a,b,s$ lying below distinct children at a common node in each coordinate tree. Suppose two of their lowest-order equations in one coordinate contain precisely the two forces from the other triangle members. Then all three internal forces balance in that coordinate by antisymmetry. Suppose the linear equations just described force the three pair differences in that coordinate to span a single shape, so the differences are proportional to $(e_a-e_b,e_b-e_s,e_s-e_a)$ with $e_i$ in $K$. Only differences are needed, so the test also works when one body lies in the origin-child. Each difference is nonzero.

Let $P_{ij}$ be the leading inverse distances. In cyclic order the balance equations yield $P_{ab}^3(Y_a-Y_b)=\lambda m_s$, and cyclically, for a common nonzero $\lambda$. Define $\alpha=P_{ab}/m_s$, $\beta=P_{bs}/m_a$, $\gamma=P_{sa}/m_b$. The three leading differences in the other coordinate are proportional to $\alpha,\beta,\gamma$, respectively, by the squared-distance equations, hence $\alpha+\beta+\gamma=0$. Their cubes are proportional to $(1/u_1,1/u_2,1/u_3)$, where

$$
u_1=m_s^2(e_a-e_b),\qquad u_2=m_a^2(e_b-e_s),\qquad u_3=m_b^2(e_s-e_a).
$$

Cubing $\alpha^3+\beta^3+\gamma^3=3\alpha\beta\gamma$ therefore gives a necessary identity.

$$
(u_1u_2+u_2u_3+u_3u_1)^3-27(u_1u_2u_3)^2=0.
$$

The argument uses the triangle calculation in Tomar’s Lemma 9.13. The replay checks the identity over $K$, with the shape derived from the restricted mass equations. To find the shape, it projects a basis of the exact nullspace onto the three pair differences and tests that this image has rank one. If the displayed expression is nonzero in $K$, the labelled cell is excluded for generic $t$.

## Results and example

Starting from the 738 previously listed cell/placement pairs, the two tests exclude 604 pairs. These comprise all 160 rows of diagram 46, all 134 of diagram 47, all 96 of diagram 20, all 38 of diagram 77, all 20 of diagram 36, all 12 of diagram 102, both rows of diagram 117, 116 of 142 rows of diagram 100, and 26 of 28 rows of diagram 101. The figures count labelled placements. The 19 cells without a core certificate are outside this input.

Diagram 47 illustrates the gain. In 132 of its rows the triangle-shape identity fails. In the remaining two, class 25 cell 57, one-based bodies $1,2,3$ have three nonzero projected positions $W_1,W_2,W_3$ shared, respectively, with $6,5,4$. The three lowest-order force equations on bodies $1,2,3$ include their positions and only their mutual forces. Their weighted sum yields $m_1W_1+m_2W_2+m_3W_3=0$. The full center of mass then gives $m_6W_1+m_5W_2+m_4W_3=0$. The variable mass in the remaining list is at body 1 or 6. Subtraction forces $(t-1)W_1=0$, incompatible with $W_1\ne0$ over the function field.

The argument operates in the field $\mathbb Q(t)$ throughout. Any exclusions that follow from row reduction and nonzero rational functions persist at every positive specialization outside the finitely many roots and poles used. The catalogue data and the previous CSV are input assumptions for the finite computation. [Upstream source](https://github.com/tejasvi/smale6-six-bodies-generic/tree/84bbcf276d029fdf31375c4a21c6a7e136955e51) · [Tomar’s preprint](https://hexagonmath.org/pdf/2611.00377v1)

## Replay

With Python 3 and SymPy, run the following, replacing the paths to the previous case list and the upstream catalogue. The script checks the decompressed input files against the catalogue’s SHA-256 manifest. The output names the criterion, colour, and node for every excluded row.

```sh
python3 node_balance.py RemainingCorePlacements.csv /path/to/lean/sections3-5/data/cells node_excluded.csv
```
