from lark import Lark, Transformer, v_args, Tree
from const import ConstTransformer
from type import TypeTransformer
from value import ValueTransformer
from gen import Generator
import operator


parser = None

def parse(s):
    return parser.parse(s)

with open("grammar.lark", "r") as gf:
    parser = Lark(gf, propagate_positions=True)

with open("test.na", "r") as cf:
	code = cf.read()

g = Generator()
t = parse(code)
t = ConstTransformer().transform(t)
t = TypeTransformer().transform(t)
t = ValueTransformer().transform(t)
print(t.pretty())
print(g.generateStart(t))
