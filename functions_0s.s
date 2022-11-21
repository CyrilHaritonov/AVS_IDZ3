	.file	"functions.c"
	.intel_syntax noprefix
	.text
	.globl	calculateFactorial
	.type	calculateFactorial, @function
calculateFactorial:
.LFB11:
	.cfi_startproc
	endbr64
	mov	eax, 1
	fld1
.L2:
	cmp	rdi, rax
	jl	.L5
	mov	DWORD PTR -12[rsp], eax
	inc	rax
	fimul	DWORD PTR -12[rsp]
	jmp	.L2
.L5:
	ret
	.cfi_endproc
.LFE11:
	.size	calculateFactorial, .-calculateFactorial
	.globl	calculateTermValue
	.type	calculateTermValue, @function
calculateTermValue:
.LFB12:
	.cfi_startproc
	endbr64
	lea	eax, -1[rdi]
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	ebx, edi
	cvtsi2sd	xmm1, eax
	add	ebx, ebx
	sub	rsp, 48
	.cfi_def_cfa_offset 64
	movsd	xmm0, QWORD PTR .LC2[rip]
	call	pow@PLT
	cvtsi2sd	xmm1, ebx
	mov	rax, QWORD PTR .LC3[rip]
	movsd	QWORD PTR [rsp], xmm0
	movq	xmm0, rax
	movsd	QWORD PTR 32[rsp], xmm1
	call	pow@PLT
	mov	rax, QWORD PTR .LC3[rip]
	movsd	xmm1, QWORD PTR 32[rsp]
	movsd	QWORD PTR 24[rsp], xmm0
	movq	xmm0, rax
	call	pow@PLT
	lea	eax, -1[rbx]
	mov	DWORD PTR 32[rsp], eax
	fild	DWORD PTR 32[rsp]
	movsd	QWORD PTR 40[rsp], xmm0
	push	rax
	.cfi_def_cfa_offset 72
	push	rax
	.cfi_def_cfa_offset 80
	fstp	TBYTE PTR [rsp]
	push	QWORD PTR 88[rsp]
	.cfi_def_cfa_offset 88
	push	QWORD PTR 88[rsp]
	.cfi_def_cfa_offset 96
	call	powl@PLT
	movsd	xmm1, QWORD PTR 32[rsp]
	fld	TBYTE PTR 112[rsp]
	movsx	rdi, ebx
	movsd	xmm0, QWORD PTR 72[rsp]
	mulsd	xmm1, QWORD PTR 56[rsp]
	subsd	xmm0, QWORD PTR .LC4[rip]
	mulsd	xmm1, xmm0
	movsd	QWORD PTR 32[rsp], xmm1
	fmul	QWORD PTR 32[rsp]
	fmulp	st(1), st
	fstp	TBYTE PTR 32[rsp]
	add	rsp, 32
	.cfi_def_cfa_offset 64
	call	calculateFactorial
	fld	TBYTE PTR [rsp]
	add	rsp, 48
	.cfi_def_cfa_offset 16
	pop	rbx
	.cfi_def_cfa_offset 8
	fdivrp	st(1), st
	ret
	.cfi_endproc
.LFE12:
	.size	calculateTermValue, .-calculateTermValue
	.globl	calculateCombination
	.type	calculateCombination, @function
calculateCombination:
.LFB13:
	.cfi_startproc
	endbr64
	sub	rsp, 40
	.cfi_def_cfa_offset 48
	call	calculateFactorial
	sub	rdi, rsi
	fstp	TBYTE PTR 16[rsp]
	call	calculateFactorial
	mov	rdi, rsi
	fstp	TBYTE PTR [rsp]
	call	calculateFactorial
	fld	TBYTE PTR [rsp]
	fmulp	st(1), st
	fld	TBYTE PTR 16[rsp]
	add	rsp, 40
	.cfi_def_cfa_offset 8
	fdivrp	st(1), st
	ret
	.cfi_endproc
.LFE13:
	.size	calculateCombination, .-calculateCombination
	.globl	getBernoulli
	.type	getBernoulli, @function
getBernoulli:
.LFB14:
	.cfi_startproc
	endbr64
	push	r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	mov	r12, rdi
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 40
	.cfi_def_cfa_offset 64
	cmp	QWORD PTR maxBernoulliIndex[rip], rdi
	jl	.L11
.L13:
	sal	r12, 4
	lea	rax, bernoulliMemo[rip]
	fld	TBYTE PTR [rax+r12]
	jmp	.L10
.L11:
	mov	rax, rdi
	mov	ecx, 2
	cqo
	idiv	rcx
	dec	rdx
	jne	.L17
	cmp	rdi, 1
	jne	.L13
.L17:
	mov	rbx, r12
	fldz
.L15:
	mov	r8, r12
	sub	r8, rbx
	cmp	r12, r8
	jle	.L22
	fstp	TBYTE PTR 16[rsp]
	mov	rsi, r8
	mov	rdi, r12
	call	calculateCombination
	mov	rdi, r8
	fstp	TBYTE PTR [rsp]
	call	getBernoulli
	fld	TBYTE PTR [rsp]
	lea	rax, 1[rbx]
	dec	rbx
	mov	QWORD PTR [rsp], rax
	fmulp	st(1), st
	fild	QWORD PTR [rsp]
	fdivp	st(1), st
	fld	TBYTE PTR 16[rsp]
	faddp	st(1), st
	jmp	.L15
.L22:
	fchs
	mov	QWORD PTR maxBernoulliIndex[rip], r12
	lea	rax, bernoulliMemo[rip]
	sal	r12, 4
	fld	st(0)
	fstp	TBYTE PTR [rax+r12]
.L10:
	add	rsp, 40
	.cfi_def_cfa_offset 24
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE14:
	.size	getBernoulli, .-getBernoulli
	.globl	findAnswer
	.type	findAnswer, @function
findAnswer:
.LFB15:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	push	rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	sub	rsp, 56
	.cfi_def_cfa_offset 80
	fld	TBYTE PTR pi[rip]
	fld	st(0)
	fstp	TBYTE PTR [rsp]
	fstp	TBYTE PTR 16[rsp]
	push	QWORD PTR 88[rsp]
	.cfi_def_cfa_offset 88
	push	QWORD PTR 88[rsp]
	.cfi_def_cfa_offset 96
	call	fmodl@PLT
	fld	TBYTE PTR 32[rsp]
	add	rsp, 32
	.cfi_def_cfa_offset 64
	fld	st(0)
	fmul	DWORD PTR .LC6[rip]
	fxch	st(2)
	fcomi	st, st(2)
	jbe	.L32
	fstp	st(2)
	fxch	st(1)
	fsubrp	st(1), st
	jmp	.L26
.L32:
	fxch	st(2)
	fchs
	fcomip	st, st(2)
	jbe	.L34
	faddp	st(1), st
	jmp	.L26
.L34:
	fstp	st(0)
.L26:
	mov	ebp, 2
	fldz
	mov	ebx, 1
	jmp	.L28
.L35:
	fxch	st(1)
.L28:
	fstp	TBYTE PTR 16[rsp]
	mov	rdi, rbp
	add	rbp, 2
	fstp	TBYTE PTR [rsp]
	call	getBernoulli
	sub	rsp, 32
	.cfi_def_cfa_offset 96
	mov	edi, ebx
	inc	ebx
	fstp	TBYTE PTR 16[rsp]
	fld	TBYTE PTR 32[rsp]
	fld	st(0)
	fstp	TBYTE PTR [rsp]
	fstp	TBYTE PTR 32[rsp]
	call	calculateTermValue
	fld	TBYTE PTR 48[rsp]
	add	rsp, 32
	.cfi_def_cfa_offset 64
	cmp	ebx, 33
	faddp	st(1), st
	fld	TBYTE PTR [rsp]
	jne	.L35
	fstp	st(0)
	add	rsp, 40
	.cfi_def_cfa_offset 24
	pop	rbx
	.cfi_def_cfa_offset 16
	pop	rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE15:
	.size	findAnswer, .-findAnswer
	.globl	randLongDouble
	.type	randLongDouble, @function
randLongDouble:
.LFB16:
	.cfi_startproc
	endbr64
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	sub	rsp, 32
	.cfi_def_cfa_offset 48
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 24[rsp], rax
	xor	eax, eax
	lea	rdi, 16[rsp]
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	mov	ebx, eax
	call	rand@PLT
	mov	edx, eax
	movsx	rax, ebx
	sar	edx, 2
	sal	rax, 21
	movsx	rdx, edx
	xor	rax, rdx
	js	.L37
	cvtsi2sd	xmm0, rax
	jmp	.L38
.L37:
	mov	rdx, rax
	and	eax, 1
	shr	rdx
	or	rdx, rax
	cvtsi2sd	xmm0, rdx
	addsd	xmm0, xmm0
.L38:
	divsd	xmm0, QWORD PTR .LC7[rip]
	movsd	QWORD PTR 8[rsp], xmm0
	mov	rax, QWORD PTR 24[rsp]
	sub	rax, QWORD PTR fs:40
	je	.L39
	call	__stack_chk_fail@PLT
.L39:
	fld	QWORD PTR 8[rsp]
	add	rsp, 32
	.cfi_def_cfa_offset 16
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE16:
	.size	randLongDouble, .-randLongDouble
	.globl	maxBernoulliIndex
	.bss
	.align 8
	.type	maxBernoulliIndex, @object
	.size	maxBernoulliIndex, 8
maxBernoulliIndex:
	.zero	8
	.globl	bernoulliMemo
	.data
	.align 32
	.type	bernoulliMemo, @object
	.size	bernoulliMemo, 1600
bernoulliMemo:
	.long	0
	.long	-2147483648
	.long	16383
	.long	0
	.long	0
	.long	0
	.long	0
	.long	0
	.zero	1568
	.globl	pi
	.align 16
	.type	pi, @object
	.size	pi, 16
pi:
	.long	560498688
	.long	-921707870
	.long	16384
	.long	0
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	0
	.long	-1074790400
	.align 8
.LC3:
	.long	0
	.long	1073741824
	.align 8
.LC4:
	.long	0
	.long	1072693248
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC6:
	.long	1056964608
	.section	.rodata.cst8
	.align 8
.LC7:
	.long	-1
	.long	1128267775
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
