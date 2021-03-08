#!/usr/bin/env python3
import argparse
import sys
import os
import os.path
import subprocess
from lark import Lark, Transformer, v_args, Tree, LarkError
from lark.visitors import VisitError
from .const import ConstTransformer, SizeofExprTransformer
from .type import TypeTransformer, CastTransformer
from .value import VarTransformerStageOne, VarTransformerStageTwo
from .sugar import SubscriptTransformer, DeclarationTransformer, CompoundTransformer, DefinitionTransformer
from .literal import LiteralTransformer
from .structure import StructDeclarationTransformer, MemberAccessTransformer
from .function import NameInterpreter
from .lineinfo import LineInfo
from . import ccpu
from .gen import Generator
from .exceptions import NatrixError
from .callgraph import CallGraph

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

def compileNatrix(target, source, cppArgs=[], noPreprocess=False, cpp="cpp", tree=False, subsections=True):
    parser = None
    with open(os.path.join(os.path.dirname(os.path.realpath(__file__)), "grammar.lark"), "r") as gf:
        parser = Lark(gf, propagate_positions=True, parser="lalr", lexer="standard")

    if noPreprocess:
        with open(source, "r") as f:
            code = f.read()
    else:
        try:
            code = preprocess(source, cpp, cppArgs)
        except subprocess.CalledProcessError:
            sys.stderr.write("Preprocessing of {} failed\n".format(source))
            return 1

    lit = LineInfo(source, code)

    try:
        t = parser.parse(code)
    except LarkError as e:
        file, line = lit.translateLine(e.line)
        sys.stderr.write("Syntax error in {}:{}:{} {}\n".format(file, line, e.column, str(e)))
        return 1

    backend = ccpu.code
    if tree:
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
        if tree:
            print()
            print("Tree after transform:")
            print(t.pretty())
        cg = CallGraph()
        cg.visit(t)
        g = Generator(cg, lt, ni, backend, subsections)
        with open(target, "w") as fout:
            fout.write(format(g.generate(t)))
            fout.write("\n")
    except NatrixError as e:
        file, line = lit.translateLocation(e.location)
        sys.stderr.write("Error: {}:{}: {}\n".format(file, line, e.msg))
        return 1
    except VisitError as e:
        file, line = lit.translateLocation(e.orig_exc.location)
        sys.stderr.write("Error: {}:{}: {}\n".format(file, line, e.orig_exc.msg))
        return 1
    except LarkError as e:
        file, line = lit.translateLine(e.line)
        sys.stderr.write("Syntax error in {}:{} {}\n".format(file, line, str(e)))
        return 1
    except ValueError as e:
        sys.stderr.write("Error: {}\n".format(str(e)))
        return 1
    return 0
