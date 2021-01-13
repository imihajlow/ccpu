#pragma once

#define QP_WIDTH 80u8
#define QP_HEIGHT 60u8
#define QP_SIZE (80u16 * 60u16)
#define QP_INDEX(x, y) ((u16)(x) + (u16)(y) * (u16)QP_WIDTH)

import u8 qp_init(u8 fg_color, u8 bg_color);
import u8 qp_render_all();
import u8 qp_render_one(u8 x, u8 y);
import u8 qp_set_cursor_enabled(u8 enabled);
import u8 qp_set_cursor_pos(u8 x, u8 y);
import u8 qp_move_cursor(s8 dx, s8 dy);

import u8 qp_fb[QP_SIZE];
import u8 qp_cursor_x;
import u8 qp_cursor_y;
