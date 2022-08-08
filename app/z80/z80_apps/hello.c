#include <string.h>
#include <stdio.h>

void foo(char *dst, int x) {
    sprintf(dst, "Hello world! x = %d", x);
    // for (int i = 0; i != x; ++i) {
    //     strcpy(dst, "hello");
    //     // *dst = 'H';
    //     dst += 6;
    // }
}

int main(void) {
    memset((char*)0xd000, 7, 128 * 30);
    // strcpy((char*)0xe000, "Hello from Z80!");
    foo((char*)0xe000, 1234);
    foo((char*)0xe000 + 128, -500);
    return 0;
}
