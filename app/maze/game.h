#pragma once

#define RESULT_NO 0u8
#define RESULT_YES 1u8
#define RESULT_EXIT 2u8

import u8 game_init(u8 side);

import u8 game_print_state();

import u8 game_move_left();
import u8 game_move_right();
import u8 game_move_up();
import u8 game_move_down();

import u8 game_show_all();
