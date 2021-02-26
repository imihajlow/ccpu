    .export __cc_r_sp
    .export __cc_asr
    .export __cc_asl
    .export __cc_lsr
    .export __cc_sh_val
    .export __cc_sh_count

    .export __cc_push
    .export __cc_pop
    .export __cc_from
    .export __cc_to
    .export __cc_r_a
    .export __cc_r_b
    .export __cc_r_r
    .export __cc_mul_byte
    .export __cc_mul_word
    .export __cc_div_byte
    .export __cc_div_word
    .export __cc_udiv_byte
    .export __cc_udiv_word
    .export __cc_r_quotient
    .export __cc_r_remainder

    ; provided by the linker
    .global __seg_stack_end
    .global __seg_ramtext_begin
    .global __seg_ramtext_end
    .global __seg_ramtext_origin_begin
    .global __seg_ramtext_origin_end

    .global memcpy
    .global memcpy_arg0
    .global memcpy_arg1
    .global memcpy_arg2

    .global main

    ; start-up code
    .section init
    .align 0x10000 ; make sure this is at address 0
    nop
    ; enable all memory segments except for d and e
    ldi ph, 0xff
    ldi pl, 0x02
    ldi a, 0x3e
    st a
    ; point SP to the end of stack segment
    ldi pl, lo(__cc_r_sp)
    ldi ph, hi(__cc_r_sp)
    ldi a, lo(__seg_stack_end)
    st a
    inc pl
    ldi a, hi(__seg_stack_end)
    st a

    ; populate ramtext secion
    ldi pl, lo(memcpy_arg0)
    ldi ph, hi(memcpy_arg0)
    ldi a, lo(__seg_ramtext_begin)
    ldi b, hi(__seg_ramtext_begin)
    st a
    inc pl
    st b

    ldi pl, lo(memcpy_arg1)
    ldi ph, hi(memcpy_arg1)
    ldi a, lo(__seg_ramtext_origin_begin)
    ldi b, hi(__seg_ramtext_origin_begin)
    st a
    inc pl
    st b

    ldi pl, lo(memcpy_arg2)
    ldi ph, hi(memcpy_arg2)
    ldi a, lo(__seg_ramtext_end - __seg_ramtext_begin)
    ldi b, hi(__seg_ramtext_end - __seg_ramtext_begin)
    st a
    inc pl
    st b

    ldi pl, lo(memcpy)
    ldi ph, hi(memcpy)
    jmp

    ; call main
    ldi pl, lo(main)
    ldi ph, hi(main)
    jmp
main_exit:
    ldi pl, lo(main_exit)
    ldi ph, hi(main_exit)
    jmp

    .section text

; bit shifts of word values
; __cc_sh_val = __cc_sh_val >> __cc_sh_count
__cc_asr:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ldi pl, lo(__cc_sh_count)
    ld b
    inc pl
    ld a
    ldi pl, lo(return_val_sign)
    ldi ph, hi(return_val_sign)
    add a, 0
    jnz ; count >= 256
    ldi a, 15
    sub a, b ; 15 - lo(count)
    jc ; 15 < lo(count)

    ldi a, 8
    sub b, a ; lo(count) - 8
    ldi pl, lo(__cc_asr_count_lt_8)
    ldi ph, hi(__cc_asr_count_lt_8)
    jc ; lo(count) < 8
    sub b, a
    ; b = count - 16

    ; lo(val) := hi(val)
    ; hi(val) := sign(val)
    ldi pl, lo(__cc_sh_val + 1)
    ldi ph, hi(__cc_sh_val)
    ld a
    dec pl
    st a
    inc pl
    shl a ; sign -> carry
    exp a
    st a
__cc_asr_count_lt_8:
    ; b = count - 8

    ldi a, 8
    add b, a
    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jz ; count == 0

    ; b = count
__cc_asr_loop:
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val)
    ld a
    shr a
    st a
    inc pl
    ld a
    sar a
    st a
    ldi pl, lo(__cc_asr_loop_end)
    ldi ph, hi(__cc_asr_loop_end)
    jnc
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val)
    ld a
    ldi pl, 0x80
    or a, pl
    ldi pl, lo(__cc_sh_val)
    st a
__cc_asr_loop_end:
    ldi pl, lo(__cc_asr_loop)
    ldi ph, hi(__cc_asr_loop)
    dec b
    jnz ; count != 0

    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp

return_val_sign:
    ldi pl, lo(__cc_sh_val + 1)
    ldi ph, hi(__cc_sh_val)
    ld a
    shl a ; sign -> carry
    exp a
    st a
    dec pl
    st a
    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp

    ; __cc_sh_val = __cc_sh_val >> __cc_sh_count
__cc_lsr:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ldi pl, lo(__cc_sh_count)
    ld b
    inc pl
    ld a
    ldi pl, lo(return_0)
    ldi ph, hi(return_0)
    add a, 0
    jnz ; count >= 256
    ldi a, 15
    sub a, b ; 15 - lo(count)
    jc ; 15 < lo(count)

    ldi a, 8
    sub b, a ; lo(count) - 8
    ldi pl, lo(__cc_lsr_count_lt_8)
    ldi ph, hi(__cc_lsr_count_lt_8)
    jc ; lo(count) < 8
    sub b, a
    ; b = count - 16

    ; lo(val) := hi(val)
    ; hi(val) := 0
    ldi pl, lo(__cc_sh_val + 1)
    ldi ph, hi(__cc_sh_val)
    ld a
    dec pl
    st a
    inc pl
    mov a, 0
    st a
__cc_lsr_count_lt_8:
    ; b = count - 8

    ldi a, 8
    add b, a
    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jz ; count == 0

    ; b = count
__cc_lsr_loop:
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val)
    ld a
    shr a
    st a
    inc pl
    ld a
    shr a
    st a
    ldi pl, lo(__cc_lsr_loop_end)
    ldi ph, hi(__cc_lsr_loop_end)
    jnc
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val)
    ld a
    ldi pl, 0x80
    or a, pl
    ldi pl, lo(__cc_sh_val)
    st a
__cc_lsr_loop_end:
    ldi pl, lo(__cc_asr_loop)
    ldi ph, hi(__cc_asr_loop)
    dec b
    jnz ; count != 0

    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp


    ; __cc_sh_val = __cc_sh_val << __cc_sh_count
__cc_asl:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ldi pl, lo(__cc_sh_count)
    ld b
    inc pl
    ld a
    ldi pl, lo(return_0)
    ldi ph, hi(return_0)
    add a, 0
    jnz ; count >= 256
    ldi a, 15
    sub a, b ; 15 - lo(count)
    jc ; 15 < lo(count)

    ldi a, 8
    sub b, a ; lo(count) - 8
    ldi pl, lo(__cc_asl_count_lt_8)
    ldi ph, hi(__cc_asl_count_lt_8)
    jc ; lo(count) < 8
    sub b, a
    ; b = count - 16

    ; hi(val) := lo(val)
    ; lo(val) := 0
    ldi pl, lo(__cc_sh_val)
    ldi ph, hi(__cc_sh_val)
    ld a
    inc pl
    st a
    dec pl
    mov a, 0
    st a
__cc_asl_count_lt_8:
    ; b = count - 8

    ldi a, 8
    add b, a
    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jz ; count == 0

    ; b = count
__cc_asl_loop:
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val + 1)
    ld a
    shl a
    st a
    dec pl
    ld a
    shl a
    st a
    ldi pl, lo(__cc_asl_loop_end)
    ldi ph, hi(__cc_asl_loop_end)
    jnc
    ldi ph, hi(__cc_sh_val)
    ldi pl, lo(__cc_sh_val + 1)
    ld a
    ldi pl, 0x01
    or a, pl
    ldi pl, lo(__cc_sh_val + 1)
    st a
__cc_asl_loop_end:
    ldi pl, lo(__cc_asl_loop)
    ldi ph, hi(__cc_asl_loop)
    dec b
    jnz ; count != 0

    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp

return_0:
    ldi pl, lo(__cc_sh_val)
    ldi ph, hi(__cc_sh_val)
    mov a, 0
    st a
    inc pl
    st a
exit:
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    ; push onto stack values in range [__cc_from, __cc_to)
__cc_push:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ; SP -= (to - from)
    ; SP -= to
    ldi pl, lo(__cc_to)
    ld b
    ldi pl, lo(__cc_r_sp)
    ld a
    sub a, b
    st a
    ldi pl, lo(__cc_to + 1)
    ld b
    ldi pl, lo(__cc_r_sp + 1)
    ld a
    sbb a, b
    st a
    ; SP += from
    ldi pl, lo(__cc_from)
    ld b
    ldi pl, lo(__cc_r_sp)
    ld a
    add a, b
    st a
    ldi pl, lo(__cc_from + 1)
    ld b
    ldi pl, lo(__cc_r_sp + 1)
    ld a
    adc a, b
    st a

    ; src_from := from
    ldi pl, lo(__cc_from)
    ld a
    inc pl
    ld b
    ldi pl, lo(src_from)
    st a
    inc pl
    st b
    ; src_to := to
    ldi pl, lo(__cc_to)
    ld a
    inc pl
    ld b
    ldi pl, lo(src_to)
    st a
    inc pl
    st b
    ; dst_from := SP
    ldi pl, lo(__cc_r_sp)
    ld a
    inc pl
    ld b
    ldi pl, lo(dst_from)
    st a
    inc pl
    st b

    ldi pl, lo(copy)
    ldi ph, hi(copy)
    jmp

    ; pop from stack values into range [__cc_from, __cc_to)
__cc_pop:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ; src_from := SP
    ldi pl, lo(__cc_r_sp)
    ld a
    inc pl
    ld b
    ldi pl, lo(src_from)
    st a
    inc pl
    st b

    ; SP += (to - from)
    ; SP += to
    ldi pl, lo(__cc_to)
    ld b
    ldi pl, lo(__cc_r_sp)
    ld a
    add a, b
    st a
    ldi pl, lo(__cc_to + 1)
    ld b
    ldi pl, lo(__cc_r_sp + 1)
    ld a
    adc a, b
    st a
    ; SP -= from
    ldi pl, lo(__cc_from)
    ld b
    ldi pl, lo(__cc_r_sp)
    ld a
    sub a, b
    st a
    ldi pl, lo(__cc_from + 1)
    ld b
    ldi pl, lo(__cc_r_sp + 1)
    ld a
    sbb a, b
    st a

    ; src_to := SP
    ldi pl, lo(__cc_r_sp)
    ld a
    inc pl
    ld b
    ldi pl, lo(src_to)
    st a
    inc pl
    st b
    ; dst_from := from
    ldi pl, lo(__cc_from)
    ld a
    inc pl
    ld b
    ldi pl, lo(dst_from)
    st a
    inc pl
    st b

    ; copy [src_from, src_to) into [dst_from, ...)
copy:

copy_loop:
        ldi ph, hi(src_from)
        ldi pl, lo(src_from)
        ld b
        ldi pl, lo(src_to)
        ld a
        sub b, a
        ldi pl, lo(copy_loop_neq)
        ldi ph, hi(copy_loop_neq)
        jnz
        ldi ph, hi(src_from + 1)
        ldi pl, lo(src_from + 1)
        ld b
        ldi pl, lo(src_to + 1)
        ld a
        sub b, a
        ldi pl, lo(exit)
        ldi ph, hi(exit)
        jz ; src_to == src_from
    copy_loop_neq:
        ; *dst_from := *src_from
        ldi pl, lo(src_from)
        ldi ph, hi(src_from)
        ld a
        inc pl
        ld ph
        mov pl, a
        ld b
        ldi ph, hi(dst_from)
        ldi pl, lo(dst_from)
        ld a
        inc pl
        ld ph
        mov pl, a
        st b
        ; src_from -= 1
        ldi pl, lo(src_from)
        ldi ph, hi(src_from)
        ld b
        inc pl
        ld a
        inc b
        adc a, 0
        st a
        dec pl
        st b
        ; dst_from -= 1
        ldi pl, lo(dst_from)
        ld b
        inc pl
        ld a
        inc b
        adc a, 0
        st a
        dec pl
        st b

        ldi pl, lo(copy_loop)
        ldi ph, hi(copy_loop)
        jmp

; multiply A and B, result into R
__cc_mul_byte:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

; R := 0
    ldi pl, lo(__cc_r_r)
    ldi ph, hi(__cc_r_r)
    mov a, 0
    st a

__cc_mul_byte_loop:
    ; B >>= 1
    ldi pl, lo(__cc_r_b)
    ldi ph, hi(__cc_r_b)
    ld a
    shr a
    st a
    ldi pl, lo(__cc_mul_byte_added)
    ldi ph, hi(__cc_mul_byte_added)
    jnc ; no need to add
    ; R += A
    ldi pl, lo(__cc_r_a)
    ldi ph, hi(__cc_r_a)
    ld a
    ldi pl, lo(__cc_r_r)
    ld b
    add b, a
    st b
__cc_mul_byte_added:
    ; A <<= 1
    ldi ph, hi(__cc_r_a)
    ldi pl, lo(__cc_r_a)
    ld a
    shl a
    st a

    ; A | B == 0?
    ; a = A
    ldi pl, lo(__cc_r_b)
    ld b
    or a, b
    ldi pl, lo(__cc_mul_byte_loop)
    ldi ph, hi(__cc_mul_byte_loop)
    jnz ; A | B != 0

    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp

; multiply A and B, result into R
__cc_mul_word:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ; R := 0
    ldi pl, lo(__cc_r_r)
    ldi ph, hi(__cc_r_r)
    mov a, 0
    st a
    inc pl
    st a

__cc_mul_word_loop:
    ; lo(B) >>= 1
    ldi pl, lo(__cc_r_b)
    ldi ph, hi(__cc_r_b)
    ld a
    shr a
    st a
    ldi pl, lo(__cc_mul_word_added)
    ldi ph, hi(__cc_mul_word_added)
    jnc ; no need to add
    ; R += A
    ldi pl, lo(__cc_r_a)
    ldi ph, hi(__cc_r_a)
    ld a
    ldi pl, lo(__cc_r_r)
    ld b
    add b, a
    st b
    ldi pl, lo(__cc_r_a + 1)
    ld a
    ldi pl, lo(__cc_r_r + 1)
    ld b
    adc b, a
    st b
__cc_mul_word_added:
    ; hi(B) >>= 1
    ldi pl, lo(__cc_r_b + 1)
    ldi ph, hi(__cc_r_b)
    ld b
    shr b
    st b
    exp b
    ldi a, 0x80
    and a, b
    ; lo(B) |= c ? 0x80 : 0
    dec pl
    ld b
    or a, b
    st a
    ; A <<= 1
    ldi pl, lo(__cc_r_a)
    ld a
    shl a
    st a
    exp b
    ldi a, 0x01
    and b, a
    inc pl
    ld a
    shl a
    or a, b
    st a

    ; A | B == 0?
    ; a = hi(A)
    dec pl
    ld b
    or a, b
    ldi pl, lo(__cc_r_b)
    ld b
    or a, b
    inc pl
    ld b
    or a, b
    ldi pl, lo(__cc_mul_word_loop)
    ldi ph, hi(__cc_mul_word_loop)
    jnz ; A | B != 0

    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp

; A / B
; __cc_r_a / __cc_r_b -> __cc_r_quotient, __cc_r_remainder
__cc_div_word:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ; tmp & 1 = numerator was negative
    ; tmp & 2 = denominator was negative
    ; tmp := 0
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    mov a, 0
    st a

    ; test D
    ldi pl, lo(denominator + 1)
    ld a
    add a, 0
    ldi pl, lo(__cc_div_word_neg_denom)
    ldi ph, hi(__cc_div_word_neg_denom)
    js ; D < 0

__cc_div_word_test_sec:
    ; D >= 0
    ; test N
    ldi pl, lo(numerator + 1)
    ldi ph, hi(numerator)
    ld a
    add a, 0
    ldi pl, lo(__cc_div_word_neg_nom)
    ldi ph, hi(__cc_div_word_neg_nom)
    js ; N < 0

__cc_div_word_positive:
    ; D >= 0
    ; N >= 0
    ; actually divide
    ldi pl, lo(divide_word)
    ldi ph, hi(divide_word)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a
    shr a
    st a
    ldi pl, lo(__cc_div_word_result_nom_positive)
    ldi ph, hi(__cc_div_word_result_nom_positive)
    jnc

    ; numerator was negative

    ; Q = ~Q
    ldi pl, lo(quotient)
    ldi ph, hi(quotient)
    ld a
    not a
    st a
    inc pl
    ld a
    not a
    st a

    ; R == 0?
    ldi pl, lo(remainder)
    ld a
    inc pl
    ld b
    or a, b
    ldi pl, lo(__cc_div_word_d_minus_r)
    ldi ph, hi(__cc_div_word_d_minus_r)
    jnz

    ; "return -Q, 0"
    ; R == 0
    ; Q += 1 - finish the negation
    ldi pl, lo(quotient)
    ldi ph, hi(quotient)
    ld b
    inc b
    st b
    ldi pl, lo(quotient + 1)
    ld a
    adc a, 0
    st a

    ldi pl, lo(__cc_div_word_result_nom_positive)
    ldi ph, hi(__cc_div_word_result_nom_positive)
    jmp

__cc_div_word_d_minus_r:
    ; "return -Q - 1, D - R"
    ; Q is already that
    ; R := D - R
    ldi ph, hi(denominator)
    ldi pl, lo(denominator)
    ld b
    ldi pl, lo(remainder)
    ld a
    sub b, a
    st b
    ldi pl, lo(denominator + 1)
    ld b
    ldi pl, lo(remainder + 1)
    ld a
    sbb b, a
    st b

__cc_div_word_result_nom_positive:
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a
    shr a
    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jnc
    ; denominator was negative
    ; "return -Q, R"
    ; Q := -Q
    ldi pl, lo(quotient)
    ldi ph, hi(quotient)
    ld b
    inc pl
    ld a
    not b
    not a
    inc b
    adc a, 0
    st a
    dec pl
    st b

    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp

__cc_div_word_neg_denom:
    ; D = -D
    ldi ph, hi(denominator)
    ldi pl, lo(denominator)
    ld b
    inc pl
    ld a
    not a
    not b
    inc b
    adc a, 0
    st a
    dec pl
    st b

    ldi pl, lo(tmp)
    ldi a, 0x02 ; negative denominator
    st a

    ldi pl, lo(__cc_div_word_test_sec)
    ldi ph, hi(__cc_div_word_test_sec)
    jmp

__cc_div_word_neg_nom:
    ; N = -N
    ldi ph, hi(numerator)
    ldi pl, lo(numerator)
    ld b
    inc pl
    ld a
    not a
    not b
    inc b
    adc a, 0
    st a
    dec pl
    st b

    ldi pl, lo(tmp)
    ld a
    ldi b, 0x01 ; negative numerator
    or a, b
    st a

    ldi pl, lo(__cc_div_word_positive)
    ldi ph, hi(__cc_div_word_positive)
    jmp

    ; A (=N) / B (=D)
    ; preserve B
__cc_udiv_word:
divide_word:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(div_ret)
    ldi ph, hi(div_ret)
    st b
    inc pl
    st a

    ; D == 0?
    ldi ph, hi(denominator)
    ldi pl, lo(denominator)
    ld a
    inc pl
    ld b
    or a, b
    ldi pl, lo(__cc_div_zero_trap)
    ldi ph, hi(__cc_div_zero_trap)
    jz ; D == 0

    ; Q := 0
    ldi ph, hi(quotient)
    ldi pl, lo(quotient)
    mov a, 0
    st a
    inc pl
    st a
    ; R := 0
    ldi pl, lo(remainder)
    st a
    inc pl
    st a

    ; first half:

    ; qbit := 0x80
    ldi pl, lo(qbit)
    ldi a, 0x80
    st a

divide_word_loop_1:
    ; R := (R << 1) | msb(N)
    ; N <<= 1
    ldi ph, hi(remainder)
    ldi pl, lo(remainder)
    ld a
    shl a
    ldi pl, lo(numerator + 1)
    ld b
    shl b
    st b
    adc a, 0
    ldi pl, lo(remainder)
    st a

    ; R >= D?
    ; hi(R) is still 0
    ldi pl, lo(denominator + 1)
    ld a
    add a, 0
    ldi pl, lo(divide_word_loop_1_r_lt_d)
    ldi ph, hi(divide_word_loop_1_r_lt_d)
    jnz ; hi(D) != 0

    ldi ph, hi(remainder)
    ldi pl, lo(remainder)
    ld a
    ldi pl, lo(denominator)
    ld b
    sub a, b ; lo(R) - lo(D)
    ldi pl, lo(divide_word_loop_1_r_lt_d)
    ldi ph, hi(divide_word_loop_1_r_lt_d)
    jc ; lo(R) < lo(D)

    ; R >= D
    ; R -= D
    ; hi(R) == 0, hi(D) == 0, overflow isn't possible
    ldi ph, hi(denominator)
    ldi pl, lo(denominator)
    ld a
    ldi pl, lo(remainder)
    ld b
    sub b, a
    st b
    ; Q |= qbit
    ldi pl, lo(qbit)
    ld a
    ldi pl, lo(quotient + 1)
    ld b
    or b, a
    st b

divide_word_loop_1_r_lt_d:
    ; qbit >>= 1
    ldi ph, hi(qbit)
    ldi pl, lo(qbit)
    ld a
    shr a
    st a
    ldi ph, hi(divide_word_loop_1)
    ldi pl, lo(divide_word_loop_1)
    jnc

    ; second half:

    ; qbit := 0x80
    ldi ph, hi(qbit)
    ldi pl, lo(qbit)
    ldi a, 0x80
    st a

divide_word_loop_2:
    ; R := (R << 1) | msb(N)
    ; N <<= 1
    ldi ph, hi(remainder)
    ldi pl, lo(remainder)
    ld b
    inc pl
    ld a
    shl a
    shl b
    adc a, 0
    st a
    mov a, b
    ldi pl, lo(numerator)
    ld b
    shl b
    st b
    adc a, 0
    ldi pl, lo(remainder)
    st a

    ; R >= D?
    ldi pl, lo(denominator + 1)
    ld a
    ldi pl, lo(remainder + 1)
    ld b
    sub b, a
    ldi pl, lo(divide_word_loop_2_r_lt_d)
    ldi ph, hi(divide_word_loop_2_r_lt_d)
    jc ; hi(R) < hi(D)
    ldi pl, lo(divide_word_loop_2_r_gt_d)
    ldi ph, hi(divide_word_loop_2_r_gt_d)
    jnz

    ; hi(R) == hi(D)
    ldi ph, hi(remainder)
    ldi pl, lo(remainder)
    ld a
    ldi pl, lo(denominator)
    ld b
    sub a, b ; lo(R) - lo(D)
    ldi pl, lo(divide_word_loop_2_r_lt_d)
    ldi ph, hi(divide_word_loop_2_r_lt_d)
    jc ; lo(R) < lo(D)

divide_word_loop_2_r_gt_d:
    ; R >= D
    ; R -= D
    ldi ph, hi(denominator)
    ldi pl, lo(denominator)
    ld a
    ldi pl, lo(remainder)
    ld b
    sub b, a
    st b
    ldi pl, lo(denominator + 1)
    ld a
    ldi pl, lo(remainder + 1)
    ld b
    sbb b, a
    st b
    ; Q |= qbit
    ldi pl, lo(qbit)
    ld a
    ldi pl, lo(quotient)
    ld b
    or b, a
    st b

divide_word_loop_2_r_lt_d:
    ; qbit >>= 1
    ldi ph, hi(qbit)
    ldi pl, lo(qbit)
    ld a
    shr a
    st a
    ldi ph, hi(divide_word_loop_2)
    ldi pl, lo(divide_word_loop_2)
    jnc

    ldi pl, lo(div_ret)
    ldi ph, hi(div_ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp


    ; A / B
    ; __cc_r_a / __cc_r_b -> __cc_r_quotient, __cc_r_remainder
__cc_div_byte:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(int_ret)
    ldi ph, hi(int_ret)
    st b
    inc pl
    st a

    ; tmp & 1 = numerator was negative
    ; tmp & 2 = denominator was negative
    ; tmp := 0
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    mov a, 0
    st a

    ; test D
    ldi pl, lo(denominator)
    ld a
    add a, 0
    ldi pl, lo(__cc_div_byte_neg_denom)
    ldi ph, hi(__cc_div_byte_neg_denom)
    js ; D < 0

__cc_div_byte_test_sec:
    ; D >= 0
    ; test N
    ldi pl, lo(numerator)
    ldi ph, hi(numerator)
    ld a
    add a, 0
    ldi pl, lo(__cc_div_byte_neg_nom)
    ldi ph, hi(__cc_div_byte_neg_nom)
    js ; N < 0

__cc_div_byte_positive:
    ; D >= 0
    ; N >= 0
    ; actually divide
    ldi pl, lo(divide_byte)
    ldi ph, hi(divide_byte)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a
    shr a
    st a
    ldi pl, lo(__cc_div_byte_result_nom_positive)
    ldi ph, hi(__cc_div_byte_result_nom_positive)
    jnc

    ; numerator was negative

    ; Q = ~Q
    ldi pl, lo(quotient)
    ldi ph, hi(quotient)
    ld a
    not a
    st a

    ; R == 0?
    ldi pl, lo(remainder)
    ld a
    add a, 0
    ldi pl, lo(__cc_div_byte_d_minus_r)
    ldi ph, hi(__cc_div_byte_d_minus_r)
    jnz

    ; "return -Q, 0"
    ; R == 0
    ; Q += 1 - finish the negation
    ldi pl, lo(quotient)
    ldi ph, hi(quotient)
    ld b
    inc b
    st b

    ldi pl, lo(__cc_div_byte_result_nom_positive)
    ldi ph, hi(__cc_div_byte_result_nom_positive)
    jmp

__cc_div_byte_d_minus_r:
    ; "return -Q - 1, D - R"
    ; Q is already that
    ; R := D - R
    ldi ph, hi(denominator)
    ldi pl, lo(denominator)
    ld b
    ldi pl, lo(remainder)
    ld a
    sub b, a
    st b

__cc_div_byte_result_nom_positive:
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a
    shr a
    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jnc
    ; denominator was negative
    ; "return -Q, R"
    ; Q := -Q
    ldi pl, lo(quotient)
    ldi ph, hi(quotient)
    ld b
    neg b
    st b

    ldi pl, lo(exit)
    ldi ph, hi(exit)
    jmp

__cc_div_byte_neg_denom:
    ; D = -D
    ldi ph, hi(denominator)
    ldi pl, lo(denominator)
    ld b
    neg b
    st b

    ldi pl, lo(tmp)
    ldi a, 0x02 ; negative denominator
    st a

    ldi pl, lo(__cc_div_byte_test_sec)
    ldi ph, hi(__cc_div_byte_test_sec)
    jmp

__cc_div_byte_neg_nom:
    ; N = -N
    ldi ph, hi(numerator)
    ldi pl, lo(numerator)
    ld b
    neg b
    st b

    ldi pl, lo(tmp)
    ld a
    ldi b, 0x01 ; negative numerator
    or a, b
    st a

    ldi pl, lo(__cc_div_byte_positive)
    ldi ph, hi(__cc_div_byte_positive)
    jmp


    ; A (=N) / B (=D)
    ; preserve B
__cc_udiv_byte:
divide_byte:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(div_ret)
    ldi ph, hi(div_ret)
    st b
    inc pl
    st a

    ; D == 0?
    ldi ph, hi(denominator)
    ldi pl, lo(denominator)
    ld a
    add a, 0
    ldi pl, lo(__cc_div_zero_trap)
    ldi ph, hi(__cc_div_zero_trap)
    jz ; D == 0

    ; Q := 0
    ldi ph, hi(quotient)
    ldi pl, lo(quotient)
    mov a, 0
    st a
    ; R := 0
    ldi pl, lo(remainder)
    st a

    ; qbit := 0x80
    ldi pl, lo(qbit)
    ldi a, 0x80
    st a

divide_byte_loop:
    ; R := (R << 1) | msb(N)
    ; N <<= 1
    ldi ph, hi(remainder)
    ldi pl, lo(remainder)
    ld a
    shl a
    ldi pl, lo(numerator)
    ld b
    shl b
    st b
    adc a, 0
    ldi pl, lo(remainder)
    st a

    ; R >= D?
    ldi pl, lo(denominator)
    ld b
    sub a, b
    ldi pl, lo(divide_byte_loop_r_lt_d)
    ldi ph, hi(divide_byte_loop_r_lt_d)
    jc ; R < D

    ; R >= D
    ; R -= D
    ldi ph, hi(remainder)
    ldi pl, lo(remainder)
    st a ; a is already R - D after comparison

    ; Q |= qbit
    ldi pl, lo(qbit)
    ld a
    ldi pl, lo(quotient)
    ld b
    or b, a
    st b

divide_byte_loop_r_lt_d:
    ; qbit >>= 1
    ldi ph, hi(qbit)
    ldi pl, lo(qbit)
    ld a
    shr a
    st a
    ldi ph, hi(divide_byte_loop)
    ldi pl, lo(divide_byte_loop)
    jnc

    ldi pl, lo(div_ret)
    ldi ph, hi(div_ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

__cc_div_zero_trap:
    ldi pl, lo(__cc_div_zero_trap)
    ldi ph, hi(__cc_div_zero_trap)
    jmp

    .section bss
    .align 64 ; all internal data have the same hi byte
__cc_r_sp: res 2
__cc_sh_val: res 2
__cc_sh_count: res 2
__cc_from: res 2
__cc_to: res 2
numerator:
__cc_r_a: res 2
denominator:
__cc_r_b: res 2
__cc_r_r: res 2

int_ret: res 2
src_from: res 2
src_to: res 2
dst_from: res 2
tmp: res 2
__cc_r_quotient:
quotient: res 2
__cc_r_remainder:
remainder: res 2
div_ret: res 2
qbit: res 2
