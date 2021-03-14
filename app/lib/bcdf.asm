    ; Binary-coded decimal float
    ; Coding:
    ; Byte 0: sign (0x00 - positive, 0xff - negative)
    ; Byte 1: exponent (signed)
    ; Bytes 2-15: mantissa decimal digits

.const sign = 0
.const exponent = 1
.const mantissa = 2

    ; bcdf_normalize - normalize a number: adjust the exponent in a way that man[0] is not 0
    ; argument: bcdf_normalize_arg (bcdf)
    .export bcdf_normalize
    .export bcdf_normalize_ret
    .export bcdf_normalize_arg

    ; bcdf_sum - sum two bcdf numbers
    ; arguments: bcdf_sum_a, bcdf_sum_b
    ; result: bcdf_sum_r
    .export bcdf_sum
    .export bcdf_sum_ret
    .export bcdf_sum_a
    .export bcdf_sum_b
    .export bcdf_sum_r

    ; divmod10 - divide by 10
    ; argument: divmod10_arg (byte)
    ; result: divmod10_div (byte), divmod10_mod (byte)
    .export divmod10
    .export divmod10_arg
    .export divmod10_div
    .export divmod10_mod

    .section bss.bcdf_sum
    .align 16
bcdf_sum_a: res 16
bcdf_sum_b: res 16
bcdf_sum_r: res 16
bcdf_sum_ret: res 2

    .section text.bcdf_sum
bcdf_sum:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(bcdf_sum_ret)
    ldi ph, hi(bcdf_sum_ret)
    st a
    inc pl
    st b

    ldi pl, lo(bcdf_sum_a + sign)
    ldi ph, hi(bcdf_sum_a + sign)
    ld a

    ldi pl, lo(bcdf_sum_ret)
    ldi ph, hi(bcdf_sum_ret)
    ld b
    inc pl
    ld a
    mov ph, a
    mov a, b
    mov pl, a
    jmp

    .section bss.bcdf_normalize
    .align 16
bcdf_normalize_arg: res 16
bcdf_normalize_ret: res 2
delta: res 1

    .section text.bcdf_normalize
bcdf_normalize:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(bcdf_normalize_ret)
    ldi ph, hi(bcdf_normalize_ret)
    st a
    inc pl
    st b

    ; find out how many digits to shift
    mov a, 0
bcdf_normalize_delta_loop:
    ; a = index
    ldi pl, lo(bcdf_normalize_arg + mantissa)
    ldi ph, hi(bcdf_normalize_arg + mantissa)
    add pl, a
    ld b

    ; b = man[index]
    ; if b is not zero, delta is found
    mov pl, a
    mov a, 0
    add a, b
    mov a, pl
    ldi pl, lo(bcdf_normalize_delta)
    ldi ph, hi(bcdf_normalize_delta)
    jnz ; b != 0

    inc a
    ; if index == 14 then mantissa is all zeroes, nothing to normalize
    mov pl, a
    ldi a, 14
    sub a, pl
    mov a, pl
    ldi pl, lo(bcdf_normalize_finish)
    ldi ph, hi(bcdf_normalize_finish)
    jz ; index == 14

    ldi pl, lo(bcdf_normalize_delta_loop)
    ldi ph, hi(bcdf_normalize_delta_loop)
    jmp

bcdf_normalize_delta:
    ; a = delta
    ; if exp - delta < -128 then delta = exp + 128
    ldi pl, lo(bcdf_normalize_arg + exponent)
    ldi ph, hi(bcdf_normalize_arg + exponent)
    ld b

    ; b = exp
    sub b, a
    ldi pl, lo(bcdf_normalize_exp_ok)
    ldi ph, hi(bcdf_normalize_exp_ok)
    jno ; (exp - delta) doesn't overflow

    ; b = exp - delta
    add a, b ; a = exp
    ldi b, 128
    add a, b ; delta = exp + 128

bcdf_normalize_exp_ok:
    ; a = delta
    ldi pl, lo(bcdf_normalize_arg + exponent)
    ldi ph, hi(bcdf_normalize_arg + exponent)
    ld b
    sub b, a
    st b ; exp -= delta

    ; a = delta
    ldi pl, lo(delta)
    ldi ph, hi(delta)
    st a
    ldi b, 0
bcdf_normalize_copy_loop:
    ; b = i
    ; a = delta
    add a, b
    ; a = src_index
    ldi pl, 14
    sub a, pl
    ldi pl, lo(bcdf_normalize_copy_loop_zero)
    ldi ph, hi(bcdf_normalize_copy_loop_zero)
    jns ; src_index >= 14

    ; a = src_index - 14
    ldi pl, 14
    add a, pl
    ; a = src_index
    ; a < 14
    ; b = i = dst_index
    ldi pl, lo(bcdf_normalize_arg + mantissa)
    ldi ph, hi(bcdf_normalize_arg + mantissa)
    add pl, a
    ld a
    ; a = value
    ; b = dst_index
    xor a, b
    xor b, a
    xor a, b
    ; a = i = dst_index
    ; b = value
    ldi pl, lo(bcdf_normalize_arg + mantissa)
    add pl, a
    st b
    mov b, a
    ldi pl, lo(bcdf_normalize_copy_loop_finish)
    ldi ph, hi(bcdf_normalize_copy_loop_finish)
    jmp

bcdf_normalize_copy_loop_zero:
    ; b = i = dst_index
    mov a, b
    ldi pl, lo(bcdf_normalize_arg + mantissa)
    ldi ph, hi(bcdf_normalize_arg + mantissa)
    add pl, a
    mov a, 0
    st a

bcdf_normalize_copy_loop_finish:
    ; b = i
    inc b
    ldi a, 14
    sub a, b
    ldi pl, lo(delta)
    ldi ph, hi(delta)
    ld a
    ldi pl, lo(bcdf_normalize_copy_loop)
    ldi ph, hi(bcdf_normalize_copy_loop)
    jnz ; i != 14

bcdf_normalize_finish:
    ldi pl, lo(bcdf_normalize_ret)
    ldi ph, hi(bcdf_normalize_ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section bss.bcdf_divmod10
divmod10_arg: res 1
divmod10_div: res 1
divmod10_mod: res 1

divmod10_ret: res 2

    .section text.bcdf_divmod10
divmod10:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(divmod10_ret)
    ldi ph, hi(divmod10_ret)
    st a
    mov a, 0
    inc pl
    adc ph, a
    st b

    ; div = 0
    ldi pl, lo(divmod10_div)
    ldi ph, hi(divmod10_div)
    st a

    ldi pl, lo(divmod10_arg)
    ldi ph, hi(divmod10_arg)
    ld b

    ; b = arg in this loop
divmod10_loop:
    ; arg -= 10
    ldi a, 10
    sub b, a
    ldi pl, lo(divmod10_finish)
    ldi ph, hi(divmod10_finish)
    jc

    ; div += 1
    ldi pl, lo(divmod10_div)
    ldi ph, hi(divmod10_div)
    ld a
    inc a
    st a

    ldi pl, lo(divmod10_loop)
    ldi ph, hi(divmod10_loop)
    jmp

divmod10_finish:
    add b, a ; b - mod
    ldi pl, lo(divmod10_mod)
    ldi ph, hi(divmod10_mod)
    st b

    ldi pl, lo(divmod10_ret)
    ldi ph, hi(divmod10_ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

