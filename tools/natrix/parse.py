from lark import Lark, Transformer, v_args, Tree
from const import ConstTransformer
from type import TypeTransformer
from value import ValueTransformer
from callgraph import CallGraph
from gen import Generator
import operator


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
cg = CallGraph()
cg.visit(t)
g = Generator(cg)
print(t.pretty())
print(g.generateStart(t))
