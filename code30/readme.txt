代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin -l start.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：start.bin

内存分页

段式内存管理

分页内存管理
    把内存切分成等大的页面
    页表PT/Page Table
        PTE/Page Table Entrance
            页地址高20位+页属性
    页表目录
        存放页表入口
        页表地址高20位+页表属性
    CR3寄存器
        保存页目录的内存地址

段式内存访问
CodeDescriptor equ $-GDTStart
    dw 0xFFFF ; 段界限
    dw 0 ; 段基地址: 15~0
    db 0 ; 段基地址: 23~16
    db 0x9B ; 段属性
    db 0xCF ; 段界限: 19~16
    db 0 ; 段基地址: 32~24
    通过 CodeDescriptor:Offset 访问某个地址