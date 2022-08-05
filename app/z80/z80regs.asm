    .export z80_regs_origin
    .export z80_f
    .export z80_a
    .export z80_bc
    .export z80_c
    .export z80_b
    .export z80_de
    .export z80_e
    .export z80_d
    .export z80_hl
    .export z80_l
    .export z80_h
    .export z80_f_s
    .export z80_a_s
    .export z80_bc_s
    .export z80_c_s
    .export z80_b_s
    .export z80_de_s
    .export z80_e_s
    .export z80_d_s
    .export z80_hl_s
    .export z80_l_s
    .export z80_h_s
    .export z80_ix
    .export z80_iy
    .export z80_sp
    .export z80_i
    .export z80_r
    .export z80_pc
    .export z80_current_opcode
    .export z80_prefix
    .export z80_prefix_ed
    .export z80_prefix_dd
    .export z80_prefix_fd

    .export z80_cf
    .export z80_nf
    .export z80_pf
    .export z80_hf
    .export z80_zf
    .export z80_sf

    .export z80_indir_src
    .export z80_imm0
    .export z80_imm1

    .export z80_tmp
    .export z80_tmp2

    .section bss
    .align 64
z80_f: res 1

z80_a: res 1
z80_indir_src: res 1 ; located here because indirect operand is encoded by index 6
z80_hl:
z80_l: res 1
z80_h: res 1
z80_de:
z80_e: res 1
z80_d: res 1
z80_bc:
z80_c: res 1
z80_regs_origin:
z80_b: res 1

z80_a_s: res 1
z80_f_s: res 1
z80_hl_s:
z80_l_s: res 1
z80_h_s: res 1
z80_de_s:
z80_e_s: res 1
z80_d_s: res 1
z80_bc_s:
z80_c_s: res 1
z80_b_s: res 1

z80_ix: res 2
z80_iy: res 2
z80_sp: res 2

z80_i: res 1
z80_r: res 1

z80_pc: res 2

z80_current_opcode: res 1

z80_imm0: res 1
z80_imm1: res 1

z80_tmp: res 2
z80_tmp2: res 2

.const z80_prefix_dd = 0x20
.const z80_prefix_ed = 0x40
.const z80_prefix_fd = 0x80
z80_prefix: res 1


.const z80_cf = 1
.const z80_nf = 2
.const z80_pf = 4
.const z80_hf = 0x10
.const z80_zf = 0x40
.const z80_sf = 0x80

