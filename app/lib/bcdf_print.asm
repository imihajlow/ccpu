    ; Output a BCDF number
    ; vga_console_print_bcdf_arg - the number must be copied there
    ; vga_console_print_bcdf_width - max characters to output
    .export vga_console_print_bcdf
    .export vga_console_print_bcdf_arg
    .export vga_console_print_bcdf_width

    .global vga_console_putchar
    .global vga_console_putchar_arg0

    .global divmod10
    .global divmod10_arg
    .global divmod10_div
    .global divmod10_mod

    .section bss.bcdf_print
    .align 16
vga_console_print_bcdf_arg: res 16
vga_console_print_bcdf_width: res 1
    .align 2
ret: res 2
tmp: res 1
tmp2: res 1
is_three_digits: res 1

    .section text.bcdf_print
vga_console_print_bcdf:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st a
    inc pl
    st b

    ; check if normal form fits
    ldi pl, lo(vga_console_print_bcdf_width)
    ldi ph, hi(vga_console_print_bcdf_width)
    ld b
    ldi pl, lo(vga_console_print_bcdf_arg + 0) ; sign
    ldi ph, hi(vga_console_print_bcdf_arg + 0)
    ld a
    add a, 0
    ldi pl, lo(vga_console_print_bcdf_check_pos)
    ldi ph, hi(vga_console_print_bcdf_check_pos)
    jz ; sign == 0
    dec b
vga_console_print_bcdf_check_pos:
    ; b = effective_width
    ldi pl, lo(vga_console_print_bcdf_arg + 1) ; exp
    ldi ph, hi(vga_console_print_bcdf_arg + 1)
    ld a
    ; a = exp
    add a, 0
    ldi pl, lo(vga_console_print_bcdf_check_pos_neg)
    ldi ph, hi(vga_console_print_bcdf_check_pos_neg)
    js ; exp < 0
    ; exp is >= 0
    sub a, b
    ldi pl, lo(vga_console_print_bcdf_e_form)
    ldi ph, hi(vga_console_print_bcdf_e_form)
    jns ; exp > effective_width
    jz ; exp == effective_width
    ldi pl, lo(vga_console_print_bcdf_nf)
    ldi ph, hi(vga_console_print_bcdf_nf)
    jmp
vga_console_print_bcdf_check_pos_neg:
    ; b = effective_width
    ; a = exp, a < 0
    dec a
    add a, b
    ldi pl, lo(vga_console_print_bcdf_e_form)
    ldi ph, hi(vga_console_print_bcdf_e_form)
    js ; exp - 1 + effective_width < 0
    jz ; exp - 1 + effective_width == 0

vga_console_print_bcdf_nf:
    ; display in normal form
    ; b = effective_width
    ldi pl, lo(vga_console_print_bcdf_arg + 0) ; sign
    ldi ph, hi(vga_console_print_bcdf_arg + 0)
    ld a
    add a, 0
    ldi pl, lo(vga_console_print_bcdf_nf_no_sign)
    ldi ph, hi(vga_console_print_bcdf_nf_no_sign)
    jz

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st b

    ldi a, ord('-')
    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st a
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld b

vga_console_print_bcdf_nf_no_sign:
    ; b = effective_width

    ; if exp is negative, start i from exp
    ; else start from 0
    ldi pl, lo(vga_console_print_bcdf_arg + 1) ; exp
    ldi ph, hi(vga_console_print_bcdf_arg + 1)
    ld a
    add a, 0
    ; a = exp
    ldi pl, lo(vga_console_print_bcdf_nf_i_ready)
    ldi ph, hi(vga_console_print_bcdf_nf_i_ready)
    js ; exp < 0
    mov a, 0
vga_console_print_bcdf_nf_i_ready:
    ; a = i
    ; b = effective_width
    ldi pl, lo(tmp2)
    ldi ph, hi(tmp2)
    st b
vga_console_print_bcdf_nf_loop:
    ; a = i

    ; if i == exp + 1 display '.'
    ldi pl, lo(vga_console_print_bcdf_arg + 1) ; exp
    ldi ph, hi(vga_console_print_bcdf_arg + 1)
    ld b
    inc b
    sub b, a
    ldi pl, lo(vga_console_print_bcdf_nf_loop_no_dot)
    ldi ph, hi(vga_console_print_bcdf_nf_loop_no_dot)
    jnz ; exp + 1 - i != 0

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st a

    ldi b, ord('.')
    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st b
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a

    ldi pl, lo(vga_console_print_bcdf_nf_loop_end)
    ldi ph, hi(vga_console_print_bcdf_nf_loop_end)
    jmp

vga_console_print_bcdf_nf_loop_no_dot:
    ; a = i
    ; flags = exp + 1 - i (nz)
    mov b, a
    ldi pl, lo(vga_console_print_bcdf_nf_loop_before_dot)
    ldi ph, hi(vga_console_print_bcdf_nf_loop_before_dot)
    jns ; exp + 1 - i > 0
    dec a
vga_console_print_bcdf_nf_loop_before_dot:
    ; b = i
    ; a = j

    ; if j < 0 or j >= 14 display '0'
    ldi pl, 14
    sub pl, a
    ldi pl, lo(vga_console_print_bcdf_nf_loop_zero)
    ldi ph, hi(vga_console_print_bcdf_nf_loop_zero)
    js ; 14 < j
    jz ; 14 == j
    add a, 0
    js ; j < 0

    ; display man[j]
    ldi ph, hi(vga_console_print_bcdf_arg)
    ldi pl, lo(vga_console_print_bcdf_arg + 2) ; mantissa
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

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st a

    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st b
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a


    ldi pl, lo(vga_console_print_bcdf_nf_loop_end)
    ldi ph, hi(vga_console_print_bcdf_nf_loop_end)
    jmp

vga_console_print_bcdf_nf_loop_zero:
    ; b = i
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st b

    ldi b, ord('0')
    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st b
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a

vga_console_print_bcdf_nf_loop_end:
    ; i += 1
    inc a
    ; tmp2 -= 1
    ldi pl, lo(tmp2)
    ldi ph, hi(tmp2)
    ld b
    dec b
    st b
    ldi pl, lo(vga_console_print_bcdf_nf_loop)
    ldi ph, hi(vga_console_print_bcdf_nf_loop)
    jnz ; tmp2 != 0

    ; end of normal form display
finish: ; a common return label
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

vga_console_print_bcdf_e_form:
    ; display in e-form
    ; compute width reduction
    ldi pl, lo(vga_console_print_bcdf_width)
    ldi ph, hi(vga_console_print_bcdf_width)
    ld b
    dec b ; e
    dec b ; exp sign
    dec b ; one exp digit
    dec b ; one mantissa digit
    ldi pl, lo(vga_console_print_bcdf_arg + 0) ; sign
    ldi ph, hi(vga_console_print_bcdf_arg + 0)
    ld a
    add a, 0
    ldi pl, lo(vga_console_print_bcdf_positive)
    ldi ph, hi(vga_console_print_bcdf_positive)
    jz
    ; negative - output minus
    dec b ; mantissa sign
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st b

    ldi a, ord('-')
    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st a
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld b
vga_console_print_bcdf_positive:
    ldi pl, lo(vga_console_print_bcdf_arg + 1) ; exp
    ldi ph, hi(vga_console_print_bcdf_arg + 1)
    ld a
    add a, 0
    ldi pl, lo(vga_console_print_bcdf_exp_positive)
    ldi ph, hi(vga_console_print_bcdf_exp_positive)
    jns
    ; exp < 0
    neg a
vga_console_print_bcdf_exp_positive:
    ldi pl, 10
    sub a, pl
    ldi pl, lo(vga_console_print_bcdf_exp_length_done)
    ldi ph, hi(vga_console_print_bcdf_exp_length_done)
    js ; a < 10
    ; exp >= 10
    ; a = exp - 10
    dec b ; second exp digit
    ldi pl, 90
    sub a, pl ; exp - 100
    ldi pl, lo(vga_console_print_bcdf_exp_length_done)
    js ; exp < 100
    ; exp >= 100
    dec b ; third exp digit
vga_console_print_bcdf_exp_length_done:
    ; b = width (non-mandatory)

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st b

    ; always output first digit
    ldi pl, lo(vga_console_print_bcdf_arg + 2) ; man
    ldi ph, hi(vga_console_print_bcdf_arg + 2)
    ld a
    ldi pl, ord('0')
    add a, pl
    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st a
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp

    ; tmp = width
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a
    add a, 0
    ; done if width == 0
    ldi pl, lo(vga_console_print_bcdf_exp)
    ldi ph, hi(vga_console_print_bcdf_exp)
    jz

    ldi a, ord('.')
    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st a
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld b
    dec b

    mov a, b
    add a, 0
    ldi pl, lo(vga_console_print_bcdf_exp)
    ldi ph, hi(vga_console_print_bcdf_exp)
    jz
    ldi a, lo(vga_console_print_bcdf_arg + 2 + 1) ; mantissa second digit
vga_console_print_bcdf_loop:
    ; a = man_index
    ; b = remaining_width
    ldi pl, lo(tmp2)
    ldi ph, hi(tmp2)
    st b

    ldi ph, hi(vga_console_print_bcdf_arg)
    mov pl, a
    ld b
    ; b = digit
    ldi a, ord('0')
    add b, a
    mov a, pl
    ; b = char, a = man_index
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st a
    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st b
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a

    ldi pl, lo(tmp2)
    ldi ph, hi(tmp2)
    ld b
    inc a
    dec b
    ldi pl, lo(vga_console_print_bcdf_loop)
    ldi ph, hi(vga_console_print_bcdf_loop)
    jnz

vga_console_print_bcdf_exp:
    ldi pl, lo(is_three_digits)
    ldi ph, hi(is_three_digits)
    mov a, 0
    st a

    ; e
    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    ldi a, ord('e')
    st a
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp
    ; sign
    ldi b, ord('+')
    ldi pl, lo(vga_console_print_bcdf_arg + 1) ; exp
    ldi ph, hi(vga_console_print_bcdf_arg + 1)
    ld a
    add a, 0
    ldi pl, lo(vga_console_print_bcdf_exp_value)
    ldi ph, hi(vga_console_print_bcdf_exp_value)
    jns
    neg a
    ldi b, ord('-')
vga_console_print_bcdf_exp_value:
    ; a = abs(exp)
    ; b = sign char
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st a

    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st b
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a
    ldi b, 100
    sub a, b
    ldi pl, lo(vga_console_print_bcdf_exp_lt_100)
    ldi ph, hi(vga_console_print_bcdf_exp_lt_100)
    js

    ; abs(exp) >= 100
    ; a = abs(exp) - 100
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    st a

    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    ldi b, ord('1')
    st b
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a
    ldi pl, lo(is_three_digits)
    ldi ph, hi(is_three_digits)
    ldi b, 0xff
    st b

    sub a, b ; neutralize the next addition
vga_console_print_bcdf_exp_lt_100:
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
    ldi pl, lo(vga_console_print_bcdf_exp_dig2)
    ldi ph, hi(vga_console_print_bcdf_exp_dig2)
    jnz

    ; two or one digit
    ldi pl, lo(divmod10_div)
    ldi ph, hi(divmod10_div)
    ld a
    add a, 0
    ldi pl, lo(vga_console_print_bcdf_exp_dig1)
    ldi ph, hi(vga_console_print_bcdf_exp_dig1)
    jz
vga_console_print_bcdf_exp_dig2:
    ldi pl, lo(divmod10_div)
    ldi ph, hi(divmod10_div)
    ld a
    ldi b, ord('0')
    add a, b
    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st a
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp
vga_console_print_bcdf_exp_dig1:
    ldi pl, lo(divmod10_mod)
    ldi ph, hi(divmod10_mod)
    ld a
    ldi b, ord('0')
    add a, b
    ldi pl, lo(vga_console_putchar_arg0)
    ldi ph, hi(vga_console_putchar_arg0)
    st a
    ldi pl, lo(vga_console_putchar)
    ldi ph, hi(vga_console_putchar)
    jmp

    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp
