# Linux下的java环境变量配置  

本人使用的是Fedora 15 系统
<br>
jdk-7-linux-i586.rpm http://115.com/file/e6ag1iqo#
<br>
jre-7-linux-i586.rpm  http://115.com/file/clflf85z#
<br>
下载安装好后配置环境变量
<br>
终端输入

```Shell
su
sudo gedit /etc/profile
```
打开后在文件最后添加以下内容

```Bash
JAVA_HOME=/usr/java/jdk1.7.0
PATA=$JAVA_HOME/bin:$PATA
CLASSPATH=.:$JAVA_HOME/lib/dt.jar: $ JAVA_HOME\lib\tools.jar
export JAVA_HOME PATH CLASSPATH
```
保存后注销即可(也可执行source /etc/profile让变量临时在该终端下生效 )
<br>

<br>
·注解 
<br>
a. 你要将 /usr/java/jdk1.7.0改为你的jdk安装目录 
<br>
b. linux下用冒号“:”来分隔路径 
<br>
c. $PATH / $CLASSPATH / $JAVA_HOME 是用来引用原来的环境变量的值 
<br>
在设置环境变量时特别要注意不能把原来的值给覆盖掉了，这是一种 
<br>
常见的错误。 
<br>
d. CLASSPATH中当前目录“.”不能丢,把当前目录丢掉也是常见的错误。 
<br>
e. export是把这三个变量导出为全局变量。 
<br>
f. 大小写必须严格区分。

