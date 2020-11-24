# 最坑人jdk版本

 系统为 Alibaba Cloud Linux  2.1903 LTS 64位 等保2.0三级版

执行java--version查询版本号出现无法创建虚拟机,最开始使用yum install java-1.8.0-openjdk.i686
后来又到oracle官网下载了个版本，结果都这样，还以为系统有问题


## 版本号为 jdk1.8.0_271
```Java
[root@iZbp111cqx7ixlac3kfozjZ ~]# /data/opt/java/jdk1.8.0_271/bin/java --version
Unrecognized option: --version
Error: Could not create the Java Virtual Machine.
Error: A fatal exception has occurred. Program will exit.
[root@iZbp111cqx7ixlac3kfozjZ ~]# /data/opt/java/jdk1.8.0_271/bin/java -version
java version "1.8.0_271"
Java(TM) SE Runtime Environment (build 1.8.0_271-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.271-b09, mixed mode)
```



通常我都是--version查询的,这是我本机的查看版本号结果
```
shoukaiseki@shoukaiseki:~$ java --version
openjdk 11.0.9.1 2020-11-04
OpenJDK Runtime Environment (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04)
OpenJDK 64-Bit Server VM (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04, mixed mode, sharing)
shoukaiseki@shoukaiseki:~$ java -version
openjdk version "11.0.9.1" 2020-11-04
OpenJDK Runtime Environment (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04)
OpenJDK 64-Bit Server VM (build 11.0.9.1+1-Ubuntu-0ubuntu1.20.04, mixed mode, sharing)
```
