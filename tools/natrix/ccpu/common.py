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

def isPowerOfTwo(x):
    ones = 0
    while x != 0:
        if bool(x & 1):
            ones += 1
            if ones == 2:
                return False
        x >>= 1
    return True

def copyW(f, t):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ld b
        inc pl
        ld a
        ldi pl, lo({1})
        ldi ph, hi({1})
        st b
        inc pl
        st a
    '''.format(f, t)

def copyB(f, t):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ld b
        ldi pl, lo({1})
        ldi ph, hi({1})
        st b
    '''.format(f, t)

def storeConstW(c, dst):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ldi a, lo({1})
        st a
        inc pl
        ldi a, hi({1})
        st a
    '''.format(dst, c)

def storeConstB(c, dst):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ldi a, lo({1})
        st a
    '''.format(dst, c)

def call(f):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        jmp
    '''.format(f)
