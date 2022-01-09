代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin -l start.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：start.bin

CPU的操作模式
    8086：实模式
    80286：实模式、保护模式
    80386：实模式、保护模式、虚拟8086模式
    Athlon：实模式、保护模式、虚拟8086模式、64位模式、兼容模式

    归类：
        经典模式：实模式、保护模式、虚拟8086模式
        长模式（AMD）/IA-32e（Intel）：64位模式、兼容模式

加电后CPU初始模式：实模式
Intel推出了EFI标准

固件
    固件也是一种软件
    如BIOS、UEFI等
    CPU也有固件

ToyOS
    暂定只运行在64位模式
    保护模式作过渡

模式切换
    控制寄存器 (Control Register)
        CR0
        CR2
        CR3
        CR4
        CR8(64B)
        EFER(Extended Feature Enable Register)
            在上述控制寄存器基础上新增的，不是所有CPU都有
    模式切换就是修改控制寄存器的值

从实模式到保护模式的逻辑
    实模式：段地址: 偏移地址 ----> 物理地址
        0.段寄存器保存段地址
        1.段地址左移四位        
        2.加上偏移地址
    保护模式：段地址: 偏移地址 ----> 物理地址
        0.段寄存器保存段选择子
        1.查找GDT获取段描述符
        2.比较特权级获取段起始地址
        3.段起始地址加上偏移地址

切换到保护模式分四步
    1.定义GDT
        GDT（全局描述符）：
            保存段描述符、LDT、各种门的入口等等
            空描述符（64个0）
            数据段描述符
            代码段描述符
    2.告知CPU
        获取GDT的内存地址及大小
        GDTR:
            dw GDTSize
            dd GDTBase
        LGDT GDTR
    3.修改PE位
        EnableProtectBit:
            mov eax, 0x40000023
            mov cr0, eax
    4.清空流水线
            jmp CodeDescriptor: ProtectModeLand
        BITS 32
        ProtectModeLand:;从此处开始将是32位代码