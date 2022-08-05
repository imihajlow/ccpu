    .global z80_regs_origin
    .global z80_f
    .global z80_a
    .global z80_bc
    .global z80_c
    .global z80_b
    .global z80_de
    .global z80_e
    .global z80_d
    .global z80_hl
    .global z80_l
    .global z80_h
    .global z80_f_s
    .global z80_a_s
    .global z80_bc_s
    .global z80_c_s
    .global z80_b_s
    .global z80_de_s
    .global z80_e_s
    .global z80_d_s
    .global z80_hl_s
    .global z80_l_s
    .global z80_h_s
    .global z80_ix
    .global z80_iy
    .global z80_sp
    .global z80_i
    .global z80_r
    .global z80_pc
    .global z80_current_opcode
    .global z80_prefix
    .global z80_indir_src

    .global z80_reset_prefix
    .global z80_imm0
    .global z80_imm1
    .global z80_tmp

    .global z80_cf
    .global z80_nf
    .global z80_pf
    .global z80_hf
    .global z80_zf
    .global z80_sf

    .export opcode_cb

    ; Bit manipulation
    .section text.opcode_cb
opcode_cb:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(no_swap)
    ldi pl, lo(no_swap)
    jz

    ; for FD CB d OP and DD CB d OP instructions
    ; swap imm0 and imm1
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    inc pl
    ld  b
    st  a
    dec pl
    st  b
no_swap:
    ; calculate bit mask to apply for all operations
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    shr a
    shr a
    shr a
    ldi b, 0x7
    and b, a
    ldi a, 1
    ldi pl, lo(mask_loop_end)
    ldi ph, hi(mask_loop_end)
    jz
mask_loop:
    shl a
    dec b
    ldi pl, lo(mask_loop)
    ldi ph, hi(mask_loop)
    jnz
mask_loop_end:
    ; a = mask
    ldi ph, hi(z80_tmp)
    ldi pl, lo(z80_tmp)
    st  a

    ; select operation
    ; 01xxxxxx - bit
    ; 11xxxxxx - set
    ; 10xxxxxx - res
    ldi pl, lo(z80_imm0)
    ld  a
    shl a
    ldi ph, hi(set_res)
    ldi pl, lo(set_res)
    jc
    shl a
    ldi pl, lo(bit)
    ldi ph, hi(bit)
    jc
cb_not_implemented:
    ldi ph, hi(cb_not_implemented)
    ldi pl, lo(cb_not_implemented)
    jmp

set_res:
    shl a
    ldi ph, hi(res)
    ldi pl, lo(res)
    jnc
set:
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
res:
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
bit:
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    ldi b, 0x07
    and a, b
    ldi b, 0x06
    sub b, a
    ldi pl, lo(bit_common)
    ldi ph, hi(bit_common)
    jnz
    ; register number 6 - indirect operation
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi ph, hi(bit_hl)
    ldi pl, lo(bit_hl)
    jz
    ldi ph, hi(bit_iy)
    ldi pl, lo(bit_iy)
    js
bit_ix:
    ldi pl, lo(z80_imm1)
    ldi ph, hi(z80_imm1)
    ld  b
    mov a, b
    shl b
    exp b
    ldi pl, lo(z80_ix)
    ld  pl
    add a, pl
    ldi pl, lo(z80_ix + 1)
    ld  ph
    mov pl, a
    mov a, b
    adc ph, a
    ld  b
    ldi ph, hi(z80_indir_src)
    ldi pl, lo(z80_indir_src)
    st  b
    ldi ph, hi(bit_common_indirect)
    ldi pl, lo(bit_common_indirect)
    jmp
bit_iy:
    ldi pl, lo(z80_imm1)
    ldi ph, hi(z80_imm1)
    ld  b
    mov a, b
    shl b
    exp b
    ldi pl, lo(z80_iy)
    ld  pl
    add a, pl
    ldi pl, lo(z80_iy + 1)
    ld  ph
    mov pl, a
    mov a, b
    adc ph, a
    ld  b
    ldi ph, hi(z80_indir_src)
    ldi pl, lo(z80_indir_src)
    st  b
    ldi ph, hi(bit_common_indirect)
    ldi pl, lo(bit_common_indirect)
    jmp
bit_hl:
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  a
    ldi ph, hi(z80_indir_src)
    ldi pl, lo(z80_indir_src)
    st  a
bit_common_indirect:
    ldi a, 6
bit_common:
    ldi ph, hi(z80_regs_origin)
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi pl, lo(z80_tmp)
    ld  a
    and b, a
    ldi a, z80_hf
    ldi ph, hi(bit_nz)
    ldi pl, lo(bit_nz)
    jnz
    ldi b, z80_zf
    or  a, b
bit_nz:
    ldi ph, hi(z80_f)
    ldi pl, lo(z80_f)
    ld  b
    shr b
    adc a, 0
    st  a
    ldi ph, hi(z80_reset_prefix)
    ldi pl, lo(z80_reset_prefix)
    jmp
