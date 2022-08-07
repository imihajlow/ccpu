#include <string.h>

int main(void) {
    memset((char*)0xd000, 7, 80);
    strcpy((char*)0xe000, "Hello from Z80!");
    return 0;
}
