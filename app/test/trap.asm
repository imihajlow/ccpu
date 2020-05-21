    .export trap
    .export trap_ret
    .export fail
    .section text
trap:
    jmp

fail:
    jmp
    .section bss
trap_ret: res 2
