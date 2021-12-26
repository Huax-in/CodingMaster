; @author: huax

; 8位乘法
mov al, 0xf0
mov ah, 0x02
mul ah
; 结果 ah:al=0x01e0

; 16位乘法
mov ax, 0xf000
mov bx, 0x0002
mul bx
; 结果 dx:ax=0x0001e000

; 16位除法
mov ax, 0x0004
mov bl, 0x02
div bl
; 结果  商:al=0x02  余数:ah=0x00

; 32位除法
mov dx, 0x0008
mov ax, 0x0006
mov cx, 0x0002
div cx
; 结果  商:ax=0x0006  余数:dx=

; 循环及补0
w: jmp w

times 510-($-$$) db 0
db 0x55,0xaa