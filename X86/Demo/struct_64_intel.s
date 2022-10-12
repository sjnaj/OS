	.file	"struct.c"
	.intel_syntax noprefix
	.text
	.globl	get_j
	.type	get_j, @function
get_j:
.LFB0:
	.cfi_startproc
	endbr64
	movsx	rdi, edi
	lea	rdx, [rdi+rdi*2]
	lea	rax, a[rip]
	movsx	eax, WORD PTR 8[rax+rdx*4]
	ret
	.cfi_endproc
.LFE0:
	.size	get_j, .-get_j
	.comm	a,120,32
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
