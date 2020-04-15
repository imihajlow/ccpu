.global display_init
.global display_print
.global display_print_arg
.global display_set_address
.global display_set_address_arg

.const keyboard = 0xf000
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

    ldi pl, lo(number_string + 2)
    ldi ph, hi(number_string + 2)
    ldi a, 0x20 ; ' '
    st a

    ldi pl, lo(number_string + 4)
    ldi ph, hi(number_string + 4)
    mov a, 0
    st a
scan:
    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ldi a, 0xfe
    st a
    ld b
    inc b
    ldi pl, lo(pressed)
    ldi ph, hi(pressed)
    jnz

    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ldi a, 0xfd
    st a
    ld b
    inc b
    ldi pl, lo(pressed)
    ldi ph, hi(pressed)
    jnz

    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ldi a, 0xfb
    st a
    ld b
    inc b
    ldi pl, lo(pressed)
    ldi ph, hi(pressed)
    jnz

    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ldi a, 0xf7
    st a
    ld b
    inc b
    ldi pl, lo(pressed)
    ldi ph, hi(pressed)
    jnz

    ldi pl, lo(keyboard)
    ldi ph, hi(keyboard)
    ldi a, 0xef
    st a
    ld b
    inc b
    ldi pl, lo(pressed)
    ldi ph, hi(pressed)
    jnz

    ldi pl, lo(number_string)
    ldi ph, hi(number_string)
    ldi b, 0x2d ; '-'
    st b
    mov a, 0
    inc pl
    adc ph, a
    st b
    inc pl
    adc ph, a
    inc pl
    adc ph, a
    st b

    ldi pl, lo(scan_finish)
    ldi ph, hi(scan_finish)
    jmp

pressed:
    ; a - row
    ; b - col+1
    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    not a
    st a

    mov a, b
    dec a
    not a
    ldi b, 0x30 ; '0'
    add a, b

    ldi pl, lo(number_string + 3)
    ldi ph, hi(number_string + 3)
    st a

    ; mov a, 0
    ; inc pl
    ; adc ph, a
    ; st a

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a
    shr a
    shr a
    shr a
    shr a
    ldi b, 0x30 ; '0'
    add a, b

    ldi pl, lo(number_string + 0)
    ldi ph, hi(number_string + 0)
    st a

    ldi pl, lo(tmp)
    ldi ph, hi(tmp)
    ld a
    ldi b, 0x0f
    and a, b
    ldi b, 10
    sub a, b
    ldi pl, lo(ge_ten)
    ldi ph, hi(ge_ten)
    jnc
    ldi b, 10 + 0x30
    add a, b
    ldi pl, lo(number_string + 1)
    ldi ph, hi(number_string + 1)
    st a

    ldi pl, lo(scan_finish)
    ldi ph, hi(scan_finish)
    jmp
ge_ten:
    ldi b, 0x41 ; 'A'
    add a, b
    ldi pl, lo(number_string + 1)
    ldi ph, hi(number_string + 1)
    st a

scan_finish:
    ldi pl, lo(display_set_address)
    ldi ph, hi(display_set_address)
    jmp

    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    ldi a, lo(number_string)
    st a
    mov a, 0
    inc pl
    adc ph, a
    ldi a, hi(number_string)
    st a
    ldi pl, lo(display_print)
    ldi ph, hi(display_print)
    jmp

    ldi pl, lo(scan)
    ldi ph, hi(scan)
    jmp


    ; ldi pl, lo(finish)
    ; ldi ph, hi(finish)
    ; jmp



.align 0x1000
finish:
    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp

hello_string:
    ascii "Hello, world"
    db 0

.section data
number_string: res 5
tmp: res 1

