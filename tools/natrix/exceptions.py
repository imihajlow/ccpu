class NatrixError(Exception):
    def __init__(self, position, msg, errorType):
        self.position = position
        self.msg = msg
        super().__init__("{} at {}: {}".format(errorType, str(position), msg))

class SemanticError(NatrixError):
    def __init__(self, position, msg):
        super().__init__(position, msg, "Semantic error")

class LiteralError(NatrixError):
    def __init__(self, position, msg):
        super().__init__(position, msg, "Literal parsing error")

class NatrixNotImplementedError(NatrixError):
    def __init__(self, position, msg):
        super().__init__(position, f"Not implemented: {msg}", "Not implemented error")


class RegisterNotSupportedError(Exception):
    def __init__(self, argNumber):
        self.argNumber = argNumber
