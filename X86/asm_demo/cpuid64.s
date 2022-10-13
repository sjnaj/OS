.section .data
output:
        .asciz "The processor Vendor ID is '%s'\n"
.section .bss
        .lcomm buffer, 12
.section .text
.globl _start
_start:
        movl $0, %eax
        cpuid
        movl $buffer, %edi
        movl %ebx, (%edi)
        movl %edx, 4(%edi)
        movl %ecx, 8(%edi)
        movq    $buffer,%rsi
        movq    $output,%rdi
        movl    $0, %eax
        call printf
        pushq $0
        call exit