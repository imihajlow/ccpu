    .export qp_fb
    .export qp_colors
    .export qp_render_fast
    .export qp_render_fast_ret
    .export qp_vga_clear
    .export qp_vga_clear_ret

    .global vga_color_seg
    .global vga_char_seg

    .const CHAR_BOTTOM = 220

    .section text.qp_render_fast
qp_render_fast:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(offset)
    ldi ph, hi(offset)
    mov a, 0
    st a
    inc pl
    st a
    inc pl
    st a    ; row

row_loop:
    ldi pl, lo(col)
    ldi ph, hi(col)
    mov a, 0
    st a
    col_loop:
            ; qp_fb is aligned
            ldi pl, lo(offset + 1)
            ldi ph, hi(offset)
            ld a
            dec pl
            ld pl
            ldi ph, hi(qp_fb)
            add ph, a

            ld a ; pair of quasipixels
            ldi ph, hi(qp_colors)
            ldi pl, lo(qp_colors)
            add pl, a
            ld b ; color

            ldi pl, lo(offset + 1)
            ldi ph, hi(offset)
            ld a
            dec pl
            ld pl
            ldi ph, hi(vga_color_seg)
            add ph, a
            st b

            ldi pl, lo(offset)
            ldi ph, hi(offset)
            ld a
            inc a
            st a

            ldi pl, lo(col)
            ld a
            inc a
            st a
            ldi b, 80
            sub b, a
            ldi pl, lo(col_loop)
            ldi ph, hi(col_loop)
            jnz

        ldi pl, lo(offset)
        ldi ph, hi(offset)
        ldi b, 0x80
        ld a
        and a, b
        add a, b
        st a
        ldi pl, lo(offset + 1)
        ld b
        mov a, 0
        adc b, a
        st b

        inc pl ; row
        ld a
        inc a
        st a
        ldi b, 30
        sub b, a
        ldi pl, lo(row_loop)
        ldi ph, hi(row_loop)
        jnz

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section text.qp_vga_clear
qp_vga_clear:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(offset)
    ldi ph, hi(offset)
    mov a, 0
    st a
    inc pl
    ldi b, hi(vga_char_seg)
    st b
    inc pl
    st a    ; row

clear_row_loop:
    ldi pl, lo(col)
    ldi ph, hi(col)
    mov a, 0
    st a
    ldi b, CHAR_BOTTOM
    clear_col_loop:
            ; qp_fb is aligned
            ldi pl, lo(offset)
            ldi ph, hi(offset)
            ld a
            inc pl
            ld ph
            mov pl, a
            st b

            ldi pl, lo(offset)
            ldi ph, hi(offset)
            ld a
            inc a
            st a

            ldi pl, lo(col)
            ld a
            inc a
            st a
            ldi pl, 80
            sub pl, a
            ldi pl, lo(clear_col_loop)
            ldi ph, hi(clear_col_loop)
            jnz

        ldi pl, lo(offset)
        ldi ph, hi(offset)
        ldi b, 0x80
        ld a
        and a, b
        add a, b
        st a
        ldi pl, lo(offset + 1)
        ld b
        mov a, 0
        adc b, a
        st b

        inc pl ; row
        ld a
        inc a
        st a
        ldi b, 30
        sub b, a
        ldi pl, lo(clear_row_loop)
        ldi ph, hi(clear_row_loop)
        jnz

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp


    .section bss.qp_fb
    .align 0x100
qp_fb:
    res 30 * 128

    .align 16
qp_render_fast_ret:
qp_vga_clear_ret:
qp_colors:
    res 4
ret:
    res 2
offset:
    res 2
row:
    res 1
col:
    res 1
