    ; provided by the linker
    .global __seg_z80_code_begin
    .global __seg_z80_ram_end

    .global z80_sp
    .global z80_pc

    .global z80_reset_prefix


    .export z80_halt_handler
    .export rst_00_handler
    .export rst_08_handler
    .export rst_10_handler
    .export rst_18_handler
    .export rst_20_handler
    .export rst_28_handler
    .export rst_30_handler
    .export rst_38_handler

    ; start-up code
    .section init
    .align 0x10000 ; make sure this is at address 0
    ; save return address
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ; point SP to the end of stack segment
    ldi pl, lo(z80_sp)
    ldi ph, hi(z80_sp)
    ldi a, lo(__seg_z80_ram_end)
    st a
    inc pl
    ldi a, hi(__seg_z80_ram_end)
    st a

    ldi pl, lo(z80_pc)
    ldi a, lo(__seg_z80_code_begin)
    st a
    inc pl
    ldi a, hi(__seg_z80_code_begin)
    st a

    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

z80_halt_handler:
    ldi ph, hi(z80_halt_handler)
    ldi pl, lo(z80_halt_handler)
    jmp
    ; ldi pl, lo(ret)
    ; ldi ph, hi(ret)
    ; ld a
    ; inc pl
    ; ld ph
    ; mov pl, a
    ; jmp

rst_00_handler:
rst_08_handler:

rst_10_handler:
rst_18_handler:

rst_20_handler:
rst_28_handler:

rst_30_handler:
rst_38_handler:
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

    .section bss
    .align 2
ret: res 2
