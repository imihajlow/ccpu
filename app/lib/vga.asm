.export vga_clear
.export vga_clear_arg0
.export vga_clear_ret

.export vga_put_text
.export vga_put_text_arg0
.export vga_put_text_arg1
.export vga_put_text_arg2
.export vga_put_text_ret
.export vga_char_seg
.export vga_color_seg

.const vga_char_seg = 0xe000
.const vga_color_seg = 0xd000

.section text.vga_clear

vga_clear:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(row)
    ldi ph, hi(row)
    mov a, 0
    st a
    inc pl
    st a

fill_row_loop:
    ldi pl, lo(col)
    ldi ph, hi(col)
    mov a, 0
    st a
    fill_col_loop:
            ldi pl, lo(row)
            ldi ph, hi(row)
            ld b
            ldi pl, lo(col)
            ld a
            add b, a
            ldi pl, lo(row + 1)
            ld a
            adc a, 0

            ldi pl, lo(color)
            ld pl

            ; a:b - offset, pl - color
            ldi ph, hi(vga_color_seg)
            add ph, a
            mov a, b
            xor a, pl
            xor pl, a
            xor a, pl
            st a
            inc pl
            st a

            ldi a, 0x10
            add ph, a
            mov a, 0
            st a
            dec pl
            st a

            ldi pl, lo(col)
            ldi ph, hi(col)
            ld a
            inc a
            inc a
            st a
            ldi b, 80
            sub a, b
            ldi pl, lo(fill_col_loop)
            ldi ph, hi(fill_col_loop)
            jnz
        ldi pl, lo(row)
        ldi ph, hi(row)
        ld b
        ldi a, 128
        add b, a
        ldi pl, lo(row + 1)
        ld a
        adc a, 0
        st a
        dec pl
        st b
        ldi b, 15
        sub a, b
        ldi pl, lo(fill_row_loop)
        ldi ph, hi(fill_row_loop)
        jnz

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

.section text.vga_put_text
vga_put_text:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ; pos := (arg1 << 7) + vga_char_seg + col
    ldi pl, lo(vga_put_text_arg1)
    ldi ph, hi(vga_put_text_arg1)
    ld b
    shr b
    exp pl
    ldi a, 0x80
    and a, pl
    ldi pl, lo(col)
    ldi ph, hi(col)
    ld pl
    add a, pl
    ldi pl, lo(pos)
    ldi ph, hi(pos)
    st a
    inc pl
    ldi a, hi(vga_char_seg)
    add a, b
    st a

vga_put_text_loop:
    ldi pl, lo(vga_put_text_arg2)
    ldi ph, hi(vga_put_text_arg2)
    ld a
    inc pl
    ld ph
    mov pl, a

    ; P = string pointer
    ld b

    ; exit if char == 0
    mov a, 0
    add b, a
    ldi pl, lo(vga_put_text_end)
    ldi ph, hi(vga_put_text_end)
    jz

    ; store char
    ldi pl, lo(pos)
    ldi ph, hi(pos)
    ld a
    inc pl
    ld ph
    mov pl, a
    st b

    ; increment position
    ldi pl, lo(pos)
    ldi ph, hi(pos)
    inc a
    st a

    ; increment string pointer
    ldi pl, lo(vga_put_text_arg2)
    ldi ph, hi(vga_put_text_arg2)
    ld b
    inc pl
    ld a
    inc b
    adc a, 0
    st a
    dec pl
    st b

    ldi pl, lo(vga_put_text_loop)
    ldi ph, hi(vga_put_text_loop)
    jmp

vga_put_text_end:
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp


.section bss.vga
.align 8
vga_clear_arg0: ; color
vga_clear_ret:
color: res 1
pos:
row: res 2
vga_put_text_arg0: ; col
col: res 1

.align 8
vga_put_text_ret:
vga_put_text_arg1: res 1 ; row
vga_put_text_arg2: res 2 ; string pointer

.align 2
ret: res 2
