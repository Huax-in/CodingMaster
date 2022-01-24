C
数据类型
数据结构
程序=数据+算法

基本数据类型
    int
    char    int的子集
    float
    double

SMS
    学生信息
        学号
        姓名
    功能：
        insert
        search
        update
        delete

结构体
    声明：
        struct student {
            unsigned int code;
            char name[32];
        };
    使用：
        struct student stu;
        struct student stus[10];

#define
    C语言中，可以用 #define 定义一个标识符来表示一个常量。
    其特点是：定义的标识符不占内存，只是一个临时的符号，
    预编译后这个符号就不存在了。

    使用：
        #define MAXSTUS 10