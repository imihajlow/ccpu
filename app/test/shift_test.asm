.section text
    nop
loop:
    ldi pl, lo(fail)
    ldi ph, hi(fail)
    ldi b, 1

    shl b ; 2
    jz
    jc
    js

    shl b ; 4
    jz
    jc
    js

    shl b ; 8
    jz
    jc
    js

    shl b ; 16
    jz
    jc
    js

    shl b ; 32
    jz
    jc
    js

    shl b ; 64
    jz
    jc
    js

    shl b ; 128
    jz
    jc
    jns

    shl b ; 0
    jnz
    jnc
    js

    ldi pl, lo(loop)
    ldi ph, hi(loop)
    jmp


    .align 0x400
fail:
    ldi pl, lo(fail)
    ldi ph, hi(fail)
    jmp
