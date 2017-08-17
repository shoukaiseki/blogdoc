# Linux下安装Oracle

oracle官网下载地址http://oss.oracle.com/projects/compat-oracle/files/RedHat/
<br />
安装时所需的包,我打包后的oraclerpm.tar.gz下载地址 http://115.com/file/bellegce#
<br />
10201_database_linux32.zip  下载地址http://115.com/file/an99n0ej#
<br />
安装方法转载http://www.233.com/oracle/zonghe/20101119/132750503.html

```Shell
yum -y install libaio-devel.i686
yum -y install libaio*
yum -y install libXp*
yum -y localinstall binutils-2.15.92.0.2-15.0.0.0.2.x86_64.rpm
yum -y localinstall compat-libcwait-2.1-1.i386.rpm
yum -y localinstall compat-libstdc++-3.2-1.i386.rpm
yum -y localinstall compat-oracle-rhel4-1.0-5.i386.rpm
yum -y localinstall libgcc32-3.2.3-49.i386.rpm
yum -y localinstall libstdc++32-3.2.3-49.i386.rpm
yum -y localinstall openmotif21-2.1.30-11.RHEL4.5.ppc.rpm
yum -y localinstall openmotif21-2.1.30-11.RHEL4.5.s390.rpm
yum -y localinstall openmotif21-2.1.30-11.RHEL5.s390.rpm

yum -y install compat-db
yum -y install compat-gcc
yum -y install compat-gcc-c++
yum -y install compat-libstdc++
yum -y install compat-libstdc++-devel
yum -y install xclock
```


## 三.创建数据库安装的准备工作: 
<br />
#### 1.创建用户和组(user/group)； 
```Shell
groupadd dba 
groupadd oinstall 
useradd oracle -g oinstall -G dba 
passwd oracle 
(密码为maximo)
mkdir -p /opt/oracle/product/10g
mkdir /opt/oracle/database
chown -R oracle.oinstall /opt/oracle
chmod 755 -R /opt/oracle
```

#### 2， 配置环境变量； 
使用第一步创建的用户名Oracle登陆: 
```Shell
su oracle 
vi ~/.bash_profile 
```
修改以下是配置文件的内容
```Shell
export ORACLE_BASE=/home/oracle/oracle/
export ORACLE_HOME=/home/oracle/oracle/product/10.2.0/db_1
export ORACLE_SID=orcl(可随意定义)
export PATH=$ORACLE_HOME/bin:$PATH
```

ESC(退出vi的编辑环境)
<br>
:wq(退出vi应用程序并保存修改)
<br>
配置好后用 source .bash_profile 命令使配置生效

我的內容
```Shell
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export ORACLE_BASE=/home/oracle/oracle/
export ORACLE_HOME=/home/oracle/oracle/product/10.2.0/db_1
export ORACLE_SID=orcl
export PATH=$ORACLE_HOME/bin:$PATH
```



## 四.设置系统参数；
Oracle 数据库 10g 需要以下所示的内核参数设置。
<br />
其中给出的是最小值，因此如果您的系统使用的值较大，则不要更改它。
<br />
切换到root用户:
```Shell
su root 
```
##### a) 修改/etc/sysctl.conf(vi /etc/sysctl.conf), 添加： 

```Shell
kernel.shmmax = 2147483648
kernel.shmmni = 4096 
kernel.shmall = 2097152 
kernel.sem = 250 32000 100 128 
fs.file-max = 65536 
net.ipv4.ip_local_port_range = 1024 65000 
net.core.rmem_default=262144
net.core.rmem_max=262144
net.core.wmem_default=262144
net.core.wmem_max=262144
```

修改后运行"/sbin/sysctl -p"命令使得内核改变立即生效； 

##### B) 设置oracle对文件的要求： 
编辑文件：vi /etc/security/limits.conf 加入以下语句： 
```
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
```
编辑文件：vi /etc/pam.d/login 加入以下语句(可能应该加在最后一条规则之前）:
```
session required /lib/security/pam_limits.so
```

安装Oralce10G


## （一）开始安装： 
```Shell
su 
unzip 10201_database_linux32.zip -d /tmp/database
chmod 755 -R /tmp/database
cd /tmp/database/database
su oracle
echo LANG   查看系统语言  zh_CN.UTF-8
export LANG=en_US 设置系统语言为英文,解决乱码
./runInstaller -ignoresysprereqs 跳过系统版本验证 
```
ORACLE安装图解 格式采用 AMERICAN_AMERICA.ZHS16GBK
<br />
http://www.hackvip.com/article/sort0132/sort0165/Hackvip_194399.html
<br />
export LANG=zh_CN.UTF-8  將系統語言改回中文
<br />
配置監聽  netmgr 在Linux/Unix下，利用netmgr命令来启动图形化Oracle网络管理器
<br />
/home/oracle/oracle/product/10.2.0/db_1/network/admin/listener.ora
啓動監聽
```Shell
lsnrctl start
```
檢查監聽
```Shell
lsnrctl status
```
查看監聽是否啓動 PLSExtProc
```Shell
netstat -ant
```
關閉監聽
```Shell
lsnrctl stop
```
启动isqlplus服务
```Shell
isqlplusctl start
```
停止isqlplus服务
```Shell
isqlplusctl stop
```
啓動數據庫
```Shell
sqlplus /nolog
connect system/maximo  帳號/密碼
connect /as sysdba  如果提示權限不足請查看下面監聽配置中的sqlnet.ora
shutdown immediate 关闭数据库
startup 啓動數據庫
```
启动oem服务
```Shell
emctl start dbconsole
```
停止oem服务
```Shell
emctl stop dbconsole
```

isqlplusctl服務亂碼
<br />
先关闭服务
```Shell
isqlplusctl stop
emctl stop dbconsole
```
再在三个目录中执行下面两句
```Shell
cp font.properties font.properties.bak
cp ./font.properties.zh_CN.Redhat ./font.properties
```
三个目录位置为
```
 $ORACLE_HOME/jre/1.4.2/lib/font.properties
 $ORACLE_HOME/jdk/jre/lib/font.properties
 $ORACLE_HOME/javavm/lib/ojvmfonts/font.properties
```
msyh微软雅黑字体下载我已经改名为zysong.ttf,直接放在/usr/share/fonts/zh_CN/TrueType下面即可
<br>
http://115.com/file/c24t6qvd#
<br>
很多方法是修改配置文件中的路径,我这人比较懒,就改下文件名可以了
<br>
此方法来自http://www.boobooke.com/bbs/thread-21005-1-1.html
<br>
删除缓存isqlplus的gif图片及imx
```Shell
rm -f $ORACLE_HOME/oc4j/j2ee/oc4j_applications/applications/isqlplus/isqlplus/cabo/images/cache/zhs/*
```
删除缓存em的gif图片及imx
```Shell
rm -f $ORACLE_HOME/oc4j/j2ee/oc4j_applications/applications/em/em/cabo/images/cache/zhs/*.gif
```
开启服务
```Shell
isqlplusctl start
emctl start dbconsole
```

iSQL*Plus URL: http://localhost:5560/isqlplus

iSQL*Plus DBA URL: http://localhost:5560/isqlplus/dba

Enterprise Manager 10g Database Control URL: http://localhost:1158/em

導庫
```Shell
cp /media/usr/lydate/20111115.dmp /tmp/oracle/
chmod 777 /tmp/oracle/20111115.dmp
imp maximo/maximo@orcl  file=/tmp/oracle/20111115.dmp full=y ignore=y
```

查看數據庫字符集編碼類型
```Shell
 select userenv ('language') from dual;
AMERICAN_AMERICA.AL32UTF8  本機
AMERICAN_AMERICA.ZHS16GBK  165
```
创建一个EM资料库
```Shell
emca -repos create
[root@fedora emca]# emca -repos create

EMCA 开始于 2011-12-20 10:34:17
EM Configuration Assistant 10.2.0.1.0 正式版
版权所有 (c) 2003, 2005, Oracle。保留所有权利。
```

输入以下信息:
```
数据库 SID: orcl
监听程序端口号: 1521
SYS 用户的口令:  sys
SYSMAN 用户的口令:  sysman
```

重建一个EM资料库
```Shell
emca -repos recreate
```
删除一个EM资料库
```Shell
emca -repos drop
```
配置数据库的 Database Control
```Shell
emca -config dbcontrol db(未配置成功)
```
输入以下信息:
```
数据库 SID: orcl
监听程序端口号: 1521
SYS 用户的口令:  sys
DBSNMP 用户的口令:  maximo
SYSMAN 用户的口令:  maximo
通知的电子邮件地址 (可选): jiangasus163@163.com
通知的发件 (SMTP) 服务器 (可选): smtp.163.com
```

删除数据库的 Database Control配置
```Shell
emca -deconfig dbcontrol db
```
重新配置db control的端口，默认端口在1158
```Shell
emca -reconfig ports
emca -reconfig ports -dbcontrol_http_port 1160
emca -reconfig ports -agent_port 3940
```
先设置ORACLE_SID环境变量后,启动EM console服务
```Shell
emctl start dbconsole
```
先设置ORACLE_SID环境变量后,停止EM console服务
```Shell
emctl stop dbconsole
```
先设置ORACLE_SID环境变量后,查看EM console服务的状态
```Shell
emctl status dbconsole
```

配置dbconsole的步骤
```Shell
emca -repos create
emca -config dbcontrol db
emctl start dbconsole
```
重新配置dbconsole的步骤
```Shell
emca -repos drop
emca -repos create
emca -config dbcontrol db
emctl start dbconsole
```


错误：
```
Exception java.lang.UnsatisfiedLinkError: /tmp/OraInstall2011-12-19_06-42-41PM/jre/1.4.2/lib/i386/libawt.so: libXp.so.6: cannot open shared object file: No such file or directory occurred..
java.lang.UnsatisfiedLinkError: /tmp/OraInstall2011-12-19_06-42-41PM/jre/1.4.2/lib/i386/libawt.so: libXp.so.6: cannot open shared object file: No such file or directory
```
解决方法
```Shell
yum install libXp*
```


在Linux系统要远程连接oracle的防火墙设置方法：

打开5801至5810 端口用于vnc

```Shell
iptables -I INPUT -p tcp --dport 5801:5810 -j ACCEPT

iptables -I INPUT -p tcp --dport 5901:5910 -j ACCEPT

iptables -A INPUT -p tcp --dport 5801:5810 -j ACCEPT
iptables -A INPUT -p tcp --dport 5901:5910 -j ACCEPT
```

打开1521 端口用于oracle

```Shell
iptables -I INPUT -p tcp --dport 1521 -j ACCEPT
iptables -A INPUT -p tcp --dport 1521 -j ACCEPT
iptables -I INPUT -p tcp --dport 5560 -j ACCEPT
iptables -A INPUT -p tcp --dport 5560 -j ACCEPT
iptables -I INPUT -p tcp --dport 1158 -j ACCEPT
iptables -A INPUT -p tcp --dport 1158 -j ACCEPT
```

永久保存
```Shell
service iptables save
```
