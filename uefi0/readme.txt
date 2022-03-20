UEFI

EDK2

kernel
    Loader
        FIRMWARE (UEFI)
            C Library
            system api

UEFI固件会把存在FAT32格式分区的磁盘都当作启动磁盘

loader目录（EFI标准）
    EFI
        Boot
            BootX64.efi(64位)/Boot.efi(32位)