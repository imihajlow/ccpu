from lark import Lark, Transformer, v_args, Tree
from const import ConstTransformer
from type import TypeTransformer
from value import ValueTransformer
from subscript import SubscriptTransformer
from callgraph import CallGraph
from gen import Generator
import operator
import pseudocode
import ccpu.code

def format(code):
	result = []
	for line in code.splitlines():
		l = line.lstrip()
		if l != '':
			colon = l.find(':')
			semicolon = l.find(';')
			if colon >= 0 and (colon < semicolon or semicolon < 0):
				result.append(l)
			else:
				result.append('\t' + l)
	return "\n".join(result)

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
t = SubscriptTransformer().transform(t)
print(t.pretty())
cg = CallGraph()
cg.visit(t)
g = Generator("test.na", cg, ccpu.code)
print(format(g.generate(t)))
