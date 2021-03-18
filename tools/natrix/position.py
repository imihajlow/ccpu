from lark import Tree, Token

class Position:
    def __init__(self, line, column, end_line, end_column):
        self._line = line
        self._column = column
        self._end_line = end_line
        self._end_column = end_column

    def getLine(self):
        return self._line

    @staticmethod
    def fromAny(t):
        if isinstance(t, Tree) or isinstance(t, Token):
            return Position(t.line, t.column, t.end_line, t.end_column)
        else:
            return t.getPosition()


    def __sub__(self, other):
        if self._line < other._line:
            line = self._line
            column = self._column
        elif self._line == other._line:
            line = self._line
            column = min(self._column, other._column)
        else:
            line = other._line
            column = other._column

        if self._end_line > other._end_line:
            end_line = self._end_line
            end_column = self._end_column
        elif self._end_line == other._end_line:
            end_line = self._end_line
            end_column = max(self._end_column, other._end_column)
        else:
            end_line = other._end_line
            end_column = other._end_column
        return Position(line, column, end_line, end_column)

    def __str__(self):
        if self._end_line == self._line:
            return "{}:{}-{}".format(self._line, self._column, self._end_column)
        else:
            return "{}:{}-{}:{}".format(self._line, self._column, self._end_line, self._end_column)
