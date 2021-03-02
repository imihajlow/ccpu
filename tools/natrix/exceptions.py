class NatrixError(Exception):
    def __init__(self, location, msg, errorType):
        self.location = location
        self.msg = msg
        super().__init__("{} at {}: {}".format(errorType, str(location), msg))

class SemanticError(NatrixError):
    def __init__(self, location, msg):
        super().__init__(location, msg, "Semantic error")

class LiteralError(NatrixError):
    def __init__(self, location, msg):
        super().__init__(location, msg, "Literal parsing error")

class NatrixNotImplementedError(NatrixError):
    def __init__(self, location, msg):
        super().__init__(location, f"Not implemented: {msg}", "Not implemented error")
