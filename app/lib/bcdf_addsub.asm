    .const sign = 0
    .const exponent = 1
    .const mantissa = 2

    ; bcdf_add - add two numbers
    ; arguments: bcdf_op_a and bcdf_op_b
    ; result: bcdf_op_r
    ; note: arguments are destroyed
    .export bcdf_add
    .export bcdf_op_a
    .export bcdf_op_b
    .export bcdf_op_r

    .global divmod10
    .global divmod10_arg
    .global divmod10_div
    .global divmod10_mod

    .section data
    .align 16
bcdf_op_a: res 16
bcdf_op_b: res 16
bcdf_op_r: res 16

ret_addr: res 2
carry: res 1
exp_diff: res 1
index: res 1

    .section text
bcdf_add:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret_addr)
    ldi ph, hi(ret_addr)
    st b
    inc pl
    st a

    ldi pl, lo(bcdf_op_a + 0) ; sign
    ldi ph, hi(bcdf_op_a + 0)
    ld a

    ldi pl, lo(bcdf_op_b + 0) ; sign
    ldi ph, hi(bcdf_op_b + 0)
    ld b

    sub a, b
    ldi pl, lo(a_sign_eq)
    ldi ph, hi(a_sign_eq)
    jz ; a.sign == b.sign

    ; if signs are different, subtract
    not b
    ldi pl, lo(bcdf_op_b + 0) ; sign
    ldi ph, hi(bcdf_op_b + 0)
    st b
    ldi pl, lo(s_begin)
    ldi ph, hi(s_begin)
    jmp
a_sign_eq:
    ; r.sign := b.sign
    ldi pl, lo(bcdf_op_r + 0) ; sign
    ldi ph, hi(bcdf_op_r + 0)
    st b

    ldi pl, lo(bcdf_op_a + 1) ; exp
    ldi ph, hi(bcdf_op_a + 1)
    ld a
    ldi pl, lo(bcdf_op_b + 1) ; exp
    ldi ph, hi(bcdf_op_b + 1)
    ld b
    sub a, b
    ; a = a.exp - b.exp
    ldi pl, lo(a_diff_too_big)
    ldi ph, hi(a_diff_too_big)
    jo

    ldi pl, lo(a_a_exp_greater)
    ldi ph, hi(a_a_exp_greater)
    jns ; a.exp - b.exp >= 0

    ; if a.exp < b.exp swap a and b
    ldi pl, lo(swap_a_b)
    ldi ph, hi(swap_a_b)
    jmp

    ldi pl, lo(bcdf_op_a + 1) ; exp
    ldi ph, hi(bcdf_op_a + 1)
    ld a
    ldi pl, lo(bcdf_op_b + 1) ; exp
    ldi ph, hi(bcdf_op_b + 1)
    ld b
    sub a, b

a_a_exp_greater:
    ; a = exp_diff
    ldi pl, lo(exp_diff)
    ldi ph, hi(exp_diff)
    st a

    ; r.exp := a.exp
    ldi pl, lo(bcdf_op_a + 1) ; exp
    ldi ph, hi(bcdf_op_a + 1)
    ld a
    ldi pl, lo(bcdf_op_r + 1) ; exp
    ldi ph, hi(bcdf_op_r + 1)
    st a

    ; carry := 0
    mov a, 0
    ldi pl, lo(carry)
    ldi ph, hi(carry)
    st a

    ; i := 0
    ldi a, 13
a_loop:
    ; a = i
    ldi pl, lo(carry)
    ldi ph, hi(carry)
    ld b
    ldi pl, lo(bcdf_op_a + 2) ; mantissa
    ldi ph, hi(bcdf_op_a + 2)
    add pl, a
    ld pl
    ; pl = a.man[i]
    ; a = i
    ; b = carry
    mov ph, a
    mov a, pl
    add b, a
    mov a, ph
    ; b = carry + a.man[i]
    ; a = i
    ldi pl, lo(index)
    ldi ph, hi(index)
    st a

    ldi pl, lo(exp_diff)
    ldi ph, hi(exp_diff)
    ld pl
    sub a, pl
    ; b = carry + a.man[i]
    ; a = i - exp_diff
    ldi pl, lo(a_divide)
    ldi ph, hi(a_divide)
    js ; i - exp_diff < 0

    ldi pl, lo(bcdf_op_b + 2) ; mantissa
    ldi ph, hi(bcdf_op_b + 2)
    add pl, a
    ld a
    add b, a
    ; b = carry + a.man[i] + b.man[i - exp_diff]
a_divide:
    ; b = sum
    ldi pl, lo(divmod10_arg)
    ldi ph, hi(divmod10_arg)
    st b
    ldi pl, lo(divmod10)
    ldi ph, hi(divmod10)
    jmp

    ; carry := div
    ldi pl, lo(divmod10_div)
    ldi ph, hi(divmod10_div)
    ld a
    ldi pl, lo(carry)
    ldi ph, hi(carry)
    st a

    ; r.man[i] := mod
    ldi pl, lo(index)
    ldi ph, hi(index)
    ld a
    ldi pl, lo(divmod10_mod)
    ldi ph, hi(divmod10_mod)
    ld b
    ldi pl, lo(bcdf_op_r + 2) ; mantissa
    ldi ph, hi(bcdf_op_r + 2)
    add pl, a
    st b

    ; i -= 1
    dec a
    ldi pl, lo(a_loop)
    ldi ph, hi(a_loop)
    jns

    ldi pl, lo(carry)
    ldi ph, hi(carry)
    ld a
    add a, 0
    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jz ; carry == 0

    ; carry != 0 - shift result by 1
    ; a = carry
    ldi pl, lo(bcdf_op_r + 1) ; exp
    ldi ph, hi(bcdf_op_r + 1)
    ld b
    inc b
    st b
    ldi pl, lo(a_inf)
    ldi ph, hi(a_inf)
    jo ; r.exp > 127

    ldi a, 12
a_shift_loop:
    ; a = i
    ; r.man[i + 1] := r.man[i]
    ldi pl, lo(bcdf_op_r + 2) ; mantissa
    ldi ph, hi(bcdf_op_r + 2)
    add pl, a
    ld b
    inc pl
    st b
    dec a
    ldi pl, lo(a_shift_loop)
    ldi ph, hi(a_shift_loop)
    jns

    ; r.man[0] := carry
    ldi pl, lo(carry)
    ldi ph, hi(carry)
    ld a
    ldi pl, lo(bcdf_op_r + 2) ; mantissa
    ldi ph, hi(bcdf_op_r + 2)
    st a
finish:
    ldi pl, lo(ret_addr)
    ldi ph, hi(ret_addr)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

a_diff_too_big:
    ; flags = a.exp - b.exp
    ldi a, 15
    ldi pl, lo(a_return_a_loop)
    ldi ph, hi(a_return_a_loop)
    js ; (a.exp - b.exp) % 256 >= 128

a_return_b_loop:
    ldi pl, lo(bcdf_op_b)
    ldi ph, hi(bcdf_op_b)
    add pl, a
    ld b
    ldi pl, lo(bcdf_op_r)
    ldi ph, hi(bcdf_op_r)
    add pl, a
    st b
    dec a
    ldi pl, lo(a_return_b_loop)
    ldi ph, hi(a_return_b_loop)
    jnc

    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp

a_return_a_loop:
    ldi pl, lo(bcdf_op_a)
    ldi ph, hi(bcdf_op_a)
    add pl, a
    ld b
    ldi pl, lo(bcdf_op_r)
    ldi ph, hi(bcdf_op_r)
    add pl, a
    st b
    dec a
    ldi pl, lo(a_return_a_loop)
    ldi ph, hi(a_return_a_loop)
    jnc

    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp

a_inf:
    ; TODO return infinity
    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp

bcdf_sub:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret_addr)
    ldi ph, hi(ret_addr)
    st b
    inc pl
    st a


s_begin:

    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp

    .section data
    .align 2
swap_a_b_ret: res 2
swap_a_b_tmp: res 1

    .section text
swap_a_b:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(swap_a_b_ret)
    ldi ph, hi(swap_a_b_ret)
    st b
    inc pl
    st a

    ldi a, 15
swap_loop:
    ; swap_a_b_tmp := a[i]
    ldi pl, lo(bcdf_op_a)
    ldi ph, hi(bcdf_op_a)
    add pl, a
    ld b
    ldi pl, lo(swap_a_b_tmp)
    ldi ph, hi(swap_a_b_tmp)
    st b

    ; a[i] := b[i]
    ldi pl, lo(bcdf_op_b)
    ldi ph, hi(bcdf_op_b)
    add pl, a
    ld b
    ldi pl, lo(bcdf_op_a)
    ldi ph, hi(bcdf_op_a)
    add pl, a
    st b

    ; b[i] := swap_a_b_tmp
    ldi pl, lo(swap_a_b_tmp)
    ldi ph, hi(swap_a_b_tmp)
    ld b
    ldi pl, lo(bcdf_op_b)
    ldi ph, hi(bcdf_op_b)
    add pl, a
    st b

    ; i -= 1
    dec a
    ldi pl, lo(swap_loop)
    ldi ph, hi(swap_loop)
    jnc

    ldi pl, lo(swap_a_b_ret)
    ldi ph, hi(swap_a_b_ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp
