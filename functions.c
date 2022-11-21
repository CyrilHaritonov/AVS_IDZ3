#include <math.h>
#include <stdlib.h>
#include <time.h>

long double pi = 3.14159265358979;

long double bernoulliMemo[100] = {1, 0};
long maxBernoulliIndex = 0;

long double calculateFactorial(long n) {
    long double ans = 1;
    for (int i = 1; i <= n; ++i) {
        ans *= i;
    }
    return ans;
}

long double calculateTermValue(int n, long double x, long double bernoulli) {
    return (pow(-1, n - 1) * pow(2, 2 * n) * (pow(2, 2 * n) - 1) * bernoulli * powl(x, 2 * n - 1)) / calculateFactorial(2 * n);
}

long double calculateCombination(long n, long k) {
    return calculateFactorial(n)/(calculateFactorial(n-k) * calculateFactorial(k));
}

long double getBernoulli(long n) {
    if (maxBernoulliIndex >= n) {
        return bernoulliMemo[n];
    }
    if (n % 2 == 1 && n != 1) {
        return bernoulliMemo[n];
    }
    long double answer = 0;
    for (int k = 0; k <= n - 1; ++k) {
        answer += calculateCombination(n, k) * getBernoulli(k) / (n + 1 - k);
    }
    answer *= -1;
    maxBernoulliIndex = n;
    bernoulliMemo[n] = answer;
    return answer;
}

long double findAnswer(long double argument){
    long double answer = 0;
    argument = fmodl(argument, pi);
    if (argument > pi/2) {
        argument -= pi;
    } else if (argument < -pi/2) {
        argument += pi;
    }
    for (int i = 1; i <= 32; ++i) {
        answer += calculateTermValue(i, argument, getBernoulli(2 * i));
    }
    return answer;
}

long double randLongDouble(void) {
    time_t t;
    srand((unsigned) time(&t));
    unsigned long r53 = ((unsigned long)(rand()) << 21) ^ (rand() >> 2);
    return (double)r53 / 9007199254740991.0;
}