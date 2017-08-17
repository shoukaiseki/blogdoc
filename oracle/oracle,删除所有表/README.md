# oracle,删除所有表  

以下方法本人试过，在sqlplus下最好用的删除，还原方法是：
<br />
把删除表，写成脚本：
```
　　SQL>SET HEAD OFF 

　　SQL>SPOOL  /tmp/database/drop_tables.sql 

　　SQL>select 'drop table '||table_name||';' from user_tables; 

　　SQL>spool off; 

　　SQL>@/tmp/database/drop_tables.sql; 

　　SQL >@drop_tables.sql 
```



然后再还原数据。
```Shell
imp maximo/maximo@orcl fromuser=maximo touser=maximo file=21时14分34秒.dmp  tablespaces=tablespaces
```


斷開所有已連接到數據庫的用戶
<br />
查看所有已經連接的用戶select * from v$session where username is not null; ; 

斷開連接到MAXIMO用戶的連接
```

　　SQL>SET HEAD OFF 

　　SQL>SPOOL  /tmp/database/killusers.sql 

　　SQL>select 'alter system kill session '''||sid||','||serial#||''';' from v$session where username='MAXIMO'; 

　　SQL>spool off; 

　　SQL>@/tmp/database/killusers.sql; 

　　sql >@killuser.sql
```
