# 成功编译Linux3.2-rc6内核  

先说明以下我的系统为Fedora 16 Verne,编译内核所许的包请查看我的Linux分类下的Linux安装与卸载NVIDIA驱动
<br>
[fedora@fedora ~]$ uname -a
<br>
Linux fedora 3.2.0-rc6 #1 SMP Sat Dec 24 00:40:17 CST 2011 i686 i686 i386 GNU/Linux
<br>
[fedora@fedora ~]$ 
<br>
说来惭愧，主要是前天装Linux显卡驱动造成无法进Gnome桌面，卸载掉驱动也没用，按照网上说的使用
<br>
[root@fedora ~]#X -configure生成一个新的xorg.conf.new,然后
<br>
[root@fedora ~]#cp /root/xorg.conf.new /etc/X11/xorg.conf还是没用
<br>
我就打算升级内核看下,打算再不行就卸载Gnome再重装下Gnome试一下的.先来说说我编译内核用的几个命令吧
<br>
cd /tmp
<br>
[root@fedora tmp]#wget http://www.kernel.org/pub/linux/kernel/v3.0/testing/linux-3.2-rc6.tar.bz2
<br>
下载好了源码包开始解压吧,不过解压前注意用uname查看下内核版本,和/usr/src/kernels目录下有没同版本目录
<br>
[root@fedora tmp]#tar -jxvf linux-3.2-rc6.tar.bz2 -C /usr/src/kernels
<br>
cd /usr/src/kernels/linux-3.2-rc6
<br>
在开始配置内核之前，首先需要通过下面的命令清除所有的临时文件、中间件和配置文件。对于一个刚从网上下载的内核来说，它肯定是干净的，这么做只会多此一举。但是这是一个良好习惯，而且不会有坏结果。(这个当时我没执行)
<br>
[root@fedora linux-3.2-rc6]#make mrproper
<br>
然后执行make menuconfig来配置内核,具体配置请查看http://www.linuxsir.org/bbs/thread290748.html或
<br>
http://linux.chinaitlab.com/kernel/531925_4.html
<br>
反正配置好后选择刚进入的配置界面的save保存下即可,我当时情急,没有细选,你有时间可以慢慢选
<br>
[root@fedora linux-3.2-rc6]#make menuconfig
<br>
配置完成了就开始make吧,其中的-j[N]参数是"同时允许 N 个任务",有的说这个N取值,如果你想压榨最大性能的话采用核心数+1,有得说可以取为核心数*2,我当时是拿手机看的,因为图形界面进不了了,就没仔细分析了,反正我4核编译的时候才用的是j8
<br>
[root@fedora linux-3.2-rc6]#make -j8
<br>
编译基本查不多完成了,反正我是凌晨1点开始在编译后我就去睡觉了,第二天11:30过来的时候已经编译好了
<br>
然后安装模块：
<br>
[root@fedora linux-3.2-rc6]#make modules_install -j8 
<br>
安装内核:
<br>
[root@fedora linux-3.2-rc6]#make install
<br>
这样就完成了,OK了
<br>
好像有的文章说还要编译编译内核： make bzImage 编译模块：make modules,我反正都没用到,还有啥配置grub之类的,我看grub2菜单中已经有了就直接重启机子选择新内核了
<br>

