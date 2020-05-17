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

g = Generator()
line = input()
while len(line) > 0:
    t = parse(line)
    t = ConstTransformer().transform(t)
    t = TypeTransformer().transform(t)
    t = ValueTransformer().transform(t)
    print(t.pretty())
    print(g.generateFunction(t))

    line = input()
