# java 开启debug模式 tomcat debug

java 开启remote java Application 即 debug模式

只要在jvm加以下参数即可
```
-Xdebug -Xrunjdwp:transport=dt_socket,address=5000,server=y,suspend=n 
```



tomcat debug 

在catalina.bat中的 :doneSetArgs下面添加下列语句即可
```
 set JAVA_OPTS=%JAVA_OPTS%   -Xdebug -Xrunjdwp:transport=dt_socket,address=5000,server=y,suspend=n 
```
