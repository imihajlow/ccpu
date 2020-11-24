; ALU test program
; If any of the tests fails, program jumps to one of the fail_* labels and goes into an infinite loop there.
; Each of the fail labels is aligned by 0x100 starting from 0x1000.
; This way you can observe the fail "code" on the address bus display and find out which of the tests has failed.

    .section text
    nop
begin:
    ; check if sub and invert work
    ldi a, 0xa5
    ldi b, 0xa5
    ldi pl, lo(fail_initial)
    ldi ph, hi(fail_initial)
    sub a, b ; a = 0x00, b = 0xa5
    jnz
    ldi a, 0xa5
    sub b, a ; a = 0xa5, b = 0x00
    jnz
    sub b, a ; a = 0xa5, b = 0x5b
    jz
    sub a, b ; a = 0x4a, b = 0x5b
    jz

not:
    ldi ph, hi(fail_not)
    ldi a, 0xa5
    not a
    jz
    js
    jc
    ldi b, 0x5a
    sub a, b
    jnz

and:
    ldi ph, hi(fail_and)
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
    ldi ph, hi(fail_or)
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
    ldi ph, hi(fail_shl)
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
    ldi ph, hi(fail_shr)
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
    ldi ph, hi(fail_sar)
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
    ldi ph, hi(fail_exp)
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
    ldi ph, hi(fail_xor)
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
    ldi ph, hi(fail_add)
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
    ldi ph, hi(fail_adc)
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
    ldi ph, hi(fail_sub)
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
    ldi ph, hi(fail_sbb)
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
    ldi ph, hi(fail_inc)
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
    ldi ph, hi(fail_dec)
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
    ldi ph, hi(fail_mov)
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
fail_initial:
    ; a = 0xfe, b = 0x81
    ldi pl, lo(fail_initial)
    ldi ph, hi(fail_initial)
    jmp

    .align 0x100
fail_not:
    ldi pl, lo(fail_not)
    ldi ph, hi(fail_not)
    jmp

    .align 0x100
fail_and:
    ldi pl, lo(fail_and)
    ldi ph, hi(fail_and)
    jmp

    .align 0x100
fail_or:
    ldi pl, lo(fail_or)
    ldi ph, hi(fail_or)
    jmp

    .align 0x100
fail_shl:
    ldi pl, lo(fail_shl)
    ldi ph, hi(fail_shl)
    jmp

    .align 0x100
fail_shr:
    ldi pl, lo(fail_shr)
    ldi ph, hi(fail_shr)
    jmp

    .align 0x100
fail_sar:
    ldi pl, lo(fail_sar)
    ldi ph, hi(fail_sar)
    jmp

    .align 0x100
fail_exp:
    ldi pl, lo(fail_exp)
    ldi ph, hi(fail_exp)
    jmp

    .align 0x100
fail_xor:
    ldi pl, lo(fail_xor)
    ldi ph, hi(fail_xor)
    jmp

    .align 0x100
fail_add:
    ldi pl, lo(fail_add)
    ldi ph, hi(fail_add)
    jmp

    .align 0x100
fail_adc:
    ldi pl, lo(fail_adc)
    ldi ph, hi(fail_adc)
    jmp

    .align 0x100
fail_sub:
    ldi pl, lo(fail_sub)
    ldi ph, hi(fail_sub)
    jmp

    .align 0x100
fail_sbb:
    ldi pl, lo(fail_sbb)
    ldi ph, hi(fail_sbb)
    jmp

    .align 0x100
fail_inc:
    ldi pl, lo(fail_inc)
    ldi ph, hi(fail_inc)
    jmp

    .align 0x100
fail_dec:
    ldi pl, lo(fail_dec)
    ldi ph, hi(fail_dec)
    jmp

    .align 0x100
fail_mov:
    ldi pl, lo(fail_mov)
    ldi ph, hi(fail_mov)
    jmp
