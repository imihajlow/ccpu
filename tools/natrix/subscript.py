from lark import Transformer, v_args, Tree

class SubscriptTransformer(Transformer):
    # Transform a[x] -> *(a + x)

    @v_args(tree = True)
    def subscript(self, t):
        return Tree("deref", [Tree("add", t.children, t.meta)], t.meta)
