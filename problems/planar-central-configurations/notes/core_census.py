#!/usr/bin/env python3
"""Specialize Tomar's 1,928 certified mass obstructions on the five-equal line."""
import argparse
import csv
import gzip
import hashlib
import io
import json
import lzma
import tarfile
from collections import Counter
from contextlib import nullcontext
from itertools import combinations
from pathlib import Path


def require(condition, message):
    if not condition:
        raise ValueError(message)


def read_mass_terms(member, expected_digest):
    # The integer-polynomial identity comes first. Its right-hand side ('h')
    # is at the very end, even for the much larger compressed cofactors.
    raw = member.read()
    require(hashlib.sha256(raw).hexdigest() == expected_digest, 'certificate hash mismatch')
    if raw.startswith(b'\x1f\x8b'):
        # Avoid expanding the entire cofactor into memory.
        stream = gzip.GzipFile(fileobj=io.BytesIO(raw))
    else:
        stream = io.BytesIO(raw)
    with stream:
        require(stream.readline().strip() == b'L6CERT 1', 'unsupported certificate')
        header = stream.readline().split()
        require(header[:2] == [b'nmass', b'6'] and header[4] == b'fixed', 'bad mass header')
        fixed = int(header[5])
        # Search in blocks. The header may straddle a block boundary.
        tail = b'\n'
        while block := stream.read(1 << 20):
            block = tail + block
            offset = block.find(b'\nh ')
            if offset >= 0:
                lines = (block[offset + 1:] + stream.read()).splitlines()
                break
            tail = block[-2:]
        else:
            raise ValueError('missing h')
    count = int(lines[0].split()[1])
    terms = [tuple(map(int, line.split())) for line in lines[1:]]
    require(len(terms) == count and all(len(row) == 8 and row[-1] == 0 for row in terms),
            'unexpected shape or nonmass variable in h')
    return fixed, [(row[0], row[1:7]) for row in terms]


def specialize(terms, fixed, variable_slot):
    coeffs = Counter()
    for coefficient, exponent in terms:
        degree = exponent[variable_slot]
        if fixed == variable_slot:
            # The other five normalized coordinates are 1/t. The fixed one is 1.
            degree -= sum(exponent)
        coeffs[degree] += coefficient
    return {degree: c for degree, c in coeffs.items() if c}


def read_obstructions(archive_path, f4):
    expected = {label: digest for digest, label in
                (line.split() for line in (f4 / 'certs/SHA256SUMS').read_text().splitlines())}
    metadata = {row['certid']: row for row in map(json.loads, (f4 / 'cores.jsonl').read_text().splitlines())}
    results = {}
    chosen_terms = {}
    with lzma.open(archive_path, 'rb') as stream, tarfile.open(fileobj=stream, mode='r|', bufsize=1 << 20) as archive:
        for entry in archive:
            if not entry.isfile():
                continue
            label = Path(entry.name).name
            cert_id = label.split('.')[0]
            require(label in expected and cert_id in metadata and cert_id not in results, entry.name)
            fixed, terms = read_mass_terms(archive.extractfile(entry), expected[label])
            require(fixed == metadata[cert_id]['fixed'], 'fixed mass index mismatch')
            if cert_id in ('9ff5f6dec2baab1d', '18da9e9512937815'):
                chosen_terms[cert_id] = dict((exponent, c) for c, exponent in terms)
            polys = [specialize(terms, fixed, slot) for slot in range(6)]
            equal_value = sum(c for c, _ in terms)
            require(all(sum(p.values()) == equal_value for p in polys), 'evaluation at 1 mismatch')
            zero = [not p for p in polys]
            # Multiply by a power of 3 to evaluate a Laurent polynomial exactly at t=3.
            zero_at_three = [not p or sum(c * 3**(e - min(p)) for e, c in p.items()) == 0 for p in polys]
            results[cert_id] = fixed, zero, zero_at_three, equal_value
    require(set(results) == set(metadata) and len(expected) == len(results) == 1928, 'incomplete input')
    # Confirm the two displayed ambient polynomials coefficient by coefficient.
    require(chosen_terms['9ff5f6dec2baab1d'] == {(1,0,0,0,0,0):1, (0,1,0,0,0,0):1}, 'graph 63 h')
    require(chosen_terms['18da9e9512937815'] == {
        (0,6,6,0,0,1):1, (0,6,0,6,0,1):-1, (0,0,6,0,6,1):-1, (0,0,0,6,6,1):1}, 'graph 8 h')
    return results, metadata


def hand_classification(path):
    labels = {}
    entry = 'supplement/hand_explanations/residual/data/tiers_v2.jsonl'
    with tarfile.open(path, 'r:xz') as archive:
        for line in archive.extractfile(entry):
            row = json.loads(line)
            key = (row['class'], row['cell'])
            require(key not in labels, 'duplicate hand-classification row')
            balanced = bool({'E', 'E1'}.intersection(row['cell_level_generic']))
            unconditional = bool({'T', 'P', 'C', 'B0', 'K', 'L'}.intersection(row['cell_level_allmass']))
            labels[key] = balanced, unconditional
    require(len(labels) == 91273 and sum(v[0] for v in labels.values()) == 86875, 'upstream Corollary 9.10 count')
    return labels



def eligible_cliques(diagram):
    cliques = []
    for size in (3, 4):
        for bodies in combinations(range(6), size):
            colours = {diagram['edges'].get(f'{a}{b}', 0) for a, b in combinations(bodies, 2)}
            clique = frozenset(bodies)
            if (colours == {3} or colours == {1} and clique.isdisjoint(diagram['zcircles'])
                    or colours == {2} and clique.isdisjoint(diagram['wcircles'])):
                cliques.append(clique)
    return cliques


def forcing_dimension(clique, colour, minima):
    forced = 0
    has_position = False
    for body in clique:
        terms = minima.get((colour, body), set())
        if any(('cross', body, other) not in terms for other in clique if other != body):
            return None
        forced += any(tag[0] == 'cross' and tag[2] not in clique for tag in terms)
        has_position |= ('pos', body) in terms
    # Span of the coordinate vectors of the forced bodies and, if present,
    # the all-ones vector. That vector adds one dimension unless the span is full.
    return min(len(clique), forced + int(has_position))


def matches_clique(cliques, argmin):
    minima = {(name[0], name[2][0]): {tuple(term) for term in terms}
              for name, terms in argmin if name[0] in ('z', 'w') and name[1] == 'S' and len(name[2]) == 1}
    for clique in cliques:
        dims = [forcing_dimension(clique, colour, minima) for colour in ('z', 'w')]
        if None in dims:
            continue
        if len(clique) == 3 and max(dims) <= 2 and sum(dims) <= 3:
            return True
        if len(clique) == 4 and max(dims) <= 1:
            return True
    return False


def classify_cliques(source):
    diagrams = json.loads((source / 'diagrams/n6.json').read_text())['classes']
    cells = source / 'lean/sections3-5/data/cells'
    hashes = {n: d for d, n in (line.split() for line in (cells / 'SHA256SUMS').read_text().splitlines())}
    matched = set()
    total = 0
    for cls, diagram in enumerate(diagrams):
        name = f'c{cls}.jsonl'
        candidates = eligible_cliques(diagram)
        digest = hashlib.sha256()
        with lzma.open(cells / (name + '.xz')) as content:
            for cell, line in enumerate(content):
                digest.update(line)
                total += 1
                if candidates and matches_clique(candidates, json.loads(line)['argmin']):
                    matched.add((cls, cell))
        require(digest.hexdigest() == hashes[name], 'raw cell hash mismatch: ' + name)
    require(total == 91273 and len(matched) == 86938, 'Corollary 9.18 coverage')
    return matched


def tally(source, archive, output_path, hand_path, use_cliques, final_output):
    f4 = source / 'lean/sections3-5/data/f4'
    results, metadata = read_obstructions(archive, f4)
    labels = {row['ours']: row['cc'] for row in json.loads((source / 'diagrams/cc_compare.json').read_text())['per_cc']}
    hand = hand_classification(hand_path) if hand_path else None
    clique_cells = classify_cliques(source) if use_cliques else None
    after_cliques = Counter()
    final_rows = []
    closed_diagrams = {64, 66, 81, 82, 89, 90, 98}
    hand_counts = Counter()
    hand_by_diagram = Counter()
    totals = Counter()
    by_diagram = {}
    seen_cells = set()
    occurrences = Counter()
    all_slots_zero = []
    with (output_path.open('w', newline='') if output_path else nullcontext()) as output:
        writer = csv.writer(output) if output else None
        if writer:
            writer.writerow(['tomar_class', 'cell_id', 'chang_chen_diagram', 'variable_mass_slot_1_based', 'certificate_id'])
        for path in sorted((f4 / 'links').glob('c*.txt')):
            for line in path.read_text().splitlines():
                class_id, cell_id, cert_id, fixed_id = line.split(maxsplit=4)[:4]
                cls, cell = int(class_id), int(cell_id)
                require(path.stem == f'c{cls}' and (cls, cell) not in seen_cells, 'duplicate/misfiled cell')
                seen_cells.add((cls, cell))
                occurrences[cert_id] += 1
                fixed, zero, at_three, at_one = results[cert_id]
                require(fixed == int(fixed_id), 'cell has wrong normalization')
                delta = Counter(cells=1, placements=6, vanishing=sum(zero), zero_at_three=sum(at_three),
                                zero_at_one=(at_one == 0), all_six_nonzero=(not any(zero)))
                if all(zero):
                    all_slots_zero.append((cls, cell, labels.get(cls), cert_id))
                if hand is not None:
                    balanced, unconditional = hand[cls, cell]
                    if balanced:
                        hand_counts['balanced'] += sum(zero)
                        hand_by_diagram[labels.get(cls)] += sum(zero)
                    elif unconditional:
                        hand_counts['further_unconditional'] += sum(zero)
                    else:
                        hand_counts['remaining'] += sum(zero)
                        if clique_cells is not None and (cls, cell) not in clique_cells and any(zero):
                            diagram = labels.get(cls)
                            after_cliques[diagram] += sum(zero)
                            if diagram not in closed_diagrams:
                                final_rows.extend((cls, cell, diagram, slot, cert_id)
                                                  for slot, is_zero in enumerate(zero, start=1) if is_zero)
                totals.update(delta)
                by_diagram.setdefault(labels.get(cls), Counter()).update(delta)
                if writer:
                    for slot, is_zero in enumerate(zero, start=1):
                        if is_zero:
                            writer.writerow([cls, cell, labels.get(cls, ''), slot, cert_id])
    require(all(occurrences[i] == row['cells'] for i, row in metadata.items()), 'cell multiplicity mismatch')
    require(totals == Counter(cells=38798, placements=232788, vanishing=29669, zero_at_three=30315,
                              zero_at_one=8336, all_six_nonzero=30475), 'published census mismatch')
    require(all_slots_zero == [(29, 1617, 8, '18da9e9512937815')], 'all-six zero cases mismatch')
    require(by_diagram[52]['zero_at_one'] == 0, 'diagram 52 at equal masses')
    for diagram, expected in [(8,(1296,1569)), (52,(7,0)), (63,(1,0))]:
        row = by_diagram[diagram]
        require((row['cells'],row['vanishing']) == expected, 'diagram subtotal mismatch')
        print(f"Diagram {diagram}: {row['cells']} cells, {row['vanishing']}/{row['placements']} identically-zero placements")
    print('Total:', dict(totals))
    print('Identically zero in all six slots:', all_slots_zero)
    print('Nonzero in Q(t):', totals['placements'] - totals['vanishing'])
    print('Nonzero at t=3:', totals['placements'] - totals['zero_at_three'])
    if hand is not None:
        require(hand_counts == Counter(balanced=28137, further_unconditional=640, remaining=892), 'hand overlap')
        require(hand_by_diagram[8] == 1569 and hand[29, 1617][0], 'graph 8 balance test')
        print('Original zero placements, after joining the hand lemmas:', dict(hand_counts))
        print('Diagram 8 zero placements covered by Corollary 9.10:', hand_by_diagram[8])
    if clique_cells is not None:
        require(sum(after_cliques.values()) == 864, 'combined clique overlap mismatch')
        counts = Counter(row[2] for row in final_rows)
        require(counts == {20:96, 36:20, 46:160, 47:134, 77:38, 84:4, 93:28, 94:72,
                           99:2, 100:142, 101:28, 102:12, 117:2}, 'post-diagram counts mismatch')
        print('After all cell tests:', sum(after_cliques.values()))
        print('After diagram exclusions:', len(final_rows), sorted(counts.items()))
        if final_output:
            with final_output.open('w', newline='') as dest:
                writer = csv.writer(dest, lineterminator='\n')
                writer.writerow(['tomar_class', 'cell_id', 'chang_chen_diagram', 'variable_mass_slot_1_based', 'certificate_id'])
                writer.writerows(sorted(final_rows))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, required=True, help='Root of the Tomar source checkout')
    parser.add_argument('--archive', type=Path, required=True, help='Reassembled lean-certs.tar.xz (all 22 parts)')
    parser.add_argument('--remaining', type=Path, help='Write zero-specialization cell/slot rows to this CSV')
    parser.add_argument('--hand-archive', type=Path, help='Optional hand-explanations-data.tar.xz from Zenodo')
    parser.add_argument('--cliques', action='store_true', help='Join exact Corollary 9.18 tests and known diagram exclusions')
    parser.add_argument('--final-remaining', type=Path, help='Save the final 738 core placements as CSV')
    args = parser.parse_args()
    if args.cliques and not args.hand_archive:
        parser.error('--cliques requires --hand-archive')
    if args.final_remaining and not args.cliques:
        parser.error('--final-remaining requires --cliques')
    tally(args.source, args.archive, args.remaining, args.hand_archive, args.cliques, args.final_remaining)
