# WinXP下硬盘安装CentOS6.0  

WinXP下硬盘安装CentOS6.0

CentOS6.0下载地址

http://mirror.neu.edu.cn/centos/6.0/isos/i386/CentOS-6.0-i386-bin-DVD.iso

grub4dos-0.4.4.zip下载地址

http://115.com/file/dn9bbbti#

 

1．  利用Grub引导进入安装界面

a)           

右键点击我的电脑à属性à高级à启动和故障恢复中的”设置”à编辑

再最后一行添加以下语句

C:\grldr="Install CentOS6.0"的

 

b)           

解压grub4dos-0.4.4.zip中的grldr, grldr.mbr, grub.exe, MENU.LST到C盘根目录

创建一个MENU.LST, 然后用记事本,复制以下后保存

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

title install  CentOS6.0

     title "CentOS-6.0-i386-LiveCD"

     kernel (hd0,0)/isolinux/vmlinuz

     initrd (hd0,0)/isolinux/initrd.img

 

以下为我压缩好的MENU.LST,和grub4dos,直接解压到C盘即可

CentOSInstall解压到C盘即可grub_Menu.7z 下载地址

http://115.com/file/cl1wutd1#

 

2．  解压CentOS-6.0-i386-bin-DVD.iso中的isolinux文件夹到C盘根目录

注：做完这一步就能够启动安装界面了,不过在安装的时候会提示选取ISO的路径

而ISO超过4G,没法存放到FAT32文件系统(即FAT32格式的分区)中, NTFS文件系统虽然可以存放超过4G的文件,但是Linux的安装器确不支持访问NTFS文件系统,所以只能采用Linux的Ext2文件系统(Ext3也可以).

3．  建立并格式化ext2格式分区

下载PQ分区魔术师v10.0_绿色单文件版.zip

http://115.com/file/bhkbh0h0#

打开分区魔术师,选择一个没用的分区,注意：转移该分区的所以数据到其它分区,原因不解释,后果你懂的

选择格式化成Linux ext2(或Linux ext3)

下载 Ext2Fsd-0.51.zip

http://115.com/file/e6a06vcz#

打开Ext2 Volume Manager

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/CentOS/WinXP%E4%B8%8B%E7%A1%AC%E7%9B%98%E5%AE%89%E8%A3%85CentOS6.0/img/001.jpg)
 
右键点击刚刚格式化的分区-à配置文件系统

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/CentOS/WinXP%E4%B8%8B%E7%A1%AC%E7%9B%98%E5%AE%89%E8%A3%85CentOS6.0/img/002.png)
 
右键点击刚刚格式化的分区-à配置ext2卷属性

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/CentOS/WinXP%E4%B8%8B%E7%A1%AC%E7%9B%98%E5%AE%89%E8%A3%85CentOS6.0/img/003.png)
 
右键点击刚刚格式化的分区-à更改分区类型

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/CentOS/WinXP%E4%B8%8B%E7%A1%AC%E7%9B%98%E5%AE%89%E8%A3%85CentOS6.0/img/004.png)
 
大功告成,打开K盘,复制CentOS-6.0-i386-bin-DVD.iso到K盘根目录,注意不要改文件名

解压CentOS-6.0-i386-bin-DVD.iso中的images文件夹到K盘根目录

4．  重启计算机，在启动菜单中选择Install CentOS6.0

再选择  【 07 】安装CentOS6.0   或者   Install CentOS6.0

几分钟后进入安装界面，第一个选择语言 Chinese(Simplified) 即简体中文

然后选择 键盘布局，选择默认的us即可，接下来选择ISO的位置

选择Hard drive后出现/dev/sda1      /dev/sda2          /dev/sda5          /dev/sda6之类的,

/dev/sda1 一般指winxp下的C盘

/dev/sda2 一般指winxp下的d盘

/dev/sda5 一般指winxp下的e盘

/dev/sda6 一般指winxp下的f盘

         不懂得直接一个一个回车看下,没有出现提示的就证明选对了选对了之后,几分钟之后就会出现安装界面
