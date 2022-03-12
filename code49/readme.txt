C

编译过程
 
1.预处理
    clang -E main.c -o main.i
    clang -E add.c -o add.i
    .i文件是经过处理后的中间文件，其语法规则和C语言基本一致

2.编译
    clang -S main.i -masm=intel
    clang -S add.i -masm=intel
    获得目标cpu汇编代码
    生成的文件格式  .s
3.汇编
    clang -c main.s -o main.o
    clang -c add.s -o add.o

readelf linux 命令
    readelf -h main.o
    查看main.o文件elf头部信息

4.链接
    整合多个代码文件
    clang main.o add.o
    生成a.out文件，也可以用readelf命令查看信息