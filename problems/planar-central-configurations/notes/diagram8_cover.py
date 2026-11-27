"""Check two balanced-triangle criteria in the 1,866 cells of diagram 8."""
import argparse
from collections import Counter
import hashlib
from itertools import combinations, permutations
import json
import lzma
from pathlib import Path

DIGEST = "bac30d6948dbe2a6825f3c81b400b9b22d5b4695d58bfb7b2436736dffdb904c"


def path_to_root(tree, i):
    parents = {child: int(node) for node, children in tree["children"].items()
               for child in children}
    path = [tree["leaf"][str(i)]]
    while path[-1] in parents:
        path.append(parents[path[-1]])
    return path


def is_triangle(paths, triple):
    branches = []
    for i in triple:
        path = paths[i]
        branches.append(dict(zip(path[1:], path[:-1])))
    return any(len({p[node] for p in branches}) == 3
               for node in set.intersection(*(set(p) for p in branches)))


def same_position(paths, a, b):
    # Their paths first merge strictly below their meeting with the origin.
    meet = next(node for node in paths[a] if node in paths[b])
    return meet not in paths[6]


def classify(cell):
    colors = ("z", "w")
    paths = {c: [path_to_root(cell[c + "tree"], i) for i in range(7)]
             for c in colors}
    support = {(tag[0], tag[2][0]): set(map(tuple, terms))
               for tag, terms in cell["argmin"]
               if len(tag) == 3 and tag[1] == "S" and len(tag[2]) == 1}
    q_witnesses, f_witnesses = [], []
    for tri in combinations(range(6), 3):
        if not all(is_triangle(paths[c], tri) for c in colors):
            continue
        forces = {i: {("cross", i, j) for j in tri if j != i} for i in tri}
        balanced = {c: {i for i in tri if support.get((c, i)) == forces[i]}
                    for c in colors}
        if min(map(len, balanced.values())) >= 1 and max(map(len, balanced.values())) >= 2:
            q_witnesses.append(tri)
        for c, other in permutations(colors):
            for a, b in combinations(tri, 2):
                if {a, b} <= balanced[c] and same_position(paths[other], a, b):
                    if all(support.get((other, i)) == forces[i] | {("pos", i)}
                           for i in (a, b)):
                        f_witnesses.append((tri, a, b, c))
    return q_witnesses, f_witnesses


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("data", type=Path, help="the original c29.jsonl.xz")
    args = parser.parse_args()
    raw = args.data.read_bytes()
    if hashlib.sha256(raw).hexdigest() != DIGEST:
        raise ValueError("unexpected input SHA-256 digest")
    counts = Counter()
    for k, line in enumerate(lzma.decompress(raw).splitlines()):
        qs, fs = classify(json.loads(line))
        if qs:
            counts["Q"] += 1
        elif fs:
            counts["F"] += 1
        else:
            raise ValueError(f"uncovered cell {k}")
        if k == 1617 and set(qs) != {(1, 4, 5), (2, 3, 5)}:
            raise ValueError("unexpected witnesses in cell 1617")
    if counts != {"Q": 1842, "F": 24}:
        raise ValueError(f"unexpected coverage: {counts}")
    print("diagram 8: 1,866 cells; 1,842 covered by Corollary 9.10 and 24 further by Theorem 9.9(ii).")


if __name__ == "__main__":
    main()
