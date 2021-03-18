from lark import Transformer, v_args, Tree
from value import Value
from type import IntType
from position import Position

class SubscriptTransformer(Transformer):
    # Transform a[x] -> *(a + x)

    @v_args(tree = True)
    def subscript(self, t):
        return Tree("deref", [Tree("add", t.children, t.meta)], t.meta)

def _transformDecl(type, subtree):
    return Tree(subtree.data, [type] + subtree.children, subtree.meta)

class DeclarationTransformer(Transformer):
    # Transform t a, b, c; -> t a; t b; t c;

    @v_args(tree = Tree)
    def declaration(self, t):
        type = t.children[0]
        return Tree("block", [_transformDecl(type, c) for c in t.children[1:]], t.meta)

@v_args(tree = Tree)
class DefinitionTransformer(Transformer):
    def def_var(self, t):
        # Transform t a = x; -> { t a; a = x; }
        type = t.children[0]
        var = t.children[1]
        value = t.children[2]
        return Tree("block", [Tree("decl_var", [type, var], t.meta), Tree("assignment", [Tree("var", [var], t.meta), value], t.meta)], t.meta)

    def def_var_fn(self, t):
        # Transform t a = f(...); -> { t a; a = f(...); }
        type = t.children[0]
        var = t.children[1]
        value = t.children[2]
        return Tree("block", [Tree("decl_var", [type, var], t.meta), Tree("assignment_function", [Tree("var", [var], t.meta), value], t.meta)], t.meta)


class CompoundTransformer(Transformer):
    @v_args(tree = True)
    def compound_assignment(self, t):
        l, cop, r = t.children
        op = {"+=": "add",
            "-=": "sub",
            "*=": "mul",
            "/=": "div",
            "%=": "mod",
            ">>=": "shr",
            "<<=": "shl",
            "&=": "band",
            "|=": "bor",
            "^=": "bxor",
            "&&=": "land",
            "||=": "lor"}[cop]
        return Tree("assignment", [l, Tree(op, [l, r], t.meta)], t.meta)
