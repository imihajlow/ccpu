def align(x, a):
    if x % a == 0:
        return x
    else:
        return (x // a)  * a + a

def hi(x):
    return (x >> 8) & 0xff

def lo(x):
    return x & 0xff

def isPowerOfTwo(x):
    return not bool(x & (x - 1))

def log(x):
    result = 0
    while x > 1:
        x >>= 1
        result += 1
    return result

def loadByte(reg, loc, offset):
    v = loc.getSource()
    if loc.getIndirLevel() == 0:
        b = v.byte(offset)
        if b.isNumber():
            if int(b) == 0 and reg == 'a':
                return 'mov a, 0\n'
            else:
                return f'ldi {reg}, {b}\n'
        else:
            return f'ldi {reg}, {b}\n'
    else:
        if v.isRegister():
            assert(loc.getType().getSize() == 1)
            assert(offset == 0)
            if reg == 'a':
                return ''
            else:
                return f'mov {reg}, a\n'
        else:
            return f'''
                ldi pl, lo({v} + {offset})
                ldi ph, hi({v} + {offset})
                ld {reg}
            '''

def loadP(loc, offset=0):
    """
    Load P from location with offset considering indirection level.
    """
    result = ''
    if loc.getIndirLevel() == 0:
        result += '''
            ldi pl, lo({0} + {1})
            ldi ph, hi({0} + {1})
        '''.format(loc.getSource(), offset)
    else:
        result += '''
            ldi pl, lo({0})
            ldi ph, hi({0})
            ld a
        '''.format(loc.getSource())
        if loc.isAligned():
            result += 'inc pl\n'
        else:
            result += '''
                ldi pl, lo({0} + 1)
                ldi ph, hi({0} + 1)
            '''.format(loc.getSource())
        result += '''
            ld ph
            mov pl, a
        '''
        if offset != 0:
            l = lo(offset)
            h = hi(offset)
            if l == 0:
                pass
            elif l == 1:
                result += 'inc pl\n'
            else:
                result += '''
                    ldi a, {}
                    add pl, a
                '''.format(l)
            if h == 0:
                result += 'mov a, 0\n'
            else:
                result += 'ldi a, {}\n'.format(h)
            if l == 0:
                # carry was not set
                result += 'add ph, a\n'
            else:
                result += 'adc ph, a\n'
    return result

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

def incP(aligned):
    if aligned:
        return 'inc pl\n'
    else:
        return '''
            inc pl
            mov a, 0
            adc ph, a
        '''
