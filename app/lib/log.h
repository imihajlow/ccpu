#pragma once

// #define DISABLE_LOG

#ifndef DISABLE_LOG
import u8 log_string(u8 *s);
import u8 log_u8(u8 x);
import u8 log_u16(u16 x);
import u8 log_u32(u32 x);
#else
#define log_string(s)
#define log_u8(s)
#define log_u16(s)
#define log_u32(s)
#endif
