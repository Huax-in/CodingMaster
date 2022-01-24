#include <stdio.h>

int main(int argc, char* argv[]) {
    int price = 18;
    printf("price is: %d\n", price);
    price = 16;
    int* p = NULL;
    p = &price;
    printf("*p=%d, p=%x, &p=%x\n", *p, p, &p);

    // number 等价于number[0] 的地址
    int number[4] = {1, 2, 3, 4};
    p = number;
    printf("p[0] is: %d, p=%x\n", p[0], p);
    p++; // 指向下一个元素
    printf("*p=%d, p=%x, &p=%x\n", *p, p, &p);
    return 0;
}