from lark import Lark, Transformer, v_args, Tree

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
