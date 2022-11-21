default: main.c functions.c
	gcc -lc main.c functions.c -o default -lm
original_assembly: main.c functions.c
	gcc -S -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions -O0 main.c -o main_original.s
	gcc -S -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions -O0 functions.c -o functions_original.s
assembly: main.s functions.s
	gcc -masm=intel -lc main.s functions.s -o assembly -lm
O3: main.c functions.c
	gcc -S -O3 -masm=intel main.c -o main_03.s
	gcc -S -O3 -masm=intel functions.c -o functions_03.s
	gcc -lc main_03.s functions_03.s -o O3 -lm
Os: main.c functions.c
	gcc -S -Os -masm=intel main.c -o main_0s.s
	gcc -S -Os -masm=intel functions.c -o functions_0s.s
	gcc -lc main_0s.s functions_0s.s -o Os -lm
run: default
	./default
test_default: default
	./default < input1
	./default < input2
	./default -f input1:output1
	cat output1
	./default -f input2:output2
	cat output2
	./default -r 1
test_assembly: assembly
	./assembly < input1
	./assembly < input2
	./assembly -f input1:output1
	cat output1
	./assembly -f input2:output2
	cat output2
	./assembly -r 1
