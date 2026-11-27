"""Specialize Tomar 9.11(a,b) and test the shared binary positions in graph 46."""
import argparse
import csv
import hashlib
import json
import lzma
from collections import Counter
from itertools import combinations
from pathlib import Path

ORIGIN = 6


def tree_paths(tree):
    parent = {child: int(node) for node, children in tree["children"].items()
              for child in children}
    paths = []
    for i in range(7):
        p = [tree["leaf"][str(i)]]
        while p[-1] in parent:
            p.append(parent[p[-1]])
        paths.append(p)
    return paths


def child_at(paths, node, label):
    path = paths[label]
    if node in path[1:]:
        return path[path.index(node)-1]
    return None


def triangle_node(paths, triple):
    for node in paths[triple[0]][1:]:
        children = [child_at(paths, node, label) for label in triple]
        if None not in children and len(set(children)) == 3:
            return node
    return None


def minimum_terms(cell):
    return {(key[0], key[2][0]): {tuple(term) for term in terms}
            for key, terms in cell["argmin"] if len(key) == 3 and key[1] == "S"
            and key[0] in ("z","w") and len(key[2]) == 1}


def find_triangles(cell):
    minima = minimum_terms(cell)
    paths = {colour: tree_paths(cell[colour + "tree"]) for colour in "zw"}
    witnesses = []
    for triple in combinations(range(6), 3):
        nodes = {c: triangle_node(paths[c], triple) for c in "zw"}
        if None in nodes.values():
            continue
        for c in "zw":
            node = nodes[c]
            if node != cell[c+"tree"]["root"]:
                continue
            groups = {i: child_at(paths[c], node, i) for i in range(7)}
            for s in triple:
                if groups[s] != groups[ORIGIN]:
                    continue
                a, b = (i for i in triple if i != s)
                def balanced(i):
                    return minima.get((c,i)) == {("cross",i,j) for j in triple if j != i}
                if not (balanced(a) and balanced(b)):
                    continue
                extras = {i for i in range(6) if groups[i] not in (groups[a], groups[b], groups[s])}
                # Each extra body lies in a non-O root child. Its position is
                # minimal, so all extra equations have the root's exponent.
                # Their mass-weighted sum cancels all their minimal forces.
                if any(("pos",i) not in minima.get((c,i), set()) or
                       any(term[0] != "pos" and
                           (term[0] != "cross" or term[2] not in extras)
                           for term in minima[c,i]) for i in extras):
                    continue
                left = tuple(i for i in range(6) if groups[i] == groups[a])
                right = tuple(i for i in range(6) if groups[i] == groups[b])
                witnesses.append({"formula": "9.11b" if extras else "9.11a",
                                  "colour": c, "bodies_zero_based": [a,b,s],
                                  "left": left, "right": right, "extras": sorted(extras)})
    return witnesses


def three_binaries(cell):
    # Within either side, all bodies have the same nonzero leading position.
    # The two mass-weighted equations of a matched pair imply m_i X + m_j Y=0.
    pairs = [(0,5), (1,4), (2,3)]
    paths = tree_paths(cell["ztree"])
    node = cell["ztree"]["root"]
    left = {child_at(paths,node,i) for i in (0,1,2)}
    right = {child_at(paths,node,i) for i in (3,4,5)}
    origin = child_at(paths,node,ORIGIN)
    if len(left) != 1 or len(right) != 1 or left == right or origin in left | right:
        return False
    minima = minimum_terms(cell)
    return all(minima.get(("z",i)) == {("pos",i), ("cross",i,j)}
               for pair in pairs for i,j in (pair,pair[::-1]))


def impossible_shared_pair(cell):
    paths = tree_paths(cell["ztree"])
    root = cell["ztree"]["root"]
    origin = child_at(paths,root,ORIGIN)
    minima = minimum_terms(cell)
    for i,j in [(0,5), (1,4), (2,3)]:
        common = child_at(paths,root,i)
        if common != origin and common == child_at(paths,root,j) and all(
                minima.get(("z",a)) == {("pos",a), ("cross",a,b)}
                for a,b in [(i,j),(j,i)]):
            return True
    return False


def graph46_all_cells(cells):
    counts = Counter()
    for n, cell in enumerate(cells):
        ws = find_triangles(cell)
        if any(len(w["left"]) == len(w["right"]) == 2 for w in ws):
            counts["central quarter"] += 1
        elif impossible_shared_pair(cell):
            counts["impossible"] += 1
        elif three_binaries(cell):
            counts["equal masses"] += 1
        else:
            raise ValueError(f"uncovered diagram 46 cell {n}")
    if counts != {"central quarter":231,"equal masses":2,"impossible":6}:
        raise ValueError(f"unexpected diagram 46 totals: {counts}")
    print("all diagram 46 cells:",dict(counts))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cells",required=True,type=Path,
                        help="upstream lean/sections3-5/data/cells directory")
    parser.add_argument("--input",required=True,type=Path,help="previous placement CSV")
    parser.add_argument("--witnesses",type=Path,help="optional JSONL, one exclusion per row")
    args = parser.parse_args()
    hashes = {name: digest for digest,name in (r.split() for r in
              (args.cells/"SHA256SUMS").read_text().splitlines())}
    rows = list(csv.DictReader(args.input.open()))
    records = []
    counts = Counter()
    for cls in sorted({int(row["tomar_class"]) for row in rows}):
        name = f"c{cls}.jsonl"
        data = lzma.open(args.cells/(name+".xz"),"rb").read()
        if hashlib.sha256(data).hexdigest() != hashes[name]:
            raise ValueError(f"digest mismatch for {name}")
        cells = [json.loads(line) for line in data.splitlines()]
        if cls == 23:
            graph46_all_cells(cells)
        cases = [row for row in rows if int(row["tomar_class"]) == cls]
        needed = {int(row["cell_id"]) for row in cases}
        triangles = {n: find_triangles(cells[n]) for n in needed}
        for row in cases:
            n = int(row["cell_id"])
            graph = int(row["chang_chen_diagram"])
            if triangles[n]:
                w = triangles[n][0]
            elif graph == 46 and three_binaries(cells[n]):
                w = {"formula":"three matched binaries","colour":"z"}
            else:
                continue
            counts[graph,w["formula"]] += 1
            records.append({**row, "witness":w})
    if args.witnesses:
        with args.witnesses.open("w") as f:
            for row in records:
                print(json.dumps(row, separators=(",",":")), file=f)
    print("input rows",len(rows),"excluded rows",len(records))
    for key,value in sorted(counts.items()):
        print(*key,value)


if __name__ == "__main__":
    main()
