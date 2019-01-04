# Mysql8.0用户授权命令

##### 注意
从MySQL 8开始，您不再可以（隐式）使用该GRANT命令创建用户。请改用CREATE USER，然后使用GRANT语句：

```
-- 创建用户
CREATE USER 'root'@'%' IDENTIFIED BY '@H666777kd';
-- 授权
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';


-- 删除用户
drop user root@'%';
```

