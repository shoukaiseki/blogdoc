# PLSQL developer 连接不上64位Oracle 解决办法  

PLSQL developer 连接不上64位Oracle 解决办法

本文转自 http://hi.baidu.com/worldkingspace/blog/item/cc60d58eb9b1a9e3513d92bf.html

下载地址请查看: http://shoukaiseki.blog.163.com/blog/static/192856149201111533612207/

         http://115.com/file/c2bqmc6d#               plsqldevfor64.7z(已经将下面文件压缩至一个包中)

手动安装版:instantclient-basic-win32-11.2.0.1.0.exe  (Oracle11.2G)

     手动安装版:instantclienoracle10.2.0.1.exe  (10G)

     绿色整合版: instantclienoracle10.2.0.1.7z   (10G)7z格式压缩率比较高,WINRAR用户请见亮,可以下载HaoZip

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/oracle/PLSQL%20developer%20%E8%BF%9E%E6%8E%A5%E4%B8%8D%E4%B8%8A64%E4%BD%8DOracle%20%E8%A7%A3%E5%86%B3%E5%8A%9E%E6%B3%95/img/001.jpg)
 
去客户那里布置系统，结果用PLSQL时，死活连接不上他们的ORACLE，郁闷了好久，今天发现网上有解决办法，分享于大家：

问题：

在64位Windows2008上安装Oracle后，用PLSQL developer去连接数据库出现报错：

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/oracle/PLSQL%20developer%20%E8%BF%9E%E6%8E%A5%E4%B8%8D%E4%B8%8A64%E4%BD%8DOracle%20%E8%A7%A3%E5%86%B3%E5%8A%9E%E6%B3%95/img/002.jpg)
 
 

Could not load "……\bin\oci.dll"

OCIDLL forced to……

LoadLibrary（……oci.dll） returned 0

原因：

oci.dll是64位的，32位应用程序PLSQL Developer自然无法加载了，而且PLSQL Developer只支持32位，所以如果非要64位Oracle，我们只有想别的办法解决了；

解决方法一：

1、下载instantclient_32位客户端，加压后存放，如D:\ProgramFiles\instantclient

2、拷贝Oracle10G的msvcr71.dll(Oracle11.2G为 msvcr80.dll)和tnsnames.ora到解压的instantclient_32位客户端根目录，它们的位置分别是：

F:\oracle\product\10.2.0\db_1\BIN 和F:\oracle\product\10.2.0\db_1\NETWORK\ADMIN

注:我已经将msvcr71.dll集成于压缩包中, tnsnames.ora已经配置主机IP为127.0.0.1的服务名orcl,

也可自行复制后进行覆盖,

3、设置PLSQL Developer中设置Oracle_Home和OCI Library，

如图：

 

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/oracle/PLSQL%20developer%20%E8%BF%9E%E6%8E%A5%E4%B8%8D%E4%B8%8A64%E4%BD%8DOracle%20%E8%A7%A3%E5%86%B3%E5%8A%9E%E6%B3%95/img/003.jpg)
 
4、在PLSQL Developer目录下创建bat文件，作为PLSQL Developer的启动快捷方式替换PLSQL Developer传统启动方式，bat文件中的内容如下：

@echo off

set path=D:\ProgramFiles\instantclient

set ORACLE_HOME=D:\ProgramFiles\instantclient

set TNS_ADMIN=D:\ProgramFiles\instantclient

set NLS_LANG=AMERICAN_AMERICA.AL32UTF8

start plsqldev.exe

至此设置完成，经实验PLSQL Developer的可以成功连接到Oracle 10G 64位

至此设置完成，经实验PLSQL Developer的可以成功连接到Oracle 11.2G 64位
