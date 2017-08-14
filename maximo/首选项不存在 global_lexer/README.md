# 首选项不存在: global_lexer 

```
ORA-29855: 执行 ODCIINDEXCREATE 例行程序时出错
ORA-20000: Oracle Text 错误:
DRG-10700: 首选项不存在: global_lexer
ORA-06512: 在 "CTXSYS.DRUE", line 160
ORA-06512: 在 "CTXSYS.TEXTINDEXMETHODS", line 364
```


执行

```Sql
begin Ctx_Ddl.Create_Preference ('global_lexer','CHINESE_VGRAM_LEXER'); end;
```

ctxsys用户必须启用,默认是关闭的

用 ctxsys用户登录执行  grant execute on ctx_ddl to maximo_75;

全文索引

```Sql
select * from person  where ( contains(displayname,'  $陈  ') > 0 );
```

创建person表DISPLAYNAME字段的全文索引

```Sql
 create index PERSON_NDX8 on PERSON ("DISPLAYNAME") 
   INDEXTYPE IS "CTXSYS"."CONTEXT"  PARAMETERS ('lexer global_lexer language column LANGCODE');
```
