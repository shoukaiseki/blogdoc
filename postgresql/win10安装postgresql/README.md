# win10安装postgresql

##### 安装到最后报以下错误

Problem running post-install step. Installation may not complete correctly. The database cluster initialisation failed.


发现服务没有,实例也没有,那就手动来


首先创建一个用户  右击  计算机->管理->本地用户和组->用户   新建个 postgres 用户

管理员方式运行命令行


```Bat
cd /D E:\PostgreSQL\PostgreSQL\10\bin
pg_ctl register -N PostgreSQL  -D "E:\PostgreSQL\PostgreSQL\10\data"
set PGDATA=E:\PostgreSQL\PostgreSQL\10\data
initdb
pg_ctl -D E:\PostgreSQL\PostgreSQL\10\data start
```

打开新的命令行窗口(不需要管理员)

```Bat
cd /D E:\PostgreSQL\PostgreSQL\10\bin
psql -d postgres
```

连接上了,先查个时间看下数据库是否正常

```Bat
select now();
```

## 创建数据库新用户
```Bat
CREATE USER dbuser WITH PASSWORD '123456';
```

## 创建用户数据库
```Bat
CREATE DATABASE exampledb OWNER dbuser;
```
## 将exampledb数据库的所有权限都赋予dbuser
```Bat
GRANT ALL PRIVILEGES ON DATABASE exampledb TO dbuser;
```

## 使用命令 \q 退出psql

```Bat
\q
```

然后再用 E:\PostgreSQL\PostgreSQL\10\pgAdmin 4\pgAdmin4.exe 开启web客户端

