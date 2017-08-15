# oracle undo表空间大小调整  

参考资料: http://blog.sina.com.cn/s/blog_7e04e0d00101j203.html
<br />
          http://blog.csdn.net/lwei_998/article/details/6537066

```Sql

--检查是否还有事务存在
select  count(*) from  v$transaction;

--创建UNDO表空间
create undo tablespace UNDOTBS2 datafile '/orabase/oradata/orcl/UNDOTBS101.DBF' size 4G;

--切换UNDO表空间
alter system set undo_tablespace=UNDOTBS2 scope=both;

--等待旧的undo表空间事物全部结束后执行：
--变更表空间文件为无效
alter database datafile  '/orabase/oradata/orcl/undotbs01.dbf' offline;
alter database datafile  '/orabase/oradata/orcl/undotbs01.dbf' offline drop ; 
--删除UNDO表空间及数据文件
drop tablespace UNDOTBS1 including contents and datafiles;
```
