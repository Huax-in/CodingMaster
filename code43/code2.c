#include <stdio.h>
#include <stdlib.h>
//结构体
struct student {
    unsigned int code;
    char name[32];
};

// 类型别名
typedef struct student Student;

int main() {
    // 结构体初始化
    Student stus[10] = {{0,"123"}};
    printf("%s\n", stus[0].name);
    // stus[1] = {2, "names"}; //语法报错
    // stus[1] = new Student(); //语法报错
    stus[1] = *(Student*) malloc(sizeof(stus[1]));
    printf("%d\n", stus[1].code); //0
    // 匿名结构体
    struct {
        int id;
        char name[];
    } ax;
    ax.id = 1;
    printf("%d\n", ax.id);
    return 0;
}