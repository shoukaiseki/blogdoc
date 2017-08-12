# was不生成 heapdump  



产生heapdump的根本原因是你的Java堆栈溢出，解决方法：

1.加大堆空间

2.检查应用中的内存泄漏

3.请看下面的解释：



为什么WebSphere Application Server的IBM JDK在升级到V1.3.1 SR5以后总是自动产生heapdumps和javacores，如何避免



产品：WebSphere Application Server(以下简称WAS)

版本：4.0.x,5.0.x,5.1.x

平台：AIX,Windows,Linux



问题描述：

为什么WebSphere Application Server的JDK在升级到V1.3.1 SR5以后总是自动产生heapdumps和javacores



解答：

为了辅助第一时间捕捉错续信息，从IBM JDK V1.3.1 SR5(131-20030618)版本开始，当Java的堆空间耗尽时系统会自动的产生heapdumps和javacores。如果希望在Java对空间耗尽时不会自动的产生heapdumps和javacores,请按照如下的步骤操作：



对于WAS 4.0.x:

1. 找到<WAS_HOME>/bin/startupServer.sh (.bat)文件,其中<WAS_HOME>表示WAS的安装目录

2. 用文本编辑器打开该文件，并在文件的顶部添加如下的2行：

export IBM_HEAPDUMP_OUTOFMEMORY=false

export IBM_JAVADUMP_OUTOFMEMORY=false

3. 保存并关闭文件，重新启动WAS



对于WAS 5.0.x或者5.1.x:

1. 打开管理控制台，依次选择：服务器 > 应用服务器 > 需要更改的服务器名称 > 进程定义 > 环境条目

2. 新建如下的2个条目：

Name 	Value 

IBM_HEAPDUMP_OUTOFMEMORY 	false 

IBM_JAVADUMP_OUTOFMEMORY 	false 

3. 保存配置的更改，重新启动WAS

















jvm 生成javacore和heapdump文件

（1）如果使用Oracle JVM也就是标准的SUN JVM（SUN已被oracle收购）

当内存溢出时生成heapdump文件配置如下

-Xloggc:${目录}/temp_gc.log           （GC日志文件）

-XX:+HeapDumpOnOutOfMemoryError       （内存溢出时生成heapdump文件）

-XX:HeapDumpPath=${目录}              （heapdump文件存放位置）



如果要即时动态生成heapdump文件可以使用jmap命令，jdk6.0已取消了-XX:+HeapDumpOnCtrlBreak配置参数通过ctrl+break的方式。

jmap -dump:format=b,file=temp_heapdump.hprof <pid>



（2）HP JVM

-Xverbosegc:file=${目录}/temp_gc.log  （GC日志文件）

-XX:+HeapDumpOnOutOfMemoryError       （内存溢出时生成heapdump文件）

-XX:+HeapDumpOnCtrlBreak              （可以通过ctrl+break组合键动态生成heapdump文件）

-XX:HeapDumpPath=${目录}              （heapdump文件存放位置）



（3）IBM JVM

非windows操作系统环境中

-XverboseGClog: ${目录}/temp_gc.log   （GC日志文件）

-Xdump:heap:events=user,file=${目录}/pid%uid%pid.phd

表示可以根据需要通过kill -3 <pid>产生DUMP文件，%uid和%pid为变量



windows操作系统环境中

启动wsadmin,进入wsadmin环境

wsadmin> set jvm [$AdminControl completeObjectName type=JVM,process=server1,*]

wsadmin> $AdminControl invoke $jvm generateHeapDump

wsadmin> $AdminControl invoke $jvm dumpThreads


