# VBOX虚拟机安装GHOSTXP  

我的系统:Fedora 15
<br>

<br>
VBOX运行是出错"/etc/init.d/vboxdrv setup"
<br>
解决方案,重新配置内核路径
<br>
KERN_DIR=/usr/src/kernels/2.6.40.3-0.fc15.i686.PAE /etc/init.d/vboxdrv setup
<br>

<br>

<br>
XP版本:深度 GHOST XP SP3 至尊纯净版 2011V5.0
<br>
XP安装版:DeepinXP-V5.6
<br>
注:运行时选择安装在C盘没法完成,
<br>
1.选择DeepinXP-V5.6.ISO安装,安装是分区格式化复制完系统文件,自动重启虚拟机时强制退出虚拟机
<br>
2.更换ISO为"GHOST XP SP3 至尊纯净版 2011V5.0",启动时选择进入winpe
<br>
3.在winpe中运行GHOST(开始->程序->)选择光盘中的GHOST文件恢复镜像到C盘
<br>
4.再次启动时选择硬盘启动,进入"深度XP"安装界面,在安装进度到达第三步时跳出的对话框选择取消
<br>
5.安装完成进入XP,如果虚拟机中像我一样只有一个C盘的话是无法打开我的文档的,因为基本上所有GHOST版本都是把我的文档移动到了D盘,只要右键点击我的文档,把C:\我的文档改成D:\我的文档确定即可
<br>
6.点击VBOX中的设备->安装增强工具,启用VBOX的无缝鼠标.
<br>
7.大功告成
<br>

