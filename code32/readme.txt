代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin -l start.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：start.bin

内存分页的四种模式
    4-Level Paging

逻辑地址

线性地址
    =段地址/段选择子:逻辑地址

64位X86系列CPU支持的四种内存分页模式
    32 BIT PAGING
        CR4.PG=1
    PAE PAGING
        CR4.PG=1, CR4.PAE=1
    4-LEVEL PAGING
        CR4.PG=1, CR4.PAE=1, CR4.LME=1
    5-LEVEL PAGING
        CR4.PG=1, CR4.PAE=1, CR4.LME=1, CR4.LA57=1

    32 BIT PAGING和PAE PAGING两种模式只能在保护模式下使用
    4-LEVEL PAGING和5-LEVEL PAGING两种模式只能在长模式/IA-32e下使用
    