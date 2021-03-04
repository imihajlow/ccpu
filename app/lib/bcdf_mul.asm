    ; bcdf_mul - multiply two numbers
    ; arguments: bcdf_op_a and bcdf_op_b
    ; result: bcdf_op_r
    .export bcdf_mul
    .global bcdf_op_a
    .global bcdf_op_b
    .global bcdf_op_r

    .global bcdf_add

    .section bss.bcdf_mul
    .align 16
bcdf_mul_a: res 16
bcdf_mul_b: res 16

ret_addr: res 2
i: res 1
j: res 1    ; j should follow i

    .section text.bcdf_mul
bcdf_mul:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret_addr)
    ldi ph, hi(ret_addr)
    st b
    inc pl
    st a

    ; init
    ; 0 => bcdf_op_r
    ldi a, 15
    ldi b, 0
loop_init_r:
        ldi pl, lo(bcdf_op_r)
        ldi ph, hi(bcdf_op_r)
        add pl, a
        st b
        dec a
        ldi pl, lo(loop_init_r)
        ldi ph, hi(loop_init_r)
        jnc

    ; bcdf_op_a => bcdf_mul_a
    ; bcdf_op_b => bcdf_mul_b
    ldi a, 15
loop_copy_args:
        ldi pl, lo(bcdf_op_a)
        ldi ph, hi(bcdf_op_a)
        add pl, a
        ld b
        ldi pl, lo(bcdf_mul_a)
        ldi ph, hi(bcdf_mul_a)
        add pl, a
        st b

        ldi pl, lo(bcdf_op_b)
        ldi ph, hi(bcdf_op_b)
        add pl, a
        ld b
        ldi pl, lo(bcdf_mul_b)
        ldi ph, hi(bcdf_mul_b)
        add pl, a
        st b

        dec a
        ldi pl, lo(loop_copy_args)
        ldi ph, hi(loop_copy_args)
        jnc ; a >= 0

    mov a, 0
loop_man:
        ; a = i
        ldi pl, lo(bcdf_mul_a + 2) ; mantissa
        ldi ph, hi(bcdf_mul_a + 2)
        add pl, a
        ld b

        ; a = i
        ; b = a.man[i]
        ldi pl, lo(i)
        ldi ph, hi(i)
        st a
        inc pl
        dec b
        st b
        ; j = a.man[i] - 1
        ldi pl, lo(loop_digit_end)
        ldi ph, hi(loop_digit_end)
        jc ; j < 0

loop_digit:
            ; bcdf_op_r => bcdf_op_a
            ; bcdf_mul_b => bcdf_op_b
            ldi a, 15
loop_copy_add_args:
                ldi pl, lo(bcdf_op_r)
                ldi ph, hi(bcdf_op_r)
                add pl, a
                ld b
                ldi pl, lo(bcdf_op_a)
                ldi ph, hi(bcdf_op_a)
                add pl, a
                st b

                ldi pl, lo(bcdf_mul_b)
                ldi ph, hi(bcdf_mul_b)
                add pl, a
                ld b
                ldi pl, lo(bcdf_op_b)
                ldi ph, hi(bcdf_op_b)
                add pl, a
                st b

                dec a
                ldi pl, lo(loop_copy_add_args)
                ldi ph, hi(loop_copy_add_args)
                jnc

            ; add
            ldi pl, lo(bcdf_add)
            ldi ph, hi(bcdf_add)
            jmp

            ldi pl, lo(j)
            ldi ph, hi(j)
            ld a
            dec a
            st a
            ldi pl, lo(loop_digit)
            ldi ph, hi(loop_digit)
            jnc ; j >= 0
loop_digit_end:
        ; b.exp -= 1
        ldi pl, lo(bcdf_mul_b + 1) ; exp
        ldi ph, hi(bcdf_mul_b + 1)
        ld a
        dec a
        st a
        ldi pl, lo(loop_man_end)
        ldi ph, hi(loop_man_end)
        jo ; b.exp - 1 < -128

        ; i += 1
        ldi pl, lo(i)
        ldi ph, hi(i)
        ld a
        inc a
        st a
        ldi b, 14
        sub b, a
        ldi pl, lo(loop_man)
        ldi ph, hi(loop_man)
        jnz ; i != 14
loop_man_end:
    ; r.sign ^= a.sign
    ldi pl, lo(bcdf_mul_a + 0) ; sign
    ldi ph, hi(bcdf_mul_a + 0)
    ld a
    ldi pl, lo(bcdf_op_r + 0) ; sign
    ldi ph, hi(bcdf_op_r + 0)
    ld b
    xor b, a
    st b
    ; r.exp += a.exp
    ldi pl, lo(bcdf_mul_a + 1) ; exp
    ldi ph, hi(bcdf_mul_a + 1)
    ld a
    ldi pl, lo(bcdf_op_r + 1) ; exp
    ldi ph, hi(bcdf_op_r + 1)
    ld b
    add b, a
    st b
    ldi pl, lo(exp_ovf)
    ldi ph, hi(exp_ovf)
    jo ; r.exp + a.exp > 127 or < -128
finish:
    ldi pl, lo(ret_addr)
    ldi ph, hi(ret_addr)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

exp_ovf:
    ; flags = r.exp + a.exp
    ldi pl, lo(return_inf)
    ldi ph, hi(return_inf)
    js ; > 127
    ; < -128
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
    ldi pl, lo(bcdf_op_r + 1) ; exp
    ldi ph, hi(bcdf_op_r + 1)
    ldi a, 127
    st a
    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp
