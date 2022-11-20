#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>
#include <sys/time.h>
#include <time.h>

extern long double findAnswer(long double argument);

extern long double randLongDouble(void);

int main(int argc, char *argv[]) {
    struct timeval start, end;
    static struct option longOptions[] = {
            {"iofiles", required_argument, 0, 'f'},
            {"random",  required_argument, 0, 'r'}
    };
    int optionIndex = 0, n, iterations = 1, flag = 0;
    int arg = getopt_long(argc, argv, "f:r:", longOptions, &optionIndex);
    long double argument, answer;
    time_t t;
    FILE* file_output = stdout;
    switch (arg) {
        case 'f': {
            char *file_name = strtok(optarg, ":");
            FILE* file_input = fopen(file_name, "r");
            if (file_input == NULL) {
                printf("Wrong input file name!\n");
                exit(1);
            }
            fscanf(file_input, "%Lf", &argument);
            fclose(file_input);
            file_name = strtok(NULL, ":");
            file_output = fopen(file_name, "w");
            if (file_output == NULL) {
                printf("Wrong output file name!\n");
                exit(1);
            }
            break;
        }
        case 'r': {
            srand((unsigned) time(&t));
            iterations = (int) strtol(strtok(optarg, ":"), NULL, 10);
            argument = randLongDouble();
            fprintf(file_output,"Following floating point number was generated: %Lf \n", argument);
            break;
        }
        default: {
            printf("Enter x: ");
            scanf("%Lf", &argument);
        }
    }
    gettimeofday(&start, NULL);
    for (int i = 0; i < iterations; ++i) {
        answer = findAnswer(argument);
    }
    gettimeofday(&end, NULL);
    fprintf(file_output, "tan(x) = %Lf", answer);
    double time_taken = (double) (end.tv_sec - start.tv_sec) * 1e6;
    time_taken = (time_taken + (double) (end.tv_usec - start.tv_usec)) * 1e-6;
    printf("\nTime taken to execute this program: %f\n", time_taken);
    fclose(file_output);
    return 0;
}