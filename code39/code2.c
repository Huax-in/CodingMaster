#include <stdio.h>
#include <string.h>
/**
 * @brief 
 * 
 * @param argc 参数个数
 * @param argv 参数数组指针
 * @return int 
 */
int main(int argc, char* argv[]) {
    printf("argc is: %d\n", argc);
    for(int i = 0; i < argc;i++) {
        printf("argv[%d] is: %s\n", i, argv[i]);
    }
    char p = argv[2][0];
    int i = 0, a = 0, b = 0;
    for(i = 0; i < strlen(argv[1]); i++) {
        a = a*10 + argv[1][i] - 48;
    }
    for(i = 0; i < strlen(argv[3]);i++) {
        b = b*10 + argv[3][i] - 48;
    }
    int result = 0;
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
    printf("result is: %d\n", result);
    return 0;
}