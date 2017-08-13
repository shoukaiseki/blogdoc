# 如何设置Weblogic 启动时不输入密码  

新建一个 

/opt/bea10r3/weblogic/user_projects/domains/wgldomain01/servers/AdminServer/security/boot.properties 

文件，内容如下
```
username=weblogic
password=123455
```
