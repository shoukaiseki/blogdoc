# firefox安装 jdk插件  
```
mkdir /opt/java
tar zxvf jre-8u66-linux-x64.tar.gz -C /opt/java
```
必须采用ln，因为会自动检测到ln对应的jdk路径
```
ln -s /opt/java/jre1.8.0_66/lib/amd64/libnpjp2.so /usr/lib/mozilla/plugins/
```

重启firefox浏览器即可


java安全控制台
```
/opt/java/jre1.8.0_66/bin/jcontrol
```
