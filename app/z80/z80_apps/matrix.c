#include <stdlib.h>
#include <string.h>

typedef unsigned char u8;
typedef signed char s8;
typedef unsigned int u16;
typedef signed int s16;

#define VGA_COLS 80
#define VGA_ROWS 30
#define VGA_OFFSET(c,r) ((c) + (((u16)r) << 7))

#define VGA_CHAR_SEG ((u8*)0xe000)
#define VGA_COLOR_SEG ((u8*)0xd000)

#define COLOR_BLACK 0
#define COLOR_BLUE 1
#define COLOR_GREEN 2
#define COLOR_CYAN 3
#define COLOR_RED 4
#define COLOR_MAGENTA 5
#define COLOR_BROWN 6
#define COLOR_GRAY 7
#define COLOR_DARK_GRAY 8
#define COLOR_LIGHT_BLUE 9
#define COLOR_LIGHT_GREEN 10
#define COLOR_LIGHT_CYAN 11
#define COLOR_LIGHT_RED 12
#define COLOR_LIGHT_MAGENTA 13
#define COLOR_YELLOW 14
#define COLOR_WHITE 15

#define COLOR(fg, bg) ((fg) + ((bg) << 4))

#define N_TRACERS 32
#define CHAR_STEP 57

struct Pos {
    u8 col;
    s8 row;
};

u8 c;

struct Pos tracers[N_TRACERS];
struct Pos erasers[N_TRACERS];

void new_tracer(u8 i) {
    u16 col = rand() % VGA_COLS;
    u16 row = rand() % 5;
    u16 length = rand() % 20;
    tracers[i].col = col;
    tracers[i].row = -row;

    erasers[i].col = col;
    erasers[i].row = -row - length - 5;
}

void main(void) {
    memset(VGA_COLOR_SEG, COLOR(COLOR_GREEN, COLOR_BLACK), 30 * 128);
    memset(VGA_CHAR_SEG, 0, 30 * 128);

    c = 'a';
    for (u8 i = 0; i < N_TRACERS; i += 1) {
        new_tracer(i);
    }

    while (1) {
        // u8 key = ps2_get_key_event();
        // if (key == PS2_KEY_ESCAPE) {
        //     break;
        // }
        u8 col;
        s8 row;
        u8 i;
        for (i = 0; i < N_TRACERS; i += 1) {
            col = erasers[i].col;
            row = erasers[i].row;
            if (row >= 0) {
                VGA_CHAR_SEG[VGA_OFFSET(col, row)] = 0;
            }
            row += 1;
            if (row < (s8)VGA_ROWS) {
                erasers[i].row = row;
            } else {
                new_tracer(i);
            }
        }
        for (i = 0; i < N_TRACERS; i += 1) {
            row = tracers[i].row;
            if (row < (s8)VGA_ROWS) {
                col = tracers[i].col;
                if (row >= 0) {
                    VGA_COLOR_SEG[VGA_OFFSET(col, row)] = COLOR(COLOR_GREEN, COLOR_BLACK);
                }
                row += 1;
                tracers[i].row = row;
                if (row >= 0) {
                    u16 offset = VGA_OFFSET(col, row);
                    VGA_COLOR_SEG[offset] = COLOR(COLOR_WHITE, COLOR_BLACK);
                    VGA_CHAR_SEG[offset] = c;
                    c = (c + CHAR_STEP) & 0x7f;
                }
            }
        }
    }
}
