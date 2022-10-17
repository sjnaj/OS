
.section .bss
   .lcomm buffer, 10
   .lcomm filehandle, 4
.section .text
.globl _start
_start:
   nop
   movq %rsp, %rbp;//赋值rsp给rbp。
   movl $2, %eax;//打开文件open系统调用
   movq 16(%rbp), %rdi;//使用输入的参数为文件名字
   movq $00, %rsi;//flag为只读
   movq $0444, %rdx;//权限为只读
   syscall
   test %eax, %eax
   js badfile
   movl %eax, filehandle;//保存文件句柄，给read/write的系统调用使用
 
read_loop:
   movl $0, %eax
   movq filehandle, %rdi;//文件句柄
   movq $buffer, %rsi
   movq $10, %rdx;//每次10个
   syscall
   test %eax, %eax
   jz done;//读完跳出
   js done
   movl %eax, %edx
 
   movl $1, %eax;//写入系统调用
   movq $1, %rdi;//写到stdout
   movq $buffer, %rsi;//字符串
   syscall
   test %eax, %eax
   js badfile
   jmp read_loop
 
done:
   movl $3, %eax
   movq filehandle, %rdi
   syscall
 
badfile:
   movl %eax, %ebx
   movl $60, %eax
   syscall