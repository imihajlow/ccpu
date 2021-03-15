#pragma once

#define SYSCALL_OPEN 0u8
#define SYSCALL_READ 1u8
#define SYSCALL_WRITE 2u8
#define SYSCALL_CLOSE 3u8
#define SYSCALL_TRUNCATE 4u8
#define SYSCALL_SEEK_END 5u8
#define SYSCALL_GET_SIZE 6u8
#define SYSCALL_OPEN_DIR 7u8
#define SYSCALL_GET_NEXT_DIR_ENTRY 8u8

import u32 syscall(u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 arg5, u32 arg6, u32 arg7);
