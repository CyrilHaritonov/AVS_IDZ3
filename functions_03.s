	.file	"functions.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.type	getBernoulli.part.0, @function
getBernoulli.part.0:
.LFB22:
	.cfi_startproc
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	mov	r13, rdi
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 40
	.cfi_def_cfa_offset 96
	test	rdi, rdi
	jle	.L19
	lea	r12, 1[rdi]
	lea	ebx, 1[rdi]
	fld1
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L3:
	mov	DWORD PTR [rsp], eax
	fild	DWORD PTR [rsp]
	add	eax, 1
	fmulp	st(1), st
	cmp	eax, ebx
	jne	.L3
	fld1
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L4:
	mov	DWORD PTR [rsp], eax
	fild	DWORD PTR [rsp]
	add	eax, 1
	fmulp	st(1), st
	cmp	eax, r12d
	jne	.L4
	cmp	QWORD PTR maxBernoulliIndex[rip], 0
	fdivp	st(1), st
	jns	.L38
	fstp	TBYTE PTR [rsp]
	xor	edi, edi
	call	getBernoulli.part.0
	fld	TBYTE PTR [rsp]
	fxch	st(1)
.L6:
	fmulp	st(1), st
	mov	QWORD PTR [rsp], r12
	mov	r14d, 2
	mov	ebp, 1
	fild	QWORD PTR [rsp]
	lea	r15, bernoulliMemo[rip]
	fdivp	st(1), st
	fadd	DWORD PTR .LC2[rip]
	cmp	r13, 1
	je	.L16
.L7:
	fld1
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L8:
	mov	DWORD PTR [rsp], eax
	fild	DWORD PTR [rsp]
	add	eax, 1
	fmulp	st(1), st
	cmp	eax, ebx
	jne	.L8
	mov	rdx, r13
	sub	rdx, rbp
	test	rdx, rdx
	jle	.L21
	add	edx, 1
	fld1
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L10:
	mov	DWORD PTR [rsp], eax
	fild	DWORD PTR [rsp]
	add	eax, 1
	fmulp	st(1), st
	cmp	eax, edx
	jne	.L10
.L9:
	xor	eax, eax
	fld1
	.p2align 4,,10
	.p2align 3
.L11:
	lea	edx, 1[rax]
	mov	DWORD PTR [rsp], edx
	fild	DWORD PTR [rsp]
	mov	rdx, rax
	add	rax, 1
	add	rdx, 2
	fmulp	st(1), st
	cmp	rdx, rbp
	jle	.L11
	fmulp	st(1), st
	cmp	QWORD PTR maxBernoulliIndex[rip], rbp
	fdivp	st(1), st
	jge	.L14
	cmp	rbp, 1
	je	.L39
	test	bpl, 1
	jne	.L14
	fxch	st(1)
	jmp	.L22
	.p2align 4,,10
	.p2align 3
.L39:
	fxch	st(1)
.L22:
	fstp	TBYTE PTR 16[rsp]
	mov	rdi, rbp
	fstp	TBYTE PTR [rsp]
	call	getBernoulli.part.0
	fld	TBYTE PTR [rsp]
	fld	TBYTE PTR 16[rsp]
	fxch	st(2)
.L13:
	fmulp	st(1), st
	mov	rax, r12
	sub	rax, rbp
	mov	rbp, r14
	add	r14, 1
	mov	QWORD PTR [rsp], rax
	fild	QWORD PTR [rsp]
	fdivp	st(1), st
	faddp	st(1), st
	cmp	r13, rbp
	jg	.L7
.L16:
	fchs
.L2:
	mov	QWORD PTR maxBernoulliIndex[rip], r13
	sal	r13, 4
	fld	st(0)
	fstp	TBYTE PTR [r15+r13]
	add	rsp, 40
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L14:
	.cfi_restore_state
	mov	rax, rbp
	sal	rax, 4
	fld	TBYTE PTR [r15+rax]
	jmp	.L13
	.p2align 4,,10
	.p2align 3
.L38:
	fld	TBYTE PTR bernoulliMemo[rip]
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L21:
	fld1
	jmp	.L9
.L19:
	fldz
	lea	r15, bernoulliMemo[rip]
	fchs
	jmp	.L2
	.cfi_endproc
.LFE22:
	.size	getBernoulli.part.0, .-getBernoulli.part.0
	.p2align 4
	.globl	calculateFactorial
	.type	calculateFactorial, @function
calculateFactorial:
.LFB16:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	jle	.L43
	add	edi, 1
	fld1
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L42:
	mov	DWORD PTR -12[rsp], eax
	fild	DWORD PTR -12[rsp]
	add	eax, 1
	fmulp	st(1), st
	cmp	edi, eax
	jne	.L42
	ret
	.p2align 4,,10
	.p2align 3
.L43:
	fld1
	ret
	.cfi_endproc
.LFE16:
	.size	calculateFactorial, .-calculateFactorial
	.p2align 4
	.globl	calculateTermValue
	.type	calculateTermValue, @function
calculateTermValue:
.LFB17:
	.cfi_startproc
	endbr64
	lea	eax, -1[rdi]
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	pxor	xmm1, xmm1
	mov	ebx, edi
	cvtsi2sd	xmm1, eax
	add	ebx, ebx
	sub	rsp, 32
	.cfi_def_cfa_offset 48
	movsd	xmm0, QWORD PTR .LC4[rip]
	call	pow@PLT
	pxor	xmm1, xmm1
	movsd	xmm2, QWORD PTR .LC5[rip]
	cvtsi2sd	xmm1, ebx
	movsd	QWORD PTR [rsp], xmm0
	movapd	xmm0, xmm2
	movsd	QWORD PTR 16[rsp], xmm1
	call	pow@PLT
	mov	rax, QWORD PTR .LC5[rip]
	movsd	xmm1, QWORD PTR 16[rsp]
	movsd	QWORD PTR 8[rsp], xmm0
	movq	xmm0, rax
	call	pow@PLT
	lea	eax, -1[rbx]
	sub	rsp, 16
	.cfi_def_cfa_offset 64
	mov	DWORD PTR 32[rsp], eax
	fild	DWORD PTR 32[rsp]
	movsd	QWORD PTR 40[rsp], xmm0
	fstp	TBYTE PTR [rsp]
	push	QWORD PTR 72[rsp]
	.cfi_def_cfa_offset 72
	push	QWORD PTR 72[rsp]
	.cfi_def_cfa_offset 80
	call	powl@PLT
	movsd	xmm1, QWORD PTR 32[rsp]
	mulsd	xmm1, QWORD PTR 40[rsp]
	movsd	xmm0, QWORD PTR 56[rsp]
	subsd	xmm0, QWORD PTR .LC6[rip]
	fld	TBYTE PTR 96[rsp]
	mulsd	xmm1, xmm0
	movsd	QWORD PTR 32[rsp], xmm1
	fmul	QWORD PTR 32[rsp]
	add	rsp, 32
	.cfi_def_cfa_offset 48
	fmulp	st(1), st
	test	ebx, ebx
	jle	.L45
	lea	edx, 1[rbx]
	fld1
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L47:
	mov	DWORD PTR [rsp], eax
	fild	DWORD PTR [rsp]
	add	eax, 1
	fmulp	st(1), st
	cmp	edx, eax
	jne	.L47
	fdivp	st(1), st
.L45:
	add	rsp, 32
	.cfi_def_cfa_offset 16
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE17:
	.size	calculateTermValue, .-calculateTermValue
	.p2align 4
	.globl	calculateCombination
	.type	calculateCombination, @function
calculateCombination:
.LFB18:
	.cfi_startproc
	endbr64
	mov	rdx, rdi
	test	rdi, rdi
	jle	.L57
	lea	ecx, 1[rdi]
	fld1
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L52:
	mov	DWORD PTR -12[rsp], eax
	fild	DWORD PTR -12[rsp]
	add	eax, 1
	fmulp	st(1), st
	cmp	ecx, eax
	jne	.L52
	sub	rdx, rsi
	test	rdx, rdx
	jle	.L58
.L62:
	add	edx, 1
	fld1
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L54:
	mov	DWORD PTR -12[rsp], eax
	fild	DWORD PTR -12[rsp]
	add	eax, 1
	fmulp	st(1), st
	cmp	eax, edx
	jne	.L54
.L53:
	test	rsi, rsi
	jle	.L55
	add	esi, 1
	fld1
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L56:
	mov	DWORD PTR -12[rsp], eax
	fild	DWORD PTR -12[rsp]
	add	eax, 1
	fmulp	st(1), st
	cmp	eax, esi
	jne	.L56
	fmulp	st(1), st
.L55:
	fdivp	st(1), st
	ret
	.p2align 4,,10
	.p2align 3
.L57:
	sub	rdx, rsi
	fld1
	test	rdx, rdx
	jg	.L62
	.p2align 4,,10
	.p2align 3
.L58:
	fld1
	jmp	.L53
	.cfi_endproc
.LFE18:
	.size	calculateCombination, .-calculateCombination
	.p2align 4
	.globl	getBernoulli
	.type	getBernoulli, @function
getBernoulli:
.LFB19:
	.cfi_startproc
	endbr64
	cmp	QWORD PTR maxBernoulliIndex[rip], rdi
	jge	.L66
	mov	rdx, rdi
	shr	rdx, 63
	lea	rax, [rdi+rdx]
	and	eax, 1
	sub	rax, rdx
	cmp	rax, 1
	jne	.L68
	cmp	rdi, 1
	jne	.L66
.L68:
	jmp	getBernoulli.part.0
	.p2align 4,,10
	.p2align 3
.L66:
	sal	rdi, 4
	lea	rax, bernoulliMemo[rip]
	fld	TBYTE PTR [rax+rdi]
	ret
	.cfi_endproc
.LFE19:
	.size	getBernoulli, .-getBernoulli
	.p2align 4
	.globl	findAnswer
	.type	findAnswer, @function
findAnswer:
.LFB20:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	sub	rsp, 112
	.cfi_def_cfa_offset 160
	fld	TBYTE PTR pi[rip]
	fld	st(0)
	fstp	TBYTE PTR [rsp]
	fstp	TBYTE PTR 16[rsp]
	push	QWORD PTR 168[rsp]
	.cfi_def_cfa_offset 168
	push	QWORD PTR 168[rsp]
	.cfi_def_cfa_offset 176
	call	fmodl@PLT
	fld	st(0)
	fstp	TBYTE PTR 112[rsp]
	fld	TBYTE PTR 32[rsp]
	add	rsp, 32
	.cfi_def_cfa_offset 144
	fld	st(0)
	fmul	DWORD PTR .LC7[rip]
	fxch	st(2)
	fcomi	st, st(2)
	jbe	.L87
	fstp	st(2)
	fxch	st(1)
	fsubrp	st(1), st
	fstp	TBYTE PTR 80[rsp]
	jmp	.L76
.L91:
	fstp	st(0)
	fstp	st(0)
.L76:
	fldz
	mov	ebx, 3
	mov	ebp, 2
	xor	r12d, r12d
	fstp	TBYTE PTR 16[rsp]
	lea	r13, bernoulliMemo[rip+32]
	jmp	.L82
	.p2align 4,,10
	.p2align 3
.L90:
	fstp	st(0)
.L82:
	cmp	rbp, QWORD PTR maxBernoulliIndex[rip]
	mov	r14d, ebp
	jle	.L89
	test	bpl, 1
	jne	.L80
	mov	rdi, rbp
	call	getBernoulli.part.0
	fstp	TBYTE PTR 64[rsp]
.L79:
	pxor	xmm1, xmm1
	mov	rax, QWORD PTR .LC4[rip]
	cvtsi2sd	xmm1, r12d
	movq	xmm0, rax
	call	pow@PLT
	pxor	xmm1, xmm1
	mov	rax, QWORD PTR .LC5[rip]
	cvtsi2sd	xmm1, r14d
	movsd	QWORD PTR [rsp], xmm0
	movq	xmm0, rax
	movsd	QWORD PTR 48[rsp], xmm1
	call	pow@PLT
	mov	rax, QWORD PTR .LC5[rip]
	movsd	xmm1, QWORD PTR 48[rsp]
	movsd	QWORD PTR 40[rsp], xmm0
	movq	xmm0, rax
	call	pow@PLT
	lea	eax, -2[rbx]
	sub	rsp, 16
	.cfi_def_cfa_offset 160
	mov	DWORD PTR 64[rsp], eax
	fild	DWORD PTR 64[rsp]
	movsd	QWORD PTR 72[rsp], xmm0
	fstp	TBYTE PTR [rsp]
	push	QWORD PTR 104[rsp]
	.cfi_def_cfa_offset 168
	push	QWORD PTR 104[rsp]
	.cfi_def_cfa_offset 176
	call	powl@PLT
	movsd	xmm1, QWORD PTR 32[rsp]
	mulsd	xmm1, QWORD PTR 72[rsp]
	mov	eax, 1
	movsd	xmm0, QWORD PTR 88[rsp]
	subsd	xmm0, QWORD PTR .LC6[rip]
	fld	TBYTE PTR 96[rsp]
	mulsd	xmm1, xmm0
	movsd	QWORD PTR 32[rsp], xmm1
	fmul	QWORD PTR 32[rsp]
	add	rsp, 32
	.cfi_def_cfa_offset 144
	fmulp	st(1), st
	fld1
	.p2align 4,,10
	.p2align 3
.L81:
	mov	DWORD PTR [rsp], eax
	fild	DWORD PTR [rsp]
	add	eax, 1
	fmulp	st(1), st
	cmp	eax, ebx
	jne	.L81
	fdivp	st(1), st
	add	rbp, 2
	add	r12d, 1
	add	r13, 32
	lea	ebx, 2[rax]
	fld	TBYTE PTR 16[rsp]
	faddp	st(1), st
	fld	st(0)
	fstp	TBYTE PTR 16[rsp]
	cmp	rbp, 66
	jne	.L90
	add	rsp, 96
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	pop	rbx
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L89:
	.cfi_restore_state
	fld	TBYTE PTR 0[r13]
	fstp	TBYTE PTR 64[rsp]
	jmp	.L79
	.p2align 4,,10
	.p2align 3
.L80:
	fld	TBYTE PTR 0[r13]
	fstp	TBYTE PTR 64[rsp]
	jmp	.L79
.L87:
	fstp	st(0)
	fxch	st(1)
	fchs
	fld	TBYTE PTR 80[rsp]
	fxch	st(1)
	fcomip	st, st(1)
	jbe	.L91
	faddp	st(1), st
	fstp	TBYTE PTR 80[rsp]
	jmp	.L76
	.cfi_endproc
.LFE20:
	.size	findAnswer, .-findAnswer
	.p2align 4
	.globl	randLongDouble
	.type	randLongDouble, @function
randLongDouble:
.LFB21:
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
	movsx	rdx, ebx
	sar	eax, 2
	sal	rdx, 21
	cdqe
	xor	rdx, rax
	js	.L93
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rdx
.L94:
	divsd	xmm0, QWORD PTR .LC8[rip]
	movsd	QWORD PTR 8[rsp], xmm0
	mov	rax, QWORD PTR 24[rsp]
	sub	rax, QWORD PTR fs:40
	jne	.L97
	fld	QWORD PTR 8[rsp]
	add	rsp, 32
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	pop	rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L93:
	.cfi_restore_state
	mov	rax, rdx
	and	edx, 1
	pxor	xmm0, xmm0
	shr	rax
	or	rax, rdx
	cvtsi2sd	xmm0, rax
	addsd	xmm0, xmm0
	jmp	.L94
.L97:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE21:
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
	.set	.LC2,.LC4
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC4:
	.long	0
	.long	-1074790400
	.align 8
.LC5:
	.long	0
	.long	1073741824
	.align 8
.LC6:
	.long	0
	.long	1072693248
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC7:
	.long	1056964608
	.section	.rodata.cst8
	.align 8
.LC8:
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
