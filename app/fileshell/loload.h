#pragma once

import u8 loload_buf[256];

/**
    Copy 256 bytes from loload_buf to (addr_hi << 8) in lo RAM.
 */
import u8 copy_to_loram(u8 addr_hi);
