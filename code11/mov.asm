; mov 指令运用

; 通用寄存器 ax bx等
; 8位寄存器 ah al bh bl等
; 内存单元
; 段寄存器 cs ds等
; 立即数 0xb800等

; 标记说明
; xx: mov指令在此场景不可用
; √√：mov指令在此场景可用

; 1 立即数 <-- 立即数 ××
; error: invalid combination of opcode and operands
mov 0xb00, 0xb800
; 1 end

; 2 内存单元 <-- 立即数 √√
; error: operation size not specified
; 报错原因：未指定操作大小
; [0x01]：操作的起始内存单元
mov [0x01], 0xb800

; warning: byte data exceeds bounds [-w+number-overflow]
; 报警原因：字节数据超出范围
; byte：指定操作大小为8位
; 0xb800：16位  1011 1000 0000 0000
mov byte [0x01], 0xb800

; word：指定操作大小为16位
mov word [0x01], 0xb800
; 2 end

; 3 通用寄存器 <-- 立即数 √√
mov ax, 0xb800

; warning: byte data exceeds bounds [-w+number-overflow]
; bh：8位寄存器
; 0xb800：16位  1011 1000 0000 0000
mov bh, 0xb800

mov bh, 0xb8
; 3 end

; 4 段寄存器 <-- 立即数 ××
; error: invalid combination of opcode and operands
mov cs, 0xb800
; 4 end

; 5 立即数 <-- 内存单元 ××
; error: invalid combination of opcode and operands
mov 0xb800, [0x01]
; 5 end

; 6 内存单元 <-- 内存单元 ××
; error: invalid combination of opcode and operands
mov [0x02], [0x01]
; 6 end

; 7 通用寄存器 <-- 内存单元 √√
mov ax, [0x01]

mov bh, [0x01]
; 7 end

; 8 段寄存器 <-- 内存单元 √√
mov cs, [0x01]
; 8 end

; 9 立即数 <-- 通用寄存器 ××
; error: invalid combination of opcode and operands
mov 0xb800, ax
; 9 end

; 10 内存单元 <-- 通用寄存器 √√
mov [0x01], ax
; 10 end

; 11 通用寄存器 <-- 通用寄存器 √√
mov bx, ax

; error: invalid combination of opcode and operands
mov bh, ax

mov bh, ah
; 11 end

; 12 段寄存器 <-- 通用寄存器 √√
mov cs, ax

; error: invalid combination of opcode and operands
mov cs, bh
; 12 end

; 13 立即数 <-- 段寄存器 ××
; error: invalid combination of opcode and operands
mov 0xb800, cs
; 13 end

; 14 内存单元 <-- 段寄存器 √√
mov [0x01], cs
; 14 end

; 15 通用寄存器 <-- 段寄存器 √√
mov ax, cs

; error: invalid combination of opcode and operands
mov bh, cs
; 15 end

; 16 段寄存器 <-- 段寄存器 ××
; error: invalid combination of opcode and operands
mov ds, cs
; 16 end