# mysql-8.0.21绿色版安装

参考 https://blog.csdn.net/confoo/article/details/89398124

##  路径信息
下载的压缩包解压后路径为 D:\usr\mysql-8.0.21-winx64


### 在 D:\usr\mysql-8.0.21-winx64\bin 新建 my.ini
```Ini
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
```

在环境变量PATH中添加：D:\usr\mysql-8.0.21-winx64\bin;



以管理员权限运行CMD

输入命令：
```
cd /D D:\usr\mysql-8.0.21-winx64\bin
mysqld --defaults-file=my.ini --initialize-insecure
mysqld --install
```
