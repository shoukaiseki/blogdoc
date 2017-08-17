# Fedora 17升级后grub2菜单无Fedora选项  

看着大家都升级到17了,听了心里痒痒,升级一下吧

就用了几个命令,可以网速不给力,老升级错误,yum clean all了好多次
```Shell
yum update rpm yum -y update yum clean all
yum install preupgrade preupgrade -cli
```
安装包下载完之后重启吧,重启看他进行升级了,那么先去睡觉吧.第二天醒来,誒,挺好,F17了.都说启动速度超快,咋也得重启看下,不料,
<br>
halt --reboot之后,grub2尽然没有Fedora菜单,只剩下个Win XP的.唉,只能手动了
<br>
在这个win7菜单下按e进入编辑模式
```Shell
  insmod ext4
  set root='hd0,msdos3'
  linux /boot/vmlinuz-3.3.7-1.fc17.i686.PAE root=UUID=/dev/sda3 1
  initrd /boot/initramfs-3.3.7-1.fc17.i686.PAE.img
```

进入单用户模式后
```Shell
grub2-mkconfig -o /boot/grub2/grub.cfg
shutdown -r now
```

重启之后菜单如下
```
Fedora Linux
Advanced options for Fedora Linux
Windows XP 
```

然后Fedora Linux采用的是debug模式

而Advanced options for Fedora Linux又是一个submenu菜单,子菜单如下
```
Fedora Linux，Linux 3.3.7-1.fc17.i686.debug
Fedora Linux，Linux 3.3.7-1.fc17.i686.debug (恢复模式)
Fedora Linux，Linux 3.3.7-1.fc17.i686.PAEdebug
Fedora Linux，Linux 3.3.7-1.fc17.i686.PAEdebug (恢复模式)
Fedora Linux，Linux 3.3.7-1.fc17.i686.PAE
Fedora Linux，Linux 3.3.7-1.fc17.i686.PAE (恢复模式)
Fedora Linux，Linux 3.3.7-1.fc17.i686
Fedora Linux，Linux 3.3.7-1.fc17.i686 (恢复模式)
```

又该更改默认启动项了
```Shell
grub2-set-default Fedora Linux，Linux 3.3.7-1.fc17.i686.PAE 
```
重启后没效果,因为主菜单没有Fedora Linux，Linux 3.3.7-1.fc17.i686.PAE菜单.

后来百度了以下,菜单
```Shell
grub2-set-default "1>Fedora Linux，Linux 3.3.7-1.fc17.i686.PAE"
```

这里的1>代表第二个主菜单,就是刚开机时显示在grub的第二项,从0开始.
