#pragma once
// #define MAZE_ASCII

#define DISPLAY_WIDTH (u8)16

#define NORTH 0u8
#define EAST 1u8
#define SOUTH 2u8
#define WEST 3u8

#define MAZE_MAX_SIDE 64

#define MAZE_WALL 0u8
#define MAZE_PASSAGE 1u8
#define MAZE_KEY 2u8
#define MAZE_EXIT 3u8

#define MAZE_MAX_SIDE 64

#ifdef MAZE_ASCII
#define CHAR_WALL '#'
#define CHAR_PASSAGE_UP '_'
#define CHAR_PASSAGE_DN 'T'
#define CHAR_PASSAGE_UPDN ' '
#define CHAR_PASSAGE 'I'

#define CHAR_PLAYER_UP '@'
#define CHAR_PLAYER_DN '@'
#define CHAR_PLAYER_UPDN '@'
#define CHAR_PLAYER '@'

#define CHAR_KEY '?'
#define CHAR_EXIT 'E'
#else
#define CHAR_WALL 0xffu8
#define CHAR_PASSAGE_UP 0x0eu8
#define CHAR_PASSAGE_DN 0x08u8
#define CHAR_PASSAGE_UPDN ' '
#define CHAR_PASSAGE 0x09u8

#define CHAR_PLAYER_UP 0x0bu8
#define CHAR_PLAYER_DN 0x0cu8
#define CHAR_PLAYER_UPDN 0x0au8
#define CHAR_PLAYER 0x0du8

#define CHAR_KEY 0xd2u8
#define CHAR_EXIT 0xfcu8
#endif

import u8 maze_init(u8 w, u8 h);

import u8 maze_dfs(u8 x, u8 y);

import u8 maze_print(u8 x, u8 y, u8 orientation);

import u8 maze_set(u8 x, u8 y, u8 v);
import u8 maze_get(s8 x, s8 y);

import u8 maze_load_cgram();
