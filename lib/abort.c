#include <stdio.h>
#include <stdlib.h>

__attribute__((__noreturn__)) void abort(void) 
{
    printk("hypervisor abort()\n");
    while (1) { }
    __builtin_unreachable();
}
