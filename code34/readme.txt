代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin -l start.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：start.bin

宏
    编译器提供的语法，不是cpu指令
    %define
        %define Video 0xb800
        等价于 Video equ 0xb800
        %define PAGE_2M_PDE_ATTR (PAGE_2M_MBO + \
                                  PAGE_ACCESSED + \
                                  PAGE_DIRTY + \
                                  PAGE_READ_WRITE + \
                                  PAGE_PRESENT)
            PAGE_2M_PDE_ATTR => 宏名
        %define PDP(offset) (ADDR_OF \
                             (TopLevelPageDirectory)\
                              + (offset) + \
                              PAGE_PDP_ATTR)
            offset 参数,可以有多个，逗号隔开

    条件汇编
        可以选择性的让部分代码不经过编译
    
        %define ToyOS   -> 定义一个简单宏作为条件
        %ifdef ToyOS    -> 判断是否已经定义了 宏ToyOS
            add NB, 250 -> 条件为真则语句执行
        %endif          -> 判断语句结束标志
    
    %assign i 0     -> 类似C语言int i = 0
    %rep 5          -> 循环语句开始,5:循环次数
        add NB, 250 -> 循环体
    %endrep         -> 循环语句结束标志

定义页表
BIT 64 ; 编译为64位代码
%define ALIGN_TOP_TO_4K_FOR_PAGING ;顶部4k对齐

%define PAGE_PRESENT            0x01    ;0b1 属性P位
%define PAGE_READ_WRITE         0x02    ;0b10 属性R/W位
%define PAGE_USER_SUPERVISOR    0x04    ;0b100
%define PAGE_WRITE_THROUGH      0x08    ;0b1000
%define PAGE_CACHE_DISABLE      0x010   ;0b10000
%define PAGE_ACCESSED           0x020   ;0b100000
%define PAGE_DIRTY              0x040   ;0b1000000
%define PAGE_PAT                0x080   ;0b10000000
                                    ;sum=0b11111111

%define PAGE_GLOBAL             0x0100
%define PAGE_2M_MBO             0x080
%define PAGE_2M_PAT             0x01000

;2M分页的属性
;0xE3/0B11100011
%define PAGE_2M_PDE_ATTR (PAGE_2M_MBO + \
                          PAGE_ACCESSED + PAGE_DIRTY + \
                          PAGE_READ_WRITE + PAGE_PRESENT)

%define PAGE_PDP_ATTR (PAGE_ACCESSED + \
                       PAGE_READ_WRITE + PAGE_PRESENT)

%define PGTBLS_OFFSET(x) ((x) - TopLevelPageDirectory)

%define PGTBLS_ADDR(x) (ADDR_OF(TopLevelPageDirectory) + (x))

%define PDP(offset) (ADDR_OF(TopLevelPageDirectory) + (offset) + PAGE_PDP_ATTR)

%define PTE_2MB(x) ((x << 21) + PAGE_2M_PDE_ATTR)

TopLevelPageDirectory: ;页表起始
    ; Top Level Page Directory Pointers (1 * 512B entry)
    DQ  PDP(0x1000) ;定义PML4表的第0个PML4E

    ; Next Level Page Directory Pointers (4 * 1GB entries => 4GB)
    TIMES 0x1000-PGTBLS_OFFSET($) DB 0 ;保持4K对齐
    DQ  PDP(0x2000)
    DQ  PDP(0x3000)
    DQ  PDP(0x4000)
    DQ  PDP(0x5000)

    ; Page Table Entries (2048 * 2MB entries => 4GB)
    TIMES 0x2000-PGTBLS_OFFSET($) DB 0

%assign i 0 ;初始值为0
%rep 0x800 ;循环次数为2048
    DQ  PTE_2MB(i) ;定义1个物理页入口，i左移21位就是物理地址
    %assign i i+1
%endrep