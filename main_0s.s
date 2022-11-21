	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"f:r:"
.LC1:
	.string	":"
.LC2:
	.string	"r"
.LC3:
	.string	"Wrong input file name!"
.LC4:
	.string	"%Lf"
.LC5:
	.string	"w"
.LC6:
	.string	"Wrong output file name!"
.LC7:
	.string	"Following floating point number was generated: %Lf \n"
.LC8:
	.string	"Enter x: "
.LC9:
	.string	"tan(x) = %Lf"
.LC12:
	.string	"\nTime taken to execute this program: %f\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB36:
	.cfi_startproc
	endbr64
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	lea	rcx, longOptions.0[rip]
	lea	rdx, .LC0[rip]
	push	rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	push	rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	sub	rsp, 96
	.cfi_def_cfa_offset 128
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 88[rsp], rax
	xor	eax, eax
	lea	r8, 28[rsp]
	mov	DWORD PTR 28[rsp], 0
	call	getopt_long@PLT
	mov	rbp, QWORD PTR stdout[rip]
	cmp	eax, 102
	je	.L2
	cmp	eax, 114
	jne	.L15
	mov	rdi, QWORD PTR optarg[rip]
	lea	rsi, .LC1[rip]
	call	strtok@PLT
	mov	edx, 10
	xor	esi, esi
	mov	rdi, rax
	call	strtol@PLT
	mov	ebx, eax
	call	randLongDouble@PLT
	lea	rdx, .LC7[rip]
	mov	esi, 1
	xor	eax, eax
	fld	st(0)
	fstp	TBYTE PTR 32[rsp]
	push	rdi
	.cfi_def_cfa_offset 136
	push	rdi
	.cfi_def_cfa_offset 144
	mov	rdi, rbp
	fstp	TBYTE PTR [rsp]
	call	__fprintf_chk@PLT
	pop	r8
	.cfi_def_cfa_offset 136
	pop	r9
	.cfi_def_cfa_offset 128
	jmp	.L6
.L2:
	mov	rdi, QWORD PTR optarg[rip]
	lea	r12, .LC1[rip]
	mov	rsi, r12
	call	strtok@PLT
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	lea	rdi, .LC3[rip]
	mov	rbp, rax
	test	rax, rax
	je	.L13
	lea	rdx, 32[rsp]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	mov	rdi, rbp
	mov	ebx, 1
	call	fclose@PLT
	mov	rsi, r12
	xor	edi, edi
	call	strtok@PLT
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	rbp, rax
	test	rax, rax
	jne	.L6
	lea	rdi, .LC6[rip]
.L13:
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L15:
	lea	rsi, .LC8[rip]
	mov	edi, 1
	xor	eax, eax
	mov	ebx, 1
	call	__printf_chk@PLT
	lea	rsi, 32[rsp]
	lea	rdi, .LC4[rip]
	xor	eax, eax
	call	__isoc99_scanf@PLT
.L6:
	lea	rdi, 56[rsp]
	xor	esi, esi
	xor	r12d, r12d
	call	gettimeofday@PLT
.L7:
	cmp	ebx, r12d
	jle	.L16
	push	QWORD PTR 40[rsp]
	.cfi_def_cfa_offset 136
	inc	r12d
	push	QWORD PTR 40[rsp]
	.cfi_def_cfa_offset 144
	call	findAnswer@PLT
	fstp	TBYTE PTR 16[rsp]
	pop	rcx
	.cfi_def_cfa_offset 136
	pop	rsi
	.cfi_def_cfa_offset 128
	jmp	.L7
.L16:
	lea	rdi, 72[rsp]
	xor	esi, esi
	call	gettimeofday@PLT
	push	QWORD PTR 8[rsp]
	.cfi_def_cfa_offset 136
	mov	esi, 1
	xor	eax, eax
	push	QWORD PTR 8[rsp]
	.cfi_def_cfa_offset 144
	lea	rdx, .LC9[rip]
	mov	rdi, rbp
	call	__fprintf_chk@PLT
	mov	rax, QWORD PTR 88[rsp]
	sub	rax, QWORD PTR 72[rsp]
	lea	rsi, .LC12[rip]
	cvtsi2sd	xmm0, rax
	mov	rax, QWORD PTR 96[rsp]
	sub	rax, QWORD PTR 80[rsp]
	mov	edi, 1
	mulsd	xmm0, QWORD PTR .LC10[rip]
	cvtsi2sd	xmm1, rax
	mov	al, 1
	addsd	xmm0, xmm1
	mulsd	xmm0, QWORD PTR .LC11[rip]
	call	__printf_chk@PLT
	mov	rdi, rbp
	call	fclose@PLT
	pop	rax
	.cfi_def_cfa_offset 136
	pop	rdx
	.cfi_def_cfa_offset 128
	mov	rax, QWORD PTR 88[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	add	rsp, 96
	.cfi_def_cfa_offset 32
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE36:
	.size	main, .-main
	.section	.rodata.str1.1
.LC14:
	.string	"iofiles"
.LC15:
	.string	"random"
	.section	.data.rel.local,"aw"
	.align 32
	.type	longOptions.0, @object
	.size	longOptions.0, 64
longOptions.0:
	.quad	.LC14
	.long	1
	.zero	4
	.quad	0
	.long	102
	.zero	4
	.quad	.LC15
	.long	1
	.zero	4
	.quad	0
	.long	114
	.zero	4
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC10:
	.long	0
	.long	1093567616
	.align 8
.LC11:
	.long	-1598689907
	.long	1051772663
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
