    .global z80_pc
    .global z80_reset_prefix

    .export z80run
    .export z80run_arg0
    .export z80run_ret

    .export z80_halt_handler

    .section text.z80run
z80run:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st  b
    inc pl
    st  a

    ldi pl, lo(z80run_arg0)
    ldi ph, hi(z80run_arg0)
    ld  a
    inc pl
    ld  b
    ldi pl, lo(z80_pc)
    ldi ph, hi(z80_pc)
    st  a
    inc pl
    st  b
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp


z80_halt_handler:
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    jmp

    .section bss.z80run
    .align 2
z80run_arg0:
    res 2
z80run_ret:
ret:
    res 2
