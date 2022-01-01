代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
编译后文件：start.bin

eflags常用标志位

0  CF  进位     进位时为1
2  PF  偶数     偶数时为1
6  ZF  zero     结果0时为1
7  SF  符号     减法结果为负值时为1
11 OF  溢出     计算存在溢出时为1

jcc/条件转移指令
    eflags 配合jcc指令使用
    jz  =>  Jump if zero(ZF=1)
    jnz =>  Jump if not zero(ZF=0)

cmp/比较指令
    cmp dest目的(reg/mem) source源(reg/mem/imm)

无符号数
operands        CF  ZF
dest>source     0   0
dest=source     0   1
dest>source     1   0

有符号数
operands        OF      ZF
dest>source     SF      0
dest=source     0       1
dest>source     NOT SF  0

section /分段
    section name align=16/32 vstart=0
            段名    对其大小   段内偏移地址的基准地址

call指令
    call 标号/寄存器/内存地址

ret指令
    加在代码块最后（return）

参数与返回值通过寄存器实现

逻辑运算指令
and/与运算指令
    and dest目的(reg/mem) source源(reg/mem/imm)
    例：and al, 0x10    取al第四位的值

or/或运算指令
    or dest目的(reg/mem) source源(reg/mem/imm)
    例：or al, 0x04     设置al第六位为1

not/非运算指令
    not reg/mem
    反转操作数的每一位
    例：not al

xor/抑或运算指令
    xor dest目的(reg/mem) source源(reg/mem/imm)
    运算结果会影响zf标志位
    例：xor al, al      0x00

equ 声明常量

db指令
  作为汇编语言中的伪操作命令，它用来定义操作数占用的字节数。
    [标号:] db 表达式表
    表达式中可包含符号、字符串、或表达式等项，
    各个项之间用逗号隔开，字符串应用引号括起来。
    括号内的标号是可选项，如果使用了标号，
    则标号的值将是表达式表中第一字节的地址。
    DB 指令必须位于 数据段之内，否则将会发生错误。

标号
    标号是充当指令或数据位置标记的标识符。
    数据标号：
        数据标号标识了变量的地址，为在代码中引用该变量提供了方便，如：
        count DWORD 100  ;定义了一个名为count的变量
    代码标号：
        程序代码区中的标号必须以冒号（:）结尾。代码标号通常用作跳转和循环指令的目标地址，如：
        loop:
            jmp loop            ;跳到loop处执行代码，这是一个死循环
        代码标号可以与指令在同一行也可以独自成一行。

伪指令
    伪指令是内嵌在程序源代码中，由汇编器识别并执行相应动作的命令。
    与真正的指令不同，伪指令在程序运行时并不执行。
    伪指令可用于定义变量、宏以及过程，
    可用于命名段以及执行许多其他与汇编器相关的簿记任务。MASM中伪指令大小写不敏感，
    .data和.DATA是等价的。每个汇编器都有一套不同的伪指令，
    例如，TASM以及NASM和MASM的伪指令有一个公共的交集，
    而GNU汇编器与MASM的伪指令几乎完全不同。