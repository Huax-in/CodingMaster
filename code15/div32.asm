; @author: huax

; 高位被除数
mov dx, 0x0009
; 低位被除数
mov ax, 0x0006
; 除数
mov cx, 0x0002
; 保存低位
push ax
; 高位转低位
mov ax, dx
; 清空高位
mov dx, 0x0000
; 计算高位除法 商:ax 余数:dx
div cx
; 保存高位商到bx
mov bx, ax
; dx中余数作为高位
; 取出之前保存的低位被除数到ax
pop ax
; 计算低位除法 商:ax 余数:dx
div cx
; 最终结果 商 bx:ax=0x00048003 余数:dx=0x0000

; 循环及补0
w: jmp w

times 510-($-$$) db 0
db 0x55,0xaa