"""Identify the a <= -2/3 sector among the seven previous diagram-93 slots."""
import argparse
import csv
import hashlib
import json
import lzma
from pathlib import Path


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--source', required=True, type=Path)
    p.add_argument('--output', type=Path, help='Write the two removed placements')
    args = p.parse_args()
    root = args.source
    diagrams = json.loads((root / 'diagrams/n6.json').read_text())
    graph = diagrams['classes'][132]
    far, regular = set(graph['wcircles']), set(graph['zcircles'])
    special, = set(range(6)) - far - regular
    assert (far, regular, special) == ({0, 4, 5}, {2, 3}, 1)
    raw = (root / 'lean/sections3-5/data/cells/c132.jsonl.xz').read_bytes()
    if hashlib.sha256(raw).hexdigest() != 'b0b584ec934fc8031363ecaf2c4766f184652c5c0433f18363988ee1981ea8fb':
        raise ValueError('Wrong diagram-93 input')
    cells = list(map(json.loads, lzma.decompress(raw).splitlines()))
    removed = []
    for i in [43, 60, 61, 62, 53]:
        terms, = (set(map(tuple, items)) for label, items in cells[i]['argmin']
                  if label == ['w', 'S', [special]])
        if all(('cross', special, k) in terms for k in regular):
            removed.append((132, i, 93, special + 1))
    assert [r[1] for r in removed] == [60, 62]
    if args.output:
        with args.output.open('w', newline='') as f:
            writer = csv.writer(f, lineterminator='\n')
            writer.writerow(['tomar_class', 'cell_id', 'chang_chen_diagram', 'variable_mass_slot_1_based'])
            writer.writerows(removed)
    print('Excludes class 132 cells 60 and 62 with marked slot 2.')


if __name__ == '__main__':
    main()
