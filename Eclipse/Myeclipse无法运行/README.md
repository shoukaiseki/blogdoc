# Myeclipse无法运行

错误提示the myeclipse executable launcher was unable to locate its companion shared library
<br>
原先Myeclipse安装路径D:\usr_win7\Genuitec\MyEclipse 8.5
<br>
Myeclipse最主要的插件包安装路径D:\usr_win7\Genuitec\Common
<br>
在刚开始安装的时候提示路径有两个,一直没注意,知道出现问题才来关注一下
<br>
而eclipse则需要jdk的支持,你懂得
<br>
#这个是我的
```
-startup
../Common/plugins/org.eclipse.equinox.launcher_1.0.201.R35x_v20090715.jar
--launcher.library
../Common/plugins/org.eclipse.equinox.launcher.win32.win32.x86_1.0.200.v20090519
-install
D:/usr_win7/Genuitec/MyEclipse 8.5
-vm
D:/usr_win7/Genuitec/Common/binary/com.sun.java.jdk.win32.x86_1.6.0.013/jre/bin/client/jvm.dll
-configuration
configuration
-vmargs
-Xmx512m
-XX:MaxPermSize=256m
-XX:ReservedCodeCacheSize=64m
```
