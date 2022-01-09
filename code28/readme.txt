代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin -l start.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：start.bin

从实模式切换到保护模式
切换到保护模式分四步
    1.定义GDT
        GDT（全局描述符）：
            保存段描述符、LDT、各种门的入口等等
            包括：
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

段属性
名称    G   D/B L   AVL Limit   P   DPL S   TYPE    汇总
数据段  1   1   0   0   1111    1   00  1   0011    0xCF93
代码段  1   1   0   0   1111    1   00  1   1011    0xCF9B

    名称                    空描述符/0x     数据段/0x   代码段/0x
DW/16位，段界限：15~0           0000        FFFF        FFFF
DW/16位，段基地址：15~0         0000        0000        0000
DB/8位，段基地址：23~16         00          00          00
DB/8位，段属性                  00          93          9B
DB/8位，段界限：19~16/段属性     00         CF          CF
DB/8位，段基地址：31~24          00         00          00

section Initial vstart=0x9000
;GDTR:
;    dw 0 ; GDT大小
;    dd 0 ; GDT起始地址
;LoadGDT:
;    mov word [GDTR], GDTEnd-GDTStart
;    mov dword [GDTR+2], GDTStart
;    LGDT [GDTR]
; 改造版本
LoadGDT: ; 告知CPU
    mov word [GDTStart], GDTEnd-GDTStart
    mov dword [GDTStart+2], GDTStart
    LGDT [GDTStart]
; 改造版本 end

EnableProtectBit: ;修改cr0的PE位
    mov eax, cr0
    or eax, 0x00000001
    mov cr0, eax
    jmp CodeDescriptor: dword ProtectModeLand

BITS 32 ; 告知编译器后面生成32位代码
ProtectModeLand: ;32位代码落地
; 此处开始就是32位代码了
GDTStart:
NullDescriptor equ $-GDTStart
    dw 0 ; 段界限
    dw 0 ; 段基地址：15~0
    db 0 ; 段基地址：23~16
    db 0 ; 段属性
    db 0 ; 段界限 19:16
    db 0 ; 段基地址 32:24

DataDescriptor equ $-GDTStart
    dw 0xfff ; 段界限
    dw 0 ; 段基地址:15~0
    db 0 ; 段基地址:23~16
    db 0x93 ; 段属性
    db 0xCF ; 段界限 19:16
    db 0 ; 段基地址 32:24

CodeDescriptor equ $-GDTStart
    dw 0xfff ; 段界限
    dw 0 ; 段基地址:15~0
    db 0 ; 段基地址:23~16
    db 0x9B ; 段属性
    db 0xCF ; 段界限 19:16
    db 0 ; 段基地址 32:24
GDTEnd: