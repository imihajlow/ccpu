#!/usr/bin/env python3
import re
import argparse

def load_consts(f):
    r = re.compile(r"#define (PS2_KEY_\w+) (?:((?:0x)?\d+)u8|'(\\?.)')")
    for line in f.readlines():
        m = re.search(r, line)
        if m is not None:
            name = m.group(1)
            if m.group(2) is not None:
                value = int(m.group(2), 0)
            elif m.group(3) is not None:
                if m.group(3)[0] == '\\':
                    c = m.group(3)[1]
                    if c == '\\':
                        value = ord(c)
                    elif c == 'n':
                        value = 10
                    else:
                        raise RuntimeError(f"cannot parse {line.strip()}")
                else:
                    value = ord(m.group(3))
            globals()[name] = value

def gen_keymap(f):
    no_modifiers = {
        PS2_KEY_A:          'a',
        PS2_KEY_B:          'b',
        PS2_KEY_C:          'c',
        PS2_KEY_D:          'd',
        PS2_KEY_E:          'e',
        PS2_KEY_F:          'f',
        PS2_KEY_G:          'g',
        PS2_KEY_H:          'h',
        PS2_KEY_I:          'i',
        PS2_KEY_J:          'j',
        PS2_KEY_K:          'k',
        PS2_KEY_L:          'l',
        PS2_KEY_M:          'm',
        PS2_KEY_N:          'n',
        PS2_KEY_O:          'o',
        PS2_KEY_P:          'p',
        PS2_KEY_Q:          'q',
        PS2_KEY_R:          'r',
        PS2_KEY_S:          's',
        PS2_KEY_T:          't',
        PS2_KEY_U:          'u',
        PS2_KEY_V:          'v',
        PS2_KEY_W:          'w',
        PS2_KEY_X:          'x',
        PS2_KEY_Y:          'y',
        PS2_KEY_Z:          'z',
        PS2_KEY_0:          '0',
        PS2_KEY_1:          '1',
        PS2_KEY_2:          '2',
        PS2_KEY_3:          '3',
        PS2_KEY_4:          '4',
        PS2_KEY_5:          '5',
        PS2_KEY_6:          '6',
        PS2_KEY_7:          '7',
        PS2_KEY_8:          '8',
        PS2_KEY_9:          '9',
        PS2_KEY_BACKQUOTE:  '`',
        PS2_KEY_DASH:       '-',
        PS2_KEY_EQUALS:     '=',
        PS2_KEY_LBRACE:     '[',
        PS2_KEY_RBRACE:     ']',
        PS2_KEY_SEMICOLON:  ';',
        PS2_KEY_QUOTE:      "'",
        PS2_KEY_BACKSLASH:  '\\',
        PS2_KEY_PIPE:       '`',
        PS2_KEY_COMMA:      ',',
        PS2_KEY_DOT:        '.',
        PS2_KEY_SLASH:      '/',
        PS2_KEY_SPACE:      ' ',
        PS2_KEY_NUM_DIV:    '/',
        PS2_KEY_NUM_MUL:    '*',
        PS2_KEY_NUM_SUB:    '-',
        PS2_KEY_NUM_ADD:    '+',
        PS2_KEY_NUM_DOT:    '.',
        PS2_KEY_NUM_0:      '0',
        PS2_KEY_NUM_1:      '1',
        PS2_KEY_NUM_2:      '2',
        PS2_KEY_NUM_3:      '3',
        PS2_KEY_NUM_4:      '4',
        PS2_KEY_NUM_5:      '5',
        PS2_KEY_NUM_6:      '6',
        PS2_KEY_NUM_7:      '7',
        PS2_KEY_NUM_8:      '8',
        PS2_KEY_NUM_9:      '9'
    }
    shift = {
        PS2_KEY_A:          'A',
        PS2_KEY_B:          'B',
        PS2_KEY_C:          'C',
        PS2_KEY_D:          'D',
        PS2_KEY_E:          'E',
        PS2_KEY_F:          'F',
        PS2_KEY_G:          'G',
        PS2_KEY_H:          'H',
        PS2_KEY_I:          'I',
        PS2_KEY_J:          'J',
        PS2_KEY_K:          'K',
        PS2_KEY_L:          'L',
        PS2_KEY_M:          'M',
        PS2_KEY_N:          'N',
        PS2_KEY_O:          'O',
        PS2_KEY_P:          'P',
        PS2_KEY_Q:          'Q',
        PS2_KEY_R:          'R',
        PS2_KEY_S:          'S',
        PS2_KEY_T:          'T',
        PS2_KEY_U:          'U',
        PS2_KEY_V:          'V',
        PS2_KEY_W:          'W',
        PS2_KEY_X:          'X',
        PS2_KEY_Y:          'Y',
        PS2_KEY_Z:          'Z',
        PS2_KEY_0:          ')',
        PS2_KEY_1:          '!',
        PS2_KEY_2:          '@',
        PS2_KEY_3:          '#',
        PS2_KEY_4:          '$',
        PS2_KEY_5:          '%',
        PS2_KEY_6:          '^',
        PS2_KEY_7:          '&',
        PS2_KEY_8:          '*',
        PS2_KEY_9:          '(',
        PS2_KEY_BACKQUOTE:  '~',
        PS2_KEY_DASH:       '_',
        PS2_KEY_EQUALS:     '+',
        PS2_KEY_LBRACE:     '{',
        PS2_KEY_RBRACE:     '}',
        PS2_KEY_SEMICOLON:  ':',
        PS2_KEY_QUOTE:      '"',
        PS2_KEY_BACKSLASH:  '|',
        PS2_KEY_PIPE:       '~',
        PS2_KEY_COMMA:      '<',
        PS2_KEY_DOT:        '>',
        PS2_KEY_SLASH:      '?',
        PS2_KEY_SPACE:      ' ',
        PS2_KEY_NUM_DIV:    '/',
        PS2_KEY_NUM_MUL:    '*',
        PS2_KEY_NUM_SUB:    '-',
        PS2_KEY_NUM_ADD:    '+',
        PS2_KEY_NUM_DOT:    '.',
        PS2_KEY_NUM_0:      '0',
        PS2_KEY_NUM_1:      '1',
        PS2_KEY_NUM_2:      '2',
        PS2_KEY_NUM_3:      '3',
        PS2_KEY_NUM_4:      '4',
        PS2_KEY_NUM_5:      '5',
        PS2_KEY_NUM_6:      '6',
        PS2_KEY_NUM_7:      '7',
        PS2_KEY_NUM_8:      '8',
        PS2_KEY_NUM_9:      '9'
    }

    map_no_modifiers = [ord(no_modifiers[i]) if i in no_modifiers else 0xff for i in range(128)]
    map_shift = [ord(shift[i]) if i in shift else 0xff for i in range(128)]

    f.write('.export ps2_keymap\n')
    f.write('.section text.keymap\n')
    f.write('.align 256\n')
    f.write('ps2_keymap:\n')
    f.write('db ')
    f.write(','.join(f"0x{v:02X}" for v in map_no_modifiers))
    f.write('\ndb ')
    f.write(','.join(f"0x{v:02X}" for v in map_shift))
    f.write('\n')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Read keyboard scancodes and produce an asm mapping file')
    parser.add_argument('header', type=argparse.FileType("r"), help='input file name (natrix header)')
    parser.add_argument('output', type=argparse.FileType("w"), help='output file name (asm)')
    args = parser.parse_args()

    load_consts(args.header)
    gen_keymap(args.output)
