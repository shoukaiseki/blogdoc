# 删除windows服务 SC命令  

sc delete "服务名"(如果服务名中间有空格，就需要前后加引号) 
<br>

<br>
SC命令是XP系统中功能强大的DOS命令,SC命令能与“服务控制器”和已安装设备进行通讯。SC命令的功能有
<br>

<br>
1、SC可以 检索和设置有关服务的控制信息。可以使用 SC.exe 来测试和调试服务程序。
<br>

<br>
2、可以设置存储在注册表中的服务属性，以控制如何在启动时启动服务应用程序，以及如何将其作为后台程序运行。即更改服务的启动状态。
<br>

<br>
3、SC 命令还可以用来删除系统中的无用的服务。（除非对自己电脑中的软硬件所需的服务比较清楚，否则不建议删除任何系统服务，尤其是基础服务）
<br>

<br>
4、SC命令 的参数可以配置指定的服务，检索当前服务的状态，也可以停止和启动服务（功能上类似NET STOP/START命令，但SC速度更快且能停止更多的服务）。
<br>

<br>
5、可以创建批处理文件来调用不同的 SC 命令，以自动启动或关闭服务序列。
<br>

<br>
SC.exe 提供的功能类似于“控制面板”中“管理工具”项中的“服务”。
<br>

<br>
 
<br>

<br>
这里只介几个常用的命令：
<br>

<br>
更详细的信息可见: biadu知道SC
<br>

<br>
1. sc start
<br>

<br>
启动正在运行的服务。
<br>

<br>
语法
<br>

<br>
Sc [ServerName] start ServiceName [ServiceArguments]
<br>

<br>
参数
<br>

<br>
ServiceArguments
<br>

<br>
指定传递给要启动的服务的服务参数。
<br>

<br>
下面的示例显示了如何使用 sc start 命令：
<br>

<br>
(1)  sc start tapisrv
<br>

<br>
(2)  sc start giveio
<br>

<br>
2. sc stop
<br>

<br>
向服务发送 STOP 控制请求。
<br>

<br>
语法
<br>

<br>
Sc [ServerName] stop ServiceName
<br>

<br>
参数：略
<br>

<br>
备注
<br>

<br>
并非所有服务都能够被停止。
<br>

<br>
下面的示例显示了如何使用 sc stop 命令：
<br>

<br>
(1)  sc stop tapisrv
<br>

<br>
(2)  sc stop giveio
<br>

<br>
3. sc query
<br>

<br>
获得和显示关于指定的服务、驱动程序、服务类型或驱动程序类型的信息。
<br>

<br>
语法
<br>

<br>
Sc [ServerName] query [ServiceName] [type= {driver | service | all}] [type= {own | share | interact | kernel | filesys | rec | adapt}] [state= {active | inactive | all}] [bufsize= BufferSize] [ri= ResumeIndex] [group= GroupName]
<br>

<br>
sc query 参数很多，这里不再一一介绍，详细信息可见biaud知道SC
<br>

<br>
参数
<br>

<br>
ServiceName
<br>

<br>
指定由 getkeyname 操作返回的服务名。此 query 参数不与其他的 query 参数结合使用（除了 ServerName）。
<br>

<br>
常用如：
<br>

<br>
(1)  sc query  tapisrv
<br>

<br>
(2)  sc  query  giveio
<br>

<br>
 4、sc create
<br>

<br>
　　在注册表和“服务控制管理器”中为服务创建子项和项目。
<br>

<br>
　　语法
<br>

<br>
　　Sc [ServerName] create [ServiceName] [type= {own | share | kernel | filesys | rec | adapt | interacttype= {own | share}}] [start= {boot | system | auto | demand | disabled}] [error= {normal | severe | critical | ignore}] [binpath= BinaryPathName] [group= LoadOrderGroup] [tag= {yes | no}] [depend= dependencies] [obj= {AccountName | ObjectName}] [displayname= DisplayName] [password= Password]
<br>

<br>
　　参数：各个参数的作用参见sc config 命令
<br>

<br>
　　下面的示例显示了如何使用 sc create 命令：
<br>

<br>
　　sc \\myserver create NewService binpath= c:\windows\system32\NewServ.exe
<br>

<br>
　　sc create NewService binpath=(空格)c:\windows\system32\NewServ.exe type=(空格)share start=(空格)auto depend= "+TDI Netbios"
<br>

<br>
　　sc  create ccproxy binpath= c:\windows\ccproxy\ccproxy.exe type= share start= auto
<br>

<br>
　　5、sc delete
<br>

<br>
　　从注册表中删除服务子项。如果服务正在运行或者另一个进程有一个该服务的打开句柄，那么此服务将标记为删除。
<br>

<br>
　
<br>
　语法
<br>

<br>
　　Sc [ServerName] delete [ServiceName]
<br>

<br>
　　参数：略
<br>

<br>
　　备注
<br>

<br>
　　使用“添加或删除程序”删除 DHCP、DNS 或任何其他内置的操作系统服务。“添加或删除程序”不仅会删除该服务的注册表子项，而且还会卸载该服务并删除其所有的快捷方式。
<br>

<br>
　　下面的示例显示了如何使用 sc delete 命令：
<br>

<br>
　　sc delete newserv
<br>

<br>
       sc delete ccproxy
<br>

