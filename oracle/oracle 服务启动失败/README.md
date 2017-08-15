# oracle 服务启动失败

startup 出错

```
 invalid specification for system parameter LOCAL_LISTENER
 syntax error or unresolved network name 'LISTENER_ORCL'
```

执行下面语句
```Sql
create pfile from spfile;
```
将会在 D:\app\orcl\product\11.2.0\dbhome_1\database 下面创建一个 INITorcl.ORA 的文件
<br />
文件中添加  
```
*.local_listener='(ADDRESS_LIST=(Address=(Protocol=tcp) (Host=WIN-9KCS687QL54)(Port=1521)))'
```

```
orcl.__db_cache_size=335544320
orcl.__java_pool_size=8388608
orcl.__large_pool_size=8388608
orcl.__oracle_base='D:\app\orcl'#ORACLE_BASE set from environment
orcl.__pga_aggregate_target=444596224
orcl.__sga_target=847249408
orcl.__shared_io_pool_size=0
orcl.__shared_pool_size=478150656
orcl.__streams_pool_size=8388608
*.audit_file_dest='D:\app\orcl\admin\orcl\adump'
*.audit_trail='db'
*.compatible='11.2.0.0.0'
*.control_files='D:\app\orcl\oradata\orcl\control01.ctl','D:\app\orcl\flash_recovery_area\orcl\control02.ctl'
*.db_block_size=8192
*.db_domain=''
*.db_name='orcl'
*.db_recovery_file_dest='D:\app\orcl\flash_recovery_area'
*.db_recovery_file_dest_size=4039114752
*.diagnostic_dest='D:\app\orcl'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=orclXDB)'
*.local_listener='LISTENER_ORCL'
*.memory_target=1288699904
*.open_cursors=2000
*.processes=500
*.remote_login_passwordfile='EXCLUSIVE'
*.sessions=555
*.undo_tablespace='UNDOTBS1'
*.local_listener='(ADDRESS_LIST=(Address=(Protocol=tcp) (Host=WIN-9KCS687QL54)(Port=1521)))'
```

然后再启动服务
```Sql
startup pfile='D:/app/orcl/product/11.2.0/dbhome_1/database/INITorcl.ORA'
```


这次启动成功了,但是shutdown之后再startup还是这样

那就需要设置默认了

```Sql
create pfile='D:/app/orcl/product/11.2.0/dbhome_1/database/pfile/INITorcl.ORA' from spfile;
```
执行完之后,修改INITorcl.ORA后保存,然后在执行

```Sql
create spfile from pfile='D:/app/orcl/product/11.2.0/dbhome_1/database/pfile/INITorcl.ORA';
```

在执行 shutdown ,startup 发现可以了
