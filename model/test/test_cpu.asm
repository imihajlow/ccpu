        ldi     ph, hi(mul)
        ldi     pl, lo(mul)
        jmp

        ldi     ph, hi(finish)
        ldi     pl, lo(finish)
        jmp

mul:
        mov     a, ph
        mov     b, a
        mov     a, pl
        ldi     ph, hi(mul_return)
        ldi     pl, lo(mul_return)
        st      a
        inc     pl
        st      b

        ldi     ph, hi(mul_i)
        ldi     pl, lo(mul_i)
        ldi     a, 8
        st      a

        ldi     ph, hi(mul_b + 1)
        ldi     pl, lo(mul_b + 1)
        mov     a, 0
        st      a
mul_loop:
        ; a >>= 1
        ldi     ph, hi(mul_a)
        ldi     pl, lo(mul_a)
        ld      a
        shr     a
        st      a
        ldi     ph, hi(mul_shift_b)
        ldi     pl, lo(mul_shift_b)
        jnc

        ; result += b
        ldi     ph, hi(mul_b)
        ldi     pl, lo(mul_b)
        ld      b
        ldi     ph, hi(mul_result)
        ldi     pl, lo(mul_result)
        ld      a
        add     a, b
        st      a
        ldi     ph, hi(mul_b + 1)
        ldi     pl, lo(mul_b + 1)
        ld      b
        ldi     ph, hi(mul_result + 1)
        ldi     pl, lo(mul_result + 1)
        ld      a
        adc     a, b
        st      a

mul_shift_b:
        ; b <<= 1
        ldi     ph, hi(mul_b + 1)
        ldi     pl, lo(mul_b + 1)
        ld      a
        shl     a
        st      a
        ldi     ph, hi(mul_b)
        ldi     pl, lo(mul_b)
        ld      a
        shl     a
        st      a
        ldi     ph, hi(mul_loop_end)
        ldi     pl, lo(mul_loop_end)
        jnc
        ldi     ph, hi(mul_b + 1)
        ldi     pl, lo(mul_b + 1)
        ld      a
        inc     a
        st      a

mul_loop_end:
        ldi     ph, hi(mul_i)
        ldi     pl, lo(mul_i)
        ld      a
        dec     a
        st      a
        ldi     ph, hi(mul_loop)
        ldi     pl, lo(mul_loop)
        jnz


        ldi     ph, hi(mul_return)
        ldi     pl, lo(mul_return)
        ld      a
        inc     pl
        ld      b
        mov     pl, a
        mov     a, b
        mov     ph, a
        jmp

        .align  16
mul_return: dw  0
mul_a:  db      100
mul_b:  dw      100
mul_i:  db      0
        .align  16
mul_result: dw  0

        .offset 0x1000
finish:
