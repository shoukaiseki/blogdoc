# 在第一个硬盘用Grub引导第二个硬盘的Fedora 15系统  

在第一个硬盘用Grub引导第二个硬盘的Fedora 15系统

首先下载grub4dos-0.4.4.zip(提取码dn9bbbti) http://u.115.com/file/dn9bbbti

1、在c盘根目录下边的boot.ini文件中添加，c:\grldr="Fedore Red Hat 15"这一行。（注意要去除本文

 

件的只读属性才能保存）。

2、解压grub4dos中的grldr和menu.lst文件到c盘根目录。

在Windows XP的BOOT.ini中添加

登录Fedora 15系统 把 /boot/grub/menu.lst 的内容提取出来

打开终端，使用命令 

su  root 输入密码

vi  /boot/grub/menu.lst

下面为/boot/grub/menu.lst的内容保存到在第一个硬盘C盘下的MENU.LST即可

```Cfg
splashimage=(hd0,5)/boot/grub/splash.xpm.gz

hiddenmenu

title Fedora (2.6.38.8-32.fc15.i686.PAE)
        root (hd0,5)
        kernel /boot/vmlinuz-2.6.38.8-32.fc15.i686.PAE ro root=UUID=3c179835-52a2-4d6a-b525-6c06771bdbaa rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=zh_CN.UTF-8 KEYTABLE=us rhgb quiet
        initrd /boot/initramfs-2.6.38.8-32.fc15.i686.PAE.img
title Fedora (2.6.38.6-26.rc1.fc15.i686.PAE)
        root (hd0,5)
        kernel /boot/vmlinuz-2.6.38.6-26.rc1.fc15.i686.PAE ro root=UUID=3c179835-52a2-4d6a-b525-6c06771bdbaa rd_NO_LUKS rd_NO_LVM rd_NO_MD rd_NO_DM LANG=zh_CN.UTF-8 KEYTABLE=us rhgb quiet
        initrd /boot/initramfs-2.6.38.6-26.rc1.fc15.i686.PAE.img

```

 

下面为修改好的整套grub+boot.ini菜单,可供大家参考,高手就不必消遣了

中正修改解压到C盘即可(提取码dne5fdqf)grub_Menu.7z,http://u.115.com/file/dne5fdqf
