#include <stdio.h>

int main()
{
    int a = 0,b = 0,sum = 0;
    printf("Input a:\n");   // 输出提示信息
    scanf("%d", &a);        // %d=输入格式，十进制整数；&=取地址
    printf("Input b:\n");
    scanf("%d", &b);
    sum = a + b;
    printf("sum = %d\n", sum);
    return sum;
}