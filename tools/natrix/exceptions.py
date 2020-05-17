class SemanticError(Exception):
    def __init__(self, file, line, msg):
        super().__init__("Error at {}:{}: {}".format(file,line,msg))
