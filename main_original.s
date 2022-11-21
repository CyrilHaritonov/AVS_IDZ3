	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
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
	.align 8
.LC7:
	.string	"Following floating point number was generated: %Lf \n"
.LC8:
	.string	"Enter x: "
.LC9:
	.string	"tan(x) = %Lf"
	.align 8
.LC12:
	.string	"\nTime taken to execute this program: %f\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 160
	mov	DWORD PTR -148[rbp], edi
	mov	QWORD PTR -160[rbp], rsi
	mov	DWORD PTR -116[rbp], 0
	mov	DWORD PTR -4[rbp], 1
	lea	rdx, -116[rbp]
	mov	rsi, QWORD PTR -160[rbp]
	mov	eax, DWORD PTR -148[rbp]
	mov	r8, rdx
	lea	rdx, longOptions.0[rip]
	mov	rcx, rdx
	lea	rdx, .LC0[rip]
	mov	edi, eax
	call	getopt_long@PLT
	mov	DWORD PTR -48[rbp], eax
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR -40[rbp], rax
	cmp	DWORD PTR -48[rbp], 102
	je	.L2
	cmp	DWORD PTR -48[rbp], 114
	je	.L3
	jmp	.L11
.L2:
	mov	rax, QWORD PTR optarg[rip]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strtok@PLT
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	lea	rdx, .LC2[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -64[rbp], rax
	cmp	QWORD PTR -64[rbp], 0
	jne	.L5
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L5:
	lea	rdx, -144[rbp]
	mov	rax, QWORD PTR -64[rbp]
	lea	rcx, .LC4[rip]
	mov	rsi, rcx
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	rax, QWORD PTR -64[rbp]
	mov	rdi, rax
	call	fclose@PLT
	lea	rax, .LC1[rip]
	mov	rsi, rax
	mov	edi, 0
	call	strtok@PLT
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	lea	rdx, .LC5[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	cmp	QWORD PTR -40[rbp], 0
	jne	.L12
	lea	rax, .LC6[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	edi, 1
	call	exit@PLT
.L3:
	mov	rax, QWORD PTR optarg[rip]
	lea	rdx, .LC1[rip]
	mov	rsi, rdx
	mov	rdi, rax
	call	strtok@PLT
	mov	edx, 10
	mov	esi, 0
	mov	rdi, rax
	call	strtol@PLT
	mov	DWORD PTR -4[rbp], eax
	call	randLongDouble@PLT
	fstp	TBYTE PTR -144[rbp]
	fld	TBYTE PTR -144[rbp]
	mov	rax, QWORD PTR -40[rbp]
	lea	rsp, -16[rsp]
	fstp	TBYTE PTR [rsp]
	lea	rdx, .LC7[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	add	rsp, 16
	jmp	.L7
.L11:
	lea	rax, .LC8[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, -144[rbp]
	mov	rsi, rax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	jmp	.L7
.L12:
	nop
.L7:
	lea	rax, -96[rbp]
	mov	esi, 0
	mov	rdi, rax
	call	gettimeofday@PLT
	mov	DWORD PTR -44[rbp], 0
	jmp	.L8
.L9:
	fld	TBYTE PTR -144[rbp]
	lea	rsp, -16[rsp]
	fstp	TBYTE PTR [rsp]
	call	findAnswer@PLT
	add	rsp, 16
	fstp	TBYTE PTR -32[rbp]
	add	DWORD PTR -44[rbp], 1
.L8:
	mov	eax, DWORD PTR -44[rbp]
	cmp	eax, DWORD PTR -4[rbp]
	jl	.L9
	lea	rax, -112[rbp]
	mov	esi, 0
	mov	rdi, rax
	call	gettimeofday@PLT
	mov	rax, QWORD PTR -40[rbp]
	push	QWORD PTR -24[rbp]
	push	QWORD PTR -32[rbp]
	lea	rdx, .LC9[rip]
	mov	rsi, rdx
	mov	rdi, rax
	mov	eax, 0
	call	fprintf@PLT
	add	rsp, 16
	mov	rax, QWORD PTR -112[rbp]
	mov	rdx, QWORD PTR -96[rbp]
	sub	rax, rdx
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, rax
	movsd	xmm0, QWORD PTR .LC10[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -72[rbp], xmm0
	mov	rax, QWORD PTR -104[rbp]
	mov	rdx, QWORD PTR -88[rbp]
	sub	rax, rdx
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	movapd	xmm1, xmm0
	addsd	xmm1, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR .LC11[rip]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -72[rbp], xmm0
	mov	rax, QWORD PTR -72[rbp]
	movq	xmm0, rax
	lea	rax, .LC12[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	rax, QWORD PTR -40[rbp]
	mov	rdi, rax
	call	fclose@PLT
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.section	.rodata
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
	.section	.rodata
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
