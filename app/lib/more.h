#pragma once
#include <ps2keyboard.h>

import u8 more_init(u8 color);

// Returns 1 if everything was printed, 0 if user interrupted the output (by pressing escape on more).
import u8 more_print(u8 *s, u16 max_len);

// Returns PS2 key pressed on MORE or 0 if text fits into screen.
import u8 more_putchar(u8 c);
