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
                console.log("🚀 ~ file: start.asm ~ line 101 ~ section Initial vstart=0x7c00
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
                jmp di", section Initial vstart=0x7c00
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
                jmp di)
                jmp di