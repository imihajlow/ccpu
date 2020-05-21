from lark.visitors import Interpreter
from lark import v_args
from exceptions import SemanticError
from location import Location

class CallGraph(Interpreter):
    def __init__(self):
        self._calls = {}
        self._curFn = ""
        self._traitors = set()

    def isRecursive(self, caller, callee):
        ''' Returns True is caller can be reached following the graph starting from callee '''
        visited = set(caller)
        q = [callee]
        while len(q) > 0:
            v = q.pop()
            if v == caller:
                return True
            if v in self._traitors:
                return True
            if v not in visited:
                visited.add(v)
                if v in self._calls:
                    q = self._calls[v] + q
        return False

    @v_args(tree = True)
    def function_definition(self, tree):
        decl, body = tree.children
        _, _, name, _ = decl.children
        self.visit(decl)
        try:
            self._enterFunction(str(name))
        except ValueError as e:
            raise SemanticError(Location.fromAny(tree), str(e))
        self.visit(body)
        self._leaveFunction()

    @v_args(tree = True)
    def function_call(self, tree):
        name = tree.children[0]
        self._addCall(str(name))

    @v_args(tree = True)
    def function_declaration(self, tree):
        attrs, _, name, _ = tree.children
        for attr in attrs.children:
            if attr.data == 'attr_always_recursion':
                self._traitors.add(str(name))

    def _addCall(self, callee):
        self._calls[self._curFn] += [callee]

    def _enterFunction(self, name):
        if name in self._calls:
            raise ValueError("Function redefinition: {}".format(name))
        self._curFn = name
        self._calls[name] = []

    def _leaveFunction(self):
        self._curFn = None
