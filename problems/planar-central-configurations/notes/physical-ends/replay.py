"""Reproduce the two case lists for the signed equations and the real finiteness argument."""
import argparse
from collections import Counter
import csv
import hashlib
import json
import lzma
from pathlib import Path

PREVIOUS = Path(__file__).resolve().parent.parent / 'reduction'
DIGESTS = {
    'RemainingPlacements.csv': 'e486cec8329e9f503dd2fc92cf8117614c5cd8834667dadd5544d8ed7c92a8ac',
    'Representatives.csv': '24119e99df53449ca43e2be8d50f2f7240d94086eb3ed35a43630b7ad1692777',
}


def checked_bytes(path, digest):
    contents = path.read_bytes()
    if hashlib.sha256(contents).hexdigest() != digest:
        raise ValueError(f'Input differs from the published revision: {path}')
    return contents


def write_csv(path, rows):
    with path.open('w', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]), lineterminator='\n')
        writer.writeheader()
        writer.writerows(rows)


def update(source, output):
    graphs = json.loads(checked_bytes(source / 'diagrams/n6.json',
        '0f2ae5d0e1e8619eeb680c12b04fb168faaa856e43d61b16074df50a874e2ff4'))['classes']
    binary = {label + 1 for label in graphs[127]['wcircles']}
    assert binary == {1, 6}
    graph93 = graphs[132]
    regular = set(graph93['zcircles'])
    special, = set(range(6)) - regular - set(graph93['wcircles'])
    cells = checked_bytes(source / 'lean/sections3-5/data/cells/c132.jsonl.xz',
                          'b0b584ec934fc8031363ecaf2c4766f184652c5c0433f18363988ee1981ea8fb')
    cells93 = [json.loads(line) for line in lzma.decompress(cells).splitlines()]

    def status(row):
        graph = int(row['chang_chen_diagram'])
        slot = int(row['variable_mass_slot_1_based'])
        signed = 'open'
        if graph == 93 and slot == special + 1:
            support, = (set(map(tuple, terms)) for eq, terms in cells93[int(row['cell_id'])]['argmin']
                        if eq == ['w', 'S', [special]])
            if all(('cross', special, j) in support for j in regular):
                signed = 'excluded: negative-exponent sector'
        if signed != 'open':
            physical = signed
        elif row['real_origin_compatible'] != '1':
            physical = 'excluded: previous origin test'
        elif graph == 93:
            physical = 'excluded: triple energy and mass derivative'
        elif graph == 88 and slot in binary:
            physical = 'excluded: marked binary mass derivative'
        else:
            physical = 'open'
        return dict(row, signed_complex=signed, physical=physical)

    tables = {}
    for name, digest in DIGESTS.items():
        lines = checked_bytes(PREVIOUS / name, digest).decode('utf8').splitlines()
        tables[name] = [status(row) for row in csv.DictReader(lines)]
    placements = tables['RemainingPlacements.csv']
    reps = tables['Representatives.csv']
    indexed = {(r['tomar_class'], r['cell_id'], r['variable_mass_slot_1_based']): r for r in reps}
    for row in placements:
        rep = indexed[row['tomar_class'], row['representative_cell'], row['representative_slot']]
        assert (row['signed_complex'], row['physical']) == (rep['signed_complex'], rep['physical'])
    assert len(placements) == 187 and len(reps) == 55
    output.mkdir(parents=True, exist_ok=True)
    write_csv(output / 'PlacementLedger.csv', placements)
    write_csv(output / 'OrbitLedger.csv', reps)
    write_csv(output / 'PhysicalRepresentatives.csv', [r for r in reps if r['physical'] == 'open'])
    for field, want_p, want_r in [
        ('signed_complex', {'88':54, '93':5, '94':126}, {'88':8, '93':4, '94':41}),
        ('physical', {'88':20, '94':54}, {'88':3, '94':19})
    ]:
        counts = [Counter(r['chang_chen_diagram'] for r in data if r[field] == 'open')
                  for data in (placements, reps)]
        assert counts == [want_p, want_r]
        print(field, 'placements', dict(counts[0]), 'orbit representatives', dict(counts[1]))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path, help='Tomar checkout at 84bbcf2')
    parser.add_argument('output', type=Path, help='destination for the three CSV files')
    args = parser.parse_args()
    update(args.source, args.output)
