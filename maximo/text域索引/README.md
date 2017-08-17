# text域索引

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/text%E5%9F%9F%E7%B4%A2%E5%BC%95/img/001.png)


## 类似以下错误

```
ORA-29861: 域索引标记为 LOADING/FAILED/UNUSABLE
```

```
ORA-20000: Oracle Text error:
DRG-10599: 列没有编制索引
20000. 00000 -  "%s"
*Cause:    The stored procedure 'raise_application_error'
           was called which causes this error to be generated.
*Action:   Correct the problem as described in the error message or contact
           the application administrator or DBA for more information.
```

```
CREATE INDEX "LSIGOPTIONDES_TIDX" ON "L_SIGOPTION" ("DESCRIPTION") 
   INDEXTYPE IS "CTXSYS"."CONTEXT"  PARAMETERS ('lexer global_lexer language column LANGCODE')
错误报告 -
SQL 错误: ORA-29855: 执行 ODCIINDEXCREATE 例行程序时出错
ORA-20000: Oracle Text 错误:
DRG-10700: 首选项不存在: global_lexer
ORA-06512: 在 "CTXSYS.DRUE", line 160
ORA-06512: 在 "CTXSYS.TEXTINDEXMETHODS", line 366
29855. 00000 -  "error occurred in the execution of ODCIINDEXCREATE routine"
*Cause:    Failed to successfully execute the ODCIIndexCreate routine.
*Action:   Check to see if the routine has been coded correctly.
```

## 处理方案

### 以L_SIGOPTION表为例
#### 删除索引
```Sql
alter session set current_schema =MAXIMO;--或者使用sysdba切换session到CTXSYS用户
drop Index LSIGOPTIONDES_TIDX;
```

#### 使用拥有sysdba权限的用户启用ctxsys用户
https://github.com/shoukaiseki/blogdoc/tree/master/maximo/%E9%A6%96%E9%80%89%E9%A1%B9%E4%B8%8D%E5%AD%98%E5%9C%A8%20global_lexer
```Sql
alter session set current_schema =sys;--切换session到sys用户
begin Ctx_Ddl.Create_Preference ('global_lexer','CHINESE_VGRAM_LEXER'); end;
-- USER SQL
ALTER USER "CTXSYS" IDENTIFIED BY "ctxsys" 
DEFAULT TABLESPACE "SYSAUX"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK ;

-- 角色添加
ALTER USER "CTXSYS" DEFAULT ROLE "CTXAPP","RESOURCE";


```

#### 使用ctxsys用户登录授权maximo用户
```Sql
alter session set current_schema =CTXSYS;--或者使用sysdba切换session到CTXSYS用户
grant execute on ctx_ddl to maximo;
```

#### 使用maximo用户登录建立索引
```Sql
alter session set current_schema =MAXIMO;--或者使用sysdba切换session到CTXSYS用户
  CREATE INDEX "LSIGOPTIONDES_TIDX" ON "L_SIGOPTION" ("DESCRIPTION") 
   INDEXTYPE IS "CTXSYS"."CONTEXT"  PARAMETERS ('lexer global_lexer language column LANGCODE');
```


## 直接用sys执行自动切换用户的指令
```Sql
alter session set current_schema =sys;--切换session到sys用户
call ctx_ddl.drop_preference('global_lexer');  
call ctx_ddl.drop_preference('default_lexer');  
call ctx_ddl.drop_preference('english_lexer');  
call ctx_ddl.drop_preference('chinese_lexer');  
call ctx_ddl.drop_preference('japanese_lexer');  
call ctx_ddl.drop_preference('korean_lexer');  
call ctx_ddl.drop_preference('german_lexer');  
call ctx_ddl.drop_preference('dutch_lexer');  
call ctx_ddl.drop_preference('swedish_lexer');  
call ctx_ddl.drop_preference('french_lexer');  
call ctx_ddl.drop_preference('italian_lexer');  
call ctx_ddl.drop_preference('spanish_lexer');  
call ctx_ddl.drop_preference('portu_lexer');  
call ctx_ddl.create_preference('default_lexer','basic_lexer');  
call ctx_ddl.create_preference('english_lexer','basic_lexer');  
call ctx_ddl.create_preference('chinese_lexer','chinese_lexer');  
call ctx_ddl.create_preference('japanese_lexer','japanese_lexer');  
call ctx_ddl.create_preference('korean_lexer','korean_morph_lexer');  
call ctx_ddl.create_preference('german_lexer','basic_lexer');  
call ctx_ddl.create_preference('dutch_lexer','basic_lexer');  
call ctx_ddl.create_preference('swedish_lexer','basic_lexer');  
call ctx_ddl.create_preference('french_lexer','basic_lexer');  
call ctx_ddl.create_preference('italian_lexer','basic_lexer');  
call ctx_ddl.create_preference('spanish_lexer','basic_lexer');  
call ctx_ddl.create_preference('portu_lexer','basic_lexer');  
call ctx_ddl.create_preference('global_lexer', 'multi_lexer');  
call ctx_ddl.add_sub_lexer('global_lexer','default','default_lexer');  
call ctx_ddl.add_sub_lexer('global_lexer','english','english_lexer','en');  
call ctx_ddl.add_sub_lexer('global_lexer','simplified chinese','chinese_lexer','zh');  
call ctx_ddl.add_sub_lexer('global_lexer','japanese','japanese_lexer',null);  
call ctx_ddl.add_sub_lexer('global_lexer','korean','korean_lexer',null);  
call ctx_ddl.add_sub_lexer('global_lexer','german','german_lexer','de');  
call ctx_ddl.add_sub_lexer('global_lexer','dutch','dutch_lexer',null);  
call ctx_ddl.add_sub_lexer('global_lexer','swedish','swedish_lexer','sv');  
call ctx_ddl.add_sub_lexer('global_lexer','french','french_lexer','fr');  
call ctx_ddl.add_sub_lexer('global_lexer','italian','italian_lexer','it');  
call ctx_ddl.add_sub_lexer('global_lexer','spanish','spanish_lexer','es');  
call ctx_ddl.add_sub_lexer('global_lexer','portuguese','portu_lexer',null);  

alter session set current_schema =MAXIMO;--或者使用sysdba切换session到CTXSYS用户
drop Index LSIGOPTIONDES_TIDX;

alter session set current_schema =sys;--切换session到sys用户
-- USER SQL
ALTER USER "CTXSYS" IDENTIFIED BY "ctxsys" 
DEFAULT TABLESPACE "SYSAUX"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK ;

-- 角色添加
ALTER USER "CTXSYS" DEFAULT ROLE "CTXAPP","RESOURCE";


alter session set current_schema =CTXSYS;--或者使用sysdba切换session到CTXSYS用户
grant execute on ctx_ddl to maximo;



alter session set current_schema =MAXIMO;--或者使用sysdba切换session到CTXSYS用户
  CREATE INDEX "LSIGOPTIONDES_TIDX" ON "L_SIGOPTION" ("DESCRIPTION") 
   INDEXTYPE IS "CTXSYS"."CONTEXT"  PARAMETERS ('lexer global_lexer language column LANGCODE');
   
   
   select * from L_SIGOPTION  where ( contains(DESCRIPTION,'  $Search  ') > 0 );
```
