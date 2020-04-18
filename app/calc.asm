.global display_init
.global display_print
.global display_print_byte
.global display_print_arg
.global display_set_address
.global display_set_address_arg
.global keyboard_wait_key_released
.global keyboard_wait_key_released_result

.global key_ent
.global key_right
.global key_0
.global key_left
.global key_esc
.global key_9
.global key_8
.global key_7
.global key_down
.global key_6
.global key_5
.global key_4
.global key_up
.global key_3
.global key_2
.global key_1
.global key_star
.global key_hash
.global key_f2
.global key_f1

.global keyboard_key_digit_map

.section text
    nop

    ldi pl, lo(display_init)
    ldi ph, hi(display_init)
    jmp

    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    ldi a, lo(hello_string)
    st a
    mov a, 0
    inc pl
    adc ph, a
    ldi a, hi(hello_string)
    st a
    ldi pl, lo(display_print)
    ldi ph, hi(display_print)
    jmp

    ldi pl, lo(display_set_address_arg)
    ldi ph, hi(display_set_address_arg)
    ldi a, 0x40 ; second line, first character
    st a

    ldi pl, lo(number_string + 16)
    ldi ph, hi(number_string + 16)
    mov a, 0
    st a
init:
    mov a, 0
    ldi pl, lo(number_input_position)
    ldi ph, hi(number_input_position)
    st a

    ldi pl, lo(is_dot_entered)
    ldi ph, hi(is_dot_entered)
    st a

    ldi b, 15
init_number_loop:
    ldi pl, lo(bcdf_a)
    ldi ph, hi(bcdf_a)
    mov a, b
    add pl, a
    mov a, 0
    st a
    dec b
    ldi pl, lo(init_number_loop)
    ldi ph, hi(init_number_loop)
    jnc

    ldi pl, lo(bcdf_a + 1) ; exp
    ldi ph, hi(bcdf_a + 1)
    ldi a, -1
    st a

sign_input:
    ldi pl, lo(display_entered_number)
    ldi ph, hi(display_entered_number)
    jmp

    ldi pl, lo(keyboard_wait_key_released)
    ldi ph, hi(keyboard_wait_key_released)
    jmp

    ldi pl, lo(keyboard_wait_key_released_result)
    ldi ph, hi(keyboard_wait_key_released_result)
    ld a

    ldi b, key_star ; minus
    sub b, a
    ldi pl, lo(sign_toggle)
    ldi ph, hi(sign_toggle)
    jz

    ldi b, key_right ; dot
    sub b, a
    ldi pl, lo(dot_entered)
    ldi ph, hi(dot_entered)
    jz

    ldi pl, lo(keyboard_key_digit_map)
    ldi ph, hi(keyboard_key_digit_map)
    add pl, a
    ld a ; a - digit or 0xff
    add a, 0
    ldi pl, lo(sign_input)
    ldi ph, hi(sign_input)
    js ; anything but digit is pressed - ignore
    jz ; zero is pressed - ignore
    ; else digit is entered
    ldi pl, lo(digit_entered)
    ldi ph, hi(digit_entered)
    jmp

sign_toggle:
    ldi pl, lo(bcdf_a + 0) ; sign
    ldi ph, hi(bcdf_a + 0)
    ld a
    not a
    st a
    ldi pl, lo(sign_input)
    ldi ph, hi(sign_input)
    jmp

digit_input:
    ldi pl, lo(display_entered_number)
    ldi ph, hi(display_entered_number)
    jmp

    ldi pl, lo(number_input_position)
    ldi ph, hi(number_input_position)
    ld b
    ; b = number_input_position
    ldi a, 14
    sub a, b
    ldi pl, lo(input_finish)
    ldi ph, hi(input_finish)
    jz

digit_input_retry:
    ldi pl, lo(keyboard_wait_key_released)
    ldi ph, hi(keyboard_wait_key_released)
    jmp

    ldi pl, lo(keyboard_wait_key_released_result)
    ldi ph, hi(keyboard_wait_key_released_result)
    ld a

    ; a = keycode

    ldi b, key_right ; dot
    sub b, a
    ldi pl, lo(dot_entered)
    ldi ph, hi(dot_entered)
    jz

    ldi pl, lo(keyboard_key_digit_map)
    ldi ph, hi(keyboard_key_digit_map)
    add pl, a
    ld a ; a - digit or 0xff
    add a, 0
    ldi pl, lo(digit_entered)
    ldi ph, hi(digit_entered)
    jns

    ldi pl, lo(digit_input_retry)
    ldi ph, hi(digit_input_retry)
    jmp

digit_entered:
    ; a - digit
    mov b, a
    ldi pl, lo(number_input_position)
    ldi ph, hi(number_input_position)
    ld a
    inc a
    st a
    ; b = digit, a = index + 1
    ldi pl, lo(bcdf_a + 2 - 1) ; mantissa offset - 1 (since index is already incremented)
    add pl, a ; no overflow because of alignment
    ldi ph, hi(bcdf_a)
    st b
    mov b, a ; b = new index
    ; if dot has been entered jump to digit input
    ldi pl, lo(is_dot_entered)
    ldi ph, hi(is_dot_entered)
    ld a
    add a, 0
    ldi pl, lo(digit_input)
    ldi ph, hi(digit_input)
    jnz

    ; else increment exp part
    ldi pl, lo(bcdf_a + 1) ; exp offset
    ldi ph, hi(bcdf_a + 1)
    ld a
    inc a
    st a

    ldi pl, lo(digit_input)
    ldi ph, hi(digit_input)
    jmp

dot_entered:
    ldi pl, lo(is_dot_entered)
    ldi ph, hi(is_dot_entered)
    ldi a, 0xff
    st a
    ldi pl, lo(digit_input)
    ldi ph, hi(digit_input)
    jmp

input_finish:
    ldi pl, lo(init)
    ldi ph, hi(init)
    jmp




display_entered_number:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(bcdf_a + 0) ; sign
    ldi ph, hi(bcdf_a + 0)
    ld a
    ldi b, 2
    and a, b
    ldi b, ord('+')
    ; b = '+', a = 2 if sign else 0
    add b, a ; ord('-') == ord('+') + 2
    ldi pl, lo(number_string + 0)
    ldi ph, hi(number_string + 0)
    st b

    ldi b, 0
display_entered_number_loop:
    ; b - index (0..14)
    ;
    ; if b == exp + 1:
    ;   s[b] = '.'
    ; elif b < exp + 1:
    ;   s[b] = man[b] + ord('0')
    ; else:
    ;   if b > number_input_position:
    ;     s[b] = ' '
    ;   else:
    ;     s[b] = man[b - 1] + ord('0')

    ldi pl, lo(bcdf_a + 1) ; exp
    ldi ph, hi(bcdf_a + 1)
    ld a
    inc a
    sub a, b ; a = exp + 1 - b
    ldi pl, lo(display_entered_number_loop_b_eq_exp1)
    ldi ph, hi(display_entered_number_loop_b_eq_exp1)
    jz
    ldi pl, lo(display_entered_number_loop_b_lt_exp1)
    ldi ph, hi(display_entered_number_loop_b_lt_exp1)
    jns

    ; b > exp + 1
    ldi pl, lo(number_input_position)
    ldi ph, hi(number_input_position)
    ld a
    sub a, b ; number_input_position - b
    ldi pl, lo(display_entered_number_loop_b_gt_nip)
    ldi ph, hi(display_entered_number_loop_b_gt_nip)
    js
    ; b <= number_input_position
    ldi pl, lo(bcdf_a + 2 - 1) ; man
    mov a, b
    add pl, a
    ldi ph, hi(bcdf_a)
    ld a
    ; a - digit, b - index
    ldi pl, lo(display_entered_number_put_digit)
    ldi ph, hi(display_entered_number_put_digit)
    jmp

display_entered_number_loop_b_gt_nip:
    ; b > number_input_position
    ldi pl, lo(number_string + 1)
    ldi ph, hi(number_string)
    mov a, b
    add pl, a
    ldi a, ord(' ')
    st a
    ldi pl, lo(display_entered_number_loop_end)
    ldi ph, hi(display_entered_number_loop_end)
    jmp

display_entered_number_loop_b_eq_exp1:
    ; b == exp + 1
    ldi pl, lo(number_string + 1)
    mov a, b
    add pl, a
    ldi ph, hi(number_string)
    ldi a, ord('.')
    st a
    ldi pl, lo(display_entered_number_loop_end)
    ldi ph, hi(display_entered_number_loop_end)
    jmp

display_entered_number_loop_b_lt_exp1:
    ; b < exp + 1
    ldi pl, lo(bcdf_a + 2) ; man
    mov a, b
    add pl, a
    ldi ph, hi(bcdf_a)
    ld a
display_entered_number_put_digit:
    ; a - digit, b - index
    mov pl, a
    ldi a, ord('0')
    add a, pl
    ; a - char, b - index
    xor a, b
    xor b, a
    xor a, b
    ; b - char, a - index
    ldi pl, lo(number_string + 1)
    add pl, a
    ldi ph, hi(number_string)
    st b
    mov b, a

display_entered_number_loop_end:
    inc b
    ldi a, 15
    sub a, b
    ldi pl, lo(display_entered_number_loop)
    ldi ph, hi(display_entered_number_loop)
    jnz

display_entered_number_end:
    ldi pl, lo(display_set_address)
    ldi ph, hi(display_set_address)
    jmp

    ldi a, lo(number_string)
    ldi b, hi(number_string)
    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    st a
    inc pl
    st b
    ldi pl, lo(display_print)
    ldi ph, hi(display_print)
    jmp

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    mov b, a
    inc pl
    ld a
    mov ph, a
    mov a, b
    mov pl, a
    jmp


hello_string:
    ascii "Hello, world"
    db 0

    .section data
    .align 16
number_string: res 17
tmp: res 1
    .align 16 ; guarantees no ph overflow when indexing bcdf_a
bcdf_a: res 16
number_input_position: res 1
is_dot_entered: res 1
    .align 2
ret: res 2

