# Vbox虚拟机开启Linux增强功能

转自 http://wdp107.iteye.com/blog/690591 
<br>
网络连接采用NET  主机不能访问虚拟机,虚拟机能访问外网和主机
<br>
桥接模式(Bridged)  虚拟机中设置网关为主机IP地址,这样就能主机访问虚拟机了.,网卡选择主机现在使用的网卡  http://os.51cto.com/art/200908/144564.htm
<br>

<br>

<br>
跟原文章不同,本人用的是Fedora16, 不要认为我开Virtualbox虚拟Linux是对它的不敬,没办法,Maximo主要在Win下开发,我原先在Linux下虚拟XP进行测试Maximo,因为效果不理想,再说我的本本是核心显卡+NVIDIA GT530M的SLI技术,根本没法装驱动,在此先鄙视一下NVIDIA不开发Linux下的驱动(连XP的都不开发),win7我用得也挺郁闷的,4G的内存,显存分配走了1.3G,只有2.6能用了,唉,真浪费资源啊.
<br>
回到正题,在Linux下得装两个桌面系统,而在win下的话在virtualbox虚拟的话只需要把Linux改成字符界面就可以了,可以在此装Oracle,web服务器,还能随时关闭服务,开户服务,只需几个命令就搞定了,很方便非常适合我.
<br>
Virtualbox增强工具需要dkms与gcc才能全部成功安装完成,如果某项安装失败,可能执行下面这句安装所有编译需要的包吧,
```Shell
yum -y install kernel gcc make kernel-headers kernel-devel  dkms 
```
安装完如果还有失败那么请重启下再安装,如果全部安装成功了,重启后重进就可以使用:双向剪切板"等增强功能了
<br>
注:Linux下在PAE开启的情况下无法安装,这个应该是VBox没法对PAE方式的寻址进行有效的读写吧,毕竟在虚拟机很少会去分配4G以上的内存给它的
<br>

