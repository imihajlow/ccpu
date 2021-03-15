# Memory layout for loader. Has a gap in RAM for loading programs.

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
        "name": "syscall_text_origin",
        "init": True,
        "target": "syscall_text"
    },
    {
        "name": "extension",
        "init": False,
        "begin": 0x8000,
        "end": 0xB800
    },
    {
        "name": "syscall_args",
        "begin": 0xB800,
        "init": False
    },
    {
        "name": "syscall_text",
        "begin": 0xB822,
        "init": False,
        "shadow": "syscall_text_origin"
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
