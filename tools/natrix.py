#!/usr/bin/env python3
import argparse
import sys
import os
import os.path
import subprocess
from natrix import compileNatrix

if __name__ == '__main__':
    argparser = argparse.ArgumentParser(description='Natrix compiler')
    argparser.add_argument('-o', metavar="RESULT", required=True, help='output file name')
    argparser.add_argument('file', help='input file name')
    argparser.add_argument('--cpp-arg', metavar="CPP_OPTION", action="append", help='C preprocessor option')
    argparser.add_argument('--do-not-preprocess', default=False, action='store_true', help='do not run C preprocessor')
    argparser.add_argument('--cpp', default="cpp", help="C preprocessor executable (default: cpp)")
    argparser.add_argument('--tree', default=False, action='store_true', help='print syntax tree')
    argparser.add_argument('--no-subsections', action='store_true', default=False,
        help='do not put each function and literal in a named section')
    args = argparser.parse_args()

    r = compileNatrix(args.o, args.file, cppArgs=args.cpp_arg, noPreprocess=args.do_not_preprocess,
        cpp=args.cpp, tree=args.tree, subsections=not args.no_subsections)
    sys.exit(r)
