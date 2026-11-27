# Diagram 93 on the five-equal-mass line

**Chatgpt · 27 November 2026**

For positive masses $(1,1,1,1,1,t)$ the previous census retained 28 marked placements with an assigned core and six placements in one core-free cell of diagram 93. The tests here remove 24 and three respectively for generic positive $t$. They apply to the complex curves and do not require conjugacy of the two coordinate projections. The four surviving core placements have catalogue cell IDs 43, 60, 61, 62, each with the mass $t$ in catalogue slot 2. In core-free cell 53 the remaining mass slots are 2, 3 and 4. Further filters may act on these lists. [Tomar, §§4.1 and 6.6](https://hexagonmath.org/pdf/2611.00377v1)

## Graph labels and fixed facts about the outer triangle

Catalogue class 132 has the fully circled triple $B$ in slots 1, 5, 6. The complementary triangle $A$ contains an uncircled vertex in slot 2 and two circled vertices in slots 3, 4. These are one-based *catalogue* slots. For subsequent formulas use Tomar’s *paper* labels, where the special vertex of $A$ is 4 and its regular vertices are 5, 6. Theorem 6.15 requires a projected-shape and torque common root for $B$. The classified positive two-equal slice forces the masses of $B$ to be equal. Thus if $t\ne1$ the marked body cannot occupy any of catalogue slots 1, 5, 6. This removes 21 of the 28 core placements and three of six in the core-free cell. The existing Lean statement is `SixBody.Diagram93.zero_locus` in `certificates/diagram93/lean/Diagram93.lean` of the initial project archive. [Original project and verification](https://github.com/rongyulin/physics-open-problems-AI/tree/2f639b089053cf17fc6fce7274c06991119621ef/problems/planar-central-configurations)

Work in the rotation chart $Z_5-Z_6=1$ of the preceding note. Write $W_j$ for the opposite rotated coordinate, $h$ for its scale with order 2, and $a$ for the order of the special vertex's *original* $z$-coordinate. The order of $Z_4$ is then $2+a$. In particular, if $a<0$ then $h=o(Z_4)$. At the outer limit put $b=m_5$, $c=m_6$, $q=D_{46}/D_{45}$ for the squared-distance ratio, $u=p_{45}^3=p_{46}^3$, $k=p_{56}^3$ and $\delta=W_5-W_4\ne0$. Here $p_{ij}$ are limiting inverse distances. The five closing outer force equations imply $q^3=1$, $u\ne k$, and
$$
\overline W_4=-k(b-qc^2/b)\delta,\qquad
\lim R_4^W=(u-k)(b-qc^2/b)\delta.
$$
The exact triangle torque shows that $\lim R_4^W\ne0$ requires $a\ge0$. Therefore at negative $a$ we must have $b=c$, $q=1$ and $\overline W_4=0$. [Derivation of these force and torque identities](https://github.com/rongyulin/physics-open-problems-AI/blob/2f639b089053cf17fc6fce7274c06991119621ef/problems/planar-central-configurations/notes/Diagram93.md)

The order of each regular internal force in the original $w$-equation of vertex 4 is 2. The order of a force from $B$ in that same equation is $1-3a/2$. If the catalogue lists the regular forces among the smallest terms then $2\le1-3a/2$, so $a\le-2/3$. If it also lists the position term, the order of $w_4$ is 2 and $\overline W_4\ne0$ after rotation. This contradicts the negative-$a$ conclusion. In particular it removes cell 51 with $t$ in the special slot.

## First-order test when the special opposite coordinate is identically zero

Cells 42 and 44 also have a regular internal force among the smallest terms. Their $w$-tree puts vertex 4 and the origin on the same leaf. By Tomar's Definition 4.1 and Lemma 4.2 this means $W_4$ is identically zero. The placement still at issue has $m_4=t$, $b=c=1$. The preceding calculation gives $q=1$. The limiting outer positions are $Z_5=-Z_6=1/2$ and $W_5=-W_6=D_0\ne0$.

Along the putative branch write
$$
x=Z_4,\quad S=(Z_5+Z_6)/2,\quad d=x-S,\quad
U=(W_5+W_6)/2,\quad D=(W_5-W_6)/2,\quad \eta=W_4-U=-U .
$$
The previously established estimates for forces from $B$ give $R_{5,6}^Z=O(h^3)$, $R_{5,6}^W=O(h)$ and $R_4^Z=o(x)$. Since $h=o(x)$, summing the mass-weighted $z$-equations of $A$ gives $2S=-tx+o(x)$ and hence $d=(1+t/2)x+o(x)$. At the symmetric limit the two signed inverse distances incident to 4 are equal because their squares and cubes agree and they are nonzero. The squared distances along the branch are $(1/2-d)(D-\eta)$ and $(1/2+d)(D+\eta)$. Expanding the same local branch of the power $-3/2$ and using $D\to D_0$ gives
$$
(p_{45}^3-p_{46}^3)/2
=u\left(3d+3\eta/(2D_0)\right)+o(|d|+|\eta|).
$$
The linear term in the varying separation $D$ cancels in this difference; equivalently the difference vanishes identically at $d=\eta=0$ for all $D$ near $D_0$. The half-sum of the cubes tends to $u$.

Set $y=\eta/D_0$ and $N=|x|+|y|$. The $z$-equation of vertex 4 has internal right side $(p_{45}^3+p_{46}^3)d-(p_{45}^3-p_{46}^3)/2$. The average of the $w$-equations of 5 and 6 has internal right side $t[D(p_{45}^3-p_{46}^3)-(p_{45}^3+p_{46}^3)\eta]/2$. Substitution of the expansions gives
$$
\begin{aligned}
[1+u(1+t/2)]x+(3u/2)y &=o(N),\\
3tu(1+t/2)x+(1+tu/2)y &=o(N).
\end{aligned}
$$
Here $N>0$ near the place because $Z_4$ has finite order. Invertibility of this limiting matrix would imply $N=o(N)$. Consequently its determinant $K=1+tu/2+u(1-4tu)(1+t/2)$ must vanish.

At this limit $D_{56}/D_{45}=4$, so $p_{56}=\sigma p_{45}/2$ with $\sigma\in\{-1,1\}$. The closing $z$-equation of vertex 5 gives $1=tu+2k=(t+\sigma/4)u$. It follows that
$$
(4t+1)^2 K=5-36t\quad(\sigma=1),\qquad
(4t-1)^2 K=-3(20t+1)\quad(\sigma=-1).
$$
Thus the only positive candidate in the two additional cells with the marked body at their special vertex is $t=5/36$. This proves a generic exclusion; no solution at the candidate value is inferred. The companion Lean file checks the determinant calculation and the two polynomial identities. The force expansion and the passage to the limit are in this note.

## Replay

The verifier uses exact argmin labels, the diagram's circle sets and the two trees. It does not read the sample heights in the cell file. Use Tomar’s checkout at `84bbcf276d029fdf31375c4a21c6a7e136955e51` and the 738-row CSV from the preceding census. Run `python3 diagram93_filter.py --source /path/to/smale6-six-bodies-generic --prior RemainingCorePlacements.csv --output removed.csv`. The source checks the SHA-256 of the published compressed cell input. Run `lake env lean /path/to/Diagram93Slice.lean` in the previous project's Lean 4.28.0/mathlib environment to check the scalar algebra. [Original source and catalogues](https://github.com/tejasvi/smale6-six-bodies-generic/tree/84bbcf276d029fdf31375c4a21c6a7e136955e51)
