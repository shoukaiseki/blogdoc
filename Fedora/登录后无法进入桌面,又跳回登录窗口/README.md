# 登录后无法进入桌面,又跳回登录窗口 

因在gvim中自动开启输入发,以为是ibus配置有问题,删除了/etc/X11/xinit/xinput.d后没效果,就一狠心,把该目录下的所有文件及文件夹全部删除,重启之后就无法登入到桌面,密码是验证过去了,准备启动gnome了但是又跳回到登入窗口.整了4小时,终于在安装xinit之后可以用了,熟悉的Fedora 15出现了.

下载地址: http://u.115.com/file/bhu0ivmx

xorg-x11-xinit-1.0.9-20.fc15.i686.rpm


用XP系统下载之后放到c盘的rpm目录
```Shell
mkdir /mnt/c
mount -t vfat -o iocharset=utf8 /dev/sda1 /mnt/c
cd /mnt/c
cd rpm
rpm --nodeps -i xorg-x11-xinit-1.0.9-20.fc15.i686.rpm
```
安装好之后无提示

其中的--nodeps是强制性覆盖安装


注:在无法登录的时候有时创建新用户也无法使用
```Shell
useradd  java //创建一个名为java的账户
passwd   java //给账户java设置密码
userdel -r java  //删除账户,加上-r表示连同账户目录一起删除
who 查看当前登录用户信息
cat /etc/passwd 查看所有系统用户信息
```
