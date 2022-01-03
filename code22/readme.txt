代码文件：start.asm
编译命令：nasm -f bin 32bits.asm -o 32bits.bin -l 32bits.lst
    -f: 编译后生成文件的格式
    -o: 编译后生成文件的文件名称
    -l: 输出包括汇编地址，代码及机器码的文件
编译后文件：32bits.bin

平坦模式
    32位操作系统衍生出的全新的内存管理模式

ToyOS
    BootLoader
        位于磁盘启动扇区，可读取FAT32文件系统，
        寻找并加载Initial.bin，16b汇编开发
    Initial.bin
        位于FAT32根目录，初始化各类硬件，
        寻找并加载Kernel.elf，16/32/64b汇编开发
        
        .elf文件
            Unix下的可执行文件格式
            将作为操作系统的通用格式。
    Kernel.elf
        位于FAT32根目录，操作系统核心
        功能包括内存管理、多任务、线程管理等。C语言开发。
    Shell
        一个简单的shell，也是elf格式，作为交互的窗口。
        Shell将会作为第一个用户程序，被Kernel加载运行。
        C语言开发。
    其他的应用程序
        比如文本编辑、系统信息、文件系统等。
    Shell以及这些应用程序都会放在Binary目录下，是可执行的二进制程序。

ToyOS加载流程
    1、BootLoader被BIOS程序加载到0x7c00位置并运行。
    BootLoader读取fat32文件系统并寻找Initial.bin文件
    2、如果找不到进行提示，找到则加载至0x8000位置并运行。
    Initial.bin开始读取fat32文件系统并寻找Kernel文件。
    3、如果找不到进行提示，找到则加载至内存空闲位置并运行。
    Kernel读取fat32文件系统并寻找Shell文件。
    4、如果找不到进行提示，找到则加载至内存空闲位置并运行。
    Shell开始运行并等待用户输入。

开发环境
    代码编辑器 vs code
    代码管理 git
    汇编调试工具 Bochs
    汇编编译工具 nasm
    Linux环境 WSL (ubuntu)
    C语言编译器 Clang/LLVM

一次性工作
    使用VirtualBox软件创建VHD文件，偶尔用来查看运行结果。
        1、打开VirtualBox软件，选中虚拟机，在它关闭的情况下，点击设置按钮，打开一个新的设置页。
        2、在设置页左侧边栏，点击存储，然后选中 控制器：IDE
        3、点击 控制器：IDE 右侧的图标，选择添加虚拟硬盘。弹出虚拟硬盘管理器页面，点击创建按钮加个新硬盘。
        4、在弹出的创建虚拟硬盘向导页面，选择VHD，并点击下一步。然后选择固定大小，一定不要选择动态分配，继续下一步。
        5、设置VHD文件的名称、位置和大小，并点击创建。
        6、双击创建好的Example.vhd，或者选中后点击选择按钮。这时会回到设置页面，可以看到控制器：IDE下有了2个硬盘。
        7、设置启动硬盘。先把之前硬盘设置为第二IDE控制器主通道，把第一IDE控制器的主通道让出来，然后把新建的硬盘设置为第一IDE控制器的主通道。
        8、点击ok按钮。
    使用Windows来把VHD文件格式话为fat32，并作为一个分区管理。
        9、右键我的电脑 --> 管理 --> 磁盘管理
        10、点击左上角操作 --> 附加VHD，选择刚刚创建的VHD文件，确定。
        11、右键磁盘 --> 新建简单卷 --> 下一步 --> 下一步 --> 下一步，文件系统选择FAT32 --> 下一步 --> 完成
    使用FixVHDw软件来写入BootLoader程序，后续基本不动了。

代码文件结构
    BootLoader.asm => BootLoader.bin
    Initial.asm => Initial.bin
    Kernel.c etc. => Kernel.elf
    Shell.c etc. => Shell.elf
