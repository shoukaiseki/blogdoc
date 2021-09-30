# mysql

## 复制表

### mysql 8.0需要复制表结构之后
```
create table sys_user_bak like sys_user;
insert into sys_user_bak select * from sys_user;
```

### 修改字符集

修改表字符集
```
ALTER TABLE sys_user DEFAULT CHARACTER SET utf8mb4;
```


#### 修改字段字符集
修改remark 字段的字符集
```
ALTER TABLE sys_user  modify remark  varchar(500) CHARACTER SET utf8mb4  default '' null comment '备注'
```


## 异常
### DuplicateKeyException
唯一索引冲突


##生成随机数
```
update inventory_balance set sort=rand()*1000 ,item_feature='' where 1=1;

update inventory_item set item_sort=rand()*1000,item_feature='' where 1=1;
update inventory_item set create_time=concat('2021-01-01 ', floor(10+rand()*10),':',floor(10+rand()*49),':',floor(10+rand()*49)) where 1=1;

update inventory_item set item_sort=rand()*2,item_feature=if(item_sort=0,'sell',if(item_sort=1,'use','raw')) where 1=1;



```

## 随即时间
```
       -- 起始时间 结束时间-起始时间
SELECT UNIX_TIMESTAMP(),
       FROM_UNIXTIME(UNIX_TIMESTAMP('20200223100000')),
       UNIX_TIMESTAMP()-UNIX_TIMESTAMP('20200323000000'),
       FROM_UNIXTIME(UNIX_TIMESTAMP('20200223000000')+ROUND(RAND()*(UNIX_TIMESTAMP('20200323000000')-UNIX_TIMESTAMP('20200223000000'))));
```


## 最大时间戳
时间戳转换最大值是 2038-01-19 11:14:07
```
-- 成功
select  UNIX_TIMESTAMP('2038-1-19 11:14:7'),FROM_UNIXTIME(2147483647)  ;
-- 失败
select  UNIX_TIMESTAMP('2038-1-19 11:14:8'),FROM_UNIXTIME(2147483648)  ;
```
