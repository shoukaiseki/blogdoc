# Linux下weblogic安装  

http://cache.baidu.com/c?m=9f65cb4a8c8507ed4fece7631046893b4c4380146d96864968d4e414c42246051a2db0ee703517708c9f7f6c0baa540faab66d2369543de1cc8edb1183fa8f2f25892135741a92044f934fa08e11759f7dc501b8b81996eaab6e&p=ce769a41ba9f11a05eeedc3b5a08&user=baidu&fm=sc&query=weblogic++bin&qid=81f0235106003839&p1=7

http://www.oracle.com/technetwork/middleware/weblogic/downloads/wls-main-097127.html
http://download.oracle.com/otn/bea/weblogic/server924_linux32.zip

Standard	WLS 7.0	WLS 8.1	WLS 9.0	WLS 10.0	WLS 10.3	WLS 12c

Java	1.3	1.4	5	5	6	7

Java EE	1.3	1.3	1.4	5	5	6



我的用戶名爲fedora

壓縮包放於/home/fedora/weblogic/目錄下

解壓後臨時目錄爲/tmp/database

```Shell
cd /home/fedora/weblogic

unzip wloc103_linux32.zip -d /tmp/database
```
查看java版本號
```Shell
java -version
```
我的爲1.6.0_22版本的
```Shell
cd /tmp/database
```


## 1.1 部署前准备
### a、创建weblogic用户组。
```Shell
        groupadd weblogic
        useradd -g weblogic weblogic (增加帳號,密碼)
        passwd weblogic（修改weblogic密码,不用更改密碼就可以不用執行此句）
```
### b、创建/oracle/weblogic目录,修改目录所有者权限
```Shell
  mkdir /oracle
        mkdir /oracle/weblogic
        chown –Rf weblogic:weblogic /oracle/weblogic  賦予weblogic用戶訪問/oracle/weblogic的訪問權限

```
## 1.2 安装WebLogic10
赋予.bin可执行权限： 
```Shell
chmod a+x wloc103_linux32_jdk6.bin
su weblogic
```
执行
```Shell
./wloc103_linux32_jdk6.bin
```
      进入控制台安装的欢迎界面，键入[Next]继续

      此时出现授权许可协议，读完后键入[Yes]继续

      提示选择一个BEA主目录:/oracle/weblogic

             输入 
```Shell
./server103_linux32.bin
```

然后根据提示一一选择

即可没有什么特别的地方

## 1.3新建domain
使用WebLogic用户登录系统：

因爲之前用root安裝的weblogic,所以/weblogic下有root權限才能訪問的文件夾
```Shell
cd /oracle 
chown -Rf weblogic:weblogic weblogic/  修復所屬用戶組
[root@linux-test /]# su  weblogic
[weblogic@linux-test ~]$ cd /oracle/weblogic/wloc_10.3/common/bin/

[weblogic@linux-test bin]$ pwd
/oracle/weblogic/wlserver_10.3/common/bin
[weblogic@linux-test bin] ./config.sh
```
http://localhost:7001/console
