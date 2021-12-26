代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
编译后文件：start.bin

x86汇编的加减法和循环

; 注释符号
$ 标号 当前行
jmp 跳转到某条指令


reg register    寄存器  8/16（位）
mem memory      内存    8/16（位）
imm immediate   立即数  8/16（位）

add 加法
sub 减法

add reg/mem, reg/mem/imm
    前后位宽必须一致
    结果保留在前
eflags cf 记录进位，CF（大写）即为有进位

sub reg/mem, reg/mem/imm
    前后位宽必须一致
    结果保留在前
eflags cf 记录借位，CF（大写）即为有借位

loop 循环指令
    cx保存循环次数

    标号
        ...
        循环体
        ...
    loop 标号
    cx 自动递减，为0时循环结束

inc incease 自增
inc reg/mem  =>  add reg/mem, 1

dec decease 自减
dec reg/mem  =>  sub reg/mem, 1

adc => add with carry
    => 被加数+加数+CF
    adc reg/mem, reg/mem/imm

sbb => sub with carry
    => 被减数-减数-CF
    sbb reg/mem, reg/mem/imm