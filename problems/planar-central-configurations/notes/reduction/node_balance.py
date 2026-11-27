"""Replay closed-subset position balances and triangular force tests on remaining core cells."""
import argparse
from collections import Counter, defaultdict
from itertools import combinations
from pathlib import Path
import csv, hashlib, json, lzma

import sympy as S

T = S.Symbol("t")


class Tree:
    def __init__(self, tree):
        self.children = {int(k): v for k,v in tree["children"].items()}
        self.root = tree["root"]
        self.paths = []
        parents = {child: node for node, children in self.children.items() for child in children}
        for i in range(7):
            u = tree["leaf"][str(i)]
            path = [u]
            while u in parents:
                u = parents[u]
                path.append(u)
            self.paths.append(path)

    def node(self, a, b):
        return next(v for v in self.paths[a] if v in self.paths[b])

    def child(self, i, v):
        p = self.paths[i]
        if v not in p[1:]:
            return None
        return p[p.index(v)-1]

    def triangle_node(self, tri):
        a,b,s=tri
        v=self.node(a,b)
        cs=[self.child(i,v) for i in tri]
        return v if None not in cs and len(set(cs))==3 else None


def closed_balances(minima):
    # In a reciprocal component the two endpoints of each shared force term
    # have the same minimum order, because opposing forces differ by a scalar.
    neighbours = {i:{t[2] for t in minima[i] if t[0]=='cross'} for i in range(6)}
    unseen=set(range(6))
    result=[]
    while unseen:
        todo=[unseen.pop()]
        group=set(todo)
        while todo:
            i=todo.pop()
            for j in neighbours[i]:
                if i in neighbours[j] and j in unseen:
                    unseen.remove(j)
                    group.add(j)
                    todo.append(j)
        if all(neighbours[i]<=group for i in group):
            kept={i for i in group if ('pos',i) in minima[i]}
            if kept:
                result.append(kept)
    return result


def row_for(children, leaf_children, mass, group):
    d={c:0 for c in children}
    for i in group:
        c=leaf_children[i]
        if c in d:
            d[c]+=mass[i]
    return [d[c] for c in children]


def test_cell(cell, slot):
    mass=[T if i==slot else S.Integer(1) for i in range(6)]
    trees={c:Tree(cell[c+'tree']) for c in ('z','w')}
    am={(k[0],k[2][0]):set(map(tuple,terms)) for k,terms in cell['argmin']
        if len(k)==3 and k[1]=='S' and len(k[2])==1}
    tris={tri:{c:tree.triangle_node(tri) for c,tree in trees.items()}
          for tri in combinations(range(6),3)}
    tris={tri:v for tri,v in tris.items() if all(q is not None for q in v.values())}
    for c,tree in trees.items():
        minima={i:am[c,i] for i in range(6)}
        groups=closed_balances(minima)
        for v in tree.paths[6][1:]:
            origin=tree.child(6,v)
            kids=[k for k in tree.children[v] if k!=origin]
            ch=[tree.child(i,v) for i in range(6)]
            rows=[]
            if v==tree.root:
                rows.append(row_for(kids,ch,mass,range(6)))
            for group in groups:
                if all(ch[i] in kids for i in group):
                    rows.append(row_for(kids,ch,mass,group))
            if not rows:
                continue
            kernel=S.polys.matrices.DomainMatrix.from_Matrix(S.Matrix(rows)).to_field().nullspace().to_Matrix()
            zero=S.zeros(kernel.rows,1)
            coords={origin:zero}
            coords.update({k:kernel.col(i) for i,k in enumerate(kids)})
            if any(coords[a]==coords[b] for a,b in combinations(tree.children[v],2)):
                return 'node_collision', c, v
            for tri,nodes in tris.items():
                if nodes[c]!=v:continue
                count=sum(minima[i]=={('cross',i,j) for j in tri if j!=i} for i in tri)
                if count<2:continue
                a,b,s=tri
                e=[coords[ch[i]] for i in tri]
                diffs=S.Matrix.hstack(e[0]-e[1],e[1]-e[2],e[2]-e[0])
                if diffs.rank()!=1:continue
                row=next(diffs.row(j) for j in range(diffs.rows) if any(diffs.row(j)))
                x,y,z=[d*m**2 for d,m in zip(row,(mass[s],mass[a],mass[b]))]
                lhs=(x*y+y*z+z*x)**3-27*(x*y*z)**2
                if S.cancel(lhs)!=0:
                    return 'fixed_triangle_shape', c, v
    return None


def run(input_path, cells):
    counts=defaultdict(Counter)
    kept=[]
    with open(input_path,newline='') as f:
        reader=csv.DictReader(f)
        fields=reader.fieldnames
        rows=list(reader)
    keyed=defaultdict(list)
    for row in rows:
        keyed[int(row['tomar_class'])].append(row)
    for cls,group in keyed.items():
        cc=group[0]['chang_chen_diagram']
        name=f'c{cls}.jsonl'
        payload=lzma.decompress((cells/(name+'.xz')).read_bytes())
        manifest={n:h for h,n in (line.split() for line in (cells/'SHA256SUMS').read_text().splitlines())}
        if hashlib.sha256(payload).hexdigest()!=manifest[name]:
            raise ValueError(f'catalogue file hash mismatch for {name}')
        data=[json.loads(line) for line in payload.splitlines()]
        for row in group:
            i=int(row['cell_id']);slot=int(row['variable_mass_slot_1_based'])-1
            hit=test_cell(data[i],slot)
            if hit:
                counts[cc][hit[0]]+=1
                kept.append(dict(row,criterion=hit[0],colour=hit[1],node=hit[2]))
        print(cc,counts[cc],flush=True)
    return kept,fields+['criterion','colour','node']


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('input',type=Path)
    p.add_argument('cells',type=Path)
    p.add_argument('output',type=Path)
    args=p.parse_args()
    rows,fields=run(args.input,args.cells)
    with args.output.open('w',newline='') as f:
        wr=csv.DictWriter(f,fields,lineterminator='\n')
        wr.writeheader()
        wr.writerows(rows)
