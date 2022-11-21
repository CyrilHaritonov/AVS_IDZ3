	.intel_syntax noprefix
	.text
	.globl	pi #            /
	.data #                 |
	.align 16 #             |
	.type	pi, @object #   |
	.size	pi, 16 #        |
pi: #                       | long double pi = 3.14159265358979
	.long	560498688 #     |
	.long	-921707870 #    |
	.long	16384 #         |
	.long	0 #             \
	.globl	bernoulliMemo #           /
	.align 32 #                       |
	.type	bernoulliMemo, @object #  |
	.size	bernoulliMemo, 1600 #     |
bernoulliMemo: #                      |
	.long	0 #                       |
	.long	-2147483648 #             |
	.long	16383 #                   | long double bernoulliMemo[100] = {1, 0};
	.long	0 #                       |
	.long	0 #                       |
	.long	0 #                       |
	.long	0 #                       |
	.long	0 #                       |
	.zero	1568 #                    \
	.globl	maxBernoulliIndex #          /
	.bss #                               |
	.align 8 #                           |
	.type	maxBernoulliIndex, @object # | long maxBernoulliIndex = 0
	.size	maxBernoulliIndex, 8 #       |
maxBernoulliIndex: #                     |
	.zero	8 #                          \
	.text
	.globl	calculateFactorial
	.type	calculateFactorial, @function
calculateFactorial: # long double calculateFactorial(long n)
	push	rbp # пролог
	mov	rbp, rsp
	fld1 # кладем 1 на стек x87
	fstp	TBYTE PTR -16[rbp] # выделяем место для long double ans
	mov r15, 1 # r15d = i = 1
	jmp	.L2 # прыгаем к условию цикла
.L3: # тело цикла
    mov DWORD PTR -20[rbp], r15d
	fild DWORD PTR -20[rbp] # кладем i на стек x87
	fld	TBYTE PTR -16[rbp] # кладем ans на стек x87
	fmulp	st(1), st # ans * i
	fstp	TBYTE PTR -16[rbp] # сохраняем ans на стек
	add r15, 1 # ++i
.L2: # условие цикла
	mov	eax, r15d # eax = i
	cdqe # знаково расширяем i до QWORD
	cmp	rdi, rax # сравнием n и i
	jge	.L3 # если i <= n то прыгаем в тело цикла
	fld	TBYTE PTR -16[rbp] # загружаем ans на стек x87
	pop	rbp # эпилог
	ret
	.size	calculateFactorial, .-calculateFactorial
	.globl	calculateTermValue
	.type	calculateTermValue, @function
calculateTermValue: # long double calculateTermValue(int n, long double x, long double bernoulli)
	push	rbp # пролог
	mov	rbp, rsp
	sub	rsp, 32 # выделяем место на стеке + выравнивание
	mov	DWORD PTR -4[rbp], edi # [rbp-4] = n
	mov	eax, DWORD PTR -4[rbp] # eax = n
	sub	eax, 1 # n - 1
	pxor	xmm0, xmm0 # xmm0 = 0
	cvtsi2sd	xmm0, eax # xmm0 = n - 1
	mov	rax, QWORD PTR .LC2[rip] # rax = -1
	movapd	xmm1, xmm0 # xmm1 = n - 1
	movq	xmm0, rax # xmm0 = -1
	call	pow@PLT # pow(-1, n - 1)
	movsd	QWORD PTR -32[rbp], xmm0 # сохраняем промежуточный результат
	mov	eax, DWORD PTR -4[rbp] # eax = n
	add	eax, eax # 2 * n
	pxor	xmm0, xmm0 # xmm0 = 0
	cvtsi2sd	xmm0, eax # xmm0 = 2 * n
	mov	rax, QWORD PTR .LC3[rip] # rax = 2
	movapd	xmm1, xmm0 # xmm1 = 2 * n
	movq	xmm0, rax # xmm0 = 2
	call	pow@PLT # pow(2, 2 * n)
	movapd	xmm2, xmm0 # xmm2 = xmm0
	mulsd	xmm2, QWORD PTR -32[rbp] # pow(-1, n - 1) * pow(2, 2 * n)
	movsd	QWORD PTR -32[rbp], xmm2 # [rbp-32] = pow(-1, n - 1) * pow(2, 2 * n)
	mov	eax, DWORD PTR -4[rbp] # eax = n
	add	eax, eax # 2 * n
	pxor	xmm0, xmm0 # xmm0 = 0
	cvtsi2sd	xmm0, eax # xmm0 = 2 * n
	mov	rax, QWORD PTR .LC3[rip] # rax = 2
	movapd	xmm1, xmm0 # xmm1 = 2 * n
	movq	xmm0, rax # xmm0 = 2
	call	pow@PLT # pow(2, 2 * n)
	movq	rax, xmm0 # rax = pow(2, 2 * n)
	movsd	xmm1, QWORD PTR .LC4[rip] # xmm1 = 1
	movq	xmm0, rax # xmm0 = pow(2, 2 * n)
	subsd	xmm0, xmm1 # xmm0 = pow(2, 2 * n) - 1
	mulsd	xmm0, QWORD PTR -32[rbp] # xmm0 = pow(-1, n - 1) * pow(2, 2 * n) * (pow(2, 2 * n) - 1)
	movsd	QWORD PTR -32[rbp], xmm0 # сохраняем промежуточный результат
	fld	QWORD PTR -32[rbp] # загружаем промежуточный результат на стек x87
	fld	TBYTE PTR 32[rbp] # загружаем bernoulli на стек x87
	fmulp	st(1), st # (pow(-1, n - 1) * pow(2, 2 * n) * (pow(2, 2 * n) - 1) * bernoulli
	fstp	TBYTE PTR -32[rbp] # [rbp-32] = (pow(-1, n - 1) * pow(2, 2 * n) * (pow(2, 2 * n) - 1) * bernoulli
	mov	eax, DWORD PTR -4[rbp] # eax = n
	add	eax, eax # 2 * n
	sub	eax, 1 # 2 * n - 1
	mov	DWORD PTR -8[rbp], eax # [rbp - 8] = 2 * n - 1
	fild	DWORD PTR -8[rbp] # 2 * n - 1 на стек x87
	lea	rsp, -16[rsp] # выделяем место на стеке
	fstp	TBYTE PTR [rsp] # сохраняем в него 2 * n - 1 в формате long double
	push	QWORD PTR 24[rbp] # [rbp + 24] = 2 * n - 1
	push	QWORD PTR 16[rbp] # [rbp + 16] = x
	call	powl@PLT # powl(x, 2 * n - 1)
	add	rsp, 32 # чистим стек
	fld	TBYTE PTR -32[rbp] # загружаем промежуточный результат на стек x87
	fmulp	st(1), st # (pow(-1, n - 1) * pow(2, 2 * n) * (pow(2, 2 * n) - 1) * bernoulli * powl(x, 2 * n - 1))
	fstp	TBYTE PTR -32[rbp] # сохраняем промежуточный результат
	mov	eax, DWORD PTR -4[rbp] # eax = n
	add	eax, eax # 2 * n
	cdqe # расширяем eax до QWORD
	mov	rdi, rax # rdi = 2 * n
	call	calculateFactorial # calculateFactorial(2 * n)
	fld	TBYTE PTR -32[rbp] # загружаем промежуточный результат на стек x87
	fdivrp	st(1), st # (pow(-1, n - 1) * pow(2, 2 * n) * (pow(2, 2 * n) - 1) * bernoulli * powl(x, 2 * n - 1)) / calculateFactorial(2 * n)
	leave # эпилог
	ret # return (pow(-1, n - 1) * pow(2, 2 * n) * (pow(2, 2 * n) - 1) * bernoulli * powl(x, 2 * n - 1)) / calculateFactorial(2 * n)
	.size	calculateTermValue, .-calculateTermValue
	.globl	calculateCombination
	.type	calculateCombination, @function
calculateCombination: # long double calculateCombination(long n, long k)
	push	rbp # пролог
	mov	rbp, rsp
	sub	rsp, 48 # выделяем место на стеке + выравнивание
	mov	QWORD PTR -8[rbp], rdi # [rbp - 8] = n
	mov	QWORD PTR -16[rbp], rsi # [rbp - 16] = k
	call	calculateFactorial # calculateFactorial(n)
	fstp	TBYTE PTR -32[rbp] # [rbp - 32] = calculateFactorial(n)
	mov	rax, QWORD PTR -8[rbp] # rax = n
	sub	rax, QWORD PTR -16[rbp] # rax = n - k
	mov	rdi, rax # rdi = n - k
	call	calculateFactorial # calculateFactorial(n - k)
	fstp	TBYTE PTR -48[rbp] # [rbp - 48] = calculateFactorial(n - k)
	mov	rdi, QWORD PTR -16[rbp] # rdi = k
	call	calculateFactorial # calculateFactorial(k)
	fld	TBYTE PTR -48[rbp] # кладем calculateFactorial(n - k) на стек x87
	fmulp	st(1), st #  calculateFactorial(n - k) * calculateFactorial(n)
	fld	TBYTE PTR -32[rbp] # кладем calculateFactorial(n - k) на стек x87
	fdivrp	st(1), st # calculateFactorial(n) / (calculateFactorial(n-k) * calculateFactorial(k))
	leave # эпилог
	ret # return calculateFactorial(n)/(calculateFactorial(n-k) * calculateFactorial(k))
	.size	calculateCombination, .-calculateCombination
	.globl	getBernoulli
	.type	getBernoulli, @function
getBernoulli: # long double getBernoulli(long n)
	push	rbp # пролог
	mov	rbp, rsp
	sub	rsp, 64 # выделяем место на стеке + выравнивание
	mov	QWORD PTR -40[rbp], rdi # [rbp - 40] = rdi
	mov	rax, QWORD PTR maxBernoulliIndex[rip] # rax = maxBernoulliIndex
	cmp	QWORD PTR -40[rbp], rax # сравниваем n и maxBernoulliIndex
	jg	.L10 # maxBernoulliIndex < n
	mov	rax, QWORD PTR -40[rbp] # rax = n
	sal	rax, 4
	mov	rdx, rax # rdx = n % 2
	lea	rax, bernoulliMemo[rip] # rax = bernoulliMemo
	fld	TBYTE PTR [rdx+rax] # кладем bernoulliMemo на стек x87
	jmp	.L11 # к return
.L10: # если maxBernoulliIndex < n
	mov	rax, QWORD PTR -40[rbp] # rax = n
	cqo # расширение до qword
	shr	rdx, 63 # n % 2
	add	rax, rdx # n + n % 2
	and	eax, 1
	sub	rax, rdx
	cmp	rax, 1 # сравниваем n % 2 и 1
	jne	.L12 # если n % 2 != 1 прыгаем
	cmp	QWORD PTR -40[rbp], 1 # сравниваем n и 1
	je	.L12 # если n == 1
	mov	rax, QWORD PTR -40[rbp] # rax = n
	sal	rax, 4
	mov	rdx, rax
	lea	rax, bernoulliMemo[rip] # rax = bernoulliMemo
	fld	TBYTE PTR [rdx+rax] # кладем bernoulliMemo[n] на стек x87
	jmp	.L11 # прыгаем к return
.L12: # если второй if не с работает
	fldz # answer = 0 в x87
	fstp	TBYTE PTR -16[rbp] # [rbp - 16] = answer
	mov	r14, 0 # k = 0
	jmp	.L13 # прыгаем в условию цикла
.L14: # тело цикла
	mov	eax, r14d # eax = k
	movsx	rsi, eax # rsi = k со знаковом разрешением
	mov	rdi, QWORD PTR -40[rbp] # rdi = n
	call	calculateCombination # calculateCombination(n, k)
	fstp	TBYTE PTR -64[rbp] # [rbp - 64] = calculateCombination(n, k)
	mov	eax, r14d # eax = k
	cdqe # знаковое расширение eax
	mov	rdi, rax # rdi = k
	call	getBernoulli # getBernoulli(k)
	fld	TBYTE PTR -64[rbp] # [rbp - 64] = getBernoulli(k)
	fmulp	st(1), st # calculateCombination(n, k) * getBernoulli(k)
	mov	rax, QWORD PTR -40[rbp] # rax = n
	lea	rdx, 1[rax] # rdx = [rax + 1]
	mov	eax, r14d # eax = k
	cdqe # знаковое расширение k
	sub	rdx, rax # n + 1 - k
	mov	QWORD PTR -64[rbp], rdx # [rbp - 64] = n + 1 - k
	fild	QWORD PTR -64[rbp] # кладем n + 1 - k на стек x87
	fdivp	st(1), st # calculateCombination(n, k) * getBernoulli(k) / (n + 1 - k)
	fld	TBYTE PTR -16[rbp] # кладем answer на стек x87
	faddp	st(1), st # answer + calculateCombination(n, k) * getBernoulli(k) / (n + 1 - k)
	fstp	TBYTE PTR -16[rbp] # кладем answer на обычный стек
	add	r14d, 1 # ++k
.L13: # условие цикла
	mov	eax, r14d # eax = k
	cdqe # знаковое расширние eax
	cmp	QWORD PTR -40[rbp], rax # сравниваем k и n - 1
	jg	.L14 # k <= n - 1
	fld	TBYTE PTR -16[rbp] # кладем answer на стек x87
	fchs # answer * -1
	fstp	TBYTE PTR -64[rbp] # n + 1 - k
	mov	rax, QWORD PTR -64[rbp] # rax = n + 1 - k
	mov	edx, DWORD PTR -56[rbp] # edx = [rbp - 56]
	mov	QWORD PTR -16[rbp], rax # answer = n + 1 - k
	mov	DWORD PTR -8[rbp], edx # [rbp - 8] = edx
	mov	rax, QWORD PTR -40[rbp] # rax = n
	mov	QWORD PTR maxBernoulliIndex[rip], rax # maxBernoulliIndex = n
	mov	rax, QWORD PTR -40[rbp] # rax = n
	sal	rax, 4
	mov	rdx, rax
	lea	rax, bernoulliMemo[rip] # rax = bernoulliMemo
	fld	TBYTE PTR -16[rbp] # кладем answer на стек x87
	fstp	TBYTE PTR [rdx+rax] # bernoulliMemo[n] = answer
	fld	TBYTE PTR -16[rbp] # кладем answer на стек x87
.L11:
	leave # эпилог
	ret # return answer
	.size	getBernoulli, .-getBernoulli
	.globl	findAnswer
	.type	findAnswer, @function
findAnswer: # long double findAnswer(long double argument)
	push	rbp # пролог
	mov	rbp, rsp
	sub	rsp, 32 # выделяем место на стеке + выравнивание
	fldz # answer = 0
	fstp	TBYTE PTR -16[rbp] # [rbp - 16] = 0
	fld	TBYTE PTR pi[rip] # кладем pi на стек x87
	lea	rsp, -16[rsp] # rsp - 16
	fstp	TBYTE PTR [rsp] # кладем argument на стек x87
	push	QWORD PTR 24[rbp] # кладем pi на стек
	push	QWORD PTR 16[rbp] # кладем argument на стек
	call	fmodl@PLT # fmodl(argument, pi)
	add	rsp, 32 # чистим стек
	fstp	TBYTE PTR 16[rbp] # argument = fmodl(argument, pi)
	fld	TBYTE PTR pi[rip] # кладем pi на стек x87
	fld	TBYTE PTR .LC6[rip] # кладем 2 на стек x87
	fdivp	st(1), st # pi/2
	fld	TBYTE PTR 16[rbp] # кладем argument на стек x87
	fcomip	st, st(1) # сравниваем arguemnt и pi/2
	fstp	st(0)
	jbe	.L25 # если argument <= pi/2
	fld	TBYTE PTR pi[rip] # кладем pi на стек x87
	fld	TBYTE PTR 16[rbp] # кладем arguemnt на стек x87
	fsubrp	st(1), st # argument - pi
	fstp	TBYTE PTR 16[rbp] # argument -= pi
	jmp	.L18 # к циклу
.L25: # если argument > pi/2
	fld	TBYTE PTR pi[rip] # кладем pi на стек x87
	fchs # -pi
	fld	TBYTE PTR .LC6[rip] # кладем 2 на стек x87
	fdivp	st(1), st # -pi/2
	fld	TBYTE PTR 16[rbp] # кладем argument на стек x87
	fxch	st(1)
	fcomip	st, st(1) # сравниваем argument и -pi/2
	fstp	st(0)
	jbe	.L18 # если argument >= -pi/2 то прыгаем
	fld	TBYTE PTR pi[rip] # кладем pi на стек x87
	fld	TBYTE PTR 16[rbp] # кладем argument на стек x87
	faddp	st(1), st # argument + pi
	fstp	TBYTE PTR 16[rbp] # argument += pi
.L18: # если argument >= -pi/2
	mov	r13, 1 # i = 1
	jmp	.L20 # прыгаем к условию цикла
.L21: # тело цикла
	mov	eax, r13d # eax = i
	add	eax, eax # 2 * i
	cdqe # знаковое расширение eax
	mov	rdi, rax # rdi = 2 * i
	call	getBernoulli # getBernoulli(2 * i)
	mov	eax, r13d # eax = i
	lea	rsp, -16[rsp] # выделяем место на стеке
	fstp	TBYTE PTR [rsp] # сохраняем результат getBernoulli(2 * i) на стеке
	push	QWORD PTR 24[rbp] # кладем getBernoulli(2 * i) на стек
	push	QWORD PTR 16[rbp] # кладем argument на стек
	mov	edi, eax # edi = i
	call	calculateTermValue # calculateTermValue(i, argument, getBernoulli(2 * i))
	add	rsp, 32 # чистим стек
	fld	TBYTE PTR -16[rbp] # загружаем answer на стек x87
	faddp	st(1), st # answer + calculateTermValue(i, argument, getBernoulli(2 * i))
	fstp	TBYTE PTR -16[rbp] # сохраняем новый answer
	add	r13d, 1 # ++i
.L20: # условие цикла
	cmp	r13d, 32 # сравниваем i и 32
	jle	.L21 # i <= 32
	fld	TBYTE PTR -16[rbp] # кладем answer на стек x87
	leave # эпилог
	ret # return answer
	.size	findAnswer, .-findAnswer
	.globl	randLongDouble
	.type	randLongDouble, @function
randLongDouble: # long double randLongDouble(void)
	push	rbp # пролог
	mov	rbp, rsp
	push	rbx # сохраняем регистры которые будем использовать по соглашению вызывов
	sub	rsp, 40 # выделяем место на стеке + выравнивание
	lea	rdi, -32[rbp] # rdi = &t
	call	time@PLT # time(&t)
	mov	edi, eax # edi = time(&t)
	call	srand@PLT #srand((unsigned) time(&t))
	call	rand@PLT # rand()
	cdqe # знаковое расширение результата rand()
	sal	rax, 21 # rand() << 21
	mov	rbx, rax # rbx = rand() << 21
	call	rand@PLT # rand()
	sar	eax, 2 # rand() >> 2
	cdqe # знаковое расширение результата rand()
	xor	rax, rbx # ((unsigned long)(rand()) << 21) ^ (rand() >> 2)
	mov	QWORD PTR -24[rbp], rax # r53 = ((unsigned long)(rand()) << 21) ^ (rand() >> 2)
	test	rax, rax
	js	.L27 # проверяем знаковое ли число
	pxor	xmm0, xmm0 # xmm0 = 0
	cvtsi2sd	xmm0, rax # xmm0 = r53
	jmp	.L28
.L27:
	mov	rdx, rax # rdx = r53
	shr	rdx
	and	eax, 1
	or	rdx, rax
	pxor	xmm0, xmm0 # xmm0 = 0
	cvtsi2sd	xmm0, rdx # xmm0 = r53
	addsd	xmm0, xmm0
.L28:
	movsd	xmm1, QWORD PTR .LC7[rip] # xmm1 = 9007199254740991.0
	divsd	xmm0, xmm1 # (double)r53 / 9007199254740991.0
	movsd	QWORD PTR -40[rbp], xmm0 # сохраняем результат на стек
	fld	QWORD PTR -40[rbp] # загружаем результат на стек x87
	mov	rbx, QWORD PTR -8[rbp] # восстанавливаем rbx
	leave # эпилог
	ret # return (double)r53 / 9007199254740991.0
	.size	randLongDouble, .-randLongDouble
	.section	.rodata
	.align 8
.LC2: # -1
	.long	0
	.long	-1074790400
	.align 8
.LC3: # 2
	.long	0
	.long	1073741824
	.align 8
.LC4: # 1
	.long	0
	.long	1072693248
	.align 16
.LC6: # 2
	.long	0
	.long	-2147483648
	.long	16384
	.long	0
	.align 8
.LC7: # 9007199254740991.0
	.long	-1
	.long	1128267775
