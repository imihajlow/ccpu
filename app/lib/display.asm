.export lcd_control
.export lcd_data
.export display_init
.export display_print
.export display_print_byte
.export display_set_address
.export display_print_arg
.export display_set_address_arg

.const lcd_control = 0xf002
.const lcd_data = 0xf003

.section data

    .align 2
display_return: res 2
display_print_arg: res 2
display_set_address_arg: res 1
    .align 2
delay_return: res 2

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
    ld b
    inc pl
    ld a
    mov ph, a
    mov a, b
    mov pl, a
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


; one nop - 2 clock cycles, 6.6 uS
; delay at least 5 ms at 300 kHz - ~1500 cycles
delay_5ms:
    mov a, ph
    mov b, a
    mov a, pl
    ldi pl, lo(delay_return)
    ldi ph, hi(delay_return)
    st a
    inc pl
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
    inc pl
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

hex_map:
    ascii '0123456789ABCDEF'
