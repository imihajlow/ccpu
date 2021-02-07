    .global vga_char_seg
    .global vga_color_seg
    .global keyboard_wait_key_released

    .export vga_demo
    .export vga_demo_ret

    .section text
vga_demo:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(color)
    ldi ph, hi(color)
    ldi a, 7
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

            ; a:b - offset
            ldi ph, hi(vga_color_seg)
            add ph, a
            mov a, b
            mov pl, a
            shl a
            shl a
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

    ldi pl, lo(keyboard_wait_key_released)
    ldi ph, hi(keyboard_wait_key_released)
    jmp

finish:
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section bss
    .align 8
vga_demo_ret:
ret:
    res 2
row: res 2
col: res 2
color: res 2
