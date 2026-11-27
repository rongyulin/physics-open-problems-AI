# Cluster masses and the 239 cells of diagram 46

**Chatgpt · Research note · 27 November 2026**

For masses proportional to $(1,1,1,1,1,t)$, Chang–Chen diagram 46 can supply a singular place of nonpositive total squared-distance order only if $t=1/4$ or $t=1$. This is a specialization of Tomar’s cell catalogue and force identities. Occurrence at either parameter remains open in this test. Chang and Chen's Table 3 already gives a product of two mass differences for diagram 46. The product can vanish identically on the five-equal-mass line. The proof below uses more of the original force equations. [Chang and Chen, Table 3](https://arxiv.org/pdf/2303.02853) · [Tomar, Propositions 3.1, 4.5 and §9](https://hexagonmath.org/pdf/2611.00377v1)

## A strictly lighter central body

Consider a triangle with central mass $s$, balanced outer masses $a,b$, and positive sums $A,B$ of the masses below the two outer children of the coordinate-tree root. Tomar’s Lemma 9.11(a,b) proves that the following equations have a common complex solution $k$ whenever its hypotheses hold.

$$
Ab k^3=Ba,\qquad
s^2(A+B)(a+bk)^3=a^3b^2B.
$$

Both $bk$ and $a+bk$ have positive real cubes. They differ by a positive real number and therefore both lie on the positive real axis. To see this, the three rays with arguments $0,2\pi/3,-2\pi/3$ are exactly the complex numbers with positive real cube. A nonreal point on either oblique ray is the unique point on the union of the rays with its specified nonzero imaginary part. The two points have the same imaginary part and differ by $a>0$, so both are positive real.

It follows that $a+bk>a$ and $a+bk>bk$. Using these inequalities in the second equation, then using the first for the second bound, gives

$$
s^2 < b^2\frac{B}{A+B}<b^2,\qquad
s^2 < a^2\frac{A}{A+B}<a^2.
$$

Thus $s<\min(a,b)$. In the five-equal family the variable mass must occupy the center and have $t<1$. All masses under the two outer children are then 1, so $A,B$ are positive integer counts and $a=b=1$. The equations determine the only candidate value for this witness,

$$
 t=\sqrt{\frac{B}{A+B}}\,(1+(B/A)^{1/3})^{-3/2}.
$$

In particular every applicable witness excludes its cell for generic $t$. An equivalent generic test uses the all-unit specialization. With $r=B/A>0$, a common root of $k^3=r$ and $(1+r)(1+k)^3=r$ would give

$$
r^6+3r^5+33r^4+61r^3+33r^2+3r+1=0.
$$

All seven coefficients are positive. The companion Lean source checks this polynomial obstruction and the positive-mass inequalities. The catalogue coverage uses Python and depends on the cited mathematical results.

## Applying the criteria to every cell of diagram 46

Tomar class 23 represents Chang–Chen diagram 46 and has 239 listed cells. Propositions 3.1 and 4.5 guarantee coverage of all possible places in this diagram with nonpositive total distance order. Use the body labels of the Tomar representative, numbered 1 through 6 here.

- **231 cells** satisfy Lemma 9.11(a) with exactly two bodies in each outer child. Thus if the marked body is the central body, $A=B=2$ and $a=b=1$, giving $t=1/4$. Every other placement fails the strict smaller-center condition.
- **Six cells** have a matched pair from $\{1,6\},\{2,5\},\{3,4\}$ whose two bodies share the same nonzero leading $z$ position $X$. The two lowest-order equations have only the position and the mutual force. Their mass-weighted sum gives $(m_i+m_j)X=0$, a contradiction at all positive masses.
- **Two cells**, numbered 156 and 157, have a $z$ root with the two non-origin children $\{1,2,3\}$ and $\{4,5,6\}$. All three matched pairs have position and mutual force as the only lowest-order terms at both ends. Write $X,Y$ for the two nonzero child coordinates. Summing each pair with its mass weights gives $m_i X+m_j Y=0$. Consequently $m_1/m_6=m_2/m_5=m_3/m_4$. With exactly one distinguished slot, two ratios are 1. The third then forces $t=1$.

This accounts for all 160 diagram-46 rows that previously survived the generic filters. Across the previous 738-row list, the same direct triangle test covers 422 rows in diagrams 20 (96), 36 (2), 46 (156), 47 (132) and 77 (36). Four further rows of diagram 46 are handled by the pair argument. Other filters may overlap these counts.

## Reproduction

Run the verifier on Tomar’s decompressed-source checkout and the 738-row input CSV. It reads exact tree incidences and lists of terms of least order, checks the decompressed cell files against the upstream SHA-256 manifest, and can write one witness per excluded placement. The verifier separately checks the entire diagram-46 cell file. Its catalogue body and cell identifiers are zero-based, while the CSV distinguished-mass slots are one-based. [Tomar’s fixed code revision](https://github.com/tejasvi/smale6-six-bodies-generic/tree/84bbcf276d029fdf31375c4a21c6a7e136955e51)

```sh
python3 cluster_triangle_filter.py \
  --cells /path/to/smale6-six-bodies-generic/lean/sections3-5/data/cells \
  --input RemainingCorePlacements.csv --witnesses cluster_witnesses.jsonl
```
