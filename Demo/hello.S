#include <sys/syscall.h>
.global _start
_start:
    movq $SYS_write,%rax
    movq $1,%rdi
    movq $st,%rsi
    movq $(ed-st),%rdx
    syscall
    movq $SYS_exit,%rax
    movq $1,%rdi
    syscall

st:
    .asciz "\033[01;31mHello,World\033[0m\n"
ed:
