#include "UART.h"

static const int a = 7;
static int b = 8;
static int sum;
static int onemore = 0;

void main() {
    sum = a+b;
    onemore = one() + b;
    print_uart0("hello world");
}