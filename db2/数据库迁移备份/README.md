# 数据库迁移备份

运行DB2 命令行工具

```Shell
mkdir C:\database
cd  C:\database
db2move maxdb export
```

导入
```Shell
db2move maxdb import
```


```Sql
create database maxdb on 'C:\DB2\NODE0000\MAXDB' using codeset UTF-8 territory CN
```

如果出现 SQL1052N 数据库路径 "C:\DB2\NODE0000\MAXDB" 不存在。 错误则不需要加路径

```Sql
create database maxdb  using codeset UTF-8 territory CN
```

#### 授权 运行 db2 之后执行以下语句
```Sql
grant connect on database to user  db2admin 

connect to  maxdb

grant connect on database to user db2admin

grant dbadm on database to user  db2admin
```

#### 删除数据库
运行db2命令窗口后执行
```Sql
db2 catalog db maxdb
db2 terminate
db2 drop db maxdb
db2 create db maxdb
```



### 方式3:全库导出
运行db2命令行工具后执行
```Shell
db2 backup db maxdb user db2admin using mima to c:\abc\def
```

```Shell
db2 restore db maxdb user db2admin using mima from C:\db2_bak\db2_bak
```
