代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin -l start.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：start.bin

Program:
    简历段/section head：
        程序大小/SIZE  段地址/SEGMENTADDR
        段数/SEGMENTNUM  入口点/ENTRY
    代码段/SECTION CODE
    数据段/SECTION DATA
    栈段/SECTION STACK
    结束段/SECTION END  用标号标记程序结束位置

BootLoader:
    一个代码段/SECTION CODE：
        读取第一个扇区，获取参数
        根据程序大小，读取剩余扇区
        程序段地址以及入口的重定位
        跳转至程序入口开始执行

resb指令
    reserve byte
    保留字节，先占下一定内存的空间

dw指令
    DW是x86汇编语言中的伪操作指令。
    基本含义与DB相同，不同的是DW定义16位数据，
    每个数据需两个单元存放。高8位数据字节存入高地址字节中，
    而低8位数据字节则存入低地址字节中。

jmp far
    跳转到程序外部