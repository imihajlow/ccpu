    nop
    mov a, 0
loop:
    ldi pl, lo(fail)
    ldi ph, hi(fail)
    inc a
    jz
    inc a
    jz
    mov b, a
    jz
    dec a
    jz
    dec a
    jnz
    dec b
    jz
    dec b
    jnz
    ldi pl, lo(loop)
    ldi ph, hi(loop)
    jmp

    .offset 0x400
fail:
    ldi pl, lo(fail)
    ldi ph, hi(fail)
    jmp
