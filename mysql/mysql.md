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


### 虚拟列
```
drop table if exists test_virtual;
create table test_virtual
(
    test_virtual_id bigint(20) unsigned auto_increment comment '库存表 主键' primary key,
    amount               double(20, 2)   default '0' not               null comment '数量',
    line_cost            double(20, 2)    default '0' not               null comment '行成本'
)
 engine = innodb default charset = utf8mb4 auto_increment = 1000   comment '测试虚拟字段';
alter table test_virtual add item_cost double(20,2) generated always as (if(amount=0,0,line_cost/amount)) comment '单位成本' after test_virtual_id;
```
