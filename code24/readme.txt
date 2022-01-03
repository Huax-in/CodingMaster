代码文件：start.asm
编译命令：nasm -f bin 32bits.asm -o 32bits.bin -l 32bits.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：32bits.bin

fat32
    f   file
    a   allocation
    t   table
    32  用32位标记簇

簇
    簇由若干块组成，一般为8个块

fat32最大标记16T空间

fat32
    FAT头
    FAT表  用32位标记每一个簇，若是空闲则32位全是0
    FAT数据区

BootLoader
    2、寻找fat起始块号
        起始块号 = 分区前已使用块数 + FAT保留块数 + FAT表个数*大小
    3、文件起始簇号
    4、文件起始块号
        第一个簇的编号是2
        文件起始块号 = 数据区起始块号 + (文件起始簇号-2)*每簇块数
    5、计算读取扇区数
        文件所占块数=文件长度(4bytes)/每块字节数
        只要余数不为0，就要把读取的块数+1，才能读到完整的文件

fat根目录
    文件名    8bytes
    后缀名    4bytes
    起始簇号  4bytes
    文件长度  4bytes