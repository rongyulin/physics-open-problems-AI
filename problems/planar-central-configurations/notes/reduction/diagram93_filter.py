"""Filter diagram 93 in the five-equal-mass census. Python 3.9+."""
import argparse
import csv
import hashlib
import json
import lzma
from pathlib import Path

DIGEST = 'b0b584ec934fc8031363ecaf2c4766f184652c5c0433f18363988ee1981ea8fb'


def eliminated_by(cell, marked, full, outer, special):
    if marked in full:
        return 'fully circled triple requires three equal masses'

    # Use the actual least terms, not the sampled floating-point heights.
    terms = next({tuple(term) for term in support}
                 for tag, support in cell['argmin']
                 if tag == ['w', 'S', [special]])
    far = {('cross', special, body) for body in full}
    regular = {('cross', special, body) for body in outer}
    a_negative = regular <= terms
    if not a_negative:
        return None

    # If a regular internal force is minimal then 2 <= 1-3a/2, so a<=-2/3.
    if marked in outer:
        return 'unequal outer pair incompatible with a<0'

    tree = cell['wtree']
    leaves = tree['leaf']
    if leaves[str(special)] == leaves['6']:
        return 'exact w-origin and a<0; outer linear equations'
    if ('pos', special) in terms:
        # At the same order as one regular force, w_special has exponent 2.
        return 'nonzero limiting W and a<0; torque'
    return None


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--source', type=Path, required=True, help='pinned Tomar source')
    ap.add_argument('--prior', type=Path, required=True, help='RemainingCorePlacements.csv')
    ap.add_argument('--output', type=Path, help='optional core and core-free removal records')
    args = ap.parse_args()
    data = args.source / 'lean/sections3-5/data'
    cls = 132
    cc = json.loads((args.source / 'diagrams/cc_compare.json').read_text())
    assert next(r['ours'] for r in cc['per_cc'] if r['cc']==93) == cls
    diagram = json.loads((args.source / 'diagrams/n6.json').read_text())['classes'][cls]
    full = set(diagram['wcircles'])
    outer = set(diagram['zcircles'])
    special, = set(range(6)) - full - outer
    assert (full, outer, special)==({0,4,5},{2,3},1)
    raw = (data / 'cells/c132.jsonl.xz').read_bytes()
    if hashlib.sha256(raw).hexdigest() != DIGEST:
        raise ValueError('unexpected upstream cell file')
    cells = list(map(json.loads, lzma.decompress(raw).splitlines()))
    cores = {int(line.split()[1]) for line in (data / 'f4/links/c132.txt').read_text().splitlines()}
    assert len(cells)==147 and set(range(len(cells)))-cores=={53}
    with args.prior.open() as f:
        rows = [(int(r['cell_id']),int(r['variable_mass_slot_1_based'])-1,'core')
                for r in csv.DictReader(f) if int(r['tomar_class'])==cls]
    assert len(rows)==28 and all(i in cores for i,_,_ in rows)
    rows.extend((53, slot, 'core-free') for slot in range(6))
    out = []
    for i, slot, kind in rows:
        why = eliminated_by(cells[i],slot,full,outer,special)
        if why: out.append((cls,i,93,slot+1,kind,why))
    assert len([r for r in out if r[4]=='core'])==24
    assert len([r for r in out if r[4]=='core-free'])==3
    print('93: removed 24 of 28 core and 3 of 6 core-free placements')
    print('surviving core:', [(i,k+1) for i,k,kind in rows if kind=='core' and not eliminated_by(cells[i],k,full,outer,special)])
    if args.output:
        with args.output.open('w',newline='') as f:
            w=csv.writer(f,lineterminator='\n')
            w.writerow(['tomar_class','cell_id','chang_chen_diagram','variable_mass_slot_1_based','group','reason'])
            w.writerows(out)


if __name__=='__main__':
    main()
