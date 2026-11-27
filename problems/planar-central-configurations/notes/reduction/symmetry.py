"""Relabel a Tomar cell with its distinguished mass, optionally exchanging z and w."""
import csv
import hashlib
import itertools
import json
import lzma
from collections import defaultdict
from pathlib import Path

ID = tuple(range(6))


def automorphisms(graph):
    edges = {(i, j): graph['edges'].get(f'{i}{j}', 0)
             for i, j in itertools.combinations(range(6), 2)}
    circles = [set(graph['zcircles']), set(graph['wcircles'])]
    for perm in itertools.permutations(ID):
        for swap in (False, True):
            if any({perm[v] for v in circles[i]} != circles[i ^ swap] for i in (0, 1)):
                continue
            if all(edges[tuple(sorted((perm[a], perm[b])))] == ((3-e) if swap and e in (1, 2) else e)
                   for (a, b), e in edges.items()):
                yield perm, swap


def tree_clusters(tree, mapping):
    leaves = defaultdict(int)
    for label, node in tree['leaf'].items():
        leaves[node] |= 1 << mapping[int(label)]
    children = tree['children']
    clusters = []

    def visit(node):
        mask = leaves[node]
        for child in children.get(str(node), []):
            mask |= visit(child)
        clusters.append(mask)
        return mask

    assert visit(tree['root']) == 127
    return tuple(sorted(clusters))


def cell_key(cell, perm=ID, swap=False):
    m = (*perm, 6)
    colours = ('w', 'z') if swap else ('z', 'w')
    trees = tuple(tree_clusters(cell[col+'tree'], m) for col in colours)
    eqs = []
    for eq, terms in cell['argmin']:
        if len(eq) == 3:
            col, kind, bodies = eq
            assert kind == 'S' and len(bodies) == 1
            identity = (colours[('z','w').index(col)], m[bodies[0]])
        else:
            assert eq in (['I'], ['U'])
            identity = tuple(eq)
        support = []
        for kind, *labels in terms:
            assert kind in ('pos','cross','zw','delta','E','ME')
            mapped = [m[i] for i in labels]
            if kind in ('zw','delta'):
                mapped.sort()
            support.append((kind, *mapped))
        eqs.append((identity, tuple(sorted(support))))
    return (trees, tuple(sorted(eqs)))


def all_images(source, keys):
    by_class = defaultdict(list)
    for cls, cell, slot in keys:
        by_class[cls].append((cell, slot))
    graphs = json.loads((source/'diagrams/n6.json').read_text())['classes']
    root = source/'lean/sections3-5/data/cells'
    hashes = {n: h for h, n in (line.split() for line in (root/'SHA256SUMS').read_text().splitlines())}
    images = {}
    for cls, pairs in by_class.items():
        name = f'c{cls}.jsonl'
        raw = lzma.decompress((root/(name+'.xz')).read_bytes())
        if hashlib.sha256(raw).hexdigest() != hashes[name]:
            raise ValueError(f'cell SHA mismatch: class {cls}')
        cells = [json.loads(line) for line in raw.splitlines()]
        index = {cell_key(c): i for i,c in enumerate(cells)}
        assert len(index) == len(cells)
        group = list(automorphisms(graphs[cls]))
        for i, slot in pairs:
            orbit = {}
            for perm, swap in group:
                j = index[cell_key(cells[i], perm, swap)]
                target = (cls, j, perm[slot-1]+1)
                orbit.setdefault(target, (perm, swap))
            images[cls, i, slot] = orbit
    return images
