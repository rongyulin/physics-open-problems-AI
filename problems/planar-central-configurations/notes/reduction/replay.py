"""Rebuild the reduced five-equal-mass case list on the published input."""
import argparse
from collections import Counter, defaultdict
import csv
import hashlib
import json
import lzma
from pathlib import Path
import tempfile

import diagram84
import diagram93_filter
import node_balance
import rectangle
import symmetry

HERE = Path(__file__).resolve().parent
FIELDS = ['tomar_class', 'cell_id', 'chang_chen_diagram', 'variable_mass_slot_1_based']
KEY_FIELDS = ['tomar_class', 'cell_id', 'variable_mass_slot_1_based']
START_HASH = '695973079b8bd934cac81c6f8d644eeac48ae50a0ea04ab880bb4ee7a10b2d69'


def key(row):
    return tuple(int(row[name]) for name in KEY_FIELDS)


def write_rows(path, fields, rows):
    with path.open('w', newline='') as stream:
        writer = csv.DictWriter(stream, fields, lineterminator='\n')
        writer.writeheader()
        writer.writerows(rows)


def free_inputs(source, cells):
    """For the three surviving core-free diagrams the missing link IDs are exactly the published 19."""
    expected = {127: (88, set(range(9))), 132: (93, {53}),
                147: (94, {5, 11, 17, 23, 29, 35, 41, 47, 53})}
    rows = []
    for cls, (diagram, expected_ids) in expected.items():
        links = cells.parent / 'f4/links' / f'c{cls}.txt'
        linked = {int(s.split()[1]) for s in links.read_text().splitlines()} if links.exists() else set()
        cell_count = len(lzma.decompress((cells / f'c{cls}.jsonl.xz').read_bytes()).splitlines())
        missing = set(range(cell_count)) - linked
        assert missing == expected_ids
        for index in sorted(missing):
            for slot in range(1, 7):
                rows.append(dict(zip(FIELDS, (cls, index, diagram, slot))))
    return rows


def reduce(source, output):
    prior = HERE.parent / 'RemainingCorePlacements.csv'
    assert hashlib.sha256(prior.read_bytes()).hexdigest() == START_HASH
    cells = source / 'lean/sections3-5/data/cells'
    assert hashlib.sha256((cells / 'SHA256SUMS').read_bytes()).hexdigest() == 'deb001fef4cf445f53af88d9c06d20be0ee86dd333a050e50bd9d65fe458b895'
    assert hashlib.sha256((source / 'diagrams/n6.json').read_bytes()).hexdigest() == '0f2ae5d0e1e8619eeb680c12b04fb168faaa856e43d61b16074df50a874e2ff4'
    with prior.open() as stream:
        core = list(csv.DictReader(stream))
    all_rows = {}
    for family, rows in [('core', core), ('core-free', free_inputs(source, cells))]:
        for r in rows:
            k = key(r)
            assert k not in all_rows
            all_rows[k] = {'family': family, **{name: int(r[name]) for name in FIELDS}}
    assert len(all_rows) == 852
    reasons = {}

    def record(k, name, detail):
        assert k in all_rows and k not in reasons
        reasons[k] = {'criterion': name, 'witness': detail}

    node_hits, node_fields = node_balance.run(prior, cells)
    for r in node_hits:
        record(key(r), r['criterion'], f"{r['colour']} tree, node {r['node']}")
    assert len(reasons) == 604
    with tempfile.TemporaryDirectory() as tmp:
        npath, rpath = Path(tmp)/'nodes.csv', Path(tmp)/'rect.csv'
        write_rows(npath, node_fields, node_hits)
        rectangle.squarefree_test()
        rectangle.check(source, prior, npath, rpath)
        with rpath.open() as stream:
            for r in csv.DictReader(stream):
                record(key(r), 'rectangle', r['rectangle_test'])
    for k in diagram84.checked_keys(source):
        record(k, 'two-scale rectangle', 'noncancelling diagonal potential')
    file93 = cells / 'c132.jsonl.xz'
    assert hashlib.sha256(file93.read_bytes()).hexdigest() == diagram93_filter.DIGEST
    cat93 = [json.loads(s) for s in lzma.decompress(file93.read_bytes()).splitlines()]
    for k in all_rows:
        cls, i, slot = k
        if cls == 132:
            reason = diagram93_filter.eliminated_by(cat93[i], slot-1, {0,4,5}, {2,3}, 1)
            if reason:
                record(k, 'diagram 93', reason)
    live = set(all_rows) - reasons.keys()
    assert Counter(all_rows[k]['family'] for k in live) == {'core': 76, 'core-free': 111}

    # The physically selected curve has equal sets of identically zero z and w positions.
    # This column is separate from the complex-curve exclusions above.
    real_origin = {}
    for cls in sorted({k[0] for k in live}):
        entries = [json.loads(s) for s in lzma.decompress((cells / f'c{cls}.jsonl.xz').read_bytes()).splitlines()]
        for k in sorted(k for k in live if k[0] == cls):
            _, i, _ = k
            def origin_set(colour):
                leaves = entries[i][colour + 'tree']['leaf']
                return {j for j in range(6) if leaves[str(j)] == leaves['6']}
            real_origin[k] = origin_set('z') == origin_set('w')

    images = symmetry.all_images(source, live)
    families = defaultdict(list)
    detail = []
    for k in sorted(live):
        orbit = images[k]
        assert set(orbit) <= live
        assert all(real_origin[j] == real_origin[k] for j in orbit)
        rep = min(orbit)
        assert set(images[rep]) == set(orbit)
        families[rep].append(k)
        perm, swap = orbit[rep]
        detail.append({**all_rows[k], 'real_origin_compatible': int(real_origin[k]),
                       'representative_cell': rep[1], 'representative_slot': rep[2],
                       'permutation_to_representative_1_based': ''.join(str(i+1) for i in perm),
                       'exchange_z_w': int(swap)})
    reps=[]
    for rep, members in sorted(families.items()):
        counts = Counter(all_rows[k]['family'] for k in members)
        reps.append({**{field: all_rows[rep][field] for field in FIELDS},
                     'core_placements': counts['core'], 'core_free_placements': counts['core-free'],
                     'real_origin_compatible': int(real_origin[rep])})
    assert len(families) == 55 and sum(r['real_origin_compatible'] for r in reps) == 29
    assert sum(real_origin.values()) == 90
    output.mkdir(parents=True, exist_ok=True)
    removed = [{**all_rows[k], **reasons[k]} for k in sorted(reasons)]
    for name, rows in [('RemovedPlacements.csv', removed), ('RemainingPlacements.csv', detail),
                       ('Representatives.csv', reps)]:
        write_rows(output/name, list(rows[0]), rows)
    print('Input and remaining labelled placements:', len(all_rows), len(detail))
    print('Orbit representatives:', len(reps), '; compatible with real origin:', sum(real_origin.values()),
          'placements in', sum(r['real_origin_compatible'] for r in reps), 'orbits')
    print('By diagram (placements, orbits, real-compatible placements, real-compatible orbits):')
    for d in sorted({r['chang_chen_diagram'] for r in reps}):
        placed = [r for r in detail if r['chang_chen_diagram'] == d]
        grouped = [r for r in reps if r['chang_chen_diagram'] == d]
        print(d, len(placed), len(grouped), sum(r['real_origin_compatible'] for r in placed),
              sum(r['real_origin_compatible'] for r in grouped))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path, help='Tomar repository at revision 84bbcf2')
    parser.add_argument('output', type=Path, help='directory for the three CSV files')
    args = parser.parse_args()
    reduce(args.source, args.output)
