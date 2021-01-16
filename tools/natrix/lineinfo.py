from lark import Transformer, v_args, Discard
from literal import unescapeString
from location import Location

class LineInfo():
	def __init__(self, filename, code):
		self._directives = []
		self._defaultFilename = filename
		self._parse(code)

	def translateLocation(self, loc):
		return self.translateLine(loc.getLine())

	def translateLine(self, raw_line):
		# TODO bisect
		file = self._defaultFilename
		line = 0
		dirLine = -1
		for l, f, vl in self._directives:
			if l > raw_line:
				break
			file = f
			line = vl
			dirLine = l
		return file, line + (raw_line - dirLine) - 1

	def _parse(self, code):
		for raw_ln, line in enumerate(code.split("\n")):
			line = line.strip()
			if len(line) > 0 and line[0] == '#':
				_, ln, filename = line.split(' ', 2)
				filename = unescapeString(filename, findLastQuote=True)
				self._directives += [(raw_ln, filename, int(ln) - 1)]
