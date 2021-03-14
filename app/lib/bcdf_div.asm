    ; bcdf_div - divide
    ; arguments: bcdf_op_a, bcdf_op_b
    ; result: bcdf_op_r
    .export bcdf_div
    .export bcdf_div_ret
    .global bcdf_op_a
    .global bcdf_op_b
    .global bcdf_op_r

    .global bcdf_sub

    .section bss.bcdf_div
    .align 16
bcdf_div_ret:
divisor: res 16
result: res 16
ret_addr: res 2
index: res 1

    .section text.bcdf_div
bcdf_div:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret_addr)
    ldi ph, hi(ret_addr)
    st b
    inc pl
    st a

    ; r.sign := a.sign ^ b.sign
    ldi pl, lo(bcdf_op_a + 0) ; sign
    ldi ph, hi(bcdf_op_a + 0)
    ld a
    ldi pl, lo(bcdf_op_b + 0) ; sign
    ldi ph, hi(bcdf_op_b + 0)
    ld b
    xor a, b
    ldi pl, lo(result + 0) ; sign
    ldi ph, hi(result + 0)
    st a

    ; r.exp := a.exp - b.exp
    ldi pl, lo(bcdf_op_a + 1) ; exp
    ldi ph, hi(bcdf_op_a + 1)
    ld a
    ldi pl, lo(bcdf_op_b + 1) ; exp
    ldi ph, hi(bcdf_op_b + 1)
    ld b
    sub a, b
    ldi pl, lo(result + 1) ; exp
    ldi ph, hi(result + 1)
    st a
    ldi pl, lo(exp_ovf)
    ldi ph, hi(exp_ovf)
    jo

    ; b == 0?
    ldi pl, lo(bcdf_op_b + 2) ; b.man[0]
    ldi ph, hi(bcdf_op_b + 2)
    ld a
    add a, 0
    ldi pl, lo(return_inf)
    ldi ph, hi(return_inf)
    ; b.man[0] == 0 means either b is zero or b isn't normalized
    ; not normalized => undefined behaviour, can as well treat as 0
    jz

    ; a == 0?
    ldi pl, lo(bcdf_op_a + 2) ; a.man[0]
    ldi ph, hi(bcdf_op_a + 2)
    ld a
    add a, 0
    ldi pl, lo(return_zero)
    ldi ph, hi(return_zero)
    jz ; a.man[0] == 0

    ; a.sign := 0
    ; a.exp := 0
    mov a, 0
    ldi pl, lo(bcdf_op_a + 0) ; sign
    ldi ph, hi(bcdf_op_a + 0)
    st a
    inc pl ; exp
    st a

    ; divisor.sign := 0
    ; divisor.exp := 0
    ldi pl, lo(divisor + 0) ; sign
    ldi ph, hi(divisor + 0)
    st a
    inc pl ; exp
    st a

    ; divisor.man := b.man
    ; r.man := 0
    ldi a, 13
copy_divisor_loop:
        ldi pl, lo(bcdf_op_b + 2) ; mantissa
        ldi ph, hi(bcdf_op_b + 2)
        add pl, a
        ld b
        ldi pl, lo(divisor + 2) ; mantissa
        ldi ph, hi(divisor + 2)
        add pl, a
        st b
        ldi b, 0
        ldi pl, lo(result + 2) ; mantissa
        ldi ph, hi(result + 2)
        add pl, a
        st b
        dec a
        ldi pl, lo(copy_divisor_loop)
        ldi ph, hi(copy_divisor_loop)
        jnc

    ; shift the exponents until a >= divisor
init_exp_loop:
        ldi pl, lo(compare)
        ldi ph, hi(compare)
        jmp

        ldi pl, lo(init_exp_end)
        ldi ph, hi(init_exp_end)
        jns ; a >= divisor

        ; a.exp += 1
        ldi pl, lo(bcdf_op_a + 1) ; exp
        ldi ph, hi(bcdf_op_a + 1)
        ld a
        inc a
        st a

        ; r.exp -= 1
        ldi pl, lo(result + 1) ; exp
        ldi ph, hi(result + 1)
        ld a
        dec a
        st a
        ldi pl, lo(return_zero)
        ldi ph, hi(return_zero)
        jo ; r.exp < -128

        ldi pl, lo(init_exp_loop)
        ldi ph, hi(init_exp_loop)
        jmp
init_exp_end:

    ; index := 0
    mov a, 0
    ldi pl, lo(index)
    ldi ph, hi(index)
    st a

divide_loop:
        ldi pl, lo(compare)
        ldi ph, hi(compare)
        jmp

        ldi pl, lo(divide_a_eq_divisor)
        ldi ph, hi(divide_a_eq_divisor)
        jz ; a == divisor

        ldi pl, lo(divide_loop_lt)
        ldi ph, hi(divide_loop_lt)
        js ; a < divisor

        ; a > divisor
        ; b := divisor
        ldi a, 15
divide_loop_copy_b_loop:
            ldi pl, lo(divisor)
            ldi ph, hi(divisor)
            add pl, a
            ld b
            ldi pl, lo(bcdf_op_b)
            ldi ph, hi(bcdf_op_b)
            add pl, a
            st b

            dec a
            ldi pl, lo(divide_loop_copy_b_loop)
            ldi ph, hi(divide_loop_copy_b_loop)
            jnc

        ldi pl, lo(bcdf_sub)
        ldi ph, hi(bcdf_sub)
        jmp

        ; a := a - b
        ldi a, 15
divide_loop_copy_r_loop:
            ldi pl, lo(bcdf_op_r)
            ldi ph, hi(bcdf_op_r)
            add pl, a
            ld b
            ldi pl, lo(bcdf_op_a)
            ldi ph, hi(bcdf_op_a)
            add pl, a
            st b

            dec a
            ldi pl, lo(divide_loop_copy_r_loop)
            ldi ph, hi(divide_loop_copy_r_loop)
            jnc

        ; result.man[i] += 1
        ldi pl, lo(index)
        ldi ph, hi(index)
        ld a
        ldi pl, lo(result + 2) ; mantissa
        ldi ph, hi(result + 2)
        add pl, a
        ld b
        inc b
        st b

        ldi pl, lo(divide_loop)
        ldi ph, hi(divide_loop)
        jmp

divide_loop_lt:
        ; a < divisor
        ; a.exp += 1
        ldi pl, lo(bcdf_op_a + 1) ; exp
        ldi ph, hi(bcdf_op_a + 1)
        ld a
        inc a
        st a
        ; i += 1
        ldi pl, lo(index)
        ldi ph, hi(index)
        ld a
        inc a
        st a

        ldi b, 14
        sub b, a
        ldi pl, lo(divide_loop)
        ldi ph, hi(divide_loop)
        jnz ; i != 14

    ldi pl, lo(copy_result)
    ldi ph, hi(copy_result)
    jmp

divide_a_eq_divisor:
    ; a == divisor
    ; result.man[i] += 1
    ldi pl, lo(index)
    ldi ph, hi(index)
    ld a
    ldi pl, lo(result + 2) ; mantissa
    ldi ph, hi(result + 2)
    add pl, a
    ld b
    inc b
    st b

copy_result:
    ldi a, 15
copy_result_loop:
        ldi pl, lo(result)
        ldi ph, hi(result)
        add pl, a
        ld b
        ldi pl, lo(bcdf_op_r)
        ldi ph, hi(bcdf_op_r)
        add pl, a
        st b

        dec a
        ldi pl, lo(copy_result_loop)
        ldi ph, hi(copy_result_loop)
        jnc

finish:
    ldi pl, lo(ret_addr)
    ldi ph, hi(ret_addr)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

exp_ovf:
    ; flags = a.exp - b.exp
    ldi pl, lo(return_inf)
    ldi ph, hi(return_inf)
    js ; a.exp - b.exp > 127

return_zero:
    ldi a, 15
    ldi b, 0
return_zero_loop:
        ldi pl, lo(bcdf_op_r)
        ldi ph, hi(bcdf_op_r)
        add pl, a
        st b
        dec a
        ldi pl, lo(return_zero_loop)
        ldi ph, hi(return_zero_loop)
        jnc

    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp

return_inf:
    ldi pl, lo(result + 0) ; sign
    ldi ph, hi(result + 0)
    ld a
    ldi pl, lo(bcdf_op_r + 0) ; sign
    ldi ph, hi(bcdf_op_r + 0)
    st a
    inc pl ; exp
    ldi a, 127
    st a
    inc pl ; man[0]
    ldi a, 1
    st a

    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp

    .section text.bcdf_compare
    ; compare bcdf_op_a and divisor (absolute values), return flags accordingly
compare:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(compare_ret)
    ldi ph, hi(compare_ret)
    st b
    inc pl
    st a

    ; compare exponents
    ldi pl, lo(bcdf_op_a + 1) ; exp
    ldi ph, hi(bcdf_op_a + 1)
    ld a
    ldi pl, lo(divisor + 1) ; exp
    ldi ph, hi(divisor + 1)
    ld b
    sub a, b
    ldi pl, lo(compare_finish)
    ldi ph, hi(compare_finish)
    jnz ; a.exp != divisor.exp

    ; compare mantissae
    mov a, 0
compare_loop:
        ; a = i
        ldi pl, lo(bcdf_op_a + 2) ; man
        ldi ph, hi(bcdf_op_a + 2)
        add pl, a
        ld b

        ldi pl, lo(divisor + 2) ; man
        ldi ph, hi(divisor + 2)
        add pl, a
        ld pl

        ; a = i
        ; b = a.man[i]
        ; pl = divisor.man[i]
        xor a, b
        xor b, a
        xor a, b

        ; a = a.man[i]
        ; b = i
        ; pl = divisor.man[i]
        sub a, pl
        mov a, b
        ; a = i
        ; flags = a.man[i] - divisor.man[i]
        ldi pl, lo(compare_finish)
        ldi ph, hi(compare_finish)
        jnz ; a.man[i] != divisor.man[i]

        inc a
        ldi b, 14
        sub b, a
        ; flags = z if the loop has ended, can return that immediately
        jz ; i == 14

        ldi pl, lo(compare_loop)
        ldi ph, hi(compare_loop)
        jmp


compare_finish:
    ; preserve flags
    ldi pl, lo(compare_ret)
    ldi ph, hi(compare_ret)
    ld a
    ldi pl, lo(compare_ret + 1)
    ld ph
    mov pl, a
    jmp

    .section bss.bcdf_div
    .align 2
compare_ret: res 2
