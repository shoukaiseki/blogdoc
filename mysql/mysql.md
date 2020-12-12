# mysql





#### 查询连接的用户
```
SELECT substring_index(host, ':',1) AS host_name,state,count(*) FROM information_schema.processlist GROUP BY state,host_name;

select * FROM information_schema.processlist
```


###  查询表注释
```sql
select table_schema, table_name, table_comment from information_schema.tables where table_schema = 'xxx' and table_name = 'xxx';
```


###  查询表字段注释
```sql
select table_schema, table_name, column_name, column_comment from information_schema.columns where table_schema = 'xxx' and table_name = 'xxx';

select distinct column_name, column_comment from information_schema.columns where column_comment is not null and column_comment != ''
```
