from lark import Lark, Transformer, v_args, Tree
from const import ConstTransformer
from type import TypeTransformer
from value import ValueTransformer
from callgraph import CallGraph
from gen import Generator
import operator
import pseudocode


parser = None

def parse(s):
    return parser.parse(s)

with open("grammar.lark", "r") as gf:
    parser = Lark(gf, propagate_positions=True)

with open("test.na", "r") as cf:
	code = cf.read()

t = parse(code)
t = ConstTransformer(False).transform(t)
t = TypeTransformer().transform(t)
t = ConstTransformer(True).transform(t)
t = ValueTransformer().transform(t)
print(t.pretty())
cg = CallGraph()
cg.visit(t)
# cg.print()
# for caller in "fghi":
# 	for callee in "fghi":
# 		print("{}: {} -> {}".format(caller, callee, cg.isRecursive(caller, callee)))
g = Generator("test.na", cg, pseudocode)
print(g.generate(t))
