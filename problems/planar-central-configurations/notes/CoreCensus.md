# Which of Tomar’s cell certificates survive five equal masses?

The 738-row list below is the archived input for a later reduction. [Current working list](reduction/README.md)

Take positive masses with five entries equal to 1 and the sixth equal to $t$. Tomar’s Proposition 5.3 assigns a verified polynomial identity to each of 38,798 cells. For each cell the identity implies that a singular place in that cell must have $h(m)=0$. Specializing these stored polynomials gives an exact filter for the cells that could supply the nonpositive sum of distance valuations required by Corollary 2.7. The entries below count six labelled choices for the position of the variable mass per cell, before identifying symmetries.

| Outcome of the original certificate | Count |
| --- | ---: |
| Cell and variable-slot pairs tested | 232,788 |
| Specialized $h$ nonzero as a rational function of $t$ | 203,119 |
| Specialized $h$ identically zero | 29,669 |
| Specialized $h(3)\ne0$ | 202,473 |
| Specialized $h(3)=0$ | 30,315 |

For a nonzero rational function, only its finitely many positive zeros can survive this test. An identically zero polynomial supplies no exclusion with that particular certificate. Another leading equation, a different certificate, positivity, or a higher-order equation can still give an exclusion. At the cell level, 30,475 of the 38,798 cells retain a nonzero rational function for every slot. At $t=1$, the 38,798 certificates evaluated with cell multiplicity are zero in 8,336 cells. Different cells can use the same polynomial identity. Tomar separately excludes 52,432 cells by a unique lowest-order term and treats 43 residual cells by graph-specific arguments.

## Three examples of what the original certificates detect

- **Chang–Chen diagram 52.** Seven cells have certificates in this census. All seven polynomials are nonzero at six equal masses. Every choice of variable slot therefore yields a nonzero function. Proposition 5.3 leaves no residual cell of diagram 52. Outside a finite set of positive $t$, diagram 52 cannot supply the nonpositive end required by Corollary 2.7.
- **Chang–Chen diagram 63.** Only one cell needs a core certificate. It is Tomar class 84, cell 0, certificate `9ff5f6dec2baab1d`. In the representative’s mass order its right-hand side is exactly $m_1+m_2$, positive for every positive mass vector. All other nonpositive cells of this diagram, if present, are covered by the unique-minimum argument. Diagram 63 therefore cannot supply the required nonpositive end for **any positive masses**. Neither this conclusion nor the conclusion for diagram 52 excludes singular places with positive sum of valuations.
- **Chang–Chen diagram 8.** Its 1,296 certificate-bearing cells give 7,776 cell/slot pairs. Of those, 1,569 specializations vanish identically. Exactly one cell in the entire census has identically zero specializations in all six slots. It is Tomar class 29, cell 1617, certificate `18da9e9512937815`. With mass indices starting at 1, its ambient right-hand side is exactly $m_6(m_2^6-m_5^6)(m_3^6-m_4^6)$. The two differences involve disjoint pairs, so at least one difference is zero wherever five masses coincide. Tomar’s separate balanced-triangle criterion applies to this cell, as well as to all 1,569 vanishing placements of diagram 8. A direct test on every listed cell sharpens the remaining candidate to $t=1/4$. [Diagram 8 derivation and verification](Diagram8.md)

## Intersecting with Tomar’s balanced-triangle test

Corollary 9.10 says that if two bodies in a triangle are balanced in one colour and one body in the other, a necessary mass polynomial $Q_T$ vanishes. On this line its value is $-3$ for a triple of unit masses and $1-4t$ for a triple containing the variable mass. Thus any cell satisfying the corollary is impossible for positive $t$ other than $1/4$. The test also excludes a balanced all-unit triple at $t=1/4$.

Joining the original certificate results to Tomar’s stored `tiers_v2.jsonl` classification reproduces the published total of 86,875 applicable cells out of 91,273. Among the **29,669 identically zero placements**, **28,137** occur in cells satisfying Corollary 9.10. This leaves **1,532** such placements. Of those, **640** satisfy one of the unconditional positive-mass Lemmas 9.2–9.7. Those two additional filters therefore leave **892** cell/slot pairs from the certificate-bearing cells before any other arguments. This count concerns generic $t$. The 43 cells without a core are a separate group.

## Clique tests and the remaining diagram numbers

Corollary 9.18 tests triangles and four-body cliques. For a three-body clique, the alternatives in Theorem 9.9(i) and (ii) both fail at three unit masses. The first gives $Q_T=-3$ and the second would require $1=16$. Each alternative therefore cuts out only finitely many points of the mass line. For a four-body clique, the exceptional set $B_E$ is Zariski closed and excludes the four-unit point by Proposition 7.8 and the paragraph after Theorem 7.13. Its pullback to any cluster placement omits $t=1$ and is finite. Thus each applicable clique excludes that cell for generic positive $t$.

The replay computes the two forcing-space dimensions directly from each cell’s least-order terms and its diagram’s edge and circle labels. This reproduces all 86,938 cells in Proposition 9.19. The clique test removes another 28 of the 892 placements, all from diagram 31. Of the 864 that survive, diagram-wide arguments remove 88 in diagram 66, 32 in 89, four in 82 and two in 81. Here Tomar’s Propositions 6.4, 6.7 and Theorem 6.5 rule out 90, 82 and 89. His Proposition 6.8 requires three disjoint equal pairs for 81. For 64 and 66, the two four-body exceptional sets are closed and exclude the four-unit point (§7.4). The [project’s diagram-98 paper](https://github.com/rongyulin/physics-open-problems-AI/blob/main/problems/planar-central-configurations/papers/FiveEqualSixBody.tex) supplies the generic exclusion of 98. Diagrams 64, 90 and 98 already contribute zero to the subtotal of 864.

The resulting **738 certificate-bearing cell/slot pairs** are listed in [RemainingCorePlacements.csv](RemainingCorePlacements.csv). By Chang–Chen diagram, the counts are 20 (96), 36 (20), 46 (160), 47 (134), 77 (38), 84 (4), 93 (28), 94 (72), 99 (2), 100 (142), 101 (28), 102 (12) and 117 (2).

Separately, of Tomar’s 43 cells without a core, those in graphs 64, 66, 89 and 98 are excluded generically by diagram-wide results. The other 19 occur in 88 (nine cells), 93 (one) and 94 (nine). This gives **14 distinct diagram numbers** across the two lists, adding 88 to the 13 above. The CSV enumerates only the 738 certificate-bearing placements. Further mass relations, individual labels or higher-order equations may remove more. Membership in either list does not establish a singular place or an infinite family of central configurations.

## Replay on the published inputs

The computation uses Python 3.9 or later and its standard library. [core_census.py](core_census.py) reads the public cofactor certificates, checks every certificate file against Tomar’s SHA-256 manifest, and extracts its exact integer mass polynomial. The polynomial identities themselves were verified in the upstream Lean development. This script does not rerun that Lean development.

1. Check out [Tomar’s source repository at commit `84bbcf2`](https://github.com/tejasvi/smale6-six-bodies-generic/tree/84bbcf276d029fdf31375c4a21c6a7e136955e51). The script uses `diagrams/cc_compare.json`, `lean/sections3-5/data/f4/cores.jsonl`, `lean/sections3-5/data/f4/certs/SHA256SUMS`, and the 66 `c*.txt` files under `lean/sections3-5/data/f4/links/`.
2. From [Zenodo record 23472605](https://doi.org/10.5281/zenodo.23472605), download the 22 files named `smale6-six-bodies-generic-lean-certs.tar.xz.part000` through `.part021`. Concatenate them in numerical order. The resulting archive contains `data/f4/certs/*.txt` and `*.txt.gz`. The script reads the archive without unpacking it to disk.
3. For the additional intersection with the hand lemmas, also download `smale6-six-bodies-generic-hand-explanations-data.tar.xz` from the same record. The optional argument `--hand-archive` reads `supplement/hand_explanations/residual/data/tiers_v2.jsonl` directly from that archive. The labels `E` and `E1` identify the balanced-triangle test. The six unconditional labels used here are `T`, `P`, `C`, `B0`, `K`, and `L`, following the author’s `hand_explanations/audit/hand_coverage.py`.
4. For the clique test, `--cliques` additionally reads `diagrams/n6.json` and `lean/sections3-5/data/cells/c0.jsonl.xz` through `c190.jsonl.xz` from the source checkout. The replay checks the SHA-256 of each decompressed file against the upstream `cells/SHA256SUMS` manifest.
5. Run the following commands from the directory containing the downloaded parts and the script. Replace the source path with the root of the checkout. The optional `--remaining` CSV lists precisely the identically zero specializations. A blank Chang–Chen diagram field means that Tomar’s numbered class is outside Chang and Chen’s 117 representatives. Class and cell IDs retain Tomar’s indexing. Mass slots in the CSV are numbered 1 through 6.

```sh
cat smale6-six-bodies-generic-lean-certs.tar.xz.part[0-9][0-9][0-9] > lean-certs.tar.xz
python3 core_census.py --source /path/to/smale6-six-bodies-generic \
  --archive lean-certs.tar.xz --remaining remaining.csv \
  --hand-archive smale6-six-bodies-generic-hand-explanations-data.tar.xz \
  --cliques --final-remaining RemainingCorePlacements.csv
```

For a certificate without a fixed mass, set one entry to $t$ and the others to 1. For a certificate that fixed $m_f=1$, first divide every physical mass by the original $m_f$, as in Tomar’s Lemma 5.2(b). If the variable slot is $f$, all five other normalized masses become $1/t$. The script adds coefficients of equal Laurent powers exactly. It verifies $t=3$ by clearing the lowest power and using integer arithmetic.

| Input | SHA-256 |
| --- | --- |
| Reassembled `lean-certs.tar.xz` | `f3db395afcdb965d932c609064811bcb857d0ad9e37538173b8d33ad14a2bd67` |
| `smale6-six-bodies-generic-hand-explanations-data.tar.xz` | `4fbe286ef6ef663b7d7b8b9ed74e5a1e100d65d714697ceaa97a0ae93f6de4bb` |
| Archived `tiers_v2.jsonl` | `ea896522ca8c6c7d7f2b46bf0c08ffd6e685e052a167144720d85b6391a4aa51` |
| `cc_compare.json` | `b5fdcb74c29ada7e104b74eda7b8a1f5de7431c2f2cc80011a50568579a15fa5` |
| `cores.jsonl` | `d418c4e45eedbce5570089a13a33b8bed16cb423cc61d0ad90a4db2290d10934` |
| `certs/SHA256SUMS` | `f14be1079b0e7cbd8dd3766783aca8c0933889edb1468308f66b1a34680b3fff` |
| `diagrams/n6.json` | `0f2ae5d0e1e8619eeb680c12b04fb168faaa856e43d61b16074df50a874e2ff4` |
| `cells/SHA256SUMS` | `deb001fef4cf445f53af88d9c06d20be0ee86dd333a050e50bd9d65fe458b895` |
| Manifest of the 66 link files | `643d7180f66154ceccb085df135ccaed6d2fc311d27a80ea5f80fa2388f0c286` |

The final digest hashes one ASCII line per link file, in lexicographic filename order. Each line contains its lowercase SHA-256 hex digest, two spaces, its basename, and a newline.

The diagram numbering follows [Chang and Chen, §11](https://arxiv.org/pdf/2303.02853). The cells, identities, valuation functional and nonpositive-end criterion are those of [Tomar, §§2, 5, 8 and 9](https://hexagonmath.org/pdf/2611.00377v1).
