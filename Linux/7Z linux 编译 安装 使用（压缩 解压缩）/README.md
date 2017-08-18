# 7Z linux 编译 安装 使用（压缩 解压缩）  


官網下載地址，http://7-zip.org/download.html

本文章轉自 http://blog.johntechinfo.com/technology/248

7z是一个开源压缩软件。其压缩率较高。Windows下的使用客户端操作很简便。Linux下的使用，需要安装。

首先下载7z的linux版本，在linux叫p7zip，在sourceforge下载。

wget http://downloads.sourceforge.net/project/p7zip/p7zip/9.13/p7zip_9.13_src_all.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fp7zip%2Ffiles%2Fp7zip%2F9.13%2F&ts=1293507429&use_mirror=cdnetworks-kr-1 

解压安装:

```Shell
tar jxvf p7zip_9.13_src_all.tar.bz2  cd p7zip_9.13  make && make install  ./install.sh  ldconfig 
```
安装完毕。使用src版本后二进制可执行文件叫7za。官方下载页有bin版本，不需要编译，下载后直接运行目录下的install.sh即可，生成可执行文件是7z没有那个a。

解压缩7z文件

7za x soft.7z -r -o./soft x soft.7z -r -o./

参数含义：

x  代表解压缩文件，并且是按原始目录解压（还有个参数 e 也是解压缩文件，但其会将所有文件都解压到根下，而不是自己原有的文件夹下）

soft.7z  是压缩文件，这里我用soft做测试。这里默认使用当前目录下的soft.7z

-r 表示递归解压缩所有的子文件夹

-o 是指定解压到的目录，-o后是没有空格的直接接目录

压缩文件／文件夹

7za a -t7z -r Mytest.7z /opt/phpMyAdmin-3.3.8.1-all-languages/*

参数含义：

a  代表添加文件／文件夹到压缩包

-t 是指定压缩类型，这里定为7z

-r 表示递归所有的子文件夹

Mytest.7z 是压缩好后的压缩包名


