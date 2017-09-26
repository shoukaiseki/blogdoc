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
