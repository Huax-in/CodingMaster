NUL equ 0x00
SETCHAR equ 0x07
VIDEOMEM equ 0xb800
STRINGLEN equ 0xffff

section code align=16 vstart=0x7c00
    mov si, SayHello
    xor di, di
    call PrintString
    mov si, SayByeBye
    call PrintString
    jmp End

PrintString:
    .setup:
    mov ax, VIDEOMEM
    mov es, ax

    ; 字体颜色黑底白字
    mov bh, SETCHAR
    ; 循环次数
    mov cx, STRINGLEN

    .printchar:
    ; [ds:si]取物理内存地址
    mov bl, [ds:si]
    inc si
    mov [es:di], bl
    inc di
    mov [es:di], bh
    inc di
    or bl, NUL
    jz .return
    loop .printchar
    .return:
    ret

SayHello db 'Hi there,I am Huax!'
            ;0x0d回车键 0x0a换行键
        db 0x0d, 0x0a, 0x00
SayByeBye db 'Thank you can handle it,bay!'
          db 0x00

End: jmp End
times 510-($-$$) db 0
                 db 0x55, 0xaa