# mysql


### 修改表锁时间

```
SHOW GLOBAL VARIABLES LIKE 'lock_wait_timeout';
SHOW GLOBAL VARIABLES LIKE 'innodb_lock_wait_timeout';
set global lock_wait_timeout= 300;

```



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


### 触发器
##### [HY000][1419] You do not have the SUPER privilege and binary logging is enabled (you *might* want to use the less safe log_bin_trust_function_creators variable)
如果报该错误,需用root用户执行
```sql
set global log_bin_trust_function_creators = 1;

```

#### 更新时 rowstamp 自增

```sql
DROP TRIGGER IF EXISTS inventory_balance_rowstamp;
create trigger inventory_balance_rowstamp before update on inventory_balance FOR EACH ROW
begin
    set @rowstamp= old.rowstamp;
    set NEW.rowstamp=@rowstamp+1;
end;
```
mybatis 中更新时也写上自增,双重保护

```xml
	update inventory_balance
	set rowstamp=rowstamp+1
		,amount=#{amount}
		,line_cost = #{lineCost}
	<where>
		rowstamp=rowstamp
		and inventory_balance_id = #{inventoryBalanceId}
	</where>
```
