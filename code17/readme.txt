代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin -l start.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：start.bin

读取硬盘的方式
CHS（物理寻址）
    C   Cylinders
    H   Heads
    S   Sectors

LBA（逻辑块寻址）
    L   Logical
    B   Block
    A   Addressing

in/读出指令
    in  dest目的（al/ax）    source源（dx/imm8）

out/写入指令
    in  dest目的（dx/imm8）    source源（al/ax）

LBA28
    28位标记硬盘逻辑扇区号
    最大支持128GB硬盘

    端口
    0x1F7   0x1F6   0x1F5   0x1F4   0x1F3   0x1F2   0x1F1   0x1F0
            |       28位逻辑扇区号       |   扇区数
            27~24   23~16   15~8     7~0
    0x1F6 28~31位标识硬盘号及读写模式
    31  
    30  选择读写模式
    29  
    28  选择硬盘号 0：主硬盘  1：从硬盘
    
    0x1F7 写入0x20，表示读硬盘；写入0x30，表示写硬盘。
    0x1F7 第三位  0：未就绪  1：已就绪
    0x1F7 第七位  0：硬盘闲  1：硬盘忙
    in al, dx  ;读入状态字节
    and al, 0x88  ;取得第3、7位，其它位置为0
    cmp al, 0x08  ;判断是否硬盘闲且已就绪

    0x1F0 用于读取数据
    readword:
        mov dx, 0x1f0
        in ax, dx
        loop readword

LBA48
    48位标记硬盘逻辑扇区号

dd指令 
    dword (double word)双字型数据 