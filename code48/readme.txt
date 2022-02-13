C

动态库还有共享库


clang main.c ./add/add.c -o main
    需要指定所有的代码文件
    .h 文件会自动查找，不需要在变异时指定

    main.c  -> main.o   ->
    add.c   -> add.o    -> 合并 -> main
            -> printf.o ->
    以上 printf.o 引用的方式是将文件整合进最终的二进制文件中，为静态引用

    .o 文件     通用程度低，变异效率高
    .c 文件     通用程度高，变异效率低
    各有利弊

动态库
    windows .dll文件
    linux   .so文件

    通用程度低，编译效率高，可定制性低，性能低