import yaml

class Layout:
    def __init__(self, filename):
        with open(filename) as f:
            self.layout = yaml.safe_load(f)
            for d in self.layout:
                if "begin" not in d:
                    d["begin"] = None
                if "end" not in d:
                    d["end"] = None
                if "target" not in d:
                    d["target"] = None
                if "shadow" not in d:
                    d["shadow"] = None

    def findSegment(self, name):
        for s in self.layout:
            if s["name"] == name:
                return s
        raise RuntimeError("Segment not found: `{}'".format(name))
