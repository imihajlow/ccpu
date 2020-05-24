#!/usr/bin/env python3
import argparse
import sys
import os
from lark import Lark, Transformer, v_args, Tree, LarkError
from const import ConstTransformer
from type import TypeTransformer, CastTransformer
from value import ValueTransformer
from sugar import SubscriptTransformer, DeclarationTransformer
from literal import LiteralTransformer
from compound import CompoundTransformer
from lineinfo import LineInfoTransformer
import subprocess
import ccpu.code
from gen import Generator
from exceptions import NatrixError
from callgraph import CallGraph

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

def preprocess(filename, cpp, cppArgs):
    if cppArgs is None:
        cppArgs = []
    cppCmd = [cpp, "-nostdinc"] + cppArgs + [filename]
    r = subprocess.run(cppCmd, stdout=subprocess.PIPE, encoding="ascii", check=True)
    return r.stdout

if __name__ == '__main__':
    argparser = argparse.ArgumentParser(description='Natrix compiler')
    argparser.add_argument('-o', metavar="RESULT", type=argparse.FileType("w"), required=True, help='output file name')
    argparser.add_argument('file', help='input file name')
    argparser.add_argument('--cpp-arg', metavar="CPP_OPTION", action="append", help='C preprocessor option')
    argparser.add_argument('--do-not-preprocess', default=False, action='store_true', help='do not run C preprocessor')
    argparser.add_argument('--cpp', default="cpp", help="C preprocessor executable (default: cpp)")
    argparser.add_argument('--tree', default=False, action='store_true', help='print syntax tree')
    args = argparser.parse_args()

    parser = None
    with open(os.path.join(sys.path[0], "grammar.lark"), "r") as gf:
        parser = Lark(gf, propagate_positions=True, parser="lalr", lexer="standard")

    if args.do_not_preprocess:
        with open(args.file, "r") as f:
            code = f.read()
    else:
        try:
            code = preprocess(args.file, args.cpp, args.cpp_arg)
        except subprocess.CalledProcessError:
            sys.stderr.write("Preprocessing of {} failed\n".format(args.file))
            sys.exit(1)

    try:
        t = parser.parse(code)
    except LarkError as e:
        sys.stderr.write("Syntax error in {}: {}\n".format(args.file, str(e)))
        sys.exit(1)

    lit = LineInfoTransformer(args.file)
    t = lit.transform(t)
    try:
        t = DeclarationTransformer().transform(t)
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
        g = Generator(cg, lt, ccpu.code)
        args.o.write(format(g.generate(t)))
        args.o.write("\n")
    except NatrixError as e:
        file, line = lit.translateLocation(e.location)
        sys.stderr.write("Error: {}:{}: {}\n".format(file, line, e.msg))
        sys.exit(1)
    except LarkError as e:
        sys.stderr.write("Syntax error in {}: {}\n".format(args.file, str(e)))
        sys.exit(1)
