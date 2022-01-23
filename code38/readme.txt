C
编译 
    clang code.c -o code
加减乘除

Byte Unsigned Integer                           8位
Word Unsigned Integer                           16位
Doubleword Unsigned Integer     unsigned int    32位
Quadword Unsigned Integer                       64位
Byte Signed Integer                             8位（首位是符号位）
Word Signed Integer                             16位（首位是符号位）
Doubleword Signed Integer       int             32位（首位是符号位）
Quadword Signed Integer                         64位（首位是符号位）

short int  <=  int  <= long int <= long long int
16位         16/32位    32/64位         64位

生成汇编代码
    clang -S code.c -o code.S -masm=intel
    -masm=intel: 生成intel风格的汇编