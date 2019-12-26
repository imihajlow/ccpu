        ldi ph, hi(in_a)
        ldi pl, lo(in_a)
        ld  a
        ldi pl, lo(in_b)
        ld  b
        ldi pl, lo(out)
        add a, b
        st  a

        ldi pl, lo(in_a) + 1
        ld  a
        ldi pl, lo(in_b) + 1
        ld  b
        ldi pl, lo(out) + 1
        adc a, b
        st  a

        ldi pl, lo(in_a) + 2
        ld  a
        ldi pl, lo(in_b) + 2
        ld  b
        ldi pl, lo(out) + 2
        adc a, b
        st  a

        ldi pl, lo(in_a) + 3
        ld  a
        ldi pl, lo(in_b) + 3
        ld  b
        ldi pl, lo(out) + 3
        adc a, b
        st  a

        ldi ph, hi(finish)
        ldi pl, lo(finish)
        jmp
        .align 16
in_a:   dd 0x11223344
in_b:   dd 0x224466ff
out:    dd 0

        .offset 0x1000
finish:
