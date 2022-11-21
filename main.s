	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"f:r:" # строка для getopt_long
.LC1:
	.string	":" # строка для strtok
.LC2:
	.string	"r" # стркоа для fopen
.LC3:
	.string	"Wrong input file name!" # строка для printf
.LC4:
	.string	"%Lf" # строка для fscanf
.LC5:
	.string	"w" # стркоа для fopen
.LC6:
	.string	"Wrong output file name!" # строка для fopen
	.align 8
.LC7:
	.string	"Following floating point number was generated: %Lf \n"  # строка для fprintf
.LC8:
	.string	"Enter x: " # строка для printf
.LC9:
	.string	"tan(x) = %Lf" # строка для fprintf
	.align 8
.LC12:
	.string	"\nTime taken to execute this program: %f\n" # строка для printf
	.text
	.globl	main
	.type	main, @function
main: # int main(int argc, char *argv[])
	push	rbp # пролог
	mov	rbp, rsp
	sub	rsp, 160 # выделяем место для переменных на стеке + выравнивание
	mov	DWORD PTR -148[rbp], edi # [rbp-148] = char *argv[]
	mov	QWORD PTR -160[rbp], rsi # [rbp-160] = int argc
	mov	DWORD PTR -116[rbp], 0 # [rbp-116] = optionIndex
	mov	DWORD PTR -4[rbp], 1 # [rbp-4] = iterations
	lea	r8, -116[rbp] # r8 = &optionIndex
	mov	rsi, QWORD PTR -160[rbp] # rsi = argc
	mov	edi, DWORD PTR -148[rbp] # edi = argv
	lea	rcx, longOptions.0[rip] # rcx = longOptions
	lea	rdx, .LC0[rip] # rdx = "f:r:"
	call	getopt_long@PLT # getopt_long(argc, argv, "f:r:", longOptions, &optionIndex)
	mov	DWORD PTR -48[rbp], eax # int arg = getopt_long(argc, argv, "f:r:", longOptions, &optionIndex)
	mov	rax, QWORD PTR stdout[rip] # rax = stdout
	mov	QWORD PTR -40[rbp], rax # [rbp-40] = stdout
	cmp	DWORD PTR -48[rbp], 102 # case 'f'
	je	.L2 # заходим внутрь case 'f'
	cmp	DWORD PTR -48[rbp], 114 # case 'r'
	je	.L3 # заходим внутрь case 'r'
	jmp	.L11 # default
.L2: # case 'f'
	mov	rdi, QWORD PTR optarg[rip] # rdi = optarg
	lea	rsi, .LC1[rip] # rsi = ":"
	call	strtok@PLT # strtok(optarg, ":")
	mov	QWORD PTR -56[rbp], rax # char *file_name = strtok(optarg, ":")
	mov	rdi, QWORD PTR -56[rbp] #  rdi = file_name
	lea	rsi, .LC2[rip] # rsi = "r"
	call	fopen@PLT # fopen(file_name, "r")
	mov	QWORD PTR -64[rbp], rax # FILE* file_input = fopen(file_name, "r")
	cmp	QWORD PTR -64[rbp], 0 # if (file_input == NULL)
	jne	.L5 # если нет то идем дальше
	lea	rdi, .LC3[rip] # rdi = "Wrong input file name!\n"
	call	puts@PLT # printf("Wrong input file name!\n")
	mov	edi, 1 # edi = 1
	call	exit@PLT # exit(1)
.L5: # если file_input != NULL
	lea	rdx, -144[rbp] # rdx = &argument
	mov	rdi, QWORD PTR -64[rbp] # rdi = file_input
	lea	rsi, .LC4[rip] # rsi = "%Lf"
	mov	eax, 0 # 0 так как не используем xmm регистры
	call	__isoc99_fscanf@PLT # fscanf(file_input, "%Lf", &argument)
	mov	rdi, QWORD PTR -64[rbp] # rdi = file_input
	call	fclose@PLT # fclose(file_input)
	lea	rsi, .LC1[rip] # rsi = ":"
	mov	edi, 0 # edi = NULL
	call	strtok@PLT # strtok(NULL, ":")
	mov	QWORD PTR -56[rbp], rax # file_name = strtok(NULL, ":")
	mov	rdi, rax # rdi = file_name
	lea	rsi, .LC5[rip] # rsi = "w"
	call	fopen@PLT # fopen(file_name, "w")
	mov	QWORD PTR -40[rbp], rax # file_output = fopen(file_name, "w")
	cmp	QWORD PTR -40[rbp], 0 # if (file_output == NULL)
	jne	.L7 # если != прыгаем
	lea	rdi, .LC6[rip] # rdi = "Wrong output file name!\n"
	call	puts@PLT # printf("Wrong output file name!\n")
	mov	edi, 1 # edi = 1
	call	exit@PLT # exit(1)
.L3: # case 'r'
	mov	rdi, QWORD PTR optarg[rip] # rdi = optarg
	lea	rsi, .LC1[rip] # rsi = ":"
	call	strtok@PLT # strtok(optarg, ":")
	mov	edx, 10 # edx = 10
	mov	esi, 0 # esi = NULL
	mov	rdi, rax # rdi = strtok(optarg, ":")
	call	strtol@PLT # strtol(strtok(optarg, ":"), NULL, 10)
	mov	DWORD PTR -4[rbp], eax # iterations = (int) strtol(strtok(optarg, ":"), NULL, 10)
	call	randLongDouble@PLT # randLongDouble()
	fstp	TBYTE PTR -144[rbp] #
	fld	TBYTE PTR -144[rbp] # argument = randLongDouble()
	mov	rax, QWORD PTR -40[rbp] # rax = file_input
	lea	rsp, -16[rsp] # выделяем место на стеке для промежуточных операций
	fstp	TBYTE PTR [rsp] # кладем argument в барабан подпроцессора x87
	lea	rsi, .LC7[rip] # rsi = "Following floating point number was generated: %Lf \n"
	mov	rdi, rax # rdi = file_input
	mov	eax, 0 # 0 так как не используем xmm регистры
	call	fprintf@PLT # fprintf(file_output,"Following floating point number was generated: %Lf \n", argument)
	add	rsp, 16 # чистим стек
	jmp	.L7 # break
.L11: # default
	lea	rdi, .LC8[rip] # rdi = "Enter x: "
	mov	eax, 0
	call	printf@PLT # printf("Enter x: ");
	lea	rsi, -144[rbp] # rsi = &argument
	lea	rdi, .LC4[rip] # rdi = "%Lf"
	mov	eax, 0 # 0 так как не используем xmm регистры
	call	__isoc99_scanf@PLT # scanf("%Lf", &argument)
.L7: # вышли из switch
	lea	rdi, -96[rbp] # rdi = &start
	mov	esi, 0 # esi = NULL
	call	gettimeofday@PLT # gettimeofday(&start, NULL)
	mov	r12d, 0 # r12d = i = 0
	jmp	.L8 # прыгаем к условию цикла
.L9: # тело цикла
	fld	TBYTE PTR -144[rbp] # кладем argument в стек x87
	lea	rsp, -16[rsp] # выделяем место для argument на обычном стеке
	fstp	TBYTE PTR [rsp] # кладем argument на стек
	call	findAnswer@PLT # findAnswer(argument);
	add	rsp, 16 # чистим стек
	fstp	TBYTE PTR -32[rbp] # answer = findAnswer(argument);
	add	r12d, 1 # i++
.L8: # условие цикла
	cmp	r12d, DWORD PTR -4[rbp] # сравнием i и iterations
	jl	.L9 # если i < iterations то прыгаем в тело цикла
	lea	rdi, -112[rbp] # rdi = &end
	mov	esi, 0 # esi = NULL
	call	gettimeofday@PLT # gettimeofday(&end, NULL)
	mov	rdi, QWORD PTR -40[rbp] # rdi = file_output
	push	QWORD PTR -24[rbp]
	push	QWORD PTR -32[rbp] # кладем argument на стек
	lea	rsi, .LC9[rip] # rsi = "tan(x) = %Lf"
	mov	eax, 0  # 0 так как не используем xmm регистры
	call	fprintf@PLT # fprintf(file_output, "tan(x) = %Lf", answer)
	add	rsp, 16 # чистим стек
	mov	rax, QWORD PTR -112[rbp] # rax = end.tv_sec
	mov	rdx, QWORD PTR -96[rbp] # rdi = start.tv_sec
	sub	rax, rdx # (end.tv_sec - start.tv_sec)
	pxor	xmm1, xmm1 # xmm1 = 0
	cvtsi2sd	xmm1, rax # xmm1 = (end.tv_sec - start.tv_sec)
	movsd	xmm0, QWORD PTR .LC10[rip] # xmm0 = 1e6
	mulsd	xmm0, xmm1 # (end.tv_sec - start.tv_sec) * 1e6
	movsd	QWORD PTR -72[rbp], xmm0 # double time_taken = (double) (end.tv_sec - start.tv_sec) * 1e6;
	mov	rax, QWORD PTR -104[rbp] # rax = end.tv_usec
	mov	rdx, QWORD PTR -88[rbp] # rdx = start.tv_usec
	sub	rax, rdx # (end.tv_usec - start.tv_usec)
	pxor	xmm0, xmm0 # xmm0 = 0
	cvtsi2sd	xmm0, rax # xmm0 = (end.tv_usec - start.tv_usec)
	movapd	xmm1, xmm0 # xmm1 += xmm0
	addsd	xmm1, QWORD PTR -72[rbp] # xmm1 += time_taken
	movsd	xmm0, QWORD PTR .LC11[rip] # xmm0 = 1e-6
	mulsd	xmm0, xmm1 # (end.tv_usec - start.tv_usec)) * 1e-6
	movsd	QWORD PTR -72[rbp], xmm0 # time_taken = (time_taken + (double) (end.tv_usec - start.tv_usec)) * 1e-6
	mov	rax, QWORD PTR -72[rbp] # rax = time_taken
	movq	xmm0, rax # xmm0 = time_taken
	lea	rdi, .LC12[rip] # rdi = "\nTime taken to execute this program: %f\n"
	mov	eax, 1 # 1 так как используем xmm регистр
	call	printf@PLT # printf("\nTime taken to execute this program: %f\n", time_taken)
	mov	rdi, QWORD PTR -40[rbp] # rdi = file_output
	call	fclose@PLT # fclose(file_output)
	mov	eax, 0 # eax = 0
	leave # эпилог
	ret # return 0
	.size	main, .-main
	.section	.rodata
.LC14:
	.string	"iofiles" # строка для струтуры longOptions
.LC15:
	.string	"random" # строка для струтуры longOptions
	.section	.data.rel.local,"aw"
	.align 32
	.type	longOptions.0, @object
	.size	longOptions.0, 64
longOptions.0: # структура longOptions
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
.LC10: # 1e6
	.long	0
	.long	1093567616
	.align 8
.LC11: # 1e-6
	.long	-1598689907
	.long	1051772663
