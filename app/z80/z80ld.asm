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

    .export opcode_ld_rr
    .export opcode_ld_r_indir
    .export opcode_ld_indir_r
    .export opcode_ld_indir_bc_a
    .export opcode_ld_indir_de_a

    ; 8-Bit Load Group LD, page 42 of the manual
    .section text.ld
    ; ================================
    ; 40-6F, 78-7F
opcode_ld_rr:
    ; ED 57, ED 5F, ED 47, ED 4F aren't supported
    ; same PH through the whole function
    ldi ph, hi(z80_current_opcode)
    ldi pl, lo(z80_current_opcode)
    ld  b
    ldi a, 0x07
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ; PH:PL = source Z80 register
    ld  b
    ldi pl, lo(z80_current_opcode)
    ld  a

    ; b = source value
    ; a = opcode
    shr a
    shr a
    shr a
    ; a = (destination register number) | 0x8
    ldi pl, lo(z80_regs_origin + 8)
    sub pl, a
    st  b

    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

    ; ================================
    ; 46, 4E, 56, 5E, 66, 6E
opcode_ld_r_indir:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi pl, lo(opcode_ld_r_indir_hl)
    ldi ph, hi(opcode_ld_r_indir_hl)
    jz  ; no prefix

    ; indexed LD
    shl a
    ldi pl, lo(opcode_ld_r_indir_iy)
    ldi ph, hi(opcode_ld_r_indir_iy)
    jc ; prefix FD
    ; otherwise prefix DD
    ldi pl, lo(z80_imm0)
    ldi ph, hi(z80_imm0)
    ld  a
    shl a
    exp b
    ld  a
    ldi pl, lo(z80_ix)
    ld  pl
    add a, pl
    ldi pl, lo(z80_ix + 1)
    ld  ph
    mov pl, a
    mov a, b
    adc ph, a

    ld  b

    ldi pl, lo(z80_current_opcode)
    ldi ph, hi(z80_current_opcode)
    ld  a
    shr a
    shr a
    shr a
    ; a = (destination register number) | 0x8
    ldi pl, lo(z80_regs_origin + 8)
    sub pl, a
    st  b
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

opcode_ld_r_indir_iy:
    ldi pl, lo(z80_imm0)
    ldi ph, hi(z80_imm0)
    ld  a
    shl a
    exp b
    ld  a
    ldi pl, lo(z80_iy)
    ld  pl
    add a, pl
    ldi pl, lo(z80_iy + 1)
    ld  ph
    mov pl, a
    mov a, b
    adc ph, a

    ld  b
    ldi pl, lo(z80_current_opcode)
    ldi ph, hi(z80_current_opcode)
    ld  a
    shr a
    shr a
    shr a
    ; a = (destination register number) | 0x8
    ldi pl, lo(z80_regs_origin + 8)
    sub pl, a
    st  b
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

opcode_ld_r_indir_hl:
    ldi pl, lo(z80_hl)
    ldi ph, hi(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    ld  b
    ldi pl, lo(z80_current_opcode)
    ldi ph, hi(z80_current_opcode)
    ld  a
    shr a
    shr a
    shr a
    ; a = (destination register number) | 0x8
    ldi pl, lo(z80_regs_origin + 8)
    sub pl, a
    st  b
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

    ; ================================
    ; 70-75, 77
    ; ld (hl), r
    ; ld (ix+o), r
    ; ld (iy+o), r
opcode_ld_indir_r:
    ; jump by prefix
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    ld  a
    add a, 0
    ldi pl, lo(opcode_ld_indir_hl_r)
    ldi ph, hi(opcode_ld_indir_hl_r)
    jz  ; no prefix

    ; save source register into fixed location
    ldi pl, lo(z80_current_opcode)
    ldi ph, hi(z80_current_opcode)
    ld  a
    ldi b, 0x07
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi pl, lo(z80_imm1) ; using imm1 as temp variable (located at the same PH)
    st  b

    ldi pl, lo(z80_prefix)
    ld  a

    ; indexed LD
    shl a
    ldi pl, lo(opcode_ld_indir_iy_r)
    ldi ph, hi(opcode_ld_indir_iy_r)
    jc ; prefix FD
    ; otherwise prefix DD

opcode_ld_indir_ix_r:
    ; compute destination address
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    ldi pl, lo(z80_ix)
    ld  b
    mov pl, a
    shl pl
    exp pl
    add b, a
    mov a, pl
    ldi pl, lo(z80_ix + 1)
    ld  pl
    adc a, pl
    ; a:b - dest addr
    
    ; load source value
    ldi pl, lo(z80_imm1)
    ld  pl
    mov ph, a
    mov a, b
    xor a, pl
    xor pl, a
    xor a, pl
    st  a

    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

opcode_ld_indir_hl_r:
    ; load source register into b
    ldi pl, lo(z80_current_opcode)
    ldi ph, hi(z80_current_opcode)
    ld  a
    ldi b, 0x07
    and a, b
    ldi pl, lo(z80_regs_origin)
    sub pl, a
    ld  b
    ldi ph, hi(z80_hl)
    ldi pl, lo(z80_hl)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    st  b

    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

opcode_ld_indir_iy_r:
    ; compute destination address
    ldi ph, hi(z80_imm0)
    ldi pl, lo(z80_imm0)
    ld  a
    ldi pl, lo(z80_iy)
    ld  b
    mov pl, a
    shl pl
    exp pl
    add b, a
    mov a, pl
    ldi pl, lo(z80_iy + 1)
    ld  pl
    adc a, pl
    ; a:b - dest addr
    
    ; load source value
    ldi pl, lo(z80_imm1)
    ld  pl
    mov ph, a
    mov a, b
    xor a, pl
    xor pl, a
    xor a, pl
    st  a

    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

    ; ================================
    ; 02
    ; ld (bc), a
opcode_ld_indir_bc_a:
    ldi ph, hi(z80_a)
    ldi pl, lo(z80_a)
    ld  b
    ldi pl, lo(z80_bc)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    st b
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

    ; ================================
    ; 12
    ; ld (de), a
opcode_ld_indir_de_a:
    ldi ph, hi(z80_a)
    ldi pl, lo(z80_a)
    ld  b
    ldi pl, lo(z80_de)
    ld  a
    inc pl
    ld  ph
    mov pl, a
    st b
    ldi pl, lo(z80_reset_prefix)
    ldi ph, hi(z80_reset_prefix)
    jmp

    .section bss.ld
source: res 1
