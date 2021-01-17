#pragma once

#define NORTH 0u8
#define EAST 1u8
#define SOUTH 2u8
#define WEST 3u8

#define MAZE_MAX_SIDE 30

#define MAZE_WALL 0u8
#define MAZE_PASSAGE 1u8
#define MAZE_KEY 2u8
#define MAZE_EXIT 3u8

import u8 maze_init(u8 w, u8 h);

import u8 maze_dfs(u8 x, u8 y);

import u8 maze_show_all(u8 player_x, u8 player_y);
import u8 maze_show_los(u8 player_x, u8 player_y);

import u8 maze_set(u8 x, u8 y, u8 v);
import u8 maze_get(s8 x, s8 y);
