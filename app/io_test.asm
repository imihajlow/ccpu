.global display_init
.global display_print
.global display_print_byte
.global display_print_arg
.global display_set_address
.global display_set_address_arg
.global keyboard_wait_key_released
.global keyboard_wait_key_released_result

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

loop:
    ldi pl, lo(keyboard_wait_key_released)
    ldi ph, hi(keyboard_wait_key_released)
    jmp

    ldi pl, lo(display_set_address)
    ldi ph, hi(display_set_address)
    jmp
    ldi pl, lo(keyboard_wait_key_released_result)
    ldi ph, hi(keyboard_wait_key_released_result)
    ld a
    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    st a
    ldi pl, lo(display_print_byte)
    ldi ph, hi(display_print_byte)
    jmp

    ldi pl, lo(loop)
    ldi ph, hi(loop)
    jmp

hello_string:
    ascii "Hello, world"
    db 0

.section data
number_string: res 5
tmp: res 1

