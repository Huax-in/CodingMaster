代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
编译后文件：start.bin

编译后文件放到VirtualBox虚拟机执行

Bochs 命令

s: 单步调试
b: 打断点，后跟内存地址
    例：b 0x7c00
c: cointine，继续运行
q: 退出bochs调试
    直接关闭窗口会导致lock，需要删除.lock文件
r: 查看通用寄存器
sreg: 查看段寄存器

xp: 查看物理内存
xp /nuf addr
    n: 查看多少个单位，整数
    u: 单位，可以是b（字节）、h（2字节）、w（4字节）、g（8字节）
    f: 格式，可以是x（十六进制）、d（十进制）、u（无符号十进制）、o（八进制）、t（二进制）
    addr: 地址
    例：xp /1bx 0x7c0f1  每次1单位，每单位1字节，16进制输出