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
        "begin": 0x8000,
        "init": False
    },
    {
        "name": "stack",
        "end": 0xf000,
        "init": False
    }
]

for d in layout:
    if "begin" not in d:
        d["begin"] = None
    if "end" not in d:
        d["end"] = None
