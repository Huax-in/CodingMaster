代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin -l start.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：start.bin

四层内存分页

PML4E/8B
    PML4 -> PDPTE/8B
        PDPT -> PDE/8B
            PD -> PTE/8B
                PT -> PAGE/4KB

47:39   38:30   29:21   20:12   11:0
PML4E   PDPTE   PDE     PTE     PAGE
PML4    PDPT    PD      PT      物理地址