    .export syscall_ret
    .export syscall_arg0
    .export syscall_arg1
    .export syscall_arg2
    .export syscall_arg3
    .export syscall_arg4
    .export syscall_arg5
    .export syscall_arg6
    .export syscall_arg7
    .export syscall_last_error
    .export syscall

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
syscall_last_error:
    res 2

    .section syscall_text
syscall:
