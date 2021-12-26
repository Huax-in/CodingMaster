代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
编译后文件：start.bin

寄存器
8b      AL  8
8086    AX  16
32cpu   EAX 32
64cpu   RAX 64

reg register    寄存器  8/16（位）
mem memory      内存    8/16（位）
imm immediate   立即数  8/16（位）

乘法指令
mul reg/mem

被乘数      乘数    高位乘积    低位乘积
reg/mem8    al      ah          al
reg/mem16   ax      dx          ax
会影响CF标志位

除法指令
div reg/mem

被除数      除数        余数       商
ax        reg8/mem8     ah        al
dx:ax     reg16/mem16   dx        ax
不会影响CF标志位

栈
栈底 ss寄存器
栈顶 sp寄存器

push指令
    push ax
pop指令
    pop ax

push => sp-
pop  => sp+