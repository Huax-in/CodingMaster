代码文件：start.asm
编译命令：nasm -f bin start.asm -o start.bin
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
编译后文件：start.bin

编译后文件放到VirtualBox虚拟机执行


彩色文字属性字节
7   6   5   4   3   2   1   0
K   R   G   B   I   R   G   B
闪              高
烁  红  绿  蓝   亮  红  绿  蓝
    背景色       |     前景色

11001110
0xBD

00000100
0x04