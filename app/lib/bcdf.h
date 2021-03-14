#pragma once

struct Bcdf {
    u8 sign; // 0 - positive, 0xff - negative
    s8 exp;
    u8 man[14];
};

import struct Bcdf bcdf_op_a;
import struct Bcdf bcdf_op_b;
import struct Bcdf bcdf_op_r;
import struct Bcdf bcdf_normalize_arg;

import u8 bcdf_normalize();
import u8 bcdf_add();
import u8 bcdf_sub();
import u8 bcdf_mul();
import u8 bcdf_div();
import u8 vga_console_print_bcdf(struct Bcdf x, u8 max_width);
