# Linux Oracle各種服務的啓動  

iSQL*Plus URL: http://127.0.0.1:5560/isqlplus
<br />
iSQL*Plus DBA URL: http://127.0.0.1:5560/isqlplus/dba
<br />
Enterprise Manager 10g Database Control URL: http://127.0.0.1:1158/em

```
帐号 system
密码 maximo
```
http://127.0.0.1:5560/isqlplus 中無法用system登錄
<br />
新建用戶後能登入
```

* 用户名 		maximo
* 口令		  maximo
连接标识符		 orcl  
配置監聽  netmgr 在Linux/Unix下，利用netmgr命令来启动图形化Oracle网络管理器
/home/oracle/oracle/product/10.2.0/db_1/network/admin/listener.ora
啓動監聽   配置監聽  netmgr 在Linux/Unix下，利用netmgr命令来启动图形化Oracle网络管理器,基於java運行的
lsnrctl start
檢查監聽
lsnrctl status
查看監聽是否啓動 
netstat -ant
關閉監聽
lsnrctl stop
source .bash_profile
启动isqlplus服务
isqlplusctl start
停止isqlplus服务
isqlplusctl stop
启动oem服务
emctl start dbconsole
停止oem服务
emctl stop dbconsole

啓動數據庫
sqlplus /nolog
connect /as sysdba
shutdown immediate 关闭数据库
startup 啓動數據庫

在Linux系统要远程连接oracle的防火墙设置方法：

打开5801至5810 端口用于vnc

iptables -I INPUT -p tcp --dport 5801:5810 -j ACCEPT

iptables -I INPUT -p tcp --dport 5901:5910 -j ACCEPT

iptables -A INPUT -p tcp --dport 5801:5810 -j ACCEPT
iptables -A INPUT -p tcp --dport 5901:5910 -j ACCEPT

打开1521 端口用于oracle

iptables -I INPUT -p tcp --dport 1521 -j ACCEPT
iptables -A INPUT -p tcp --dport 1521 -j ACCEPT
iptables -I INPUT -p tcp --dport 5560 -j ACCEPT
iptables -A INPUT -p tcp --dport 5560 -j ACCEPT
iptables -I INPUT -p tcp --dport 1158 -j ACCEPT
iptables -A INPUT -p tcp --dport 1158 -j ACCEPT

永久保存
service iptables save

下面文章轉自http://blog.sina.com.cn/s/blog_3f2ef1180100bv82.html
登錄http://127.0.0.1:5560/isqlplus/dba
通过如下步骤实现：

1.切换到正确的目录
    [oracle@RHEL ~]$ cd $ORACLE_HOME/oc4j/j2ee/isqlplus/\
    >application-deployments/isqlplus
2.运行JAZN shell
    [oracle@RHEL isqlplus]$ $JAVA_HOME/bin/java -Djava.security.properties=$ORACLE_HOME/sqlplus/admin/iplus/provider -jar $ORACLE_HOME/oc4j/j2ee/home/jazn.jar -user "iSQL*Plus DBA/admin" -password welcome -shell
    或者
    [oracle@RHEL isqlplus]$ $JAVA_HOME/bin/java -Djava.security.properties=$ORACLE_HOME/oc4j/j2ee/home/config/jazn.security.props -jar $ORACLE_HOME/oc4j/j2ee/home/jazn.jar -user "iSQL*Plus DBA/admin" -password welcome -shell

3.创建用户
    JAZN:> adduser "iSQL*Plus DBA" oracle oracle
    示例中创建用户oracle，密码也是oracle。语法是：adduser "iSQL*Plus DBA" username password。
4.授予webDba role给用户
    JAZN:> grantrole webDba "iSQL*Plus DBA" oracle
5.退出JAZN shell
    JAZN:> exit

    重新启动iSQL*Plus。
[oracle@RHEL isqlplus]$ isqlplusctl start
iSQL*Plus 10.2.0.1.0
Copyright (c) 2003, 2005, Oracle.  All rights reserved.
Starting iSQL*Plus ...
iSQL*Plus started.

    再次登录iSQL*Plus，输入之前创建的用户oracle以及密码后。輸入第三步創建的用戶密碼
* 用户名 		sys
* 口令		  maximo
连接标识符		 orcl 
权限		                       SYSDBA                                                SYSOPER           
```
