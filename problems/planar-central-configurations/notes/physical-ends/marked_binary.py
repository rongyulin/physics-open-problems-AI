"""Extract the diagram-88 marked binaries from the real-compatible reduction list."""
import argparse
import csv
from pathlib import Path


def select(path):
    with path.open(newline='') as source:
        reader = csv.DictReader(source)
        rows = [row for row in reader if row['tomar_class'] == '127'
                and row['chang_chen_diagram'] == '88'
                and row['real_origin_compatible'] == '1'
                and row['variable_mass_slot_1_based'] in {'1', '6'}]
    return rows, reader.fieldnames


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--previous', required=True, type=Path, help='previous reduction directory')
    parser.add_argument('--output', type=Path, help='write the ten rejected placements as CSV')
    args = parser.parse_args()
    rows, fields = select(args.previous / 'RemainingPlacements.csv')
    reps, _ = select(args.previous / 'Representatives.csv')
    expected = {('0', '1'), ('6', '1')}
    actual = {(row['cell_id'], row['variable_mass_slot_1_based']) for row in reps}
    linked = {(row['representative_cell'], row['representative_slot']) for row in rows}
    if actual != expected or linked != expected or len(reps) != 2 or len(rows) != 10:
        raise ValueError('expected ten placements and two marked-binary orbits')
    if args.output:
        with args.output.open('w', newline='') as destination:
            writer = csv.DictWriter(destination, fieldnames=fields, lineterminator='\n')
            writer.writeheader()
            writer.writerows(rows)
    print('Diagram 88 with a marked binary: 10 of 90 real-compatible placements, 2 of 29 orbits.')


if __name__ == '__main__':
    main()
