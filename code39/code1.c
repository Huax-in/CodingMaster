#include <stdio.h>

int main() {
    int a = 0, b = 0, result = 0;
    char p = 0;
    printf("Input the math:\n");
    scanf("%d %c %d", &a, &p, &b);
    switch (p) {
    case '+':
        result = a + b;
        break;
    case '-':
        result = a - b;
        break;
    case '*':
        result = a * b;
        break;
    case '/':
        result = a / b;
        break;
    case '%':
        result = a % b;
        break;
    default:
        break;
    }
    printf(" = %d\n", result);
    return 0;
}