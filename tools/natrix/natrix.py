#!/usr/bin/env python3
import argparse
import sys
import os
from lark import Lark, Transformer, v_args, Tree, LarkError
from lark.visitors import VisitError
from const import ConstTransformer, SizeofExprTransformer
from type import TypeTransformer, CastTransformer
from value import VarTransformerStageOne, VarTransformerStageTwo
from sugar import SubscriptTransformer, DeclarationTransformer, CompoundTransformer, DefinitionTransformer
from literal import LiteralTransformer
from structure import StructDeclarationTransformer, MemberAccessTransformer
from function import NameInterpreter
from lineinfo import LineInfo
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
    argparser.add_argument('--no-subsections', action='store_true', default=False,
        help='do not put each function and literal in a named section')
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

    lit = LineInfo(args.file, code)

    try:
        t = parser.parse(code)
    except LarkError as e:
        file, line = lit.translateLine(e.line)
        sys.stderr.write("Syntax error in {}:{}:{} {}\n".format(file, line, e.column, str(e)))
        sys.exit(1)

    backend = ccpu.code
    if args.tree:
        print("Tree before transform:")
        print(t.pretty())
    try:
        t = DeclarationTransformer().transform(t)
        t = ConstTransformer(False).transform(t)
        tt = TypeTransformer()
        t = tt.transform(t)
        sdt = StructDeclarationTransformer()
        t = sdt.transform(t)
        sdt.populateTypes(tt.getStructs())
        t = ConstTransformer(True).transform(t)
        t = DefinitionTransformer().transform(t)
        t = VarTransformerStageOne().transform(t)
        ni = NameInterpreter()
        ni.visit(t)
        t = VarTransformerStageTwo(backend).transform(t)
        t = CompoundTransformer().transform(t)
        t = CastTransformer().transform(t)
        t = SubscriptTransformer().transform(t)
        t = MemberAccessTransformer().transform(t)
        t = SizeofExprTransformer().transform(t)
        t = ConstTransformer(True).transform(t)
        lt = LiteralTransformer(ni)
        t = lt.transform(t)
        if args.tree:
            print()
            print("Tree after transform:")
            print(t.pretty())
        cg = CallGraph()
        cg.visit(t)
        g = Generator(cg, lt, ni, backend, not args.no_subsections)
        args.o.write(format(g.generate(t)))
        args.o.write("\n")
    except NatrixError as e:
        file, line = lit.translateLocation(e.location)
        sys.stderr.write("Error: {}:{}: {}\n".format(file, line, e.msg))
        sys.exit(1)
    except VisitError as e:
        file, line = lit.translateLocation(e.orig_exc.location)
        sys.stderr.write("Error: {}:{}: {}\n".format(file, line, e.orig_exc.msg))
        sys.exit(1)
    except LarkError as e:
        file, line = lit.translateLine(e.line)
        sys.stderr.write("Syntax error in {}:{} {}\n".format(file, line, str(e)))
        sys.exit(1)
    except ValueError as e:
        sys.stderr.write("Error: {}\n".format(str(e)))
        sys.exit(1)
