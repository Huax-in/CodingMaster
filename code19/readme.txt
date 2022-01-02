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

GPU
    0x3d4端口   下发寄存器编号
    0x3d5端口   读取下发编号的寄存器里的值
    0x0e寄存器 代表光标位置的高8位
    0x0f寄存器 代表光标位置的低8位

回车处理
    方法1：
    .putCR: ;输出回车
        mov bl, 160
        mov ax, di
        div bl
        mul bl
        mov di, ax
        call SetCursor
        inc si
    方法2：
    .putCR: ;输出回车
        mov bl, 160
        mov ax, di
        div bl
        shr ax, 8
        sub di, ax
        call SetCursor
        inc si

shr（右移）指令
    使目的操作数逻辑右移n位，最高位用 0 填充。
    最低位复制到进位标志位，而进位标志位中原来的数值被丢弃。

换行处理
    .putLF: ;输出换行
    add di, 160 ;80
    call SetCursor
    inc si

shl（左移）指令
    使目的操作数逻辑左移n位，最低位用 0 填充。
    最高位移入进位标志位，而进位标志位中原来的数值被丢弃。