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