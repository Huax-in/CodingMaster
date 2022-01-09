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