    .export ext_main
    .global ps2_wait_key_pressed
    .global vga_clear
    .global vga_clear_arg0
    .section text
ext_main:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(vga_clear_arg0)
    ldi ph, hi(vga_clear_arg0)
    ldi a, 0x34
    st a
    ldi pl, lo(vga_clear)
    ldi ph, hi(vga_clear)
    jmp

    ldi pl, lo(ps2_wait_key_pressed)
    ldi ph, hi(ps2_wait_key_pressed)
    jmp

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp
    .section bss
    .align 2
ret:
    res 2
