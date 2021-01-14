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
tmp: res 1

    .section text
    .align 16
hex_map:
    ascii '0123456789ABCDEF'
