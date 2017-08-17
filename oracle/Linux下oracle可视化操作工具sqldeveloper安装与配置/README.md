# Linux下oracle可视化操作工具sqldeveloper安装与配置  

转自：http://www.cnblogs.com/zhou__zhou/archive/2009/09/23/sqldeveloper.html
<br>

<br>
Linux下的可视化界面的oracle 工具 
<br>
一、Oracle SQL Developer 2.1 选择for linux 版本下载
<br>
http://www.oracle.com/technology/software/products/sql/index.html
<br>
1、安装sqldeveloper，
<br>
rpm -Uhv sqldeveloper-2.1.1.64.39-1.noarch.rpm，
<br>
安装完成后软件在/opt/sqldeveloper, 虽然在程序菜单中有sql-developer的图标，但单击并不能启动，估计
<br>

<br>
是没有配置jdk的路径。所以，只能用命令行启动。
<br>
# cd /opt/sqldeveloper
<br>
# ./sqldeveloper.sh 出现
<br>
Oracle SQL Developer
<br>
  Copyright (c) 2008, Oracle. All rights reserved.
<br>

<br>
Type the full pathname of a J2SE installation (or Ctrl-c to quit), the path will be stored in
<br>

<br>
~/.sqldeveloper/jdk
<br>
会提示输入要jdk路径，/opt/oracle/jdk1.6.0_18
<br>

<br>
安装jdk参考下面
<br>

<br>
二、安装jdk
<br>
因为下载的sqldeveloper 不含JDK所以要单独下载,我下载的版本是 jre-6u18-linux-i586.bin for linux
<br>
下载页面 http://java.sun.com/javase/downloads/widget/jdk6.jsp
<br>
安装说明：http://java.sun.com/javase/6/webnotes/install/jdk/install-linux-self-extracting.html
<br>
1、将jre-6u18-linux-i586.bin放到本地,我放在/opt/oracle/目录下，我将所有和oracle相关的都放这下面了
<br>

<br>
。呵。以下操作切换至root权限下。
<br>
2、设置执行权限 chmod a+x jdk-6u<version>-linux-i586.bin 
<br>
3、运行自解压： ./jdk-6u<version>-linux-i586.bin ，提示授权说明，q跳过，然后输入yes后等待会即可完
<br>

<br>
成。最后安装完成在opt/oracle/ (即解压在当前路径)
<br>
4、打开/etc/profile，在profile文件末尾加入： 
<br>
#
<br>
# set java enviornment
<br>
#
<br>
JAVA_HOME=/opt/oracle/jdk1.6.0_18
<br>
JAVA_BIN=/opt/oracle/jdk1.6.0_18/bin
<br>
PATH=$PATH:$JAVA_HOME/bin
<br>
CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar 
<br>
export JAVA_HOME
<br>
export JAVA_BIN
<br>
export PATH
<br>
export CLASSPATH
<br>
5、验证java -version出现关于JDK版本信息即成功，最后可选操作，删除此bin文件，如果想节省空间的话。
<br>

<br>
三、最后使用，在程序中可以看到sqldeveloper图标，点击即可，在控制台输入sqldeveloper也可。但可能会
<br>

<br>
出现界面中文字体乱码。解决方案：
<br>
1.首先拷贝字体
<br>
拷贝从windows下的simsun.ttc，更名为simsun.ttf至相应目录下。
<br>
linux:cd /usr/X11R6/lib/X11/fonts/truetype 
<br>
# cp /home/simsun.ttc simsun.ttf
<br>

<br>
必须放在/usr/X11R6/lib/X11/fonts/truetype
<br>
否则添加的字体只能Root用，别的用户没法用。
<br>

<br>
2.安装字体，运行命令 SuSEconfig -module fonts 即可
<br>

<br>
因为JDK不支持中文的原因
<br>
[root@ ~]# cd $JAVA_HOME/jre/lib/fonts
<br>
[root@ fonts]# mkdir fallback
<br>
[root@ fonts]# cd fallback/
<br>
[root@ fallback]# ln -s /usr/share/fonts/default/simsun.ttf  (你想要的字体)
<br>
[root@ fallback]# mkfontdir
<br>
[root@ fallback]# mkfontscale
<br>

<br>
======================================================================
<br>
参考文章：
<br>
sqldeveloper 安装 http://www.nichael.cn/blog/show-5-1.html
<br>
jdk 安装 http://www.nichael.cn/blog/show-4-1.html
<br>
使用sqldeveloper界面乱码：http://www.blogjava.net/tokyo2006/archive/2009/07/08/285939.html
<br>

<br>
在linux下配置环境变量，
<br>
参考文章：http://www.linuxeden.com/html/sysadmin/20080424/56879.html
<br>
下面以配置java环境变量为例介绍三种配置环境变量的方法。
<br>
1.修改/etc/profile文件：如果你的计算机仅仅作为开发使用时推荐使用这种方法，因为所有用户的shell都有
<br>

<br>
权使用这些环境变量，可能会给系统带来安全性问题。
<br>
2. 修改.bashrc文件：这种方法更为安全，它可以把使用这些环境变量的权限控制到用户级别，如果你需要给
<br>

<br>
某个用户权限使用这些环境变量，你只需要修改其个人用户主目录下的.bashrc文件就可以了。
<br>
3. 直接在shell下设置变量:不赞成使用这种方法，因为换个shell，你的设置就无效了，因此这种方法仅仅是
<br>

<br>
临时使用，以后要使用的时候又要重新设置，比较麻烦。
<br>

