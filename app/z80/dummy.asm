    .global z80run

    .section init
    .align 0x10000

    ldi pl, lo(z80run)
