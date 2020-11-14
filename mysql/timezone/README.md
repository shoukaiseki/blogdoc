# timezone

mybatis插入会按照时区进行调整后插入数据，而 jackson.time-zone: GMT+8 会按照读取时候进行格式化显示，而datagrip等数据库管理工具基本插入/修改/查询时候不会进行时区转换，处理的都是数据库实际存储的数据

所以 serverTimezone 设置在mybatis是插入生效的，设置错误会导致insert时候的值与datagrip查询出来不同


```
# mysql安装在linux系统
serverTimezone=UTC 
# mysql安装在时区为+8区的win系统
serverTimezone=GMT%2B8
```

serverTimezone设置不正确虽然在前端看到的和新增/修改的时间一致，但是在使用 between 等查询时就会发现查询出来数据不对
```Sql
-- 前端字符串传递过来的时间进行查询会出现错误
create_time between CONCAT(#{beginCreateTime},' 00:00:00') and CONCAT(#{endCreateTime},' 23:59:59')
-- 或者
create_time between '2020-11-19 00:00:00' and '2020-11-19 23:59:59'
```

除非使用jdbc中的Timestap参数进行查询，虽然未测试改方案，但是可行性很高，不过得修改好多东西，所以就没有测试
```Sql
create_time between ? and ?
```

## mybatis中设置的serverTimezone=UTC为数据库服务器的时间
数据库服务器为linux情况下，基本都是用 serverTimezone=UTC 

而如果你的mysql是在windows运行的，那么必须按照数据库服务器所在的时区格式进行设置，国内基本使用 serverTimezone=GMT%2B8 也就是+8区，实际自行查看

```
serverTimezone=GMT%2B8
```
### 注意
windows是设值UTC存在一定误区,网上说的修改注册表（方法如下），只是使用硬件UTC计时方式,时区还是需要手动去修改时区为  （UTC)+00:00圣多美 

而修改时候服务器时间就会变成少了8小时,那是UTC标准时间，你不能去调整这个时间,只能习惯这个时间，时间不一致会导致一定的问题
```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]

"RealTimeIsUniversal"=dword:00000001
```

my.ini
```ini
[mysql]
 
# 设置mysql客户端默认字符集
 
default-character-set=utf8
 
[mysqld]
 
# 设置3306端口
 
port=3306
 
# 设置mysql的安装目录
 
basedir=D:\usr\mysql-8.0.21-winx64\
 
# 设置mysql数据库的数据的存放目录
 
datadir=D:\usr\mysql-8.0.21-winx64\data
 
# 允许最大连接数
 
max_connections=200
 
# 服务端使用的字符集默认为8比特编码的latin1字符集
 
character-set-server=utf8
 
# 创建新表时将使用的默认存储引擎
 
default-storage-engine=INNODB

default-time-zone='+00:00'
```

## mybatis在插入时间时会使用对比springboot运行的服务器时间与数据库时间，进行时间差转换
原理是mybatis会将Date转换为Timestamp进行设置值，而Timestamp是存在时区转换的



