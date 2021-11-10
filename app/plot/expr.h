#pragma once
#include "tokenizer.h"


#define PARSE_SUCCESS 0u8
#define PARSE_ERR_OUT_OF_NODES 1u8
#define PARSE_ERR_OUT_OF_OPERATORS 2u8
#define PARSE_ERR_BRACKETS 3u8
#define PARSE_ERR_TOO_FEW_OPERANDS 4u8
#define PARSE_ERR_TOO_MANY_OPERANDS 5u8
#define PARSE_ERR_UNKNOWN 255u8

// Returns error code
import u8 parse(u8 *str);
import u8 print_tree();
import struct Bcdf *evaluate(struct Bcdf *vars);
