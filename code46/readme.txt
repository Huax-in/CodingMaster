C
文件
设备也是文件

File* file = fopen("data.txt", "a");

fprintf(file, "%d,%s\n", stu->code, stu->name);

文件描述符
    Unix系统下的高级抽象
    设备的输入输出通过修改某个文件实现
    open() read()
        linux打开文件的底层函数
    一切皆文件的抽象可以使操作设备像操作文件一样简单