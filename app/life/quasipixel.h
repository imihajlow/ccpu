#pragma once

#define QP_WIDTH 80u8
#define QP_HEIGHT 60u8
#define QP_SIZE (80u16 * 60u16)

import u8 qp_init(u8 fg_color, u8 bg_color);

/*
    Sets the pixel to the value v, but doesn't render.
 */
import u8 qp_set(u8 x, u8 y, u8 v);

/*
    Sets the pixel to the value v and renders it immediately.
 */
import u8 qp_set_and_render(u8 x, u8 y, u8 v);

/*
    Renders all pixels set with qp_set().
 */
import u8 qp_render();

import u8 qp_render_all();

import u8 qp_set_cursor_enabled(u8 enabled);
import u8 qp_set_cursor_pos(u8 x, u8 y);
import u8 qp_move_cursor(s8 dx, s8 dy);

import u8 qp_cursor_x;
import u8 qp_cursor_y;
