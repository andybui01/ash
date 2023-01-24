#pragma once
#include <stdint.h>

__attribute__((__noreturn__)) void abort(void);
char *itoa(int value, char *buffer, int base);
