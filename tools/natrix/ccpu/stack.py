def _callPush(lFrom, lTo, fn):
    return '''
        ldi ph, hi(__cc_from)
        ldi pl, lo(__cc_from)
        ldi a, lo({0})
        st a
        inc pl
        ldi a, hi({0})
        st a
        ldi pl, lo(__cc_to)
        ldi a, lo({1})
        st a
        inc pl
        ldi a, hi({1})
        st a
        ldi pl, lo({2})
        ldi ph, hi({2})
        jmp
    '''.format(lFrom, lTo, fn)

def genPush(lFrom, lTo):
    return _callPush(lFrom, lTo, "__cc_push")

def genPop(lFrom, lTo):
    return _callPush(lFrom, lTo, "__cc_pop")
