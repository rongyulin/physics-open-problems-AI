# Balanced triangles on the five-equal-mass line

**Chatgpt · 27 November 2026**

Tomar’s Corollary 9.10 applies to three bodies occupying three distinct children of a common node in each of the two coordinate trees. With respect to this triple, two bodies must be balanced in one coordinate and at least one in the other. A balance at a body means that precisely the two forces from the other members of the triple attain the minimum order in that body’s equation. The corollary gives a necessary mass condition $Q_T=0$. Its polynomial is symmetric in the three masses. On the line $(1,1,1,1,1,t)$, the two possibilities are $Q_T(1,1,1)=-3$ and $Q_T(1,1,t)=1-4t$. Consequently a qualifying triple excludes a cell for every positive $t$ when the triple omits the marked body, and for every positive $t$ except $1/4$ when it contains that body. The remaining candidate value needs its own test. [Tomar, §9, Corollary 9.10 and Table 6](https://hexagonmath.org/pdf/2611.00377v1)

## Counts

The replay finds a qualifying triple in **86,875 of 91,273** catalogue cells, recovering the total in Table 6. Intersecting this test with the **29,669** cell and mass-placement pairs where the assigned core polynomial is identically zero gives the following counts. [Core-polynomial census](CoreCensus.md)

| Outcome of the balanced-triangle test on those pairs | All diagrams | Diagram 8 |
| --- | ---: | ---: |
| Some qualifying triple omits the marked body | 23,349 | 1,228 |
| There is a qualifying triple, and every such triple contains the marked body | 4,788 | 341 |
| No qualifying triple | 1,532 | 0 |
| **Total** | **29,669** | **1,569** |

Thus **1,532** pairs in the original 38,798 core-certified cells still require attention after these two generic tests. The 43 cells with no assigned core belong to a separate list. The intermediate CSV lists the 1,532 pairs before using further diagram-specific or universal arguments. [Cell and placement list](after_triangles.csv) A surviving pair records that these two tests gave no contradiction. It does not establish the existence of a singular place.

Diagram 8 has 1,866 catalogue cells, including 1,842 with a qualifying triple. Each of its 1,569 identically vanishing core cases has a qualifying triple. Proposition 5.3 assigns no unhandled cell of diagram 8 to its separate list of 43. Combining the single-term exclusions, the restricted nonzero cores, and the triangle tests therefore rules out diagram 8 **as the required end of nonpositive total distance order for generic positive $t$**. Applying the equal-force test to the remaining 24 cells improves this bound to the single candidate $t=1/4$. [Diagram 8 derivation](Diagram8.md) [Tomar, §§2, 5 and 9](https://hexagonmath.org/pdf/2611.00377v1)

## Replay

Use the source checkout at commit `84bbcf276d029fdf31375c4a21c6a7e136955e51` and generate `remaining.csv` as in the core census. Then run the following with Python 3.9 or later. The optional output lists the 1,532 surviving pairs. [Source revision](https://github.com/tejasvi/smale6-six-bodies-generic/tree/84bbcf276d029fdf31375c4a21c6a7e136955e51) · [Replay script](triangle_cover.py)

```sh
python3 triangle_cover.py \
  --cells /path/to/smale6-six-bodies-generic/lean/sections3-5/data/cells \
  --remaining remaining.csv --survivors after_triangles.csv
```

The script uses the exact two tree structures and argmin labels recorded for each cell. It checks every decompressed cell file against the upstream manifest. The SHA-256 of that manifest is `deb001fef4cf445f53af88d9c06d20be0ee86dd333a050e50bd9d65fe458b895`. This is a Python replay of the combinatorial hypotheses and a hand specialization of the published mass condition.
