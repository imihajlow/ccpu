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

    .export open
    .export open_arg0
    .export open_ret

    .export read
    .export read_arg0
    .export read_arg1
    .export read_arg2
    .export read_ret

    .export write
    .export write_arg0
    .export write_arg1
    .export write_arg2
    .export write_ret

    .export close
    .export close_arg0
    .export close_ret

    .export truncate
    .export truncate_arg0
    .export truncate_ret

    .export seek_end
    .export seek_end_arg0
    .export seek_end_ret

    .export get_size
    .export get_size_arg0
    .export get_size_ret

    .export open_dir
    .export open_dir_arg0
    .export open_dir_ret

    .export get_next_dir_entry
    .export get_next_dir_entry_arg0
    .export get_next_dir_entry_arg1
    .export get_next_dir_entry_arg2
    .export get_next_dir_entry_ret

    .export mount
    .export mount_ret

    .section syscall_args
syscall_ret:
syscall_arg0:
open_ret:
read_ret:
write_ret:
close_ret:
truncate_ret:
seek_end_ret:
get_size_ret:
open_dir_ret:
get_next_dir_entry_ret:
mount_ret:
    res 4
syscall_arg1:
open_arg0:
read_arg0:
write_arg0:
close_arg0:
truncate_arg0:
seek_end_arg0:
get_size_arg0:
open_dir_arg0:
get_next_dir_entry_arg0:
    res 4
syscall_arg2:
read_arg1:
write_arg1:
get_next_dir_entry_arg1:
    res 4
syscall_arg3:
read_arg2:
write_arg2:
get_next_dir_entry_arg2:
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

    .section text.open
open:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    mov a, 0
    ldi pl, lo(jmp_syscall)
    ldi ph, hi(jmp_syscall)
    jmp

    .section text.read
read:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi a, 1
    ldi pl, lo(jmp_syscall)
    ldi ph, hi(jmp_syscall)
    jmp

.section text.write
write:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi a, 2
    ldi pl, lo(jmp_syscall)
    ldi ph, hi(jmp_syscall)
    jmp

.section text.close
close:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi a, 3
    ldi pl, lo(jmp_syscall)
    ldi ph, hi(jmp_syscall)
    jmp

.section text.truncate
truncate:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi a, 4
    ldi pl, lo(jmp_syscall)
    ldi ph, hi(jmp_syscall)
    jmp

.section text.seek_end
seek_end:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi a, 5
    ldi pl, lo(jmp_syscall)
    ldi ph, hi(jmp_syscall)
    jmp

.section text.get_size
get_size:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi a, 6
    ldi pl, lo(jmp_syscall)
    ldi ph, hi(jmp_syscall)
    jmp

.section text.open_dir
open_dir:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi a, 7
    ldi pl, lo(jmp_syscall)
    ldi ph, hi(jmp_syscall)
    jmp

.section text.get_next_dir_entry
get_next_dir_entry:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi a, 8
    ldi pl, lo(jmp_syscall)
    ldi ph, hi(jmp_syscall)
    jmp

    .section text.mount
mount:
    mov a, pl
    mov b, a
    mov a, ph
    ldi pl, lo(ret)
    ldi ph, hi(ret)
    st b
    inc pl
    st a

    ldi a, 9
    ldi pl, lo(jmp_syscall)
    ldi ph, hi(jmp_syscall)
    jmp

    .section text.jmp_syscall
jmp_syscall:
    ldi pl, lo(syscall_arg0)
    ldi ph, hi(syscall_arg0)
    st a

    ldi pl, lo(syscall)
    ldi ph, hi(syscall)
    jmp

    ldi pl, lo(ret)
    ldi ph, hi(ret)
    ld a
    inc pl
    ld ph
    mov pl, a
    jmp

    .section bss.syscall_return
    .align 2
ret:
    res 2
