#pragma once
#include <bcdf.h>

#define TOK_END 0u8
#define TOK_ERROR 255u8
// the non-normalized number is in bcdf_normalize_arg
#define TOK_NUMBER 1u8


// Returns token. Modifies str to point after the token.
import u8 tok_next(u8 **str);
