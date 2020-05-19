from lark.visitors import Interpreter
from lark import v_args

class CallGraph(Interpreter):
    def __init__(self):
        self._calls = {}
        self._curFn = ""

    def _addCall(self, callee):
        self._calls[self._curFn] += [callee]

    def _enterFunction(self, name):
        if name in self._calls:
            raise ValueError("Function redefinition: {}".format(name))
        self._curFn = name
        self._calls[name] = []

    def _leaveFunction(self):
        self._curFn = None

    @v_args(tree = True)
    def function_definition(self, tree):
        type, name, args, body = tree.children
        self._enterFunction(str(name))
        self.visit_children(tree)
        self._leaveFunction()

    @v_args(tree = True)
    def function_call(self, tree):
        name = tree.children[0]
        self._addCall(str(name))
