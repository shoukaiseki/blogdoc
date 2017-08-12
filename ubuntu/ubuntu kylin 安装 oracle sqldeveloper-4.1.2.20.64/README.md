# ubuntu kylin 安装 oracle sqldeveloper-4.1.2.20.64  

在oracle jdk官网下载  Java SE Development Kit 8u65 的x86版本，解压到/opt目录

在 /usr/bin下面建立一个名为 sqldeveloper 的文件，内容如下
```
#!/bin/sh
JAVA_HOME=/usr/lib/jvm/jdk1.8.0_65/
PATH=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:/usr/bin:/bin:$PATH
JRE_HOME=${JAVA_HOME}/jre
CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
PATH=${JAVA_HOME}/bin:$PATH
export JAVA_HOME PATH CLASSPATH

java -version

cd /opt/sqldeveloper
sh ./sqldeveloper.sh

```

之后授权sudo  chmod 777 sqldeveloper

用登录用户在终端运行 sqldeveloper
```
java version "1.8.0_65"

Java(TM) SE Runtime Environment (build 1.8.0_65-b17)
Java HotSpot(TM) Server VM (build 25.65-b01, mixed mode)

 Oracle SQL Developer
 Copyright (c) 1997, 2015, Oracle and/or its affiliates. All rights reserved.

/usr/lib/jvm/jdk1.8.0_66/bin/java: error while loading shared libraries: libjli.so: cannot open shared object file: No such file or directory
Exception in thread "main" java.lang.UnsatisfiedLinkError: /usr/lib/jvm/jdk1.8.0_65/jre/lib/i386/libawt_xawt.so: libXtst.so.6: 无法打开共享对象文件: 没有那个文件或目录
	at java.lang.ClassLoader$NativeLibrary.load(Native Method)
	at java.lang.ClassLoader.loadLibrary0(ClassLoader.java:1938)
	at java.lang.ClassLoader.loadLibrary(ClassLoader.java:1821)
	at java.lang.Runtime.load0(Runtime.java:809)
	at java.lang.System.load(System.java:1086)
	at java.lang.ClassLoader$NativeLibrary.load(Native Method)
	at java.lang.ClassLoader.loadLibrary0(ClassLoader.java:1938)
	at java.lang.ClassLoader.loadLibrary(ClassLoader.java:1842)
	at java.lang.Runtime.loadLibrary0(Runtime.java:870)
	at java.lang.System.loadLibrary(System.java:1122)
	at java.awt.Toolkit$3.run(Toolkit.java:1636)
	at java.awt.Toolkit$3.run(Toolkit.java:1634)
	at java.security.AccessController.doPrivileged(Native Method)
	at java.awt.Toolkit.loadLibraries(Toolkit.java:1633)
	at java.awt.Toolkit.<clinit>(Toolkit.java:1668)
	at java.awt.Component.<clinit>(Component.java:593)
	at oracle.ide.osgi.boot.api.SplashScreen.createInstance(SplashScreen.java:66)
	at oracle.ide.osgi.boot.OracleIdeLauncher.showSplashScreen(OracleIdeLauncher.java:821)
	at oracle.ide.osgi.boot.OracleIdeLauncher.main(OracleIdeLauncher.java:113)
```

如果出现上述错误，安装支持库

```
sudo apt-get install libxtst6:i386
```

按照完之后在运行成功
