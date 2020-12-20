# Mysql8.0用户授权命令

##### 注意
从MySQL 8开始，您不再可以（隐式）使用该GRANT命令创建用户。请改用CREATE USER，然后使用GRANT语句：

```
-- 创建用户
CREATE USER 'root'@'%' IDENTIFIED BY '@123qwe';
-- 授权
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';


-- 删除用户
drop user root@'%';
```

```sql
-- create database ruoyi character set utf8;
create database ruoyi character set utf8mb4;

create user 'ruoyi'@'%' identified by '123abc';

grant all privileges on ruoyi.* to 'ruoyi'@'%';


flush privileges;
```
