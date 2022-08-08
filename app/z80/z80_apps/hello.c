#include <string.h>
#include <stdio.h>

void foo(char *dst, int x) {
    sprintf(dst, "Hello world! x = %d", x);
}

int main(void) {
    memset((char*)0xd000, 7, 128 * 30);
    memset((char*)0xe000, 0, 128 * 30);
    foo((char*)0xe000, 1234);
    foo((char*)0xe000 + 128, -500);
    return 0;
}
