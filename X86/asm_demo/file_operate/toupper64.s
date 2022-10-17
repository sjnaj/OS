#syscall numbers
.equ SYS_OPEN,2
.equ SYS_WEITE,1
.equ SYS_READ,0
.equ SYS_CLOSE,3
.equ SYS_EXIT,60

#options for open
.equ O_RDONLY,0
.equ O_CREAT_WRONLY_TRUNC,03101
.equ O_PERMISSION,0666

#standard file descriptors

.equ STDIN,0
.equ STDOUT,2
.equ STDERR,3

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
.equ ST_SIZE_RESERVE,16
.equ ST_FD_IN,-8
.equ ST_FD_OUT,-16
.equ ST_ARGC,0
.equ ST_ARGV_0,8
.equ ST_ARGV_1,16
.equ ST_ARGV_2,24

.global _start
_start:

    movq %rsp,%rbp
    subq $ST_SIZE_RESERVE,%rsp#分配存放文件描述符的空间

open_files:
open_fd_in:
    movq $SYS_OPEN,%rax
    movq ST_ARGV_1(%rbp),%rdi#input filename(注意寻址时定义的常量不用加$)
    movq $O_RDONLY,%rsi
    movq $O_PERMISSION,%rdx
    syscall
store_fd_in:
    movq %rax,ST_FD_IN(%rbp)#save input file descriptor
open_fd_out:
    movq $SYS_OPEN,%rax
    movq ST_ARGV_2(%rbp),%rdi#output filename
    movq $O_CREAT_WRONLY_TRUNC,%rsi # write flag
    movq $O_PERMISSION,%rdx
    syscall
store_fd_out:
    movq %rax,ST_FD_OUT(%rbp)#save output file descriptor

###begin_main_loop###

// movq $0,%rsi
read_loop_begin:
    
    movq $SYS_READ,%rax
    movq ST_FD_IN(%rbp),%rdi
    movq $BUFFER_DATA,%rsi
    movq $BUFFER_SIZE,%rdx
    syscall

    cmpq $0,%rax


    jle end_loop


continue_read_loop:
    
    movq $BUFFER_DATA,%rsi
    movq %rax,%rdi
    movq %rax,%rbx#暂存rax
    call convert_to_upper
    movq %rbx,%rax

write_to_output:
    movq %rax,%rdx
    movq $SYS_WEITE,%rax
    movq ST_FD_OUT(%rbp),%rdi
    movq $BUFFER_DATA,%rsi
    syscall
    
    jmp read_loop_begin#continue read

end_loop:#close two file

    movq $SYS_CLOSE,%rax
    movq ST_FD_OUT(%rbp),%rdi
    syscall

    movq $SYS_CLOSE,%rax
    movq ST_FD_IN(%rbp),%rdi
    syscall

exit:
    movq $SYS_EXIT,%rax
    xor %rdi,%rdi
    syscall



#convert to upper function

.equ LOWERCASE_A,'a'
.equ LOWERCASE_Z,'z'
.equ UPPER_CONVERSION,'A'-'a'

.equ ST_BUFFER_LEN,16
.equ ST_BUFFER,24

convert_to_upper:

    movq %rsi,%rax
    xorq %r8,%r8 #count
    cmpq $0,%rdi
    je end_convert_loop

convert_loop:

    movb (%rax,%r8,1),%cl
    cmpb $LOWERCASE_A,%cl
    jl next_byte
    cmpb $LOWERCASE_Z,%cl
    jg next_byte
    addb $UPPER_CONVERSION,%cl
    movb %cl,(%rax,%r8,1)

next_byte:
    incq %r8
    cmpq %rdi,%r8
    jne convert_loop

end_convert_loop:
    ret
