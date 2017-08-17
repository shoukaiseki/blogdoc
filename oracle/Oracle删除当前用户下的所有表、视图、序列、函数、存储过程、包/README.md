# Oracle删除当前用户下的所有表、视图、序列、函数、存储过程、包

```Sql
--以下方法1,3本人试过，在sqlplus下最好用的删除，还原方法是：
--把删除表，写成脚本：
--************************
--**方法1
--************************
--在终端依次输入以下命令
sqlplus
--输入需要删除的用户名
--输入密码
SET HEAD OFF 
SPOOL  /tmp/database/drop_tables.sql 

--chr(13) ASCII中=换行  chr(10) ASCII中=回车
--delete tables 
select 'drop table ' || table_name ||';'||chr(13)||chr(10) from user_tables;   
--delete views 
select 'drop view ' || view_name||';'||chr(13)||chr(10) from user_views;   


--delete seqs 
select 'drop sequence ' || sequence_name||';'||chr(13)||chr(10) from user_sequences;  


--delete functions 
select 'drop function ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='FUNCTION';   


--delete procedure 
select 'drop procedure ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='PROCEDURE';   


--delete package 
select 'drop package ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='PACKAGE';   

--delete trigger
SELECT 'drop TRIGGER "' ||SYS_CONTEXT('USERENV','CURRENT_USER')||'"."'|| TRIGGER_NAME ||'";' ||CHR(13) ||CHR(10)FROM USER_TRIGGERS


spool off; 
@/tmp/database/drop_tables.sql; 

purge recyclebin; --清空Oracle的回收站

--例:(win下进行删除用户asus的所有表)
sqlplus
asus --用户名
asus --密码
SET HEAD OFF 
SPOOL  c:/drop_tables.sql --保存为sql语句

--chr(13) ASCII中=换行  chr(10) ASCII中=回车
--delete tables 
select 'drop table ' || table_name ||';'||chr(13)||chr(10) from user_tables;
--delete views 
select 'drop view ' || view_name||';'||chr(13)||chr(10) from user_views;   
--delete seqs 
select 'drop sequence ' || sequence_name||';'||chr(13)||chr(10) from user_sequences;  
--delete functions 
select 'drop function ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='FUNCTION';   
--delete procedure 
select 'drop procedure ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='PROCEDURE';   
--delete package 
select 'drop package ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='PACKAGE';   
--delete trigger
SELECT 'drop TRIGGER "' ||SYS_CONTEXT('USERENV','CURRENT_USER')||'"."'|| TRIGGER_NAME ||'";' ||CHR(13) ||CHR(10)FROM USER_TRIGGERS

spool off; 
@c:/drop_tables.sql; 
purge recyclebin; --清空Oracle的回收站
quit --退出sqlplus

--完成

--然后再还原数据。
--imp maximo/maximo@orcl fromuser=maximo touser=maximo file=21时14分34秒.dmp  tablespaces=tablespaces


--************************
--**方法2
--************************
1　select   Drop   table   ||table_name||;
　　from   all_tables
　　where   owner=要删除的用户名（注意要大写）;
　　2、
　　删除所有表
　　以用户test为例
　　for example:
　　declare
　　cursor cur1 is select table_name from dba_tables where owner=TEST;
　　begin
　　for cur2 in cur1 loop
　　execute immediate drop table test.||cur2.table_name;
　　end loop;
　　end;
　　3、这个删除当前用户的所有对象(表、视图、触发器、存储过程、函数)
　　DECLARE
　　TYPE name_list IS TABLE OF VARCHAR2(40);
　　TYPE type_list IS TABLE OF VARCHAR2(20);
　　Tab_name name_list:=name_list();
　　Tab_type type_list:=type_list();
　　sql_str VARCHAR2(500);
　　BEGIN
　　sql_str := select uo.object_name,uo.object_type from user_objects uo where uo.object_type not in(INDEX,LOB) order by uo.object_type desc;
　　EXECUTE IMMEDIATE sql_str BULK COLLECT INTO tab_name,tab_type;
　　FOR i IN Tab_name.FIRST.. Tab_name.LAST LOOP
　　sql_str := DROP || Tab_type(i) || || Tab_name(i);
　　EXECUTE IMMEDIATE sql_str;
　　END LOOP;
　　END;



--************************
--**方法3
--**使用Oracle SQL Developer
--************************
--用需要删除的用户登入
--在工作表中输入以下内容
select 'drop table ' || table_name ||';'||chr(13)||chr(10) from user_tables;
select 'drop view ' || view_name||';'||chr(13)||chr(10) from user_views;   
select 'drop sequence ' || sequence_name||';'||chr(13)||chr(10) from user_sequences;  
select 'drop function ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='FUNCTION';   
select 'drop procedure ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='PROCEDURE';   
select 'drop package ' || object_name||';'||chr(13)||chr(10) from user_objects where object_type='PACKAGE';
SELECT 'drop TRIGGER "' ||SYS_CONTEXT('USERENV','CURRENT_USER')||'"."'|| TRIGGER_NAME ||'";' ||CHR(13) ||CHR(10)FROM USER_TRIGGERS

--按F5(运行脚本)
--在脚本输出中按Ctrl+F5(将脚本输出作为脚本运行)
--按Ctrl+F5后根据脚本自动创建一个工作表窗口,此时按F5(运行脚本)

purge recyclebin; --清空Oracle的回收站
--收工


```
