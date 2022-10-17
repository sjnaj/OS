#syscall numbers
.equ SYS_OPEN,5
.equ SYS_WEITE,4
.equ SYS_READ,3
.equ SYS_CLOSE,6
.equ SYS_EXIT,1

#options for open
.equ O_RDONLY,0
.equ O_CREAT_WRONLY_TRUNC,03101
.equ O_PERMISSION,0666

#standard file descriptors

.equ STDIN,0
.equ STDOUT,2
.equ STDERR,3

#syscall interrupt
.equ LINUX_SYSCALL,0x80
.equ END_OF_FILE,0

.section .data
output_d:
    .asciz "d:%d\n"
output_s:
    .asciz "s:%s\n"
.section .bss
.equ BUFFER_SIZE,100
.lcomm BUFFER_DATA,BUFFER_SIZE



.section .text

#stack position
.equ ST_SIZE_RESERVE,8
.equ ST_FD_IN,-4
.equ ST_FD_OUT,-8
.equ ST_ARGC,0
.equ ST_ARGV_0,4
.equ ST_ARGV_1,8
.equ ST_ARGV_2,12

.global _start
_start:
    movl %esp,%ebp
    subl $ST_SIZE_RESERVE,%esp#分配存放文件描述符的空间

open_files:
open_fd_in:
    movl $SYS_OPEN,%eax
    movl ST_ARGV_1(%ebp),%ebx#input filename(注意寻址时定义的常量不用加$)
    movl $O_RDONLY,%ecx
    movl $O_PERMISSION,%edx
    int $LINUX_SYSCALL

store_fd_in:
    movl %eax,ST_FD_IN(%ebp)#save input file descriptor
open_fd_out:
    movl $SYS_OPEN,%eax
    movl ST_ARGV_2(%ebp),%ebx#output filename
    movl $O_CREAT_WRONLY_TRUNC,%ecx # write flag
    movl $O_PERMISSION,%edx
    int $LINUX_SYSCALL
store_fd_out:
    movl %eax,ST_FD_OUT(%ebp)#save output file descriptor

###begin_main_loop###

// movl $0,%esi
read_loop_begin:
    // pushl %eax
    // pushl $output_d
    // call printf
    // addl $8,%esp
    movl $SYS_READ,%eax
    movl ST_FD_IN(%ebp),%ebx
    movl $BUFFER_DATA,%ecx
    movl $BUFFER_SIZE,%edx
    int $LINUX_SYSCALL
    // incl %esi

    cmpl $0,%eax
    // cmpl $1,%esi
    // je exit
    jle end_loop

continue_read_loop:
    
    pushl $BUFFER_DATA#loc of buffer
    pushl %eax#size of data

    call convert_to_upper
    popl %eax
    addl $4,%esp#restore sp

write_to_output:
    
    movl %eax,%edx
    movl $SYS_WEITE,%eax
    movl ST_FD_OUT(%ebp),%ebx
    movl $BUFFER_DATA,%ecx
    int $LINUX_SYSCALL
    
    jmp read_loop_begin#continue read

end_loop:#close two file

    movl $SYS_CLOSE,%eax
    movl ST_FD_OUT(%ebp),%ebx
    int $LINUX_SYSCALL

    movl $SYS_CLOSE,%eax
    movl ST_FD_IN(%ebp),%ebx
    int $LINUX_SYSCALL

exit:
    movl $SYS_EXIT,%eax
    movl $0,%ebx
    int $LINUX_SYSCALL



#convert to upper function

.equ LOWERCASE_A,'a'
.equ LOWERCASE_Z,'z'
.equ UPPER_CONVERSION,'A'-'a'

.equ ST_BUFFER_LEN,8
.equ ST_BUFFER,12

convert_to_upper:
    pushl %ebp
    movl %esp,%ebp

    movl ST_BUFFER(%ebp),%eax
    movl ST_BUFFER_LEN(%ebp),%ebx
    movl $0,%edi

    cmpl $0,%ebx
    je end_convert_loop

convert_loop:
    movb (%eax,%edi,1),%cl
    cmpb $LOWERCASE_A,%cl
    jl next_byte
    cmpb $LOWERCASE_Z,%cl
    jg next_byte

    addb $UPPER_CONVERSION,%cl
    movb %cl,(%eax,%edi,1)
next_byte:
    incl %edi
    cmpl %edi,%ebx
    jne convert_loop

end_convert_loop:
    leave 
    ret
