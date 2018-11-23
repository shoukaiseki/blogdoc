# tomcat注册成服务


```properties
[Unit]
Description=tomcat_xxl-job

[Service]
WorkingDirectory=/usr/local/app/tomcat_xxl-job
PrivateTmp=true
Restart=always
Type=forking
ExecStart=/usr/local/app/tomcat_xxl-job/bin/catalina.sh start
ExecStop=/usr/bin/kill -15  $MAINPID
[Install]
WantedBy=multi-user.target
```


还需要在catalina.sh 头部添加JAVA_HOME路径

```Shell
#!/bin/sh

JAVA_HOME=/opt/jvm/jdk1.8.0_181

```
