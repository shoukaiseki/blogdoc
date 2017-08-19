# win引导grub2  

```Grub
timeout 5
# 设置动画图形菜单文件
gfxmenu (hd0,0)/boot/grub/grub_chs.msg
# 设置中文支持的字体文件
fontfile /boot/grub/fonts
# 设置图形背景文件
splashimage=/boot/grub/bj2008.xpm.gz
# splashimage=/boot/grub/WinXP.Pro.2.xpm.gz
color=green/black light-gray/blue
default=Fedora (2.6.38.7-30.fc15.i686.PAE)
#hiddenmenu可不用
#hiddenmenu
title Fedora (2.6.41.4-1.fc15.i686)
        root (hd0,4)
        kernel /vmlinuz-2.6.41.4-1.fc15.i686 ro root=UUID=0baa92e6-c726-4bed-9c48-470a4dc8271f rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=zh_CN.UTF-8 KEYTABLE=us rhgb quiet
        initrd /initramfs-2.6.41.4-1.fc15.i686.img
title 【 01 】Fedora (2.6.40.4-5.fc15.i686.PAE)
 root (hd0,4)
 kernel /vmlinuz-2.6.40.4-5.fc15.i686.PAE ro root=UUID=0baa92e6-c726-4bed-9c48-470a4dc8271f rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=zh_CN.UTF-8 KEYTABLE=us rhgb quiet
 initrd /initramfs-2.6.40.4-5.fc15.i686.PAE.img
title 【 02 】Fedora (2.6.38.6-26.rc1.fc15.i686.PAE)
 root (hd0,4)
 kernel /vmlinuz-2.6.38.6-26.rc1.fc15.i686.PAE ro root=UUID=0baa92e6-c726-4bed-9c48-470a4dc8271f rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=zh_CN.UTF-8 KEYTABLE=us rhgb quiet
 initrd /initramfs-2.6.38.6-26.rc1.fc15.i686.PAE.img


title 【 03 】启动第二硬盘的windowsXP
#下面两句map是交换主从盘的位置
       map (hd0) (hd1)
       map (hd1) (hd0)
 rootnoverify (hd1,0)
 chainloader +1
       makeactive
# 使用 TFTP 协议从网络启动一个软盘镜像
# 手工设置
#    address = ip 地址
#    mask = 子网掩码
#    gateway = 网关
#  
#  tftpserver  tftp 服务器地址
#  你可以修改 win99.img 为你的软盘镜像，注意：
#  可以使用 winzip 压缩，原始大小必须是 1.44/2.88MB
title 【 04 】从网络软盘镜像文件启动
ifconfig --address=192.168.200.1
ifconfig --mask=255.255.255.192
ifconfig --gateway=192.168.200.5
tftpserver 192.168.200.5
kernel (nd)/memdisk.gz
initrd (nd)/win99.zip

# 启动另一个功能强大的引导器。注意：
#   在它里面界面里，不要做任何保存！！！！！
title 【 05 】运行 Smart BootManager
root    (hd0,0)
kernel (hd0,0)/boot/grub/memdisk.gz
initrd (hd0,0)/boot/grub/sbm.bin


# 本地软盘镜像的使用方法之一。还可使用 4DOS 的功能
#   即 map (xxx)/win98.img (fd0) 的方法。本版本支持。
title 【 06 】启动本地 Win98 软盘镜像文件
root    (hd0,0)
kernel (hd0,0)/boot/grub/memdisk.gz
initrd (hd0,0)/boot/grub/win99.zip

# 转到光盘启动
title 【 07 】从光盘启动系统
scdrom --bootcd

# 从本地磁盘的主分区启动
title 【 07 】从硬盘第一分区启动
rootnoverify (hd0,0)
makeactive
chainloader  +1

#     title "install fedora 16"
#     kernel (hd0,0)/vmlinuz linux repo=hd:/dev/sda12:/
#     initrd (hd0,0)/initrd.img
#     boot

title grub2 2
root (hd0,2)
kernel /boot/grub2/core.img
boot
title Fedora 
```
