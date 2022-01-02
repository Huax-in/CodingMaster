代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin -l start.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：start.bin

Program:
    简历段/section head：
        程序大小/SIZE  段地址/SEGMENTADDR
        段数/SEGMENTNUM  入口点/ENTRY
    代码段/SECTION CODE
    数据段/SECTION DATA
    栈段/SECTION STACK
    结束段/SECTION END  用标号标记程序结束位置

中断
    内部软件中断
    外部硬件中断

    8086对外部中断只提供两个针脚：INTR    NMT

        INTR 接中断HUB
            通常是8259A芯片，是一个可编程中断控制器；可拓展8个引脚，接八个设备。
            8个引脚名称：IR0~IR7 对应 0x08~0x0F 中断编号
            可套娃，再接一个8259A芯片作为从片，这样可以连接15个外部设备。
            统一编号后：IRQ0~IRQ15

        NMI 
            过来的中断不可屏蔽。
            只有非常严重的事件才会通过NMI引脚传达。
            比如读取内存电路校验错误，或者UPS电源发来的停电通知。
            占据0x02中断号，没有细分。

    中断编号 0x00~0xFF
    0x00~0x07   cpu内部保留中断
        INT 00h     CPU：除零错，或商不合法时触发。
        INT 01h     CPU：单步陷阱，TF标记为打开状态时，每条指令执行后触发。（单步调试）
        INT 02h     CPU：非可屏蔽中断，如引导自我测试时发生内存错误。
        INT 03h     CPU：第一个未定义的中断向量，约定俗成仅用于调试程序。（断点调试）
        INT 04h     CPU：算数溢出。通常由INTO指令在置溢出位时触发。
        INT 05h     在按下Shift-Print Screen或BOUND指令检测到范围异常时触发。
        INT 06h     CPU：非法指令。
        INT 07h     CPU：没有数学协处理器时尝试执行浮点指令触发。
    0x08~0x0F   硬件中断
        INT 08h     IRQ0：可编程中断控制器每55毫秒触发一次，即每秒18.2次。
        INT 09h     IRQ1：每次键盘按下、按住、释放。
        INT 0Ah     IRQ2：
        INT 0Bh     IRQ3：COM2/COM4。
        INT 0Ch     IRQ4：COM1/COM3。
        INT 0Dh     IRQ5：硬盘控制器（PC/XT 下）或LPT2。
        INT 0Eh     IRQ6：需要时由软盘控制器调用。
        INT 0Fh     IRQ7：LPT1
    
    8259A芯片
        INT 1Bh     Ctrl+Break，由IRQ9自动调用。
        INT 1Ch     预留，由IRQ8自动调用。
        INT 1Dh     不可调用：指向视频参数表（包含视频模式的数据）的指针。
        INT 70h     IRQ8：由实时钟调用。
        INT 74h     IRQ12：由鼠标调用。
        INT 75h     IRQ13：由数学协处理器调用。
        INT 76h     IRQ14：由第一个IDE控制器所调用。
        INT 77h     IRQ15：由第二个IDE控制器所调用。
    
    IMR 8259A芯片8位中断屏蔽寄存器。
        每一位对应一个引脚，可以通过编程的方式修改。
        当某一位是0的时候，信号是不被屏蔽的。

    eflags寄存器 IF位
        控制INTR过来的信号
        IF是1，则INTR过来的中断不会被屏蔽。
        IF是0，则INTR过来的中断CPU就直接忽略了。
        所以INTR引脚过来的中断被称为可屏蔽中断。

    0x10~0x1A BIOS中断
        BIOS 全名 基本输出输入系统。

    优先级
        NMI 优先级高于 INTR，NMI要优先处理
        其次 INTR上IRQ的号码越小，优先级越高。

中断号会自动初始化到内存
    具体内存地址如下：
    INT 0x00    0x0000:0000~0003
    INT 0x01    0x0000:0004~0007
    INT 0x02    0x0000:0008~000b
    ...
    以此内推，每个中断号的地址起始位置 = 中断号*4

    以上这张表就叫做中断向量表，简称IVT

中断操作步骤：
    一、中断号生成
        自动生成
        硬件中断
        软件中断：
            INT3
            INTO
            BOUND
            INT
    二、IVT寻找地址
        根据中断向量表寻找地址
    三、执行处理程序
        保持现场 push/pop
        参数传递
            mov ah, 0x0e
            int 0x10
        IRET返回