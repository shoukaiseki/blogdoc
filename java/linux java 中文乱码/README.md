# linux java 中文乱码

http://pan.baidu.com/s/1i4cQky5

百度云下载所需字体文件

该方法适用于在linux主机运行的maximo中查看工作流程图无法正常显示中文字体

```Shell
#解压到 该用户所在目录
tar zxvf font.tar.gz  -C ~/
#在jdk所在位置创建 fallback 目录
mkdir  /media/linux/data/opt/java/jdk160_05/jre/lib/fonts/fallback
#创建文件链接
ln -s ~/.fonts/*  /media/linux/data/opt/java/jdk160_05/jre/lib/fonts/fallback/
ln -s ~/.fonts/*  /media/linux/data/opt/java/jdk160_05/jre/lib/fonts/

```
重新运行java程序后正常
