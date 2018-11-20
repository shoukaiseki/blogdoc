# springboot注册成服务

使用 winsw

https://github.com/kohsuke/winsw/releases

或者

http://repo.jenkins-ci.org/releases/com/sun/winsw/winsw/

都可以下载

改名为 apiview-service.exe 之后创建 apiview-service.xml

```Xml
<?xml version="1.0" encoding="UTF-8" ?>
<service>
    <id>apiview_service</id>
    <name>apiview_service</name>
    <description>服务说明</description>
	<!--env 为设置环境变量,%BASE%为当前目录-->
    <env name="APIVIEW_HOME" value="%BASE%"/>
	<!--不支持使用自定义的变量
    <logpath>"%APIVIEW_HOME%\logs"</logpath>-->
    <logpath>%BASE%\logs</logpath>
    <executable>D:\usr\java\jdk1.8.0_131\bin\java.exe</executable>
    <arguments> -Xms128m -Xmx512m  -jar %APIVIEW_HOME%\apiview.jar</arguments>
  
    <log mode="roll-by-size">
        <sizeThreshold>10240</sizeThreshold>
        <keepFiles>8</keepFiles>
    </log>
</service>
```


之后用管理员运行以下命令创建服务,无需停止服务脚本命令

```bat
apiview-service.exe install
```

