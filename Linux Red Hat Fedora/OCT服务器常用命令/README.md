# OCT服务器常用命令  

启动 vnc 服务  
```Shell
vncserver :1
```

启动IBM Http 服务
```Shell
/opt/IBM/HTTPServer/bin/apachectl start
```



maximo.ear 路径
```Shell
/opt/IBM/WebSphere/AppServer1/profiles/AppSrv01/installedApps/EAMPRDAPPCell01/MAXIMO.ear
```

修改web.xml还需要更新至该目录
```Shell
/opt/IBM/WebSphere/AppServer1/profiles/AppSrv01/config/cells/EAMPRDAPPCell01/applications/MAXIMO.ear/deployments/MAXIMO/maximouiweb.war/WEB-INF/web.xml
```




正式库112.123 ant svn自动更新使用说明
<br />
在终端有3个命令进行管理

```Shell
maximo_build_class  下载svn下的src源码之后进行javac编译，编译之后自动将*Set.class的类文件进行rmic创建sub接口类，最后会将class类文件复制到maximo.ear所在目录
maximo_checkout_lib  检出svn下的lib包目录文件，是编译所需的所有jar，如果有新增jar包，则需要提交到svn之后执行该命令，如果无心中jar，则无需执行该命令
maximo_cleanBuild  清空所有检出的svn文件以及class，基本无需执行，但是执行之后需要先执行 maximo_checkout_lib 才能执行 maximo_build_class
```
