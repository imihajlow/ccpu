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
    .global z80_prefix_ed
    .global z80_prefix_dd
    .global z80_prefix_fd
    .global z80_imm0
    .global z80_imm1

    .export z80_reset_prefix

    ; in z80ld.asm
    .global opcode_ld_rr
    .global opcode_ld_r_indir
    .global opcode_ld_indir_r
    .global opcode_ld_indir_bc_a
    .global opcode_ld_indir_de_a
    .global opcode_ld_r_imm
    .global opcode_ld_indir_imm
    .global opcode_ld_a_imm_indir
    .global opcode_ld_a_imm_bc
    .global opcode_ld_a_imm_de
    .global opcode_ld_indir_imm_a

    .global z80_halt_handler

    .section text.fetch
z80_reset_prefix:
    ldi ph, hi(z80_prefix)
    ldi pl, lo(z80_prefix)
    mov a, 0
    st a

fetch:
    ; load opcode and store it
    ldi pl, lo(z80_pc + 1)
    ldi ph, hi(z80_pc)
    ld a
    dec pl
    ld pl
    mov ph, a
    ld b
    ldi pl, lo(z80_current_opcode)
    ldi ph, hi(z80_current_opcode)
    st b
    ; increment PC
    ldi pl, lo(z80_pc)
    ld b
    inc b
    adc a, 0 ; a is still hi(PC)
    st b
    inc pl
    st a
    ; load stored opcode
    ldi pl, lo(z80_current_opcode)
    ld  pl
    ; check instruction format
    ldi ph, hi(instr_fmt)
    ld  b

    ; b = adjusted instruction format code
check_instr_fmt:
    ldi a, 0x3
    and b, a
    ldi pl, lo(tablejump)
    ldi ph, hi(tablejump)
    jz  ; instruction with no immediate
    dec b
    ldi pl, lo(fetch_imm_1)
    ldi ph, hi(fetch_imm_1)
    jz  ; one byte immediate
    ; else two bytes immediate

    ; load 2 imm bytes
    ldi pl, lo(z80_pc + 1)
    ldi ph, hi(z80_pc)
    ld  a
    dec pl
    ld  pl
    mov ph, a
    ld  b
    inc pl
    adc a, 0
    mov ph, a
    ld  a
    ; store them
    ldi pl, lo(z80_imm0)
    ldi ph, hi(z80_imm0)
    st  b
    inc pl
    st  a
    ; PC += 2
    ldi pl, lo(z80_pc)
    ld  b
    ldi a, 2
    add b, a
    st  b
    ldi pl, (z80_pc + 1)
    ld  a
    adc a, 0
    st  a
    ldi pl, lo(tablejump)
    ldi ph, hi(tablejump)
    jmp

fetch_imm_1:
    ; load 1 imm byte
    ldi pl, lo(z80_pc + 1)
    ldi ph, hi(z80_pc)
    ld  a
    dec pl
    ld  pl
    mov ph, a
    ld  b
    ; store it
    ldi pl, lo(z80_imm0)
    ldi ph, hi(z80_imm0)
    st  b
    ; increment PC
    ldi pl, lo(z80_pc)
    ld  b
    inc b
    adc a, 0 ; a is already hi(PC)
    st  b
    inc pl
    st  a

    ; jump to the callback according to the table
tablejump:
    ldi pl, lo(z80_current_opcode)
    ldi ph, hi(z80_current_opcode)
    ld  pl
    shl pl
    ldi a, hi(jump_table)
    adc a, 0
    mov ph, a
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section text.not_implemented
not_implemented:
    ldi pl, lo(not_implemented)
    ldi ph, hi(not_implemented)
    jmp

    .section text.opcode_ed
opcode_ed:
    ldi pl, lo(z80_prefix)
    ldi ph, hi(z80_prefix)
    ldi a, z80_prefix_ed
    st a
    ; load opcode and store it
    ldi pl, lo(z80_pc + 1)
    ldi ph, hi(z80_pc)
    ld a
    dec pl
    ld pl
    mov ph, a
    ld b
    ldi pl, lo(z80_current_opcode)
    ldi ph, hi(z80_current_opcode)
    st b
    ; increment PC
    ldi pl, lo(z80_pc)
    ld b
    inc b
    adc a, 0 ; a is still hi(PC)
    st b
    inc pl
    st a
    ; load stored opcode
    ldi pl, lo(z80_current_opcode)
    ld  pl
    ; check instruction format
    ldi ph, hi(instr_fmt)
    ld  b
    shr b
    shr b
    ldi pl, lo(check_instr_fmt)
    ldi ph, hi(check_instr_fmt)
    jmp

    .section text.opcode_dd
opcode_dd:
    ldi pl, lo(z80_prefix)
    ldi ph, hi(z80_prefix)
    ldi a, z80_prefix_dd
    st a
fetch_dd:
    ; load opcode and store it
    ldi pl, lo(z80_pc + 1)
    ldi ph, hi(z80_pc)
    ld a
    dec pl
    ld pl
    mov ph, a
    ld b
    ldi pl, lo(z80_current_opcode)
    ldi ph, hi(z80_current_opcode)
    st b
    ; increment PC
    ldi pl, lo(z80_pc)
    ld b
    inc b
    adc a, 0 ; a is still hi(PC)
    st b
    inc pl
    st a
    ; load stored opcode
    ldi pl, lo(z80_current_opcode)
    ld  pl
    ; check instruction format
    ldi ph, hi(instr_fmt)
    ld  b
    shr b
    shr b
    shr b
    shr b
    ldi pl, lo(check_instr_fmt)
    ldi ph, hi(check_instr_fmt)
    jmp

    .section text.opcode_fd
opcode_fd:
    ldi pl, lo(z80_prefix)
    ldi ph, hi(z80_prefix)
    ldi a, z80_prefix_fd
    st a
    ldi pl, lo(fetch_dd)
    ldi ph, hi(fetch_dd)
    jmp
    
    .section text.jump_table
    .align 256
jump_table:
    dw fetch                ; 00 - NOP
    dw not_implemented      ; 01
    dw opcode_ld_indir_bc_a ; 02
    dw not_implemented      ; 03
    dw not_implemented      ; 04
    dw not_implemented      ; 05
    dw opcode_ld_r_imm      ; 06
    dw not_implemented      ; 07
    dw not_implemented      ; 08
    dw not_implemented      ; 09
    dw opcode_ld_a_imm_bc      ; 0A
    dw not_implemented      ; 0B
    dw not_implemented      ; 0C
    dw not_implemented      ; 0D
    dw opcode_ld_r_imm      ; 0E
    dw not_implemented      ; 0F
    dw not_implemented      ; 10
    dw not_implemented      ; 11
    dw opcode_ld_indir_de_a ; 12
    dw not_implemented      ; 13
    dw not_implemented      ; 14
    dw not_implemented      ; 15
    dw opcode_ld_r_imm      ; 16
    dw not_implemented      ; 17
    dw not_implemented      ; 18
    dw not_implemented      ; 19
    dw opcode_ld_a_imm_de      ; 1A
    dw not_implemented      ; 1B
    dw not_implemented      ; 1C
    dw not_implemented      ; 1D
    dw opcode_ld_r_imm      ; 1E
    dw not_implemented      ; 1F
    dw not_implemented      ; 20
    dw not_implemented      ; 21
    dw not_implemented      ; 22
    dw not_implemented      ; 23
    dw not_implemented      ; 24
    dw not_implemented      ; 25
    dw opcode_ld_r_imm      ; 26
    dw not_implemented      ; 27
    dw not_implemented      ; 28
    dw not_implemented      ; 29
    dw not_implemented      ; 2A
    dw not_implemented      ; 2B
    dw not_implemented      ; 2C
    dw not_implemented      ; 2D
    dw opcode_ld_r_imm      ; 2E
    dw not_implemented      ; 2F
    dw not_implemented      ; 30
    dw not_implemented      ; 31
    dw opcode_ld_indir_imm_a      ; 32
    dw not_implemented      ; 33
    dw not_implemented      ; 34
    dw not_implemented      ; 35
    dw opcode_ld_indir_imm  ; 36
    dw not_implemented      ; 37
    dw not_implemented      ; 38
    dw not_implemented      ; 39
    dw opcode_ld_a_imm_indir      ; 3A
    dw not_implemented      ; 3B
    dw not_implemented      ; 3C
    dw not_implemented      ; 3D
    dw opcode_ld_r_imm      ; 3E
    dw not_implemented      ; 3F
    dw opcode_ld_rr             ; 40
    dw opcode_ld_rr             ; 41
    dw opcode_ld_rr             ; 42
    dw opcode_ld_rr             ; 43
    dw opcode_ld_rr             ; 44
    dw opcode_ld_rr             ; 45
    dw opcode_ld_r_indir        ; 46
    dw opcode_ld_rr             ; 47
    dw opcode_ld_rr             ; 48
    dw opcode_ld_rr             ; 49
    dw opcode_ld_rr             ; 4A
    dw opcode_ld_rr             ; 4B
    dw opcode_ld_rr             ; 4C
    dw opcode_ld_rr             ; 4D
    dw opcode_ld_r_indir        ; 4E
    dw opcode_ld_rr             ; 4F
    dw opcode_ld_rr             ; 50
    dw opcode_ld_rr             ; 51
    dw opcode_ld_rr             ; 52
    dw opcode_ld_rr             ; 53
    dw opcode_ld_rr             ; 54
    dw opcode_ld_rr             ; 55
    dw opcode_ld_r_indir        ; 56
    dw opcode_ld_rr             ; 57
    dw opcode_ld_rr             ; 58
    dw opcode_ld_rr             ; 59
    dw opcode_ld_rr             ; 5A
    dw opcode_ld_rr             ; 5B
    dw opcode_ld_rr             ; 5C
    dw opcode_ld_rr             ; 5D
    dw opcode_ld_r_indir        ; 5E
    dw opcode_ld_rr             ; 5F
    dw opcode_ld_rr             ; 60
    dw opcode_ld_rr             ; 61
    dw opcode_ld_rr             ; 62
    dw opcode_ld_rr             ; 63
    dw opcode_ld_rr             ; 64
    dw opcode_ld_rr             ; 65
    dw opcode_ld_r_indir        ; 66
    dw opcode_ld_rr             ; 67
    dw opcode_ld_rr             ; 68
    dw opcode_ld_rr             ; 69
    dw opcode_ld_rr             ; 6A
    dw opcode_ld_rr             ; 6B
    dw opcode_ld_rr             ; 6C
    dw opcode_ld_rr             ; 6D
    dw opcode_ld_r_indir        ; 6E
    dw opcode_ld_rr             ; 6F
    dw opcode_ld_indir_r        ; 70
    dw opcode_ld_indir_r        ; 71
    dw opcode_ld_indir_r        ; 72
    dw opcode_ld_indir_r        ; 73
    dw opcode_ld_indir_r        ; 74
    dw opcode_ld_indir_r        ; 75
    dw z80_halt_handler         ; 76
    dw opcode_ld_indir_r        ; 77
    dw opcode_ld_rr             ; 78
    dw opcode_ld_rr             ; 79
    dw opcode_ld_rr             ; 7A
    dw opcode_ld_rr             ; 7B
    dw opcode_ld_rr             ; 7C
    dw opcode_ld_rr             ; 7D
    dw opcode_ld_rr             ; 7E
    dw opcode_ld_rr             ; 7F
    dw not_implemented      ; 80
    dw not_implemented      ; 81
    dw not_implemented      ; 82
    dw not_implemented      ; 83
    dw not_implemented      ; 84
    dw not_implemented      ; 85
    dw not_implemented      ; 86
    dw not_implemented      ; 87
    dw not_implemented      ; 88
    dw not_implemented      ; 89
    dw not_implemented      ; 8A
    dw not_implemented      ; 8B
    dw not_implemented      ; 8C
    dw not_implemented      ; 8D
    dw not_implemented      ; 8E
    dw not_implemented      ; 8F
    dw not_implemented      ; 90
    dw not_implemented      ; 91
    dw not_implemented      ; 92
    dw not_implemented      ; 93
    dw not_implemented      ; 94
    dw not_implemented      ; 95
    dw not_implemented      ; 96
    dw not_implemented      ; 97
    dw not_implemented      ; 98
    dw not_implemented      ; 99
    dw not_implemented      ; 9A
    dw not_implemented      ; 9B
    dw not_implemented      ; 9C
    dw not_implemented      ; 9D
    dw not_implemented      ; 9E
    dw not_implemented      ; 9F
    dw not_implemented      ; A0
    dw not_implemented      ; A1
    dw not_implemented      ; A2
    dw not_implemented      ; A3
    dw not_implemented      ; A4
    dw not_implemented      ; A5
    dw not_implemented      ; A6
    dw not_implemented      ; A7
    dw not_implemented      ; A8
    dw not_implemented      ; A9
    dw not_implemented      ; AA
    dw not_implemented      ; AB
    dw not_implemented      ; AC
    dw not_implemented      ; AD
    dw not_implemented      ; AE
    dw not_implemented      ; AF
    dw not_implemented      ; B0
    dw not_implemented      ; B1
    dw not_implemented      ; B2
    dw not_implemented      ; B3
    dw not_implemented      ; B4
    dw not_implemented      ; B5
    dw not_implemented      ; B6
    dw not_implemented      ; B7
    dw not_implemented      ; B8
    dw not_implemented      ; B9
    dw not_implemented      ; BA
    dw not_implemented      ; BB
    dw not_implemented      ; BC
    dw not_implemented      ; BD
    dw not_implemented      ; BE
    dw not_implemented      ; BF
    dw not_implemented      ; C0
    dw not_implemented      ; C1
    dw not_implemented      ; C2
    dw not_implemented      ; C3
    dw not_implemented      ; C4
    dw not_implemented      ; C5
    dw not_implemented      ; C6
    dw not_implemented      ; C7
    dw not_implemented      ; C8
    dw not_implemented      ; C9
    dw not_implemented      ; CA
    dw not_implemented      ; CB
    dw not_implemented      ; CC
    dw not_implemented      ; CD
    dw not_implemented      ; CE
    dw not_implemented      ; CF
    dw not_implemented      ; D0
    dw not_implemented      ; D1
    dw not_implemented      ; D2
    dw not_implemented      ; D3
    dw not_implemented      ; D4
    dw not_implemented      ; D5
    dw not_implemented      ; D6
    dw not_implemented      ; D7
    dw not_implemented      ; D8
    dw not_implemented      ; D9
    dw not_implemented      ; DA
    dw not_implemented      ; DB
    dw not_implemented      ; DC
    dw opcode_dd            ; DD
    dw not_implemented      ; DE
    dw not_implemented      ; DF
    dw not_implemented      ; E0
    dw not_implemented      ; E1
    dw not_implemented      ; E2
    dw not_implemented      ; E3
    dw not_implemented      ; E4
    dw not_implemented      ; E5
    dw not_implemented      ; E6
    dw not_implemented      ; E7
    dw not_implemented      ; E8
    dw not_implemented      ; E9
    dw not_implemented      ; EA
    dw not_implemented      ; EB
    dw not_implemented      ; EC
    dw opcode_ed            ; ED
    dw not_implemented      ; EE
    dw not_implemented      ; EF
    dw not_implemented      ; F0
    dw not_implemented      ; F1
    dw not_implemented      ; F2
    dw not_implemented      ; F3
    dw not_implemented      ; F4
    dw not_implemented      ; F5
    dw not_implemented      ; F6
    dw not_implemented      ; F7
    dw not_implemented      ; F8
    dw not_implemented      ; F9
    dw not_implemented      ; FA
    dw not_implemented      ; FB
    dw not_implemented      ; FC
    dw opcode_fd            ; FD
    dw not_implemented      ; FE
    dw not_implemented      ; FF


    ; Instruction format table
    ; Possible instruction formats:
    ; - no immediate value
    ; - 1 byte immediate value
    ; - 2 byte immediate value (or 2 single byte immediates)
    ; - DDCB/FDCB format: DD CB imm8 op
    ;
    ; DD- and FD-prefixed instructions follow the same format
    ; ED is special
    ; CB has only simple instructions without an immediate - no table needed
    
    .const instr_fmt_no_imm = 0
    .const instr_fmt_imm_1 = 1
    .const instr_fmt_imm_2 = 2
    .const instr_fmt_ed_no_imm = 0 << 2
    .const instr_fmt_ed_imm_2 = 2 << 2
    .const instr_fmt_dd_no_imm = 0 << 4
    .const instr_fmt_dd_imm_1 = 1 << 4
    .const instr_fmt_dd_imm_2 = 2 << 4
    .const instr_fmt_ddcb = 3 << 4

    .section text.instr_fmt
    .align 256
instr_fmt:
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 00
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 01
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 02
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 03
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 04
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 05
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 06
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 07
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 08
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 09
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 0A
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 0B
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 0C
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 0D
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 0E
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 0F
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 10
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 11
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 12
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 13
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 14
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 15
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 16
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 17
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 18
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 19
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 1A
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 1B
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 1C
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 1D
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 1E
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 1F
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 20
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 21
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 22
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 23
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 24
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 25
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 26
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 27
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 28
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 29
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 2A
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 2B
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 2C
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 2D
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 2E
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 2F
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 30
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 31
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 32
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 33
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 34
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 35
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_imm_2    ; 36
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 37
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 38
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 39
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 3A
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 3B
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 3C
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 3D
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 3E
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 3F
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 40
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 41
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 42
    db instr_fmt_no_imm | instr_fmt_ed_imm_2 | instr_fmt_dd_no_imm    ; 43
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 44
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 45
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 46
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 47
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 48
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 49
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 4A
    db instr_fmt_no_imm | instr_fmt_ed_imm_2 | instr_fmt_dd_no_imm    ; 4B
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 4C
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 4D
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 4E
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 4F
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 50
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 51
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 52
    db instr_fmt_no_imm | instr_fmt_ed_imm_2 | instr_fmt_dd_no_imm    ; 53
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 54
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 55
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 56
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 57
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 58
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 59
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 5A
    db instr_fmt_no_imm | instr_fmt_ed_imm_2 | instr_fmt_dd_no_imm    ; 5B
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 5C
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 5D
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 5E
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 5F
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 60
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 61
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 62
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 63
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 64
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 65
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 66
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 67
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 68
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 69
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 6A
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 6B
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 6C
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 6D
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 6E
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 6F
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 70
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 71
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 72
    db instr_fmt_no_imm | instr_fmt_ed_imm_2 | instr_fmt_dd_imm_1    ; 73
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 74
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 75
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 76
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 77
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 78
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 79
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 7A
    db instr_fmt_no_imm | instr_fmt_ed_imm_2 | instr_fmt_dd_no_imm    ; 7B
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 7C
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 7D
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 7E
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 7F
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 80
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 81
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 82
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 83
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 84
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 85
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 86
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 87
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 88
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 89
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 8A
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 8B
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 8C
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 8D
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 8E
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 8F
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 90
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 91
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 92
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 93
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 94
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 95
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 96
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 97
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 98
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 99
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 9A
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 9B
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 9C
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 9D
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; 9E
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; 9F
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; A0
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; A1
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; A2
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; A3
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; A4
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; A5
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; A6
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; A7
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; A8
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; A9
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; AA
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; AB
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; AC
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; AD
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; AE
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; AF
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; B0
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; B1
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; B2
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; B3
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; B4
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; B5
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; B6
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; B7
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; B8
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; B9
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; BA
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; BB
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; BC
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; BD
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_imm_1    ; BE
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; BF
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; C0
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; C1
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; C2
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; C3
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; C4
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; C5
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; C6
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; C7
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; C8
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; C9
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; CA
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_ddcb    ; CB - fake imm1, in fact it's a prefix
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; CC
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; CD
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; CE
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; CF
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; D0
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; D1
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; D2
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; D3
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; D4
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; D5
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; D6
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; D7
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; D8
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; D9
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; DA
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; DB
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; DC
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; DD
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; DE
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; DF
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; E0
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; E1
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; E2
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; E3
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; E4
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; E5
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; E6
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; E7
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; E8
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; E9
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; EA
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; EB
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; EC
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; ED
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; EE
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; EF
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; F0
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; F1
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; F2
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; F3
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; F4
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; F5
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; F6
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; F7
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; F8
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; F9
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; FA
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; FB
    db instr_fmt_imm_2 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; FC
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; FD
    db instr_fmt_imm_1 | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; FE
    db instr_fmt_no_imm | instr_fmt_ed_no_imm | instr_fmt_dd_no_imm    ; FF
