
EDK II
    EFI Development Kit II
    UEFI标准的实现
    EFI: Extensible Firmware Interface
    UEFI: Unified Extensible Firmware Interface
    
    各阶段:
    Security(SEC)
    Pre EFI Intrinsic(PEI)
    Driver Execution Environment(DXE)
    Boot Dev Select(BDS)
    Transient System Load(TSL)
    Run Time(RT)
    After Life(AL)

FLUSH(主板固件)
    -初始化工作
    -找到启动设备
    -检查是否合规
    -寻找OS LOADER
    -加载到内存
    -跳转过去执行

OS LOADER(硬盘上)
    -初始化工作
    -寻找系统镜像
    -加载到内存
    -跳转过去执行

OS
    -OS启动进入运行时