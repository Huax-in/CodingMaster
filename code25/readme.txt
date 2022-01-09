代码文件：start.asm
编译命令：nasm -f bin 32bits.asm -o 32bits.bin -l 32bits.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：32bits.bin

BootLoader
    代码：
        包括读取FAT32的核心逻辑以及工具函数
        1、程序基础设置
            包括初始化段寄存器、初始化栈指针以及检查当前固件是否支持拓展int 0x13中断用于读取硬盘
        2、寻找活动分区入口
        3、计算数据区的起始位置
        4、读取根目录所在的簇
        5、寻找initial.bin文件
        6、计算以块为单位的文件长度
        7、读取文件并运行
        四处可能发生异常：
            1、bios不支持拓展int 0x13中断
            2、没有找到活动分区
            3、没有找到initial.bin文件
            4、读取硬盘失败
        错误处理：
            基础提示：
                Error i, xxxxx
            错误编号：
                Error 1=不支持拓展int 0x13
                Error 2=无活动分区
                Error 3=读取硬盘错误
                Error 4=没有找到initial
            统一处理：
                修改错误编号 => 打印错误信息 => 结束运行
        拓展int 0x13：
            1、检测本计算机bios是否支持拓展int 0x13中断
                CheckInt13:
                    mov ah, 0x41 ;输入参数 选择功能 0x41是检查 0x42是读取
                    mov bx, 0x55aa ;输入参数 
                    mov dl, 0x80 ;输入参数 选择硬盘 0x80是主硬盘
                    int 0x13
                    cmp bx, 0xaa55 ;调用判断
                    mov byte [ShitHappens+0x06], 0x31 ;修改错误编号
                    jnz BootLoaderEnd ;结束运行
                BootLoaderEnd:
                    mov si, ShitHappens
                    call PrintString
                    hlt ;处理器暂停指令 使处理器处于暂时停机状态
            2、通过拓展int 0x13中断读取硬盘，暂时没用写入
                ReadDisk:
                    mov ah, 0x42 ;输入参数 调用int 0x13的读取功能
                    mov dl, 0x80 ;输入参数 选择硬盘
                    mov si, DiskAddressPacket ;输入参数 数据结构体
                    int 0x13
                    test ah, ah ;调用判断
                    mov byte [ShitHappens+0x06], 0x33
                    jnz BootLoaderEnd
                    ret
                DiskAddressPacket:
                    PackSize      db 0x10 ;保留
                    Reserved      db 0    ;用于读取的块个数
                    BlockCount    dw 0    ;用于读取的块个数
                    BufferOffset  dw 0    ;目标地址的偏移
                    BufferSegment dw 0    ;段地址
                    BlockLow      dd 0    ;磁盘的起始块号
                    BlockHigh     dd 0    ;磁盘的起始块号
                PrintString:
                    push ax
                    push cx
                    push si
                    mov cx, 512 ;最大可打印字符数
                    PrintChar:
                        mov al, [si] ;输入参数
                        mov ah, 0x0e
                        int 0x10
                        cmp byte [si], 0x0a ;结尾字符0x0a
                        je Return
                        inc si
                        loop PrintChar
                    Return:
                        pop si
                        pop cx
                        pop ax
    数据：
        包括读取所需的数据结构以及重要的提示

BootLoader:
    section Initial vstart=0x7c00
    ZeroTheSegmentRegister: ;初始化段寄存器 全部为0
        xor ax, ax
        mov ds, ax
        mov es, ax
        mov ss, ax
    SetupTheStackPointer: ;初始化栈寄存器
        mov sp, 0x7c00
    Start:
        mov si, BootLoaderStart ;打印提示信息
        call PrintString
    CheckInt13: ;检查拓展INT 0x13中断
        mov ah, 0x41 ;输入参数 选择功能 0x41是检查 0x42是读取
        mov bx, 0x55aa ;输入参数 
        mov dl, 0x80 ;输入参数 选择硬盘 0x80是主硬盘
        int 0x13
        cmp bx, 0xaa55 ;调用判断
        mov byte [ShitHappens+0x06], 0x31 ;修改错误编号
        jnz BootLoaderEnd ;结束运行
    SeekTheActivePartition:
        mov di, 0x7dbe ;MBR分区表起始
        mov cx, 4
        isActivePartition:
            mov bi, [di]
            cmp bl, 0x80 ;活动分区标志
            je ActivePartitionFound
            add di, 16
            loop isActivePartition
        ActivePartitionNotFound:
            mov byte [ShitHappens+0x06], 0x32
            jmp BootLoaderEnd
        ActivePartitionFound:
            mov si, PartitionFound
            call PrintString
            mov ebx, [di+8]
            mov dword [BlockLow], ebx ;分区入口地址 如果硬盘空间大于8G，高16位也需要写入
            mov word [BufferOffset], 0x7e00
            mov byte [BlockCount], 1
            call ReadDisk
        GetFirstFat:
            mov di, 0x7e00
            xor ebx, ebx
            mov bx, [di+0x0e]
            mov eax, [di+x01c]
            add ebx, eax ;EBX: FAT表起始地址
        GetDataAreaBase:
            mov eax, [di+0x24]
            xor cx, cx
            mov cl, [di+0x10]
            AddFatSize:
                add ebx, eax
                loop AddFatSize
        ReadRootDirectory:
            mov [BlockLow], ebx
            mov word [BufferOffset], 0x8000
            mov di, 0x8000
            mov byte [BlockCount], 8
            call ReadDisk ;读取根目录8个块
            mov byte [ShitHappens+0x06], 0x34
        SeekTheInitialBin:
            cmp dword [di], 'INIT'
            jne nextFile
            cmp dword [di+4], 'IAL '
            jne nextFile
            cmp dword [di+8], 'BIN '
            jne nextFile
            jmp InitialBinFound
            nextFile:
                cmp di, 0x9000
                ja BootLoaderEnd
                add di, 32
                jmp SeekTheInitialBin
        InitialBinFound:
            mov si, InitialFound
            call PrintString

            mov ax, [di+0x1c]
            mov dx, [di+0x1e]
            mov cx, 512
            div cx
            cmp dx, 0
            je NoRemainder
            inc ax
            mov [BlockCount], ax
            NoRemainder:
                mov ax, [di+0x1a]
                sub ax, 2
                mov cx, 8
                mul cx
                and eax, 0x0000ffff
                add ebx, eax
                mov ax, dx
                shl eax, 16
                add ebx, eax
                mov [BlockLow], ebx
                mov word [BufferOffset], 0x9000
                mov di, 0x9000
                call ReadDisk
                mov si, GotoInitial
                call PrintString
                jmp di

修改VHD文件属性
    1、打开VirtualBox
    2、Ctrl+D
    3、选中以前创建的VHD文件
    4、把属性修改为多重加载
    5、点击应用