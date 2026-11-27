"""Check the rectangle and binary cells and the mod-1009 squarefreeness test."""
import argparse
from collections import Counter
import csv
import hashlib
from itertools import combinations, product
import json
import lzma
from math import comb, prod
from pathlib import Path

PRIME = 1009


def signed_norm_at_one(radicands):
    """F_0(x)=x; F_{j+1}(x)=F_j(x+sqrt(b))*F_j(x-sqrt(b))."""
    f = [0, 1]
    for b in radicands:
        even, odd = [0]*len(f), [0]*len(f)
        for j, value in enumerate(f):
            for k in range(j+1):
                row = odd if k%2 else even
                row[j-k] += value*comb(j,k)*pow(b,k//2,PRIME)
        f = [0]*(2*len(even)-1)
        for i in range(len(even)):
            for j in range(len(even)):
                f[i+j] += even[i]*even[j] - b*odd[i]*odd[j]
        f = [v%PRIME for v in f]
    return sum(f)%PRIME


def eval_poly(f,x):
    result=0
    for c in reversed(f):
        result=(result*x+c)%PRIME
    return result


def interpolate(xs,ys):
    coeffs=[0]*len(xs)
    base=[1]
    for x,y in zip(xs,ys):
        amplitude=(y-eval_poly(coeffs,x))*pow(eval_poly(base,x),-1,PRIME)%PRIME
        for k,v in enumerate(base):
            coeffs[k]=(coeffs[k]+amplitude*v)%PRIME
        base=[((base[k-1] if k>0 else 0)-x*(base[k] if k<len(base) else 0))%PRIME for k in range(len(base)+1)]
    return coeffs


def trim(f):
    while f and not f[-1]:
        f.pop()
    return f


def coprime(f,g):
    while g:
        while len(f)>=len(g):
            a=f[-1]*pow(g[-1],-1,PRIME)%PRIME
            offset=len(f)-len(g)
            for i,c in enumerate(g):
                f[i+offset]=(f[i+offset]-a*c)%PRIME
            trim(f)
        f,g=g,f
    return len(f)==1


def squarefree_test():
    from fractions import Fraction
    candidates = {- (k+p)/q for k in (Fraction(1,2), Fraction(-1,2))
                  for p in (-2,0,2) for q in (-2,2) if -(k+p)/q > 0}
    assert candidates == {Fraction(1,4), Fraction(3,4), Fraction(5,4)}
    t=2
    for signs in product((-1,1),repeat=4):
        xs=[]; ys=[]
        for x in range(2,PRIME):
            linear=(x-1,x+1,-t*x-1,-t*x+1)
            D=prod(linear)%PRIME
            if not D: continue
            v=[4*sg*m*m*pow(l%PRIME,-1,PRIME)%PRIME for sg,m,l in zip(signs,(t,t,1,1),linear)]
            xs.append(x); ys.append(pow(D,8,PRIME)*signed_norm_at_one(v)%PRIME)
            if len(xs)==34: break
        f=interpolate(xs[:-1],ys[:-1])
        assert f[-1]==pow(t,16,PRIME) and eval_poly(f,xs[-1])==ys[-1]
        df=trim([i*f[i]%PRIME for i in range(1,len(f))])
        assert coprime(f,df)


def parts(tree,node=None):
    """Unlabelled nested child partitions, preserving body labels including origin 6."""
    children=tree['children']
    if node is None: node=tree['root']
    if str(node) not in children:
        ids=[int(i) for i,leaf in tree['leaf'].items() if leaf==node]
        assert len(ids)==1
        return ids[0]
    return frozenset(parts(tree,ch) for ch in children[str(node)])


F=frozenset
ORIGIN=6


def template(data,diagram):
    z,w=parts(data['ztree']),parts(data['wtree'])
    if diagram==99:
        return 'central binary' if (z,w)==(F((F((6,0,1)),F((3,4)),F((2,5)))),
                                           F((F((6,0,1)),F((2,4)),F((3,5))))) else None
    if diagram==101:
        if (z,w)!=(F((6,F((2,3,5)),F((1,4)),0)),
                   F((F((6,5,0)),F((3,1)),F((2,4))))):return None
        return 'attached triple'
    if w!=F((F((0,4)),F((1,5)),F((6,2,3)))):return None
    sides=(F((0,5)),F((1,4)))
    if z==F((6,*sides,2,3)):return 'free binary'
    for u,v in ((2,3),(3,2)):
        for near,far in (sides,sides[::-1]):
            if z==F((6,F((near,u)),far,v)):
                # The two close rectangle vertices are a reciprocal w-binary.
                a,b=sorted(near)
                rows={tag[2][0]:set(map(tuple,terms)) for tag,terms in data['argmin']
                      if len(tag)==3 and tag[:2]==['w','S'] and len(tag[2])==1}
                assert rows[a]=={('pos',a),('cross',a,b)} and rows[b]=={('pos',b),('cross',b,a)}
                return 'single attachment'
    return None


def check(source,original,linear_removed,out):
    with original.open() as f:
        r=csv.DictReader(f); fields=r.fieldnames
        records=[v for v in r if v['chang_chen_diagram'] in ('99','100','101')]
    with linear_removed.open() as f:
        prior={(v['tomar_class'],v['cell_id'],v['variable_mass_slot_1_based']) for v in csv.DictReader(f)}
    cells=source/'lean/sections3-5/data/cells'
    hashes={n:d for d,n in (l.split() for l in (cells/'SHA256SUMS').read_text().splitlines())}
    grouped={}
    for cls in (8,64,116):
        n='c%d.jsonl'%cls; raw=lzma.decompress((cells/(n+'.xz')).read_bytes())
        assert hashlib.sha256(raw).hexdigest()==hashes[n]
        grouped[cls]=list(map(json.loads,raw.splitlines()))
    assert len(grouped[8])==1
    counts=Counter(); outputs=[]
    for row in records:
        k=tuple(row[col] for col in ('tomar_class','cell_id','variable_mass_slot_1_based'))
        if k in prior:continue
        cls,cell_id,slot=map(int,k)
        d=int(row['chang_chen_diagram'])
        assert (cls,d,slot) in ((8,99,1),(8,99,2),(64,100,3),(64,100,4),(116,101,1),(116,101,6))
        mode=template(grouped[cls][cell_id],d)
        assert mode is not None
        expected={99:((0,1),(2,4),(2,5),(3,4),(3,5)),
                  100:((2,3),(0,4),(0,5),(1,4),(1,5)),
                  101:((0,5),(1,3),(1,4),(2,3),(2,4),(2,5),(3,5))}
        if mode!='single attachment':
            terms=next(terms for tag,terms in grouped[cls][cell_id]['argmin'] if tag==['U'])
            assert set(map(tuple,terms))=={('E',)}|{('delta',a,b) for a,b in expected[d]}
        counts[mode]+=1
        outputs.append({**row,'rectangle_test':mode})
    assert counts=={'free binary':2,'single attachment':24,'central binary':2,'attached triple':2}
    with out.open('w',newline='') as f:
        w=csv.DictWriter(f,fieldnames=fields+['rectangle_test'],lineterminator='\n');w.writeheader();w.writerows(outputs)
    print(dict(counts))

if __name__=='__main__':
    ap=argparse.ArgumentParser(description=__doc__)
    for n in ('source','placements','linear_removed','removed'):ap.add_argument(n,type=Path)
    a=ap.parse_args()
    squarefree_test()
    print('16 squarefree degree-32 polynomials at t=2 over F_1009.')
    check(a.source,a.placements,a.linear_removed,a.removed)
