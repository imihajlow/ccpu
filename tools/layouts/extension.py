# Memory layout for programs to load into Hi RAM

layout = [
    {
        "name": "init_origin",
        "begin": 0x0000,
        "target": "init",
        "init": True
    },
    {
        "name": "text_origin",
        "target": "text",
        "init": True
    },
    {
        "name": "init",
        "begin": 0x8000,
        "init": False,
        "shadow": "init_origin"
    },
    {
        "name": "text",
        "init": False,
        "shadow": "text_origin"
    },
    {
        "name": "bss",
        "init": False,
        "end": 0xB800
    },
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
