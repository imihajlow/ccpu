	; Binary-coded decimal float
	; Coding:
	; Byte 0: exponent (signed)
	; Byte 1: sign (0x00 - positive, 0xff - negative)
	; Bytes 2-15: mantissa decimal digits

.const sign = 0
.const exponent = 1
.const mantissa = 2

	; bcdf_sum - sum two bcdf numbers
	; arguments: bcdf_sum_a, bcdf_sum_b
	; result: bcdf_sum_r
	.export bcdf_sum
	.export bcdf_sum_a
	.export bcdf_sum_b
	.export bcdf_sum_r

	.section data
bcdf_sum_a: res 16
bcdf_sum_b: res 16
bcdf_sum_r: res 16
bcdf_sum_ret: res 2

	.section text
bcdf_sum:
	mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(bcdf_sum_ret)
    ldi ph, hi(bcdf_sum_ret)
    st a
    mov a, 0
    inc pl
    adc ph, a
    st b

    ldi pl, lo(bcdf_sum_a + sign)
    ldi ph, hi(bcdf_sum_a + sign)
    ldi a

    ldi pl, lo(bcdf_sum_ret)
    ldi ph, hi(bcdf_sum_ret)
    ld b
    mov a, 0
    inc pl
    adc ph, a
    ld a
    mov ph, a
    mov a, b
    mov pl, a
	jmp



	; divmod10 - divide by 10
	; argument: divmod10_arg (byte)
	; result: divmod10_div (byte), divmod10_mod (byte)
	.section data
divmod10_arg: res 1
divmod10_div: res 1
divmod10_mod: res 1

divmod10_ret: res 2

	.section text
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
    ld b
    mov a, 0
    inc pl
    adc ph, a
    ld a
    mov ph, a
    mov a, b
    mov pl, a
	jmp

