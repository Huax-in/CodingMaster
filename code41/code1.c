#include <stdio.h>

int countMoney(int price, int number);
int countMoney2(int* price, int number);

int main(int argc, char* argv[]) {
    int price = 18, number = 2, money = 0;
    money = countMoney(price, number);
    printf("money is: %d\n", money);
    money = countMoney2(&price, money);
    printf("money is: %d, price is: %d\n", money, price);
    return 0;
}

/**
 * @brief 计算总价
 * 
 * @param price 单价
 * @param number 数量
 * @return int 
 */
int countMoney(int price, int number) {
    return price * number;
}

int countMoney2(int* price, int number) {
    *price = 12;
    return *price * number;
}