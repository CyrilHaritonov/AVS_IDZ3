	.file	"functions.c"
	.intel_syntax noprefix
	.text
	.globl	pi
	.data
	.align 16
	.type	pi, @object
	.size	pi, 16
pi:
	.long	560498688
	.long	-921707870
	.long	16384
	.long	0
	.globl	bernoulliMemo
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
	.globl	maxBernoulliIndex
	.bss
	.align 8
	.type	maxBernoulliIndex, @object
	.size	maxBernoulliIndex, 8
maxBernoulliIndex:
	.zero	8
	.text
	.globl	calculateFactorial
	.type	calculateFactorial, @function
calculateFactorial:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	QWORD PTR -40[rbp], rdi
	fld1
	fstp	TBYTE PTR -16[rbp]
	mov	DWORD PTR -20[rbp], 1
	jmp	.L2
.L3:
	fild	DWORD PTR -20[rbp]
	fld	TBYTE PTR -16[rbp]
	fmulp	st(1), st
	fstp	TBYTE PTR -16[rbp]
	add	DWORD PTR -20[rbp], 1
.L2:
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	cmp	QWORD PTR -40[rbp], rax
	jge	.L3
	fld	TBYTE PTR -16[rbp]
	pop	rbp
	ret
	.size	calculateFactorial, .-calculateFactorial
	.globl	calculateTermValue
	.type	calculateTermValue, @function
calculateTermValue:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -4[rbp], edi
	mov	eax, DWORD PTR -4[rbp]
	sub	eax, 1
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mov	rax, QWORD PTR .LC2[rip]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movsd	QWORD PTR -32[rbp], xmm0
	mov	eax, DWORD PTR -4[rbp]
	add	eax, eax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mov	rax, QWORD PTR .LC3[rip]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movapd	xmm2, xmm0
	mulsd	xmm2, QWORD PTR -32[rbp]
	movsd	QWORD PTR -32[rbp], xmm2
	mov	eax, DWORD PTR -4[rbp]
	add	eax, eax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mov	rax, QWORD PTR .LC3[rip]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movq	rax, xmm0
	movsd	xmm1, QWORD PTR .LC4[rip]
	movq	xmm0, rax
	subsd	xmm0, xmm1
	mulsd	xmm0, QWORD PTR -32[rbp]
	movsd	QWORD PTR -32[rbp], xmm0
	fld	QWORD PTR -32[rbp]
	fld	TBYTE PTR 32[rbp]
	fmulp	st(1), st
	fstp	TBYTE PTR -32[rbp]
	mov	eax, DWORD PTR -4[rbp]
	add	eax, eax
	sub	eax, 1
	mov	DWORD PTR -8[rbp], eax
	fild	DWORD PTR -8[rbp]
	lea	rsp, -16[rsp]
	fstp	TBYTE PTR [rsp]
	push	QWORD PTR 24[rbp]
	push	QWORD PTR 16[rbp]
	call	powl@PLT
	add	rsp, 32
	fld	TBYTE PTR -32[rbp]
	fmulp	st(1), st
	fstp	TBYTE PTR -32[rbp]
	mov	eax, DWORD PTR -4[rbp]
	add	eax, eax
	cdqe
	mov	rdi, rax
	call	calculateFactorial
	fld	TBYTE PTR -32[rbp]
	fdivrp	st(1), st
	leave
	ret
	.size	calculateTermValue, .-calculateTermValue
	.globl	calculateCombination
	.type	calculateCombination, @function
calculateCombination:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR -8[rbp], rdi
	mov	QWORD PTR -16[rbp], rsi
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	calculateFactorial
	fstp	TBYTE PTR -32[rbp]
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	calculateFactorial
	fstp	TBYTE PTR -48[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	calculateFactorial
	fld	TBYTE PTR -48[rbp]
	fmulp	st(1), st
	fld	TBYTE PTR -32[rbp]
	fdivrp	st(1), st
	leave
	ret
	.size	calculateCombination, .-calculateCombination
	.globl	getBernoulli
	.type	getBernoulli, @function
getBernoulli:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR -40[rbp], rdi
	mov	rax, QWORD PTR maxBernoulliIndex[rip]
	cmp	QWORD PTR -40[rbp], rax
	jg	.L10
	mov	rax, QWORD PTR -40[rbp]
	sal	rax, 4
	mov	rdx, rax
	lea	rax, bernoulliMemo[rip]
	fld	TBYTE PTR [rdx+rax]
	jmp	.L11
.L10:
	mov	rax, QWORD PTR -40[rbp]
	cqo
	shr	rdx, 63
	add	rax, rdx
	and	eax, 1
	sub	rax, rdx
	cmp	rax, 1
	jne	.L12
	cmp	QWORD PTR -40[rbp], 1
	je	.L12
	mov	rax, QWORD PTR -40[rbp]
	sal	rax, 4
	mov	rdx, rax
	lea	rax, bernoulliMemo[rip]
	fld	TBYTE PTR [rdx+rax]
	jmp	.L11
.L12:
	fldz
	fstp	TBYTE PTR -16[rbp]
	mov	DWORD PTR -20[rbp], 0
	jmp	.L13
.L14:
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	calculateCombination
	fstp	TBYTE PTR -64[rbp]
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	mov	rdi, rax
	call	getBernoulli
	fld	TBYTE PTR -64[rbp]
	fmulp	st(1), st
	mov	rax, QWORD PTR -40[rbp]
	lea	rdx, 1[rax]
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	sub	rdx, rax
	mov	QWORD PTR -64[rbp], rdx
	fild	QWORD PTR -64[rbp]
	fdivp	st(1), st
	fld	TBYTE PTR -16[rbp]
	faddp	st(1), st
	fstp	TBYTE PTR -16[rbp]
	add	DWORD PTR -20[rbp], 1
.L13:
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	cmp	QWORD PTR -40[rbp], rax
	jg	.L14
	fld	TBYTE PTR -16[rbp]
	fchs
	fstp	TBYTE PTR -64[rbp]
	mov	rax, QWORD PTR -64[rbp]
	mov	edx, DWORD PTR -56[rbp]
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -8[rbp], edx
	mov	rax, QWORD PTR -40[rbp]
	mov	QWORD PTR maxBernoulliIndex[rip], rax
	mov	rax, QWORD PTR -40[rbp]
	sal	rax, 4
	mov	rdx, rax
	lea	rax, bernoulliMemo[rip]
	fld	TBYTE PTR -16[rbp]
	fstp	TBYTE PTR [rdx+rax]
	fld	TBYTE PTR -16[rbp]
.L11:
	leave
	ret
	.size	getBernoulli, .-getBernoulli
	.globl	findAnswer
	.type	findAnswer, @function
findAnswer:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	fldz
	fstp	TBYTE PTR -16[rbp]
	fld	TBYTE PTR pi[rip]
	lea	rsp, -16[rsp]
	fstp	TBYTE PTR [rsp]
	push	QWORD PTR 24[rbp]
	push	QWORD PTR 16[rbp]
	call	fmodl@PLT
	add	rsp, 32
	fstp	TBYTE PTR 16[rbp]
	fld	TBYTE PTR pi[rip]
	fld	TBYTE PTR .LC6[rip]
	fdivp	st(1), st
	fld	TBYTE PTR 16[rbp]
	fcomip	st, st(1)
	fstp	st(0)
	jbe	.L25
	fld	TBYTE PTR pi[rip]
	fld	TBYTE PTR 16[rbp]
	fsubrp	st(1), st
	fstp	TBYTE PTR 16[rbp]
	jmp	.L18
.L25:
	fld	TBYTE PTR pi[rip]
	fchs
	fld	TBYTE PTR .LC6[rip]
	fdivp	st(1), st
	fld	TBYTE PTR 16[rbp]
	fxch	st(1)
	fcomip	st, st(1)
	fstp	st(0)
	jbe	.L18
	fld	TBYTE PTR pi[rip]
	fld	TBYTE PTR 16[rbp]
	faddp	st(1), st
	fstp	TBYTE PTR 16[rbp]
.L18:
	mov	DWORD PTR -20[rbp], 1
	jmp	.L20
.L21:
	mov	eax, DWORD PTR -20[rbp]
	add	eax, eax
	cdqe
	mov	rdi, rax
	call	getBernoulli
	mov	eax, DWORD PTR -20[rbp]
	lea	rsp, -16[rsp]
	fstp	TBYTE PTR [rsp]
	push	QWORD PTR 24[rbp]
	push	QWORD PTR 16[rbp]
	mov	edi, eax
	call	calculateTermValue
	add	rsp, 32
	fld	TBYTE PTR -16[rbp]
	faddp	st(1), st
	fstp	TBYTE PTR -16[rbp]
	add	DWORD PTR -20[rbp], 1
.L20:
	cmp	DWORD PTR -20[rbp], 32
	jle	.L21
	fld	TBYTE PTR -16[rbp]
	leave
	ret
	.size	findAnswer, .-findAnswer
	.globl	randLongDouble
	.type	randLongDouble, @function
randLongDouble:
	endbr64
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 40
	lea	rax, -32[rbp]
	mov	rdi, rax
	call	time@PLT
	mov	edi, eax
	call	srand@PLT
	call	rand@PLT
	cdqe
	sal	rax, 21
	mov	rbx, rax
	call	rand@PLT
	sar	eax, 2
	cdqe
	xor	rax, rbx
	mov	QWORD PTR -24[rbp], rax
	mov	rax, QWORD PTR -24[rbp]
	test	rax, rax
	js	.L27
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rax
	jmp	.L28
.L27:
	mov	rdx, rax
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, rdx
	addsd	xmm0, xmm0
.L28:
	movsd	xmm1, QWORD PTR .LC7[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -40[rbp], xmm0
	fld	QWORD PTR -40[rbp]
	mov	rbx, QWORD PTR -8[rbp]
	leave
	ret
	.size	randLongDouble, .-randLongDouble
	.section	.rodata
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
	.align 16
.LC6:
	.long	0
	.long	-2147483648
	.long	16384
	.long	0
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
