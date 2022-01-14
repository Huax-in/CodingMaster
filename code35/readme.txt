
进入64位模式
    MOV     EAX, ADDR_OF(TOPLEVELPAGEDIRECTORY)
    MOV     CR3, EAX

    MOV     EAX, CR4
    ;BTS指令 Bit Test and Set
    ;先测试EAX的第5位是否为1，如果不为1则将这一位的值Set为1
    BTS     EAX, 5      ; ENABLE PAE
    MOV     CR4, EAX

    MOV     ECX, 0XC0000080
    RDMSR
    BTS     EAX, 8      ; SET LME
    WRMSR

    MOV     EAX, CR0
    BTS     EAX, 31     ; SET PG
    MOV     CR0, EAX    ; ENABLE PAGING

    JMP     LINEAR_CODE64_SEL:ADDR_OF(JUMPTO64BITANDLANDHERE)

#1 计算机基础理论
    - 计算机硬件
    - 组成原理
    - 汇编语言
    参考书目
        《x86汇编语言：从实模式到保护模式》
        《AMD64 Architecture Programmer's Manual》
        《IntelR 64 and IA-32 Architectures Software Developer's Manual》

#2 高级语言及框架
    - C语言
    - EDK2
    参考书目
        《The C Programming Language》
        《The Standard C Library》

#3 操作系统TOYOS
    - 图形界面
    - 开发工具
    - 浏览网页
    参考书目
        《Xv6.a simple, Unix-like teaching operating system》

UEFI
    Unified Extensible Firmware Interface
    统一    可拓展      固件        接口
    
    文档
        UEFI Specification  --规定了计算机固件应该提供的标准功能，都是C语言风格的接口
        PI Specification    --规定了计算机平台分阶段初始化的标准流程以及各种细节说明
        ACPI Specification  --高级配置与电源接口特性，包括电源管理、硬件特性等内容
        PCIE
        USB4 TM DP Tunneling Compliance Test Specification --USB4
    
    EFI Development Kit II
        Intel 开源代码