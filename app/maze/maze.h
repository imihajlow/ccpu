#pragma once

#define DISPLAY_WIDTH (u8)16

#define NORTH (u8)0
#define EAST (u8)1
#define SOUTH (u8)2
#define WEST (u8)3

#define MAZE_MAX_SIDE 64

#define MAZE_WALL (u8)0
#define MAZE_PASSAGE (u8)1

#define MAZE_MAX_SIDE 64

#define CHAR_WALL '#'
#define CHAR_PASSAGE_UP '_'
#define CHAR_PASSAGE_DN 'T'
#define CHAR_PASSAGE_UPDN ' '
#define CHAR_PASSAGE 'I'

#define CHAR_PLAYER_UP '@'
#define CHAR_PLAYER_DN '@'
#define CHAR_PLAYER_UPDN '@'
#define CHAR_PLAYER '@'

import u8 maze_init(u8 w, u8 h);

import u8 maze_dfs(u8 x, u8 y);

import u8 maze_print(u8 x, u8 y, u8 orientation);
