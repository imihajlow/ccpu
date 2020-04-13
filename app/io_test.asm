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

display_init:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl ; assuming no overflow
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

    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    ld a
    inc pl
    ld b
    mov pl, a
    mov a, b
    mov ph, a
    jmp

; display_print_arg - string address
display_print:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl ; assuming no overflow
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
    ldi pl, lo(display_print_finish)
    ldi ph, hi(display_print_finish)
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

display_print_finish:
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    ld a
    inc pl
    ld b
    mov pl, a
    mov a, b
    mov ph, a
    jmp


display_set_address:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    st a
    inc pl ; assuming no overflow
    st b

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

    ldi pl, lo(display_return)
    ldi ph, hi(display_return)
    ld a
    inc pl
    ld b
    mov pl, a
    mov a, b
    mov ph, a
    jmp



; one nop - 2 clock cycles, 6.6 uS
; delay at least 5 ms at 300 kHz - ~1500 cycles
delay_5ms:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    st a
    inc pl ; assuming no overflow
    st b

    ldi a, 63
delay_5ms_loop: ; 24 clock cycles
    nop
    nop
    nop
    nop
    nop
    nop
    dec a
    ldi pl, lo(delay_5ms_loop)
    ldi ph, hi(delay_5ms_loop)
    jnz

    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    ld a
    inc pl
    ld b
    mov pl, a
    mov a, b
    mov ph, a
    jmp

; ~30000 cycles
delay_100ms:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    st a
    inc pl ; assuming no overflow
    st b

    ldi a, 5
    ldi b, 0
delay_100ms_loop: ; 24 clock cycles
    nop
    nop
    nop
    nop
    nop
    nop
    dec b
    sbb a, 0
    ldi pl, lo(delay_100ms_loop)
    ldi ph, hi(delay_100ms_loop)
    jns

    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    ld a
    inc pl
    ld b
    mov pl, a
    mov a, b
    mov ph, a
    jmp

; ~18 cycles
delay_60us:
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    jmp

.align 0x1000
finish:
    ldi pl, lo(finish)
    ldi ph, hi(finish)
    jmp

hello_string:
    ascii "Hello, world"
    db 0

    .noinit
    .offset 0x8000
ram:
delay_return: dw 0
display_return: dw 0

display_print_arg: dw 0

display_set_address_arg: db 0

number_string:
    ascii "----"
    db 0

tmp: db 0

    .offset 0xf000
io:
keyboard:
    .offset 0xf002
lcd_control:
    .offset 0xf003
lcd_data:
