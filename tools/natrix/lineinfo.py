from lark import Transformer, v_args, Discard
from literal import unescapeString
from location import Location

class LineInfoTransformer(Transformer):
	def __init__(self, filename):
		self._directives = []
		self._defaultFilename = filename

	def translateLocation(self, loc):
		# TODO bisect
		file = self._defaultFilename
		line = 0
		dirLine = -1
		for l, f, vl in self._directives:
			if l > loc.getLine():
				break
			file = f
			line = vl
			dirLine = l
		return file, line + (loc.getLine() - dirLine) - 1

	@v_args(tree = True)
	def cpp_line_info(self, t):
		line = int(str(t.children[0]))
		file = unescapeString(str(t.children[1]))
		self._directives += [(t.line, file, line)]
		raise Discard
