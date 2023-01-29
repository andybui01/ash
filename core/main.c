#include <stdint.h>
#include <stdio.h>
 
void main(uint32_t dtb_pa) {
    printk("Hello world!\n");
    uint32_t *temp = (uint32_t *) dtb_pa;
    printk("%x\n", *temp);
    for (int i = 0; i < 4; i++) {
        printk("%x\n", *((uint8_t *)temp + i));
    }

}
