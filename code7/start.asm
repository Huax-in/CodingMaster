mov ax, 0b800h
mov ds, ax

mov byte [0x00], '2'
mov byte [0x02], '0'
mov byte [0x04], '2'
mov byte [0x06], '1'
mov byte [0x08], ','
mov byte [0x0a], 'H'
mov byte [0x0c], 'u'
mov byte [0x0e], 'a'
mov byte [0x10], 'x'
mov byte [0x12], '!'

jmp $

times 510-($-$$) db 0
db 0x55,0xaa