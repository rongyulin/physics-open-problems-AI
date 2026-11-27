"""Read the published input ledgers and Tomar's marked trees; reproduce three CSVs."""
import argparse
from collections import Counter
import csv
import hashlib
import json
import lzma
from pathlib import Path

PREVIOUS = Path(__file__).resolve().parent.parent / "physical-ends"
LEDGERS = {
    "PlacementLedger.csv": "c42e5356d870e75a43f24e7f45c7c2b011a92527ca41b3fd3b834d44382df2d5",
    "OrbitLedger.csv": "4eb24384fcb029be2cc0b66cb3dc4b8d1cf2b33981f268c275437b175fa17ca6",
}


def verified(path, digest):
    data = path.read_bytes()
    if hashlib.sha256(data).hexdigest() != digest:
        raise ValueError(f"Unexpected revision of {path}")
    return data


def origin_branch(tree, quartet):
    """Labels in the origin child of the minimal node containing origin and quartet."""
    leaves = {int(body): leaf for body, leaf in tree["leaf"].items()}
    children = {int(node): values for node, values in tree["children"].items()}

    def labels(node):
        if node not in children:
            return {i for i, leaf in leaves.items() if leaf == node}
        return set().union(*(labels(child) for child in children[node]))

    target = quartet | {6}  # Tomar's seventh tree label is the origin.
    node = tree["root"]
    while True:
        child = next(c for c in children[node] if 6 in labels(c))
        if not target.issubset(labels(child)):
            return labels(child) & quartet
        node = child


def write_table(path, rows, columns):
    with path.open("w", newline="", encoding="utf8") as stream:
        writer = csv.DictWriter(stream, columns, lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def replay(source, out):
    diagrams = json.loads(verified(source / "diagrams/n6.json",
        "0f2ae5d0e1e8619eeb680c12b04fb168faaa856e43d61b16074df50a874e2ff4"))["classes"]
    cell_bytes = verified(source / "lean/sections3-5/data/cells/c127.jsonl.xz",
        "5faee4c1b6fd095e7213780497c067369d505661fb3faf8c2a5feaf55f138bc2")
    cells = [json.loads(line) for line in lzma.decompress(cell_bytes).splitlines()]
    quartet = set(diagrams[127]["zcircles"])
    zeros = [origin_branch(c["wtree"], quartet) for c in cells]
    assert zeros == [{2}, {1}, {1}, {2}, {3}, {4}, set(), {4}, {3}]
    outer, binary = (set(diagrams[147][name]) for name in ("zcircles", "wcircles"))
    assert len(outer | binary) == 5 and len(outer) == 3 and len(binary) == 2

    def revise(row):
        mark = int(row["variable_mass_slot_1_based"]) - 1
        diagram = int(row["chang_chen_diagram"])
        reason = None
        if diagram == 94:
            role = "outer" if mark in outer else "opposing binary" if mark in binary else "shared"
            reason = f"excluded: diagram 94, {role} mass"
        elif diagram == 88 and mark in zeros[int(row["cell_id"])]:
            reason = "excluded: diagram 88, marked zero projection"
        elif diagram == 88 and mark in quartet and zeros[int(row["cell_id"])]:
            reason = "excluded: diagram 88, unmarked zero projection"
        elif diagram == 88 and zeros[int(row["cell_id"])] and mark not in quartet:
            reason = "excluded: diagram 88, equal quartet with a zero projection"
        elif diagram == 88 and mark in quartet:
            reason = "excluded: diagram 88, variable quartet and equal binary torque"
        for field in ("signed_complex", "physical"):
            row["previous_" + field] = row[field]
            if row[field] == "open" and reason is not None:
                row[field] = reason
        return row

    tables = {}
    out.mkdir(parents=True, exist_ok=True)
    for filename, digest in LEDGERS.items():
        rows = csv.DictReader(verified(PREVIOUS / filename, digest).decode().splitlines())
        tables[filename] = [revise(row) for row in rows]
        write_table(out / filename, tables[filename], list(tables[filename][0]))
    placements, reps = (tables[name] for name in LEDGERS)
    indexed = {(r["tomar_class"], r["cell_id"], r["variable_mass_slot_1_based"]):r for r in reps}
    for row in placements:
        rep = indexed[row["tomar_class"], row["representative_cell"], row["representative_slot"]]
        for field in ("signed_complex", "physical"):
            assert row[field] == rep[field]
    for field, target in [("signed_complex", [{"88":2,"93":5},{"88":1,"93":4}]),
                          ("physical", [{},{}])]:
        counts = [Counter(r["chang_chen_diagram"] for r in rows if r[field] == "open")
                  for rows in (placements, reps)]
        assert counts == target
        print(field, "placements", dict(counts[0]), "orbits", dict(counts[1]))
    surviving = [r for r in reps if r["physical"] == "open"]
    assert surviving == []
    write_table(out / "PhysicalRepresentatives.csv", surviving, list(reps[0]))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path, help="Tomar checkout, revision 84bbcf2")
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    replay(args.source, args.output)
