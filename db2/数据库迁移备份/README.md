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

SQL2542N  根据所提供的源数据库别名 "MAXDB" 和时间戳记 
""，找不到与数据库映像文件相匹配的文件。

文件名为 MAXDB76.0.DB2.DBPART000.20170608095935.001 ,则数据库名称为 maxdb76 ,最后使用 into maxdb 恢复到 maxdb 数据库

```Shell
db2 restore db maxdb76  user db2admin using maximo7.6 from C:\db2_bak\DB2_bak into maxdb
```
