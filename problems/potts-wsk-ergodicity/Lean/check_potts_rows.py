"""Independently reconstruct a modulo-four row certificate (Python 3; stdlib only)."""
from collections import Counter
from itertools import product


WIDTH = 6
POSITIVE = {(0, 1, 2), (1, 2, 0), (2, 0, 1)}
NEGATIVE = {(a, c, b) for a, b, c in POSITIVE}


def face(a, b, c):
    triangle = (a, b, c)
    return int(triangle in POSITIVE) - int(triangle in NEGATIVE)


def strip(bottom, top):
    degree = 0
    for i in range(WIDTH):
        j = (i + 1) % WIDTH
        degree += face(bottom[i], bottom[j], top[j])
        degree += face(bottom[i], top[j], top[i])
    return degree


def proper(row):
    return all(row[i] != row[i-1] for i in range(WIDTH))


def fit(bottom, top):
    return all(top[i] not in (bottom[i], bottom[i-1]) for i in range(WIDTH))


def check():
    rows = [r for r in product(range(4), repeat=WIDTH) if proper(r)]
    outgoing = {r: [] for r in rows}
    neighbors = {r: [] for r in rows}
    for r in rows:
        # At each site exactly two colours avoid its two lower neighbours.
        choices = [sorted(set(range(4)) - {r[i], r[i-1]}) for i in range(WIDTH)]
        for s in product(*choices):
            if proper(s):
                outgoing[r].append((s, strip(r, s)))
                neighbors[r].append(s)
                neighbors[s].append(r)

    # Check exhaustiveness independently by testing all possible pairs of proper rows.
    assert all({s for s, _ in outgoing[r]} == {s for s in rows if fit(r, s)}
               for r in rows)

    unvisited = set(rows)
    components = []
    labels = {}
    while unvisited:
        root = min(unvisited)
        component, todo = {root}, [root]
        while todo:
            for s in neighbors[todo.pop()]:
                if s not in component:
                    component.add(s)
                    todo.append(s)
        unvisited.difference_update(component)
        components.append(component)
        for slope in (0, 1):
            potential, todo = {root: 0}, [root]
            while todo:
                r = todo.pop()
                for s, count in outgoing[r]:
                    if s not in potential:
                        potential[s] = (potential[r] + count - slope) % 4
                        todo.append(s)
            if set(potential) != component:
                raise RuntimeError("Component is not directed-reachable from its root")
            if all((count + potential[r] - slope - potential[s]) % 4 == 0
                   for r in component for s, count in outgoing[r]):
                labels.update({r: (slope, v) for r, v in potential.items()})
                break
        else:
            raise RuntimeError("Neither slope yields a consistent certificate")
    for r in rows:
        c, b = labels[r]
        for s, count in outgoing[r]:
            d, a = labels[s]
            assert c == d and (count + b - c - a) % 4 == 0
    print("Proper rows:", len(rows))
    print("Directed compatible pairs:", sum(map(len, outgoing.values())))
    print("Component sizes (size: count):", dict(sorted(Counter(map(len, components)).items())))
    print("Rows by slope:", dict(sorted(Counter(c for c, _ in labels.values()).items())))
    first, second = (0, 1) * 3, (2, 3) * 3
    print("Signed degrees for the two witness strips:", strip(first, second), strip(second, first))


if __name__ == "__main__":
    check()
