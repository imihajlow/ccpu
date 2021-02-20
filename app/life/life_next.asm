    .export life_get_next_fast
    .export life_get_next_fast_arg0
    .export life_get_next_fast_arg1
    .export life_get_next_fast_arg2
    .export life_get_next_fast_arg3
    .export life_get_next_fast_arg4
    .export life_get_next_fast_arg5
    .export life_get_next_fast_arg6
    .export life_get_next_fast_arg7
    .export life_get_next_fast_arg8
    .export life_get_next_fast_ret

    .section text
life_get_next_fast:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi ph, hi(life_get_next_fast_arg4)
    ldi pl, lo(life_get_next_fast_arg4)
    ld a
    ldi pl, lo(life_get_next_fast_ret)
    st a

    ldi pl, lo(life_get_next_fast_arg0)
    ld b
    shr b
    inc pl ; arg1
    ld a
    shr a
    add b, a
    inc pl ; arg2
    ld a
    shr a
    add b, a
    ldi pl, lo(sum_top)
    st b

    ldi pl, lo(life_get_next_fast_arg3)
    ld b
    ld a
    shr a
    sub b, a
    inc pl ; arg 4
    ld a
    add b, a
    shr a
    sub b, a
    inc pl ; arg 5
    ld a
    add b, a
    shr a
    sub b, a
    ldi pl, lo(sum_center)
    st b

    ldi pl, lo(life_get_next_fast_arg6)
    ld b
    ldi a, 1
    and b, a
    inc pl
    ld a
    inc pl
    ld ph
    ldi pl, 1
    and a, pl
    add b, a
    mov a, ph
    and a, pl
    add b, a
    ldi ph, hi(sum_bottom)
    ldi pl, lo(sum_bottom)
    st b

    dec pl ; sum_center
    ld a
    add b, a
    st b ; -> nb_bottom (number of alive cells for the bottom square)
    dec pl
    ld b
    add b, a
    ; b = nb_top (number of alive cells for the top square)

    ldi a, 3
    sub a, b
    ldi pl, lo(top_ne_3)
    ldi ph, hi(top_ne_3)
    jnz
    ; nb_top == 3, set 1
    ldi pl, lo(life_get_next_fast_ret)
    ldi ph, hi(life_get_next_fast_ret)
    ld a
    ldi b, 1
    or a, b
    st a
    ldi pl, lo(top_default)
    ldi ph, hi(top_default)
    jmp
top_ne_3:
    ; a = 3 - nb_top
    inc a
    ldi pl, lo(top_default)
    ldi ph, hi(top_default)
    jz ; nb_top == 4
    ; nb_top != 4 and nb_top != 3, set 0
    ldi pl, lo(life_get_next_fast_ret)
    ldi ph, hi(life_get_next_fast_ret)
    ld a
    ldi b, 0xfe
    and a, b
    st a
top_default:

    ldi ph, hi(nb_bottom)
    ldi pl, lo(nb_bottom)
    ld b
    ldi a, 3
    sub a, b
    ldi pl, lo(bottom_ne_3)
    ldi ph, hi(bottom_ne_3)
    jnz
    ; nb_bottom == 3, set 1
    ldi pl, lo(life_get_next_fast_ret)
    ldi ph, hi(life_get_next_fast_ret)
    ld a
    ldi b, 2
    or a, b
    st a
    ldi pl, lo(bottom_default)
    ldi ph, hi(bottom_default)
    jmp
bottom_ne_3:
    ; a = 3 - nb_bottom
    inc a
    ldi pl, lo(bottom_default)
    ldi ph, hi(bottom_default)
    jz ; nb_bottom == 4
    ; nb_bottom != 4 and nb_bottom != 3, set 0
    ldi pl, lo(life_get_next_fast_ret)
    ldi ph, hi(life_get_next_fast_ret)
    ld a
    ldi b, 0xfd
    and a, b
    st a
bottom_default:

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section bss
    .align 16
life_get_next_fast_arg0:
    res 1
life_get_next_fast_arg1:
    res 1
life_get_next_fast_arg2:
    res 1
life_get_next_fast_arg3:
    res 1
life_get_next_fast_arg4:
    res 1
life_get_next_fast_arg5:
    res 1
life_get_next_fast_arg6:
    res 1
life_get_next_fast_arg7:
    res 1
life_get_next_fast_arg8:
    res 1
life_get_next_fast_ret:
    res 1
ret:
    res 2
sum_top:
    res 1
sum_center:
nb_bottom:
    res 1
sum_bottom:
    res 1
