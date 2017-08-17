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
drop Index LSIGOPTIONDES_TIDX;
```

#### 使用拥有sysdba权限的用户启用ctxsys用户
```Sql
-- USER SQL
ALTER USER "CTXSYS" IDENTIFIED BY "ctxsys" 
DEFAULT TABLESPACE "SYSAUX"
TEMPORARY TABLESPACE "TEMP"
ACCOUNT UNLOCK ;

-- QUOTAS

-- ROLES
ALTER USER "CTXSYS" DEFAULT ROLE "CTXAPP","RESOURCE";

-- SYSTEM PRIVILEGES

```

#### 使用ctxsys用户登录授权maximo用户
```Sql
 grant execute on ctx_ddl to maximo;
```

#### 使用maximo用户登录建立索引
```Sql

  CREATE INDEX "LSIGOPTIONDES_TIDX" ON "L_SIGOPTION" ("DESCRIPTION") 
   INDEXTYPE IS "CTXSYS"."CONTEXT"  PARAMETERS ('lexer global_lexer language column LANGCODE');
```
