    .global rst_00_handler
    .global rst_08_handler
    .global rst_10_handler
    .global rst_18_handler
    .global rst_20_handler
    .global rst_28_handler
    .global rst_30_handler
    .global rst_38_handler

    .global z80_reset_prefix

    .export opcode_rst_00
    .export opcode_rst_08
    .export opcode_rst_10
    .export opcode_rst_18
    .export opcode_rst_20
    .export opcode_rst_28
    .export opcode_rst_30
    .export opcode_rst_38

    .section text.rst
opcode_rst_00:
    ldi ph, hi(rst_00_handler)
    ldi pl, lo(rst_00_handler)
    jmp
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

opcode_rst_08:
    ldi ph, hi(rst_08_handler)
    ldi pl, lo(rst_08_handler)
    jmp
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

opcode_rst_10:
    ldi ph, hi(rst_10_handler)
    ldi pl, lo(rst_10_handler)
    jmp
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

opcode_rst_18:
    ldi ph, hi(rst_18_handler)
    ldi pl, lo(rst_18_handler)
    jmp
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

opcode_rst_20:
    ldi ph, hi(rst_20_handler)
    ldi pl, lo(rst_20_handler)
    jmp
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

opcode_rst_28:
    ldi ph, hi(rst_28_handler)
    ldi pl, lo(rst_28_handler)
    jmp
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

opcode_rst_30:
    ldi ph, hi(rst_30_handler)
    ldi pl, lo(rst_30_handler)
    jmp
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp

opcode_rst_38:
    ldi ph, hi(rst_38_handler)
    ldi pl, lo(rst_38_handler)
    jmp
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
