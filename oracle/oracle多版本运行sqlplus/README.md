# oracle多版本运行sqlplus

比如有个32位客户端版本

```
D:\app\Oracle12c\product\12.1.0\client_1\BIN\sqlplus.exe /nolog
```

64位的数据库服务版本
```
D:\app\Oracle12c\product\12.1.0\dbhome_1\BIN\sqlplus.exe /nolog
```

运行sqlplus 方法

```Bat
set ORACLE_HOME=D:\app\Oracle12c\product\12.1.0\dbhome_1
set ORACLE_SID=DUNAN
D:\app\Oracle12c\product\12.1.0\dbhome_1\BIN\sqlplus.exe /nolog
```

## oracle 错误
### ORA-00838: Specified value of MEMORY_TARGET is too small, needs to be at least 1300M

```Sql
create pfile='D:\app\Oracle12c\oradata\DUNAN\init.ora' from spfile;
```
修改 init.ora 的memory_target值

```Ora
*.SPFILE='D:\app\Oracle12c\product\12.1.0\dbhome_1\database\spfiledbm.ora'
*.memory_target=10485760000
```
修改之后启动服务
```Sql
startup pfile='D:\app\Oracle12c\oradata\DUNAN\init.ora';
```
