# win10下12c创建第二个实例后第一个实例无法启动

## 服务启动最多10s就起来了,但是无法连接数据库

于是使用sqlplus启动服务

```
C:\WINDOWS\system32>sqlplus "/as sysdba"

SQL*Plus: Release 12.2.0.1.0 Production on 星期三 1月 17 18:55:49 2018

Copyright (c) 1982, 2016, Oracle.  All rights reserved.

已连接到空闲例程。

SQL> startup
ORA-01078: failure in processing system parameters
LRM-00109: ???????????????? 'E:\ORACLE\PRODUCT\12.2.0\DBHOME_1\DATABASE\INITORCL.ORA'

```

### 提示pfile文件不存在,于是复制一份过去

```
copy E:\oracle\admin\orcl\pfile\init.ora.514201793245 E:\oracle\product\12.2.0\dbhome_1\database\INITORCL.ORA
```

再启动还是报不存在

### 指定pfile文件启动

```
SQL> startup pfile='E:\oracle\product\12.2.0\dbhome_1\database\INITORCL.ORA'
ORACLE 例程已经启动。

Total System Global Area 2550136832 bytes
Fixed Size                  8922136 bytes
Variable Size             687868904 bytes
Database Buffers         1845493760 bytes
Redo Buffers                7852032 bytes
ORA-00205: ?????????, ??????, ???????
```

### 又报其他错误,查看 E:\oracle\diag\rdbms\orcl\orcl\alert\log.xml 日志文件

```Xml
<msg time='2018-01-17T19:21:45.695+08:00' org_id='oracle' comp_id='rdbms'
 type='UNKNOWN' level='16' host_id='SHOUKAISEKI'
 host_addr='fe80::4471:5f2b:1472:c27b%12' pid='17224' con_uid='1'
 con_id='1' con_name='CDB$ROOT'>
 <txt>ORA-00210: ???????????
ORA-00202: ????: &apos;&apos;E:\ORACLE\ORADATA\ORCL\CONTROL02.CTL&apos;&apos;
ORA-27041: ??????
OSD-04002: 无法打开文件
O/S-Error: (OS 5) 拒绝访问。
ORA-00210: ???????????
ORA-00202: ????: &apos;&apos;E:\ORACLE\ORADATA\ORCL\CONTROL01.CTL&apos;&apos;
ORA-27041: ??????
OSD-04002: 无法打开文件
O/S-Error: (OS 5) 拒绝访问。
 </txt>
</msg>
```
提示访问拒绝

#### 检查文件的权限,如下图所示

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/oracle/win10%E4%B8%8B12c%E5%88%9B%E5%BB%BA%E7%AC%AC%E4%BA%8C%E4%B8%AA%E5%AE%9E%E4%BE%8B%E5%90%8E%E7%AC%AC%E4%B8%80%E4%B8%AA%E5%AE%9E%E4%BE%8B%E6%97%A0%E6%B3%95%E5%90%AF%E5%8A%A8/img/001.png)

命名是ORCL实例的文件,但是权限变成了 ORCLGKB 的权限

## 添加用户权限

用户名就为服务名,系统服务中查看

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/oracle/win10%E4%B8%8B12c%E5%88%9B%E5%BB%BA%E7%AC%AC%E4%BA%8C%E4%B8%AA%E5%AE%9E%E4%BE%8B%E5%90%8E%E7%AC%AC%E4%B8%80%E4%B8%AA%E5%AE%9E%E4%BE%8B%E6%97%A0%E6%B3%95%E5%90%AF%E5%8A%A8/img/002.png)

实例的服务,复制此账户的名称

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/oracle/win10%E4%B8%8B12c%E5%88%9B%E5%BB%BA%E7%AC%AC%E4%BA%8C%E4%B8%AA%E5%AE%9E%E4%BE%8B%E5%90%8E%E7%AC%AC%E4%B8%80%E4%B8%AA%E5%AE%9E%E4%BE%8B%E6%97%A0%E6%B3%95%E5%90%AF%E5%8A%A8/img/003.png)

文件授权中添加账户

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/oracle/win10%E4%B8%8B12c%E5%88%9B%E5%BB%BA%E7%AC%AC%E4%BA%8C%E4%B8%AA%E5%AE%9E%E4%BE%8B%E5%90%8E%E7%AC%AC%E4%B8%80%E4%B8%AA%E5%AE%9E%E4%BE%8B%E6%97%A0%E6%B3%95%E5%90%AF%E5%8A%A8/img/004.png)

添加完文件权限中就多了信息

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/oracle/win10%E4%B8%8B12c%E5%88%9B%E5%BB%BA%E7%AC%AC%E4%BA%8C%E4%B8%AA%E5%AE%9E%E4%BE%8B%E5%90%8E%E7%AC%AC%E4%B8%80%E4%B8%AA%E5%AE%9E%E4%BE%8B%E6%97%A0%E6%B3%95%E5%90%AF%E5%8A%A8/img/004.png)


然而,E:\oracle\oradata\orcl 目录下面的所有文件都确实权限,一个一个添加太麻烦

写了个批处理文件,你机子的实例服务名,实例目录替换掉,保存为cmd文件,然后用管理员权限运行即可

```Cmd
@echo off
@REM oracle实例所属路径
set "orcldatapath=E:\oracle\oradata\orcl"
@REM oracle实例所属服务名
set oracleservicename=OracleServiceORCL

icacls %orcldatapath% /grant %oracleservicename%:f

for /r  %orcldatapath% %%i in (*) do (
	echo filename=%%i
	icacls %%i /grant %oracleservicename%:f
)


for /d %%i in (%orcldatapath%\*) do (
	echo pathname=%%i
	icacls %%i /grant %oracleservicename%:f
)

pause
```


授权完之后发现启动正常了

```
SQL> startup
ORACLE instance started.

Total System Global Area 2550136832 bytes
Fixed Size                  8922136 bytes
Variable Size             687868904 bytes
Database Buffers         1845493760 bytes
Redo Buffers                7852032 bytes
Database mounted.
Database opened.
```
