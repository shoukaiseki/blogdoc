# AlibabaCloudLinux安装mysql
来源 https://help.aliyun.com/document_detail/178136.html
## 安装MySQL
### 运行以下命令更新YUM源。
```shell
rpm -Uvh https://repo.mysql.com//mysql80-community-release-el8-1.noarch.rpm
```

如果安装错了更新源,就以下命令删除
```
[root@iZbp111cqx7ixlac3kfozjZ lib]# rpm -qa|grep mysql
mysql57-community-release-el7-9.noarch
[root@iZbp111cqx7ixlac3kfozjZ lib]# rpm -e mysql57-community-release
```
接着就用可以yum安装了
```
yum -y install mysql-community-server
```




### yum安装不了就自己下包安装
https://blog.csdn.net/qq_22183465/article/details/85211342

wget https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.22-linux-glibc2.17-x86_64-minimal.tar.xz
```
mysqld  --initialize
mysqld  --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql/data  --lower-case-table-names=1
```

--lower-case-table-names=1 为表名查询时大小写不敏感，mysql8.0以上只有初始化数据库时候设置有效，初始化之后不能再做更改
							windows下该配置要设置为0

```
2020-11-23T12:37:16.338737Z 0 [System] [MY-013169] [Server] /usr/local/mysql/bin/mysqld (mysqld 8.0.22) initializing of server in progress as process 1541
2020-11-23T12:37:16.338761Z 0 [ERROR] [MY-010338] [Server] Can't find error-message file '/data/mysql/mysql-8.0.22/share/errmsg.sys'. Check error-message file location and 'lc-messages-dir' configuration directive.
2020-11-23T12:37:16.355849Z 1 [System] [MY-013576] [InnoDB] InnoDB initialization has started.
2020-11-23T12:37:16.947356Z 1 [System] [MY-013577] [InnoDB] InnoDB initialization has ended.
2020-11-23T12:37:18.368564Z 6 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: ;Vq7yC<yyo#A
```

如果提示“initialize specified but the data directory has files in it. Aborting”，大意是提示data目录有文件，搞不定了。。。
大胆尝试一下，把mysql安装目录(/var/my.cnf 配置的)data文件夹里的内容清空（建议读者备份到其他地方）。再次执行"mysqld  --initialize"，没有报错了！


最后用命令启动服务
```
./mysqld --user=root
```

#创建一个软连接也可以
cd /usr/local/mysql/
cp support-files/mysql.server /etc/init.d/mysql






mysqladmin 登陆不了，执行以下命令
```
ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock
```



```sql
update user set host = '%' where user = 'root';
```



```
create database test character set utf8;
create user 'test'@'%' identified by 'test123';
grant all privileges on test.* to 'test'@'%';
flush privileges;
```


##### my.cnf
```
[mysql]
 
# 设置mysql客户端默认字符集
#  
default-character-set=utf8


[mysqld]
#datadir=/var/lib/mysql
datadir=/data/mysql/data
socket=/var/lib/mysql/mysql.sock
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0
# Settings user and group are ignored when systemd is used.
# If you need to run mysqld under a different user or group,
# customize your systemd unit file for mariadb according to the
# instructions in http://fedoraproject.org/wiki/Systemd
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid
#skip-grant-tables

character-set-server=utf8

default-storage-engine=INNODB

lower_case_table_names = 1

[mysqld_safe]
#log-error=/data/log/mariadb/mariadb.log
#pid-file=/data/run/mariadb/mariadb.pid

#
# include all files from the config directory
#
#!includedir /etc/my.cnf.d
```



创建mysql组和用户，没有目录文件就新建
```
groupadd mysql
useradd -r -g mysql mysql
chown -R mysql:mysql /var/lib/mysql
chown mysql:mysql /var/log/mysqld.log
chown mysql:mysql /var/run/mysqld/mysqld.pid
```



## 错误解决方案
安装完成不要用试着用root运行 mysqld ，不然会出现service启动失败

Starting MySQL. ERROR! The server quit without updating PID file (/var/run/mysqld/mysqld.pid).

ERROR! The server quit without updating PID file (/var/run/mysqld/mysqld.pid).

出现以上错误可以看my.cnf中配的日志文件看日志信息，基本是权限问题，需要重新授权
```shell
chown -R mysql.mysql /data/mysqldata
chown -R mysql:mysql /var/lib/mysql/mysql.sock
chown -R mysql:mysql /var/log/mysqld.log
chown -R mysql:mysql /var/run/mysqld/mysqld.pid
```
