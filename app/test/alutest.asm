.section text
    nop
begin:
    ; check if sub and invert work
    ldi a, 0xa5
    ldi b, 0xa5
    ldi pl, lo(fail)
    ldi ph, hi(fail)
    sub a, b
    jnz
    ldi a, 0xa5
    sub b, a
    jnz
    sub b, a
    jz
    sub a, b
    jz

not:
    ldi a, 0xa5
    not a
    jz
    js
    jc
    ldi b, 0x5a
    sub a, b
    jnz

and:
    ldi a, 0xff
    ldi b, 0xa5
    and a, b
    jz
    jns
    jc
    sub a, b
    jnz

    ldi a, 0x00
    ldi b, 0x5a
    and a, b
    jnz
    js
    jc

or:
    ldi a, 0xa5
    ldi b, 0x5a
    or a, b
    jz
    jns
    jc
    ldi b, 0xff
    sub a, b
    jnz

    ldi a, 0xa0
    ldi b, 0x05
    or a, b
    jz
    jns
    jc
    ldi b, 0xa5
    sub a, b
    jnz

shl:
    ldi a, 0x5a
    shl a
    jz
    jc
    jns
    ldi b, 0xb4
    sub b, a
    jnz

    shl a
    jz
    jnc
    js
    ldi b, 0x68
    sub b, a
    jnz

shr:
    ldi a, 0xa5
    shr a
    jz
    jnc
    js
    ldi b, 0x52
    sub b, a
    jnz

    shr a
    jz
    jc
    js
    ldi b, 0x29
    sub b, a
    jnz

sar:
    ldi a, 0xa5
    sar a
    jz
    jnc
    jns
    ldi b, 0xd2
    sub b, a
    jnz

    ldi a, 0x5a
    sar a
    jz
    jc
    js
    ldi b, 0x2d
    sub b, a
    jnz

    ldi a, 0x01
    sar a
    jnz
    js
    jnc


exp:
    ldi a, 0x01
    sar a
    exp a
    jz
    jc
    jns
    ldi b, 0xff
    sub b, a
    jnz

    ldi a, 0x20
    sar a
    exp a
    jnz
    jc
    js

xor:
    ldi a, 0xa5
    ldi b, 0x33
    xor a, b
    jz
    jc
    jns
    ldi b, (0xa5 ^ 0x33)
    sub b, a
    jnz

add:
    ldi a, 0xef
    ldi b, 0x01
    add a, b
    jz
    jc
    jns
    jo
    ldi b, 0xef + 0x01
    sub a, b
    jnz

    ldi a, 0xf3
    ldi b, 0x14
    add a, b
    jz
    jnc
    js
    jo
    ldi b, 0x07
    sub a, b
    jnz

    ldi a, 127
    ldi b, 126
    add a, b
    jz
    jc
    jns
    jno
    ldi b, 253
    sub a, b
    jnz

adc:
    ldi a, 1
    sar a
    ldi a, 0xff
    ldi b, 0
    adc a, b
    jnz
    jnc
    js
    jo

    ldi a, 0x02
    ldi b, 0x20
    adc a, b
    jz
    jc
    js
    jo
    ldi b, 0x23
    sub a, b
    jnz
    jc

    ldi a, 127
    ldi b, 1
    adc a, b
    jz
    jns
    jno
    jc
    ldi b, 128
    sub a, b
    jnz
    jc

    ldi a, 8
    ldi b, 2
    adc a, b
    jz
    js
    jo
    jc
    ldi b, 10
    sub a, b
    jnz

sub:
    ldi a, 1
    ldi b, 2
    sub a, b
    jz
    jns
    jo
    jnc
    ldi b, 0xff
    sub b, a
    jnz

    ldi a, 127
    ldi b, -127
    sub a, b
    jz
    jno
    jnc
    jns
    ldi b, 254
    sub a, b
    jnz

sbb:
    ldi a, 3
    sar a
    ldi b, 0
    sbb a, b
    jnz
    jc
    js
    jo

    ldi a, 1
    ldi b, 0
    sbb a, b
    jz
    jc
    js
    jo
    ldi b, 1
    sub a, b
    jnz

    ldi a, 1
    sar a
    ldi a, -128
    ldi b, 0
    sbb a, b
    jz
    jc
    js
    jno
    ldi b, 127
    sub b, a
    jnz

inc:
    ldi a, 0xa5
    inc a
    jz
    jns
    jc
    jo
    ldi b, 0xa6
    sub b, a
    jnz

    ldi a, 127
    inc a
    jz
    jns
    jc
    jno
    ldi b, 128
    sub b, a
    jnz

dec:
    ldi a, 0xa5
    dec a
    jz
    jns
    jc
    jo
    ldi b, 0xa4
    sub b, a
    jnz

    ldi a, 0x00
    dec a
    jz
    jns
    jnc
    jo
    ldi b, 0xff
    sub b, a
    jnz

    ldi a, -128
    dec a
    jz
    js
    jno
    jc
    ldi b, 127
    sub b, a
    jnz

mov:
    ldi a, 0xa5
    ldi b, 0x5a
    mov a, b
    sub b, a
    jnz

    mov a, 0
    ldi b, 0
    sub b, a
    jnz

    ldi pl, lo(begin)
    ldi ph, hi(begin)
    jmp

    .align 0x1000
fail:
    ldi pl, lo(fail)
    ldi ph, hi(fail)
    jmp
