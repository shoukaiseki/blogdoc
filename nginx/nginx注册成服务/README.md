# nginx注册成服务


## nginx 常用操作命令
```bat
start nginx

tasklist /fi "imagename eq nginx.exe"

nginx -s stop	fast shutdown
nginx -s quit	graceful shutdown
nginx -s reload	changing configuration,starting new worker processes with a new configuration,graceful shutdown of old worker processes
nginx -s reopen	re-opening log files
```


使用 winsw

https://github.com/kohsuke/winsw/releases

或者

http://repo.jenkins-ci.org/releases/com/sun/winsw/winsw/

都可以下载

改名为 nginx-service.exe 之后创建 nginx-service.xml

```Xml
<?xml version="1.0" encoding="UTF-8" ?>
<service>
    <id>nginx_service</id>
    <name>nginx_service</name>
    <description>服务说明</description>
	<!--env 为设置环境变量,%BASE%为当前目录-->
    <env name="NGINX_HOME" value="%BASE%"/>
    <logpath>%NGINX_HOME%\logs</logpath>
    <log mode="roll-by-size">
        <sizeThreshold>10240</sizeThreshold>
        <keepFiles>8</keepFiles>
    </log>
    <executable>D:\usr\nginx\nginx.exe</executable>
	<executable>%NGINX_HOME%\nginx.exe</executable>
	<startarguments>-p %NGINX_HOME%</startarguments>
	<stopexecutable>%NGINX_HOME%\nginx.exe</stopexecutable>
	<stoparguments>-p %NGINX_HOME% -s stop</stoparguments>
</service>
```

之后用管理员运行以下命令创建服务,无需停止服务脚本命令
```bat
nginx-service.exe install
```
