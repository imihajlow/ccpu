# Flat memory layout to use on simulator

layout = [
    {
        "name": "init",
        "begin": 0,
        "init": True
    },
    {
        "name": "text",
        "init": True
    },
    {
        "name": "ramtext_origin",
        "init": True,
        "target": "ramtext"
    },
    {
        "name": "data",
        "init": False
    },
    {
        "name": "bss",
        "init": False
    },
    {
        "name": "ramtext",
        "init": False,
        "shadow": "ramtext_origin"
    },
    {
        "name": "stack",
        "end": 0xd000,
        "init": False
    }
]


def findSegment(name):
    for s in layout:
        if s["name"] == name:
            return s
    raise RuntimeError("Segment not found: `{}'".format(name))

for d in layout:
    if "begin" not in d:
        d["begin"] = None
    if "end" not in d:
        d["end"] = None
    if "target" not in d:
        d["target"] = None
    if "shadow" not in d:
        d["shadow"] = None
