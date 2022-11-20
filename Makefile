default: main.c functions.c
	gcc -lc main.c functions.c -o default -lm
run: default
	./default