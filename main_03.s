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
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC7:
	.string	"Following floating point number was generated: %Lf \n"
	.section	.rodata.str1.1
.LC8:
	.string	"Enter x: "
.LC9:
	.string	"tan(x) = %Lf"
	.section	.rodata.str1.8
	.align 8
.LC12:
	.string	"\nTime taken to execute this program: %f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB51:
	.cfi_startproc
	endbr64
	fld	DWORD PTR .LC13[rip]
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
	fstp	TBYTE PTR [rsp]
	lea	r8, 28[rsp]
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 88[rsp], rax
	xor	eax, eax
	mov	DWORD PTR 28[rsp], 0
	call	getopt_long@PLT
	mov	r12, QWORD PTR stdout[rip]
	cmp	eax, 102
	je	.L2
	fld	TBYTE PTR [rsp]
	cmp	eax, 114
	je	.L3
	fstp	st(0)
	lea	rsi, .LC8[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	lea	rsi, 64[rsp]
	lea	rdi, .LC4[rip]
	xor	eax, eax
	call	__isoc99_scanf@PLT
.L16:
	lea	rdi, 32[rsp]
	xor	esi, esi
	call	gettimeofday@PLT
	push	QWORD PTR 72[rsp]
	.cfi_def_cfa_offset 136
	push	QWORD PTR 72[rsp]
	.cfi_def_cfa_offset 144
	call	findAnswer@PLT
	pop	rax
	.cfi_def_cfa_offset 136
	pop	rdx
	.cfi_def_cfa_offset 128
.L9:
	lea	rdi, 48[rsp]
	xor	esi, esi
	fstp	TBYTE PTR [rsp]
	call	gettimeofday@PLT
	fld	TBYTE PTR [rsp]
	mov	esi, 1
	mov	rdi, r12
	sub	rsp, 16
	.cfi_def_cfa_offset 144
	lea	rdx, .LC9[rip]
	xor	eax, eax
	fstp	TBYTE PTR [rsp]
	call	__fprintf_chk@PLT
	mov	rax, QWORD PTR 64[rsp]
	pxor	xmm0, xmm0
	sub	rax, QWORD PTR 48[rsp]
	cvtsi2sd	xmm0, rax
	pxor	xmm1, xmm1
	mov	rax, QWORD PTR 72[rsp]
	sub	rax, QWORD PTR 56[rsp]
	mulsd	xmm0, QWORD PTR .LC10[rip]
	cvtsi2sd	xmm1, rax
	mov	edi, 1
	mov	eax, 1
	lea	rsi, .LC12[rip]
	addsd	xmm0, xmm1
	mulsd	xmm0, QWORD PTR .LC11[rip]
	call	__printf_chk@PLT
	mov	rdi, r12
	call	fclose@PLT
	pop	rcx
	.cfi_def_cfa_offset 136
	pop	rsi
	.cfi_def_cfa_offset 128
	mov	rax, QWORD PTR 88[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L18
	add	rsp, 96
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	xor	eax, eax
	pop	rbx
	.cfi_def_cfa_offset 24
	pop	rbp
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
.L2:
	.cfi_restore_state
	mov	rdi, QWORD PTR optarg[rip]
	lea	r12, .LC1[rip]
	mov	rsi, r12
	call	strtok@PLT
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	rbp, rax
	test	rax, rax
	je	.L19
	lea	rdx, 64[rsp]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	xor	eax, eax
	call	__isoc99_fscanf@PLT
	mov	rdi, rbp
	call	fclose@PLT
	mov	rsi, r12
	xor	edi, edi
	call	strtok@PLT
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	r12, rax
	test	rax, rax
	jne	.L16
	lea	rdi, .LC6[rip]
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L3:
	mov	rdi, QWORD PTR optarg[rip]
	lea	rsi, .LC1[rip]
	fstp	TBYTE PTR [rsp]
	call	strtok@PLT
	xor	esi, esi
	mov	edx, 10
	mov	rdi, rax
	call	strtol@PLT
	mov	rbx, rax
	mov	ebp, eax
	call	randLongDouble@PLT
	mov	esi, 1
	mov	rdi, r12
	xor	eax, eax
	fld	st(0)
	fstp	TBYTE PTR 64[rsp]
	lea	rdx, .LC7[rip]
	push	r9
	.cfi_def_cfa_offset 136
	push	r9
	.cfi_def_cfa_offset 144
	fstp	TBYTE PTR [rsp]
	call	__fprintf_chk@PLT
	lea	rdi, 48[rsp]
	xor	esi, esi
	call	gettimeofday@PLT
	test	ebx, ebx
	pop	r10
	.cfi_def_cfa_offset 136
	pop	r11
	.cfi_def_cfa_offset 128
	fld	TBYTE PTR [rsp]
	jle	.L9
	fstp	st(0)
	xor	ebx, ebx
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L20:
	fstp	st(0)
.L8:
	push	QWORD PTR 72[rsp]
	.cfi_def_cfa_offset 136
	add	ebx, 1
	push	QWORD PTR 72[rsp]
	.cfi_def_cfa_offset 144
	call	findAnswer@PLT
	pop	rdi
	.cfi_def_cfa_offset 136
	pop	r8
	.cfi_def_cfa_offset 128
	cmp	ebp, ebx
	jne	.L20
	jmp	.L9
.L18:
	call	__stack_chk_fail@PLT
.L19:
	lea	rdi, .LC3[rip]
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
	.cfi_endproc
.LFE51:
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
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC13:
	.long	2143289344
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
