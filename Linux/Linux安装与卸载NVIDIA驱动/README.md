# Linux安装与卸载NVIDIA驱动  

我的显卡是GeForce GT 540M 下载的文件名是NVIDIA-Linux-x86-290.10.run

```Shell
yum -y install kernel gcc make kernel-headers kernel-devel 
gcc             从软件仓库下载gcc,然后安装，这个是编译器
make            安装make，这个是自动编译源码的工具，写好makefile就可以方便编译
kernel-headers  安装内核头文件，编译内核，驱动必要的头文件
kernel-devel    只包含用于内核开发环境所需的内核头文件以及Makefile
```

装备工作做好了,然后可以进行安装
```Shell
init 3  进入字符界面
cd /tmp
sh NVIDIA-Linux-x86-290.10.run
```
按照提示安装,正确后会出现下图

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/Linux/Linux%E5%AE%89%E8%A3%85%E4%B8%8E%E5%8D%B8%E8%BD%BDNVIDIA%E9%A9%B1%E5%8A%A8/img/001.jpg)
 


卸载方法
```Shell
cd /tmp
sh NVIDIA-Linux-x86-290.10.run -uninstall
```

其它包说明
```Shell
kernel-souce    包含所有内核源代码
```


