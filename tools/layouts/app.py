# Memory layout of a loadable application

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
        "name": "data",
        "init": True
    },
    {
        "name": "bss",
        "init": False
    },
    {
        "name": "sys_bss",
        "init": False,
        "begin": 0x8000
    },
    {
        "name": "stack",
        "end": 0xB800,
        "init": False
    },
    {
        "name": "syscall_args",
        "begin": 0xB800,
        "init": False
    },
    {
        "name": "syscall_text",
        "begin": 0xB822,
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
