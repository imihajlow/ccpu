    .global z80_pc
    .global __seg_z80_code_begin
    .global z80_reset_prefix

    .section init
    ldi pl, lo(z80_pc)
    ldi ph, hi(z80_pc)
    ldi a, lo(__seg_z80_code_begin)
    st a
    ldi a, hi(__seg_z80_code_begin)
    inc pl
    st a

    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp
