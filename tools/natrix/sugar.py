from lark import Transformer, v_args, Tree

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
