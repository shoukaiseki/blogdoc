# java增加并发数量

作为java程序员,我们就像赛车手,狙击手一样的角色,我们要挑战高并发,就像是一个赛车手如何把这辆赛车开到极致,就像一个狙击手要在极限距离击中目标

首先我们得先了解服务器的性能配置,硬件参数,比如网卡速率,CPU频率及核心数,内存容量,硬盘读写速度等. 

就像赛车手需要知道这辆车子的动力性能,轮胎气压,扭矩,风阻系数等性能参数,才能将这辆赛车发挥到极致.

就像狙击手需要知道这支狙击枪的口径,枪体重量,枪体长度,有效射程,后坐力,当前风向,温度等参数,才能完成完美的射击.


然而怎么合理的解决高并发的问题,真正的目的是为了让服务器的性能发挥到极致的情况下增加并发量.


我们以IBM Power System S812L(8247-21L) 服务器为例

## 1.网卡:双端口千兆网卡

一张网卡负责内网的其他业务,一张网卡负责互联网,所以极限吞吐量按照一张计算

为了便于分析,页面的响应时间以秒来计算,页面的数据假设为300KB,客户端网络最低延迟,网卡当前模式为全双工模式


1000Mb/s÷8=125MBx1024÷300=426

计算结果是网卡速率最高支持426个用户同一时刻访问

这种情况下,首先我们将页面中的js,css等静态资源放到其它服务器(js,css最好进行压缩),加载完js和css之后在浏览器是有缓存的,

放到其它服务器避免新用户跟已经访问过业务的用户争抢带宽,同时提高用户体验(使用过程中出现不流畅是最影响用户心情的),所以这也是Jquery等JavaScript框架备受欢迎的原因,因为很多工作可以在客户端去做,减少对服务器的负载

比如js,css等静态资源大小为270KB,这时并发量就提高了10倍,高并发情况下静态资源是必须分离的,如果有多个显示层负责不同的功能业务,但使用的同一种javascript,建议使用同一个版本,同一个url地址,以达到资源的重复利用


##### 说明
这只是网卡能达到的极致并发量提高,也可以更换 10G/40G/100G光纤网卡来提高性能,但是还得看交换机,硬件防火墙等设备的最高速率

同是硬盘有个读写速度峰值,比如RAID阵列磁盘最高读取速率为300MB/s,100G的光纤网卡也没用.

还有另外一项技术能够满足磁盘读取速率的问题,那就是内存虚拟成硬盘分区的技术,适合静态资源文件不是很大但是访问却很频繁的情况下,这种虚拟分区能够提供 1000MB/s的读取速率,写入速度也达到500MB/s

当然在linux下是不怎么需要这种的,因为系统本身会对频繁使用的文件缓存到内存中

## 2.代码执行效率,内存占用量

代码执行效率是能否达到网卡所提供极限速率的重要指数.


IBM Power System S812L(8247-21L) 的主计算硬件配置如下

CPU频率	3.42GHz
三级缓存	8MB
二级缓存	512KB
CPU核心	十核
内存描述	64GB 1600MHz DDR3

## 代码执行效率这个没法具体去说明,但是内存占用量是可以简单说明的

#### String 类型拼接时使用 StringBuffer,杜绝使用Strng类型直接拼接
比如 String a="abcd"; a+="def"; 当其中的abcd是不固定的,那么在4000个用户同事访问时就会产生4*4000=16MB的内存占用,增加CG回收的开销

经常使用的常量字符串定义在全局常亮中 

比如:"yes".equals(a)  JVM实例化一个字符串会先去内存区域寻找有没相同值的string类,而且会在栈中存放地址位,造成不必要的CPU资源内存资源浪费



暂时写到这





## JVM 性能优化

### ①JVM工作模式

JVM 运行时有 client VM 与 server VM  两种模式,server 模式性能好,到底好在哪?参照 [JVM client模式和Server模式的区别](https://blog.csdn.net/tang_123_/article/details/6018219)

我们先用jsp查看一下当前的工作模式

http://www.shoukaiseki.top/qrcode/jvm.jsp

```Jsp
<%@ page language="java" import="java.util.*,java.net.URL" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>查看java版本</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta property="qc:admins" content="4746776325477164510063757" >
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
	<br>
	java.vm.name=<%=System.getProperty("java.vm.name")%>
    JVM版本= <%=System.getProperty("java.version", "not specified")%><br>
    JVM缺省路径=<%=System.getProperty("java.home", "not specified")%>
	<br>
	java.version=<%=System.getProperty("java.version")%>
	<br>
	java.class.version=<%=System.getProperty("java.class.version")%>
	<br>
	Java 虚拟机中的内存总量=<%=Runtime.getRuntime().totalMemory()/1024/1024%>MB
	<br>
	Java 虚拟机试图使用的最大内存量=<%=Runtime.getRuntime().maxMemory()/1024/1024%>MB
	<br>
	Java 虚拟机中的空闲内存量=<%=Runtime.getRuntime().freeMemory()/1024/1024%>MB

  </body>
</html>

```

显示结果如下

```
java.vm.name=Java HotSpot(TM) Client VM JVM版本= 1.8.0_151
```
可以看出是工作在 Client 模式

怎么切换到 Server 模式呢?如果是用win系统下服务形式启动的,JVM选择jdk/jre/bin/server 下的 jvm.dll

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/%E4%BA%92%E8%81%94%E7%BD%91/java%E9%AB%98%E5%B9%B6%E5%8F%91/img/001.png)

如果是linux系统或者startup启动的,那么在catalina中加java运行参数 

##### win系统

```Bat
:execCmd
rem Get remaining unshifted command line arguments and save them in the
set CMD_LINE_ARGS=
:setArgs
if ""%1""=="""" goto doneSetArgs
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto setArgs
:doneSetArgs

@REM 此处增加 start
set JAVA_OPTS= -server %JAVA_OPTS%
@REM 此处增加 end
rem Execute Java with the applicable properties
if not "%JPDA%" == "" goto doJpda
if not "%SECURITY_POLICY_FILE%" == "" goto doSecurity
%_EXECJAVA% %JAVA_OPTS% %CATALINA_OPTS% %DEBUG_OPTS% -classpath "%CLASSPATH%" -Dcatalina.base="%CATALINA_BASE%" -Dcatalina.home="%CATALINA_HOME%" -Djava.io.tmpdir="%CATALINA_TMPDIR%" %MAINCLASS% %CMD_LINE_ARGS% %ACTION%
goto end
:doSecurity
%_EXECJAVA% %JAVA_OPTS% %CATALINA_OPTS% %DEBUG_OPTS% -classpath "%CLASSPATH%" -Djava.security.manager -Djava.security.policy=="%SECURITY_POLICY_FILE%" -Dcatalina.base="%CATALINA_BASE%" -Dcatalina.home="%CATALINA_HOME%" -Djava.io.tmpdir="%CATALINA_TMPDIR%" %MAINCLASS% %CMD_LINE_ARGS% %ACTION%
goto end
:doJpda
if not "%SECURITY_POLICY_FILE%" == "" goto doSecurityJpda
%_EXECJAVA% %JAVA_OPTS% %JPDA_OPTS% %CATALINA_OPTS% %DEBUG_OPTS% -classpath "%CLASSPATH%" -Dcatalina.base="%CATALINA_BASE%" -Dcatalina.home="%CATALINA_HOME%" -Djava.io.tmpdir="%CATALINA_TMPDIR%" %MAINCLASS% %CMD_LINE_ARGS% %ACTION%
goto end
:doSecurityJpda
%_EXECJAVA% %JAVA_OPTS% %JPDA_OPTS% %CATALINA_OPTS% %DEBUG_OPTS% -classpath "%CLASSPATH%" -Djava.security.manager -Djava.security.policy=="%SECURITY_POLICY_FILE%" -Dcatalina.base="%CATALINA_BASE%" -Dcatalina.home="%CATALINA_HOME%" -Djava.io.tmpdir="%CATALINA_TMPDIR%" %MAINCLASS% %CMD_LINE_ARGS% %ACTION%
goto end
```


