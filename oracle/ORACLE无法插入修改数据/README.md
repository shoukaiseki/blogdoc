# ORACLE无法插入修改数据  

Java代码
```
ora-29861:域索引标记为loading/failed/unusable  
```
 网上多数解释是说这个索引有问题了，但是这个索引根本没有问题，同步和重建这个索引都不能解决这个问题，知道我看到有人说是采用这样的方法查看索引的状态
<br />
Sql代码
```Sql
select * from sys.all_indexes t where t.owner='CTXSYS' AND T.INDEX_TYPE='DOMAIN';  
```
Sql代码
```Sql
select owner,index_name from all_indexes where domidx_status != 'VALID' or domidx_opstatus !='VALID';  
```
 无法插入表
```Sql
select * from sys.all_indexes t where t.owner='MAXIMO' AND T.INDEX_TYPE='DOMAIN' AND TABLE_NAME='HAZARD';
```
--用户名(OWNER)=MAXIMO,表名(TABLE_NAME)=HAZARD,索引类型(INDEX_TYPE)=DOMAIN
```Sql
select owner,index_name from all_indexes where domidx_status != 'VALID' or domidx_opstatus !='VALID';
```
--VALID为该索引不可用的意思
<br />
可以使用 DROP INDEX HAZARD_NDX2 删除索引名,然后再重建索引,HAZARD_NDX2 是索引名

oracle的索引逻辑上：
```
Single column   单行索引
Concatenated     多行索引
Unique    唯一索引
NonUnique    非唯一索引
Function-based   函数索引
Domain    域索引

物理上：
Partitioned 分区索引
NonPartitioned 非分区索引

B-tree：
Normal 正常型B树
Rever Key 反转型B树 
Bitmap 位图索引
```

