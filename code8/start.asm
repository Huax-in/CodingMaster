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
mov byte [0x14], 'y'
mov byte [0x16], 'o'
mov byte [0x18], 'u'
mov byte [0x1a], ' '
mov byte [0x1c], 'a'
mov byte [0x1e], 'r'
mov byte [0x20], 'e'
mov byte [0x22], ' '
mov byte [0x24], 't'
mov byte [0x26], 'h'
mov byte [0x28], 'e'
mov byte [0x2a], ' '
mov byte [0x2c], 'm'
mov byte [0x2e], 'o'
mov byte [0x30], 's'
mov byte [0x32], 't'
mov byte [0x34], '!'
mov byte [0x36], '!'
mov byte [0x38], '!'

jmp $

times 510-($-$$) db 0
db 0x55,0xaa