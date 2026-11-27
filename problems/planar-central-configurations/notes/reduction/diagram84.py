"""Check the labelled tree and force hypotheses of the two-scale rectangle proof."""
import hashlib
import json
import lzma

from rectangle import parts


def checked_keys(source):
    directory = source / 'lean/sections3-5/data/cells'
    raw = lzma.decompress((directory / 'c20.jsonl.xz').read_bytes())
    manifest = dict(line.split()[::-1] for line in (directory / 'SHA256SUMS').read_text().splitlines())
    assert hashlib.sha256(raw).hexdigest() == manifest['c20.jsonl']
    cells = [json.loads(line) for line in raw.splitlines()]
    result = set()
    binary = (0, 5)
    for index, vertical in ((0, ((1, 2), (3, 4))), (2, ((1, 3), (2, 4)))):
        horizontal = ((1, 4), (2, 3))
        r = cells[index]
        f = frozenset
        assert parts(r['ztree']) == f([f([6, 0, 5]), *map(f, vertical)])
        assert parts(r['wtree']) == f([0, 5, f([6, *map(f, horizontal)])])
        supports = {(k[0], k[2][0]): set(map(tuple, terms))
                    for k, terms in r['argmin'] if len(k) == 3 and k[1] == 'S' and len(k[2]) == 1}
        for colour, edges in [('z', horizontal), ('w', vertical)]:
            for a, b in (*edges, binary):
                assert supports[colour, a] == {('pos', a), ('cross', a, b)}
                assert supports[colour, b] == {('pos', b), ('cross', b, a)}
        potential = next(set(map(tuple, terms)) for k, terms in r['argmin'] if k == ['U'])
        assert potential == {('E',)} | {('delta', a, b) for a, b in (binary, *horizontal, *vertical)}
        result.update((20, index, slot) for slot in (1, 6))
    return result
