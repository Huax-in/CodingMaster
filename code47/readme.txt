C

可执行文件格式的历史渊源
自Unix开始的a.out以及后续发展的coff，进而产生的PE、ELF、Mach-O等格式。

loader程序
    每种可执行文件格式都有支持其运行的loader程序

各可执行文件格式关系
a.out
    -> coff
        -> Windows PE
        -> UEFI PE
        -> Unix ELF
    -> MacOS MACH-O

ELF
    ELF Header
        程序头表
        主程序体