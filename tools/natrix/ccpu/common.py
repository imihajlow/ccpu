def align(x, a):
    if x % a == 0:
        return x
    else:
        return (x // a)  * a + a

def signExpandByte(x):
    if x & 0x80:
        return x | 0xff00
    else:
        return x

def hi(x):
    return (x >> 8) & 0xff

def lo(x):
    return x & 0xff
