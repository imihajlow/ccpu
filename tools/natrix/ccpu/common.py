def align(x, a):
    if x % a == 0:
        return x
    else:
        return (x // a)  * a + a

def signExpandByte(x):
    if isinstance(x, int):
        if bool(x & 0x80):
            return x | 0xff00
        else:
            return x
    else:
        return "(({0}) | 0xff00 if bool({0} & 0x80) else ({0}))"

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

def copyW(f, t, fAligned, tAligned):
    result = '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ld b
        inc pl
    '''.format(f)
    if not fAligned:
        result += '''
            mov a, 0
            adc ph, a
        '''
    result += '''
        ld a
        ldi pl, lo({0})
        ldi ph, hi({0})
        st b
    '''.format(t)
    if tAligned:
        result += '''
            inc pl
            st a
        '''
    else:
        result += '''
            ldi pl, lo(({0}) + 1)
            ldi ph, hi(({0}) + 1)
            st a
        '''.format(t)
    return result

def copyB(f, t):
    return '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ld b
        ldi pl, lo({1})
        ldi ph, hi({1})
        st b
    '''.format(f, t)

def storeConstW(c, dst, aligned):
    result = '''
        ldi pl, lo({0})
        ldi ph, hi({0})
        ldi b, lo({1})
        st b
        inc pl
    '''.format(dst, c)
    if not aligned:
        result += '''
            mov a, 0
            adc ph, a
        '''
    result += '''
        ldi b, hi({})
        st b
    '''.format(c)
    return result

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
