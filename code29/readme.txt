代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin -l start.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：start.bin

从需求到流程图再到代码

显存段
    名称                    空描述符/0x     数据段/0x   代码段/0x   显存段
DW/16位，段界限：15~0           0000        FFFF        FFFF        7FFF
DW/16位，段基地址：15~0         0000        0000        0000        8000
DB/8位，段基地址：23~16         00          00          00          0B
DB/8位，段属性                  00          93          9B          93
DB/8位，段界限：19~16/段属性     00         CF          CF          C0
DB/8位，段基地址：31~24          00         00          00          00

显存段
VideoDescriptor equ $-GDTStart
    dw 0x7fff ; 段界限
    dw 0x8000 ; 段基地址：15~0
    db 0x0b ; 段基地址：23~16
    db 0x93 ; 段属性
    db 0xc0 ; 段界限 19:16
    db 0 ; 段基地址：31~24

打印特定结尾字符串
    打印一个字符
        获取光标位置
        设定光标位置
        滚动屏幕

    开始
     |
     ↓
    取字符 --> <00?>----------------------------------------
     ↑          |                                          |
     |          ↓                                          |
     |       获取光标 --> <0D?> --> 回车处理 -----           |
     |                     ↓                    |          |
     |                   <0A?> --> 换行处理      |          |
     |                     ↓          ↓         ↓          |
     |                  普通字符 -> <ROLL?> --> 设置光标     |
     |                                ↓     ↑   |          |
     |                             滚屏处理--    |          |
     |                                          ↓          ↓
      ----------------------------------------<MAX?> -->  结束
       PrintString        
ESI
    保存需要打印的字符串地址，通过DataDescriptor:esi来访问
DL
    保存传入的结束标志字符
EDI
    保存要写入的显存内存地址，通过VideoSecscrptor:edi来访问
光标
    光标位置等于显存地址偏移除以2，也就是di/2，初始值为0

光标位置获取
    GetCursor:
        push ax
        push dx
        mov dx, 0x3d4    ; 选择寄存器端口
        mov al, 0x0e     ; 选择0x0e寄存器
        out dx ,al       ; 写入到0x3d4
        mov dx, 0x3d5    ; 数据读写端口
        in al, dx        ; 读取0x0e到al
        mov ah, al       ; 高8位暂存到ah
        mov dx, 0x3d4    ; 选择寄存器端口
        mov al, 0x0f     ; 选择0x0f寄存器
        out dx, al       ; 写入到0x3d4
        mov dx, 0x3d5    ; 数据读写端口
        in al, dx        ; 读取0x0f到al
        add ax, ax       ; 光标位置乘2
        mov di, ax       ; 传给di
        pop dx
        pop ax
        ret
光标位置设置
    SetCursor:
        push dx
        push bx
        push ax
        mov ax, di
        mov dx, 0
        mov bx, 2
        div bx
        mov bx, ax
        mov dx, 0x3d4
        mov al, 0x0e
        out dx, al
        mov dx, 0x3d5
        mov al, bh
        out dx, al
        mov dx, 0x3d4
        mov al, 0x0f
        out dx, al
        mov al, bl
        mov dx, 0x3d5
        pop ax
        pop bx
        pop dx
        ret

滚动屏幕处理
    ShouldScreenRoll:
        cmp di, 4000
        jb NoScreenRoll
        RollScreen:
            push, ax
            push, cx
            push, ds
            push, si
            cld
            mov ax, es
            mov ds, ax
            mov si, 0xa0
            mov di, 0x00
            mov dx, 1920
            rep movsw
            mov di, 3840
            call ClearOneLine
            pop si
            pop ds
            pop dx
            pop ax
        NoScreenRoll:
            ret
    ClearOneLine:
        push di
        mov cx, 80
        PrintBlackSpace:
            mov word [es:di], 0x0720
            add di, 2
            loop PrintBlackSpace
        pop di
        ret
        
    PrintByteAscii:
        push ax
        push dx
        push di
        push esi
        call GetCursor
        cmp al, 0x0d
        jz PrintCR
        cmp al, 0x0a
        jz PrintLF
        PrintNormal:
            mov [es:di], al
            add di, 2
            call ShouldScreenRoll
            call SetCursor
            inc esi
            jmp PrintByteAsciiEnd
        PrintCR:
            mov dl, 160
            mov ax, di
            div dl
            shr ax, 8
            sub di, ax
            call SetCursor
            inc esi
            jmp PrintByteAsciiEnd
        PrintLF:
            add di, 160
            call ShouldScreenRoll
            call SetCursor
            inc esi
            jmp PrintByteAsciiEnd
        PrintByteAsciiEnd:
            pop esi
            pop di
            pop dx
            pop ax