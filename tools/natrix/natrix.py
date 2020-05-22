#!/usr/bin/env python3
import argparse
import sys
import os
from lark import Lark, Transformer, v_args, Tree, LarkError
from const import ConstTransformer
from type import TypeTransformer, CastTransformer
from value import ValueTransformer
from subscript import SubscriptTransformer
from literal import LiteralTransformer
from compound import CompoundTransformer
from lineinfo import LineInfoTransformer
from callgraph import CallGraph
from gen import Generator
import operator
import ccpu.code
from exceptions import NatrixError

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

if __name__ == '__main__':
    argparser = argparse.ArgumentParser(description='Natrix compiler')
    argparser.add_argument('-o', metavar="RESULT", type=argparse.FileType("w"), required=True, help='output file name')
    argparser.add_argument('file', type=argparse.FileType("r"), help='input file name')
    argparser.add_argument('--tree', default=False, action='store_true', help='print syntax tree')
    args = argparser.parse_args()

    parser = None
    with open(os.path.join(sys.path[0], "grammar.lark"), "r") as gf:
        parser = Lark(gf, propagate_positions=True)

    code = args.file.read()

    try:
        t = parser.parse(code)
    except LarkError as e:
        sys.stderr.write("Syntax error in {}: {}\n".format(args.file.name, str(e)))
        sys.exit(1)

    lit = LineInfoTransformer(args.file.name)
    t = lit.transform(t)
    try:
        t = CompoundTransformer().transform(t)
        t = ConstTransformer(False).transform(t)
        t = TypeTransformer().transform(t)
        t = ConstTransformer(True).transform(t)
        t = ValueTransformer().transform(t)
        t = CastTransformer().transform(t)
        lt = LiteralTransformer()
        t = lt.transform(t)
        t = SubscriptTransformer().transform(t)
        if args.tree:
            print(t.pretty())
        cg = CallGraph()
        cg.visit(t)
        g = Generator(args.file.name, cg, lt, ccpu.code)
        args.o.write(format(g.generate(t)))
        args.o.write("\n")
    except NatrixError as e:
        file, line = lit.translateLocation(e.location)
        sys.stderr.write("Error: {}:{}: {}\n".format(file, line, e.msg))
        sys.exit(1)
    except LarkError as e:
        sys.stderr.write("Syntax error in {}: {}\n".format(args.file.name, str(e)))
        sys.exit(1)
