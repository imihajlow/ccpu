    .export syscall_ret
    .export syscall_arg0
    .export syscall_arg1
    .export syscall_arg2
    .export syscall_arg3
    .export syscall_arg4
    .export syscall_arg5
    .export syscall_arg6
    .export syscall_arg7
    .export last_error

    .global syscall_impl

    .section syscall_args
syscall_ret:
syscall_arg0:
    res 4
syscall_arg1:
    res 4
syscall_arg2:
    res 4
syscall_arg3:
    res 4
syscall_arg4:
    res 4
syscall_arg5:
    res 4
syscall_arg6:
    res 4
syscall_arg7:
    res 4
last_error:
    res 2

    .section syscall_text
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi pl, lo(0xff02)
    ldi ph, hi(0xff02)
    ldi a, 0x3e ; enable segments A-C, both boards, disable lo RAM
    st a

    ldi pl, lo(syscall_impl)
    ldi ph, hi(syscall_impl)
    jmp

    ldi pl, lo(0xff02)
    ldi ph, hi(0xff02)
    ldi a, 0x3f ; enable segments A-C, both boards, lo RAM
    st a

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section bss
    .align 2
ret: res 2
