#include "UART.h"

static const int a = 7;
static int b = 8;
static int sum;
/*static int onemore = 0;*/

void main() {
    char a[10];
    read_str(a, 10); 
    write_str(a);
    write('\n');

    unsigned int b;
    read_int(&b);
    write_int(b);
    write('\n');
}
