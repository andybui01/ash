.global _start
_start:
    ldr x30, =stack_top
    mov sp, x30
    str     x2, [sp, #4]
    bl main
    b .
