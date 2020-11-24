    ; Init the display module. No arguments.
    .export display_init
    .export display_init_ret

    ; Clear display. No arguments.
    .export display_clear
    .export display_clear_ret

    ; Output a null-terminated string
    ; display_print_arg - string address
    .export display_print
    .export display_print_arg0
    .export display_print_ret

    ; Output a byte as a hex number
    ; display_print_arg - the byte
    .export display_print_byte
    .export display_print_byte_arg0
    .export display_print_byte_ret

    ; Set display address.
    ; display_set_address_arg - raw address, like in the datasheet.
    .export display_set_address
    .export display_set_address_arg0
    .export display_set_address_ret

    ; Output a BCDF number
    ; display_print_bcdf_arg - the number must be copied there
    ; display_print_bcdf_width - max characters to output
    .export display_print_bcdf

    ; Output a character
    ; display_print_arg - the character
    .export display_print_char
    .export display_print_char_arg0
    .export display_print_char_ret

    ; Load data into CGRAM, then sets the DDRAM address 0
    .export display_load_cg_ram
    .export display_load_cg_ram_arg0 ; data address
    .export display_load_cg_ram_arg1 ; CGRAM address
    .export display_load_cg_ram_arg2 ; data count (1-64)
    .export display_load_cg_ram_ret

    .export display_print_arg
    .export display_set_address_arg
    .export display_print_bcdf_arg
    .export display_print_bcdf_width

    .global divmod10
    .global divmod10_arg
    .global divmod10_div
    .global divmod10_mod

    .global delay_60us
    .global delay_5ms
    .global delay_100ms

    .const lcd_control = 0xf002
    .const lcd_data = 0xf003

    .section bss

    .align 2
display_return: res 2

display_init_ret:
display_clear_ret:
display_print_byte_ret:
display_print_byte_arg0:
display_print_arg0:
display_print_ret:
display_print_char_arg0:
display_print_char_ret:
display_load_cg_ram_arg0:
display_load_cg_ram_ret:
display_print_arg: res 2
display_set_address_ret:
display_set_address_arg0:
display_set_address_arg: res 1
display_load_cg_ram_arg1: res 1
display_load_cg_ram_arg2: res 1

.section text

display_init:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl
    st b

    ldi pl, lo(delay_100ms)
    ldi ph, hi(delay_100ms)
    jmp

    ldi pl, lo(lcd_control)
    ldi ph, hi(lcd_control)
    ldi a, 0x38 ; function set
    st a
    ldi pl, lo(delay_5ms)
    ldi ph, hi(delay_5ms)
    jmp

    ldi pl, lo(lcd_control)
    ldi ph, hi(lcd_control)
    ldi a, 0x0C ; display on
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(lcd_control)
    ldi ph, hi(lcd_control)
    ldi a, 0x01 ; clear
    st a
    ldi pl, lo(delay_5ms)
    ldi ph, hi(delay_5ms)
    jmp

    ldi pl, lo(lcd_control)
    ldi ph, hi(lcd_control)
    ldi a, 0x06 ; entry mode set
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

display_finish: ; a common return label
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

display_clear:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl
    st b

    ldi pl, lo(lcd_control)
    ldi ph, hi(lcd_control)
    ldi a, 0x01 ; clear
    st a
    ldi pl, lo(delay_5ms)
    ldi ph, hi(delay_5ms)
    jmp

    ldi pl, lo(display_finish)
    ldi ph, hi(display_finish)
    jmp


display_print_char:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl
    st b

    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    ld a
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(display_finish)
    ldi ph, hi(display_finish)
    jmp

; display_print_arg - string address
display_print:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl
    st b

display_print_loop:
    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    mov a, 0
    ld b
    inc pl
    adc ph, a
    ld a
    mov ph, a
    mov a, b
    mov pl, a
    ; P - char address
    ld a
    add a, 0
    ldi pl, lo(display_finish)
    ldi ph, hi(display_finish)
    jz

    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    ld a
    inc a
    st a
    ldi pl, lo(display_print_loop)
    ldi ph, hi(display_print_loop)
    jnc

    ldi pl, lo(display_print_arg + 1)
    ldi ph, hi(display_print_arg + 1)
    ld a
    inc a
    st a
    ldi pl, lo(display_print_loop)
    ldi ph, hi(display_print_loop)
    jmp

display_print_byte:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl
    mov a, 0
    adc ph, a
    st b

    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    ld a
    shr a
    shr a
    shr a
    shr a
    ldi pl, lo(hex_map)
    add pl, a
    mov a, 0
    ldi ph, hi(hex_map)
    adc ph, a
    ld b
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st b
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    ld a
    ldi b, 0x0f
    and a, b
    ldi pl, lo(hex_map)
    add pl, a
    mov a, 0
    ldi ph, hi(hex_map)
    adc ph, a
    ld b
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st b
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(display_finish)
    ldi ph, hi(display_finish)
    jmp

display_set_address:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl
    st b

display_set_address_begin:
    ldi pl, lo(display_set_address_arg)
    ldi ph, hi(display_set_address_arg)
    ld a
    ldi b, 0x80
    or a, b
    ldi pl, lo(lcd_control)
    ldi ph, hi(lcd_control)
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(display_finish)
    ldi ph, hi(display_finish)
    jmp

    .section data
    .align 16
display_print_bcdf_arg: res 16
display_print_bcdf_width: res 1

    .section text
display_print_bcdf:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl
    st b

    ; check if normal form fits
    ldi pl, lo(display_print_bcdf_width)
    ldi ph, hi(display_print_bcdf_width)
    ld b
    ldi pl, lo(display_print_bcdf_arg + 0) ; sign
    ldi ph, hi(display_print_bcdf_arg + 0)
    ld a
    add a, 0
    ldi pl, lo(display_print_bcdf_check_pos)
    ldi ph, hi(display_print_bcdf_check_pos)
    jz ; sign == 0
    dec b
display_print_bcdf_check_pos:
    ; b = effective_width
    ldi pl, lo(display_print_bcdf_arg + 1) ; exp
    ldi ph, hi(display_print_bcdf_arg + 1)
    ld a
    ; a = exp
    add a, 0
    ldi pl, lo(display_print_bcdf_check_pos_neg)
    ldi ph, hi(display_print_bcdf_check_pos_neg)
    js ; exp < 0
    ; exp is >= 0
    sub a, b
    ldi pl, lo(display_print_bcdf_e_form)
    ldi ph, hi(display_print_bcdf_e_form)
    jns ; exp > effective_width
    jz ; exp == effective_width
    ldi pl, lo(display_print_bcdf_nf)
    ldi ph, hi(display_print_bcdf_nf)
    jmp
display_print_bcdf_check_pos_neg:
    ; b = effective_width
    ; a = exp, a < 0
    dec a
    add a, b
    ldi pl, lo(display_print_bcdf_e_form)
    ldi ph, hi(display_print_bcdf_e_form)
    js ; exp - 1 + effective_width < 0
    jz ; exp - 1 + effective_width == 0

display_print_bcdf_nf:
    ; display in normal form
    ; b = effective_width
    ldi pl, lo(display_print_bcdf_arg + 0) ; sign
    ldi ph, hi(display_print_bcdf_arg + 0)
    ld a
    add a, 0
    ldi pl, lo(display_print_bcdf_nf_no_sign)
    ldi ph, hi(display_print_bcdf_nf_no_sign)
    jz

    ldi a, ord('-')
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

display_print_bcdf_nf_no_sign:
    ; b = effective_width

    ; if exp is negative, start i from exp
    ; else start from 0
    ldi pl, lo(display_print_bcdf_arg + 1) ; exp
    ldi ph, hi(display_print_bcdf_arg + 1)
    ld a
    add a, 0
    ; a = exp
    ldi pl, lo(display_print_bcdf_nf_i_ready)
    ldi ph, hi(display_print_bcdf_nf_i_ready)
    js ; exp < 0
    mov a, 0
display_print_bcdf_nf_i_ready:
    ; a = i
    ; b = effective_width
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st b
display_print_bcdf_nf_loop:
    ; a = i

    ; if i == exp + 1 display '.'
    ldi pl, lo(display_print_bcdf_arg + 1) ; exp
    ldi ph, hi(display_print_bcdf_arg + 1)
    ld b
    inc b
    sub b, a
    ldi pl, lo(display_print_bcdf_nf_loop_no_dot)
    ldi ph, hi(display_print_bcdf_nf_loop_no_dot)
    jnz ; exp + 1 - i != 0

    ldi b, ord('.')
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st b
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(display_print_bcdf_nf_loop_end)
    ldi ph, hi(display_print_bcdf_nf_loop_end)
    jmp

display_print_bcdf_nf_loop_no_dot:
    ; a = i
    ; flags = exp + 1 - i (nz)
    mov b, a
    ldi pl, lo(display_print_bcdf_nf_loop_before_dot)
    ldi ph, hi(display_print_bcdf_nf_loop_before_dot)
    jns ; exp + 1 - i > 0
    dec a
display_print_bcdf_nf_loop_before_dot:
    ; b = i
    ; a = j

    ; if j < 0 or j >= 14 display '0'
    ldi pl, 14
    sub pl, a
    ldi pl, lo(display_print_bcdf_nf_loop_zero)
    ldi ph, hi(display_print_bcdf_nf_loop_zero)
    js ; 14 < j
    jz ; 14 == j
    add a, 0
    js ; j < 0

    ; display man[j]
    ldi ph, hi(display_print_bcdf_arg)
    ldi pl, lo(display_print_bcdf_arg + 2) ; mantissa
    add pl, a
    mov a, b
    ld b
    ; b - digit
    ; a = i
    mov pl, a
    ldi a, ord('0')
    add b, a
    ; b - char
    mov a, pl

    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st b
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(display_print_bcdf_nf_loop_end)
    ldi ph, hi(display_print_bcdf_nf_loop_end)
    jmp

display_print_bcdf_nf_loop_zero:
    ; b = i
    mov a, b
    ldi b, ord('0')
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st b
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

display_print_bcdf_nf_loop_end:
    ; i += 1
    inc a
    ; tmp -= 1
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld b
    dec b
    st b
    ldi pl, lo(display_print_bcdf_nf_loop)
    ldi ph, hi(display_print_bcdf_nf_loop)
    jnz ; tmp != 0

    ; end of normal form display
    ldi pl, lo(display_finish)
    ldi ph, hi(display_finish)
    jmp

display_print_bcdf_e_form:
    ; display in e-form
    ; compute width reduction
    ldi pl, lo(display_print_bcdf_width)
    ldi ph, hi(display_print_bcdf_width)
    ld b
    dec b ; e
    dec b ; exp sign
    dec b ; one exp digit
    dec b ; one mantissa digit
    ldi pl, lo(display_print_bcdf_arg + 0) ; sign
    ldi ph, hi(display_print_bcdf_arg + 0)
    ld a
    add a, 0
    ldi pl, lo(display_print_bcdf_positive)
    ldi ph, hi(display_print_bcdf_positive)
    jz
    ; negative - output minus
    dec b ; mantissa sign
    ldi a, ord('-')
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st a
    ldi pl, lo(delay_60us) ; this doesn't modify a and b
    ldi ph, hi(delay_60us)
    jmp
display_print_bcdf_positive:
    ldi pl, lo(display_print_bcdf_arg + 1) ; exp
    ldi ph, hi(display_print_bcdf_arg + 1)
    ld a
    add a, 0
    ldi pl, lo(display_print_bcdf_exp_positive)
    ldi ph, hi(display_print_bcdf_exp_positive)
    jns
    ; exp < 0
    neg a
display_print_bcdf_exp_positive:
    ldi pl, 10
    sub a, pl
    ldi pl, lo(display_print_bcdf_exp_length_done)
    ldi ph, hi(display_print_bcdf_exp_length_done)
    js ; a < 10
    ; exp >= 10
    ; a = exp - 10
    dec b ; second exp digit
    ldi pl, 90
    sub a, pl ; exp - 100
    ldi pl, lo(display_print_bcdf_exp_length_done)
    js ; exp < 100
    ; exp >= 100
    dec b ; third exp digit
display_print_bcdf_exp_length_done:
    ; b = width (non-mandatory)

    ; always output first digit
    ldi pl, lo(display_print_bcdf_arg + 2) ; man
    ldi ph, hi(display_print_bcdf_arg + 2)
    ld a
    ldi pl, ord('0')
    add a, pl
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ; b = width
    mov a, b
    add a, 0
    ; done if width == 0
    ldi pl, lo(display_print_bcdf_exp)
    ldi ph, hi(display_print_bcdf_exp)
    jz

    ldi a, ord('.')
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    dec b

    mov a, b
    add a, 0
    ldi pl, lo(display_print_bcdf_exp)
    ldi ph, hi(display_print_bcdf_exp)
    jz
    ldi a, lo(display_print_bcdf_arg + 2 + 1) ; mantissa second digit
display_print_bcdf_loop:
    ; a = man_index
    ; b = remaining_width
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st b

    ldi ph, hi(display_print_bcdf_arg)
    mov pl, a
    ld b
    ; b = digit
    ldi a, ord('0')
    add b, a
    mov a, pl
    ; b = char, a = man_index
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st b
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld b
    inc a
    dec b
    ldi pl, lo(display_print_bcdf_loop)
    ldi ph, hi(display_print_bcdf_loop)
    jnz

display_print_bcdf_exp:
    ldi pl, lo(is_three_digits)
    ldi ph, hi(is_three_digits)
    mov a, 0
    st a

    ; e
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    ldi a, ord('e')
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp
    ; sign
    ldi b, ord('+')
    ldi pl, lo(display_print_bcdf_arg + 1) ; exp
    ldi ph, hi(display_print_bcdf_arg + 1)
    ld a
    add a, 0
    ldi pl, lo(display_print_bcdf_exp_value)
    ldi ph, hi(display_print_bcdf_exp_value)
    jns
    neg a
    ldi b, ord('-')
display_print_bcdf_exp_value:
    ; a = abs(exp)
    ; b = sign char
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st b
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi b, 100
    sub a, b
    ldi pl, lo(display_print_bcdf_exp_lt_100)
    ldi ph, hi(display_print_bcdf_exp_lt_100)
    js

    ; abs(exp) >= 100
    ; a = abs(exp) - 100
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    ldi b, ord('1')
    st b
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(is_three_digits)
    ldi ph, hi(is_three_digits)
    ldi b, 0xff
    st b

    sub a, b ; neutralize the next addition
display_print_bcdf_exp_lt_100:
    add a, b
    ; a = abs(exp) % 100

    ldi pl, lo(divmod10_arg)
    ldi ph, hi(divmod10_arg)
    st a
    ldi pl, lo(divmod10)
    ldi ph, hi(divmod10)
    jmp

    ; if is_three_digits display second digit
    ldi pl, lo(is_three_digits)
    ldi ph, hi(is_three_digits)
    ld a
    add a, 0
    ldi pl, lo(display_print_bcdf_exp_dig2)
    ldi ph, hi(display_print_bcdf_exp_dig2)
    jnz

    ; two or one digit
    ldi pl, lo(divmod10_div)
    ldi ph, hi(divmod10_div)
    ld a
    add a, 0
    ldi pl, lo(display_print_bcdf_exp_dig1)
    ldi ph, hi(display_print_bcdf_exp_dig1)
    jz
display_print_bcdf_exp_dig2:
    ldi pl, lo(divmod10_div)
    ldi ph, hi(divmod10_div)
    ld a
    ldi b, ord('0')
    add a, b
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp
display_print_bcdf_exp_dig1:
    ldi pl, lo(divmod10_mod)
    ldi ph, hi(divmod10_mod)
    ld a
    ldi b, ord('0')
    add a, b
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st a
    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

    ldi pl, lo(display_finish)
    ldi ph, hi(display_finish)
    jmp

    ; arg0 = display_print_arg - data address
    ; arg1 = CGRAM address
    ; arg2 = count
display_load_cg_ram:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl
    st b

    ldi pl, lo(display_load_cg_ram_arg1)
    ldi ph, hi(display_load_cg_ram_arg1)
    ld a
    ldi b, 0x40
    or a, b
    ldi pl, lo(lcd_control)
    ldi ph, hi(lcd_control)
    st a

    ldi pl, lo(delay_60us)
    ldi ph, hi(delay_60us)
    jmp

display_load_cg_ram_loop:
    ; load next byte
    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    ld a
    inc pl
    ld ph
    mov pl, a
    ld a

    ; send it out
    ldi pl, lo(lcd_data)
    ldi ph, hi(lcd_data)
    st a
    ; the whole loop provides >60us delay

    ; increment the pointer
    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    ld b
    inc pl
    ld a
    inc b
    adc a, 0
    st a
    dec pl
    st b

    ; count -= 1
    ldi pl, lo(display_load_cg_ram_arg2)
    ldi ph, hi(display_load_cg_ram_arg2)
    ld b
    dec b
    st b
    ldi pl, lo(display_load_cg_ram_loop)
    ldi ph, hi(display_load_cg_ram_loop)
    jnz ; count != 0

    ; b = 0 here
    ldi pl, lo(display_set_address_arg)
    ldi ph, hi(display_set_address_arg)
    st b
    ldi pl, lo(display_set_address_begin)
    ldi ph, hi(display_set_address_begin)
    jmp

    .section bss
is_three_digits: res 1
tmp: res 1

    .section text
    .align 16
hex_map:
    ascii '0123456789ABCDEF'
