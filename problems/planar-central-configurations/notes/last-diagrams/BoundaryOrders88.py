"""Check the possible four-body leading diagrams by exact linear orders.

Requires the z3 executable or its shared library. Body 4 denotes the
origin for the triangle and translated cluster-balance equations.
"""
import ctypes
import ctypes.util
from itertools import combinations, permutations
import shutil
import subprocess

BODIES = range(4)
ORIGIN = 4
PAIRS = list(combinations(BODIES, 2))
# Each row lists circles then strong force edges in the two projections.
# Labels, orientation of the two colors, and the order of bodies are immaterial.
DIAGRAMS = [
    ((0,1),(2,3), ((0,1),), ((2,3),)),                             # disconnected
    (BODIES,BODIES, ((0,1),(2,3)), ((0,3),(1,2))),                 # quadrilateral
    ((),(), ((0,1),(1,2),(0,2)), ((0,1),(1,2),(0,2))),             # isolated triangle
    (BODIES,(), ((0,1),(1,2),(0,2),(0,3)), ((0,1),(1,2),(0,2))),   # kite
    ((),(), PAIRS, PAIRS),                                           # full collapse
]


def smt(op, *args):
    return '('+op+' '+' '.join(map(str,args))+')'


def tie(terms):
    orders = [w for w in terms if w is not None]
    if len(orders) < 2:
        return 'false' if orders else 'true'
    return smt('and', *(smt('or', *(smt('<=',u,w) for j,u in enumerate(orders) if i!=j))
                        for i,w in enumerate(orders)))


def twice(order):
    return smt('*',2,order) if order is not None else None


def query(zero_low):
    declared, conditions = set(), set()

    def diff(axis,i,j):
        if axis=='w' and zero_low is not None:
            i = zero_low if i==ORIGIN else i
            j = zero_low if j==ORIGIN else j
        if i==j:
            return None
        v = f'{axis}{min(i,j)}{max(i,j)}'
        declared.add(v)
        return v

    def force(axis,i,j):
        x,y = diff('z',i,j),diff('w',i,j)
        if axis=='w':
            x,y = y,x
        return smt('+', smt('*',-1,x), smt('*',-3,y))

    for axis in ('z','w'):
        pos=[twice(diff(axis,i,ORIGIN)) for i in BODIES]
        for i,j,k in combinations(range(5),3):
            conditions.add(tie([diff(axis,i,j),diff(axis,i,k),diff(axis,j,k)]))
        all_terms=[w for w in pos if w is not None]+[force(axis,i,j) for i,j in PAIRS]
        conditions.update(smt('>=',w,-4) for w in all_terms)
        conditions.add(smt('or',*(smt('=',w,-4) for w in all_terms)))
        for size in range(1,5):
            for subset in combinations(BODIES,size):
                crosses=[force(axis,i,j) for i in subset for j in BODIES if j not in subset]
                for anchor in range(5):
                    centered = [pos[anchor]] if anchor != ORIGIN else []
                    centered += [twice(diff(axis,i,anchor)) for i in subset]
                    conditions.add(tie(crosses+centered))
        for i,j in PAIRS:
            others=[force(axis,h,l) for h in (i,j) for l in BODIES if l not in (i,j)]
            conditions.add(tie([twice(diff(axis,i,j)),force(axis,i,j)]+others))

    for cz,cw,ez,ew in DIAGRAMS:
        for label in permutations(BODIES):
            for colors in [((cz,ez),(cw,ew)),((cw,ew),(cz,ez))]:
                assignment=[]
                for axis,(circles,edges) in zip('zw',colors):
                    circle={label[i] for i in circles}
                    edge={tuple(sorted((label[i],label[j]))) for i,j in edges}
                    for i in BODIES:
                        v=diff(axis,i,ORIGIN)
                        if v is not None:
                            assignment.append(smt('=' if i in circle else '>',v,-2))
                        elif i in circle:
                            assignment.append('false')
                    for i,j in PAIRS:
                        assignment.append(smt('=' if (i,j) in edge else '>',force(axis,i,j),-4))
                conditions.add(smt('not',smt('and',*assignment)))

    decl=[f'(declare-fun {v} () Real)' for v in sorted(declared)]
    return '\n'.join(['(set-logic QF_LRA)',*decl,*(smt('assert',a) for a in sorted(conditions)),
                     '(check-sat)'])+'\n'


def check(smt_input):
    if program:=shutil.which('z3'):
        result=subprocess.run([program,'-in'],input=smt_input,text=True,capture_output=True,check=True)
        answer=result.stdout.strip()
    else:
        lib=ctypes.CDLL(ctypes.util.find_library('z3') or 'libz3.so.4')
        ptr=ctypes.c_void_p
        lib.Z3_mk_config.restype=ptr
        lib.Z3_mk_context.argtypes=[ptr]
        lib.Z3_mk_context.restype=ptr
        lib.Z3_eval_smtlib2_string.argtypes=[ptr,ctypes.c_char_p]
        lib.Z3_eval_smtlib2_string.restype=ctypes.c_char_p
        ctx=lib.Z3_mk_context(lib.Z3_mk_config())
        answer=lib.Z3_eval_smtlib2_string(ctx,smt_input.encode()).decode().strip()
    assert answer=='unsat', answer
    return answer


if __name__=='__main__':
    for zero in (0,None):
        print(f'Vanishing low body {zero}, support outside the five diagrams: {check(query(zero))}.')
