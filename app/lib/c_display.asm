    ; C bindings for display functions

    ; c_display_print(char *string)
    .export c_display_print

    ; c_display_print_byte(char c)
    .export c_display_print_byte

    ; c_display_set_address(char address)
    .export c_display_set_address

    .global __cc_r_sp

    .global display_print
    .global display_print_byte
    .global display_set_address
    .global display_set_address_arg
    .global display_print_arg

    .section text
c_display_print:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ; *SP = string address
    ldi pl, lo(__cc_r_sp)
    ldi ph, hi(__cc_r_sp)
    ld a
    inc pl
    ld ph
    mov pl, a

    ld b
    inc pl
    ld a

    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    st b
    inc pl
    st a

    ldi pl, lo(display_print)
    ldi ph, hi(display_print)
    jmp

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

c_display_print_byte:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ; *SP = byte
    ldi pl, lo(__cc_r_sp)
    ldi ph, hi(__cc_r_sp)
    ld a
    inc pl
    ld ph
    mov pl, a

    ld b

    ldi pl, lo(display_print_arg)
    ldi ph, hi(display_print_arg)
    st b

    ldi pl, lo(display_print_byte)
    ldi ph, hi(display_print_byte)
    jmp

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

c_display_set_address:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ; *SP = address
    ldi pl, lo(__cc_r_sp)
    ldi ph, hi(__cc_r_sp)
    ld a
    inc pl
    ld ph
    mov pl, a

    ld b
    inc pl
    ld a

    ldi pl, lo(display_set_address_arg)
    ldi ph, hi(display_set_address_arg)
    st b
    inc pl
    st a

    ldi pl, lo(display_set_address)
    ldi ph, hi(display_set_address)
    jmp

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section bss
ret: res 2
