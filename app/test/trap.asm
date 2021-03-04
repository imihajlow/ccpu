    .export trap
    .export trap_ret
    .export fail
    .export fail_ret
    .section text.trap
trap:
    jmp

fail:
    jmp
    .section bss.trap
fail_ret:
trap_ret: res 2
