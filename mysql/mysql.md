# mysql





#### 查询连接的用户
```
SELECT substring_index(host, ':',1) AS host_name,state,count(*) FROM information_schema.processlist GROUP BY state,host_name;

select * FROM information_schema.processlist
```
