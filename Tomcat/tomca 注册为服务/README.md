# tomca 注册为服务 

在进行项目布署的时候，有时候我们需要重新添加或者卸载tomcat服务，这里，我们可以在命令提示符下进行操作，步骤如下：

1.开始—运行，敲入cmd，回车打开命令提示符。

2.进行tomcat所在盘符，如d盘，直接在命令提示符打上d：回车。

3.用cd命令进入到tomcat安装目录下的bin目录(因为要调用文件夹里的service.bat文件，呵呵)。


(设置为自动启动: 打開service.bat文件,尋找如下--JvmMs 128 --JvmMx 256 這句代碼, 在此後面加上 --Startup=auto(注意:前面要有空

格))


4.安装删除服务命令格式：service.bat install/remove [service_name]

(1)安装：service install 如果指定名称为aa，安装之后的服务名为 apache tomcat aa,可以不指定名称，在命令为service install的情

况下，服务名称默认为apache tomcat。

(2)删除：service remove 此命令用来删除服务名称为apache tomcat的服务，也就是说，在安装服务时没有指定服务名称，如果在安装时指

定了名称的话(如apache tomcat aa)。

操作完成之后，不需要重启电脑，直接刷新服务页面就OK了。

命令则应调整为service remove aa。?

如果没有设置java目录则得先设置
```
set JAVA_HOME=d:\usr\Java\jdk1.7.0
set PATH=%PATH%;%JAVA_HOME%\bin
set CLASSPATH=%JAVA_HOME%\lib\dt.jar;
set CLASSPATH=%CLASSPATH%%JAVA_HOME%\lib\toos.jar;


service.bat install
service remove


CLASSPATH    .;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\toos.jar;

JAVA_HOME   d:\usr_xp\Java\jdk1.7.0

Path +   ;%JAVA_HOME%\bin
```
