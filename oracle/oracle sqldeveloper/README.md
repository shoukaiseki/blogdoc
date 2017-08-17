# oracle sqldeveloper  


oracle packages创建 http://www.cnblogs.com/huyong/archive/2011/05/26/2057973.html
<br />
http://blog.sina.com.cn/s/blog_4b2778c701007tg7.html
<br />
http://blog.csdn.net/mzyluokai/article/details/6318456 
<br />
运行Oracle Sqldeveloer异常,解决方案来与http://blog.163.com/fxs_whm/blog/static/25702956201031323847225/
```
---------------------------
Oracle SQL Developer
---------------------------
Unable to create an instance of the Java Virtual Machine
Located at path:
<SQLDEVELOPER>\jdk\jre\bin\client\jvm.dll
```
解决方法如下:
<br />
找到
```
D:\win7_usr\sqldeveloper\ide\bin\ide.conf
```
将
```
AddVMOption  -Xmx640M
AddVMOption  -Xms128M
```
修改为:
```
#AddVMOption  -Xmx640M
AddVMOption  -Xmx256M
AddVMOption  -Xms128M
```
即可


```Sql
--ORACLE sqldeveloper   
DBMS_OUTPUT.PUT_LINE  输出结果

set serveroutput on;--PL/SQL Developer中不用此句也可以,但是Oracle Sql Developer需要此句,不然只会出现"匿名块已完成"
begin
  DBMS_OUTPUT.PUT_LINE('Oracle Hello World!');
END;
```


删除包

```Sql
create PACKAGE DEMO_PKG AS
TYPE ROSSCURSOR IS REF CURSOR;

PROCEDURE PKG_RS_SAMPLE_DROP_RPOCEDURE
(
DBMS_OUTPUT.PRINT('yes');
);
END PKG_RS_SAMPLE_DROP;

declare package_count int;
begin

SELECT 
  count(OBJECT_NAME) into package_count
FROM 
  USER_PROCEDURES 
WHERE 
  OBJECT_TYPE='PACKAGE' AND OBJECT_NAME='DEMO_PKG';
  
if 
  package_count > 0 
then
  　　execute  immediate 'drop package DEMO_PKG';
end if;

end;
```

