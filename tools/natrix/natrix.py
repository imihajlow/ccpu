#!/usr/bin/env python3
import argparse
import sys
import os
from lark import Lark, Transformer, v_args, Tree
from const import ConstTransformer
from type import TypeTransformer
from value import ValueTransformer
from subscript import SubscriptTransformer
from callgraph import CallGraph
from gen import Generator
import operator
import ccpu.code
from exceptions import SemanticError

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

    t = parser.parse(code)
    t = ConstTransformer(False).transform(t)
    t = TypeTransformer().transform(t)
    t = ConstTransformer(True).transform(t)
    t = ValueTransformer().transform(t)
    t = SubscriptTransformer().transform(t)
    if args.tree:
        print(t.pretty())
    cg = CallGraph()
    cg.visit(t)
    g = Generator(args.file.name, cg, ccpu.code)
    try:
        args.o.write(format(g.generate(t)))
        args.o.write("\n")
    except SemanticError as e:
        sys.stderr.write("Error: {}:{}: {}\n".format(args.file.name, e.location, e.msg))
