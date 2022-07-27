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

    .export z80_reset_prefix

    .global opcode_ld_rr
    .global opcode_ld_r_indir
    .global opcode_ld_indir_r

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
    ldi ph, hi(z80_pc)
    ld b
    inc b
    adc a, 0
    st b
    inc pl
    st a
    ; load stored opcode
    ldi pl, lo(z80_current_opcode)
    ld pl

    ; jump according to the table
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

    ; prefixes ED, DD and FD can't be combined
    .section text.opcode_ed
opcode_ed:
    ldi pl, lo(z80_prefix)
    ldi ph, hi(z80_prefix)
    ldi a, z80_prefix_ed
    st a
    ldi pl, lo(fetch)
    ldi ph, hi(fetch)
    jmp

    .section text.opcode_dd
opcode_dd:
    ldi pl, lo(z80_prefix)
    ldi ph, hi(z80_prefix)
    ldi a, z80_prefix_dd
    st a
    ldi pl, lo(fetch)
    ldi ph, hi(fetch)
    jmp

    .section text.opcode_fd
opcode_fd:
    ldi pl, lo(z80_prefix)
    ldi ph, hi(z80_prefix)
    ldi a, z80_prefix_fd
    st a
    ldi pl, lo(fetch)
    ldi ph, hi(fetch)
    jmp
    
    .section text.jump_table
    .align 256
jump_table:
    dw fetch                ; 00 - NOP
    dw not_implemented      ; 01
    dw not_implemented      ; 02
    dw not_implemented      ; 03
    dw not_implemented      ; 04
    dw not_implemented      ; 05
    dw not_implemented      ; 06
    dw not_implemented      ; 07
    dw not_implemented      ; 08
    dw not_implemented      ; 09
    dw not_implemented      ; 0A
    dw not_implemented      ; 0B
    dw not_implemented      ; 0C
    dw not_implemented      ; 0D
    dw not_implemented      ; 0E
    dw not_implemented      ; 0F
    dw not_implemented      ; 10
    dw not_implemented      ; 11
    dw not_implemented      ; 12
    dw not_implemented      ; 13
    dw not_implemented      ; 14
    dw not_implemented      ; 15
    dw not_implemented      ; 16
    dw not_implemented      ; 17
    dw not_implemented      ; 18
    dw not_implemented      ; 19
    dw not_implemented      ; 1A
    dw not_implemented      ; 1B
    dw not_implemented      ; 1C
    dw not_implemented      ; 1D
    dw not_implemented      ; 1E
    dw not_implemented      ; 1F
    dw not_implemented      ; 20
    dw not_implemented      ; 21
    dw not_implemented      ; 22
    dw not_implemented      ; 23
    dw not_implemented      ; 24
    dw not_implemented      ; 25
    dw not_implemented      ; 26
    dw not_implemented      ; 27
    dw not_implemented      ; 28
    dw not_implemented      ; 29
    dw not_implemented      ; 2A
    dw not_implemented      ; 2B
    dw not_implemented      ; 2C
    dw not_implemented      ; 2D
    dw not_implemented      ; 2E
    dw not_implemented      ; 2F
    dw not_implemented      ; 30
    dw not_implemented      ; 31
    dw not_implemented      ; 32
    dw not_implemented      ; 33
    dw not_implemented      ; 34
    dw not_implemented      ; 35
    dw not_implemented      ; 36
    dw not_implemented      ; 37
    dw not_implemented      ; 38
    dw not_implemented      ; 39
    dw not_implemented      ; 3A
    dw not_implemented      ; 3B
    dw not_implemented      ; 3C
    dw not_implemented      ; 3D
    dw not_implemented      ; 3E
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


