class SemanticError(Exception):
    def __init__(self, line, msg):
        super().__init__("Error at line {}: {}".format(line,msg))
