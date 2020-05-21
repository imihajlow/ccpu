class SemanticError(Exception):
    def __init__(self, location, msg):
        self.location = location
        self.msg = msg
        super().__init__("Error at {}: {}".format(str(location), msg))
