# ORACLE啓動腳本  

我的系統是Linux Fedora16 Verne

執行dbstart時剛開始提示cat: /etc/oratab: 没有那个文件或目录
```
#按照下面格式進行新建時添加即可
#database_sid:oracle_home_dir:Y|N
#database_sid 是服务器上的Oracle 实例的系统ID(例如我的实例名是orcl,这里的database_sid就是orcl)
#Oracle_home_dir 是Oracle_HOME的父目錄
#- Y|N 指定数据库实例是否在系统启动时自动开始
orcl:/home/oracle/oracle/product/10.2.0:N
```
whereis vim查看軟件安裝路徑


最後感覺還是自己重寫方便多了
<br />
把兩文件放在/home/oracle/oracle/product/10.2.0/bin目錄下
<br />
給與執行權限chmod 755 dbstart.sh
<br />
就可以在終端輸入
```Shell
su oracle 
source ~/.bash_profile
dbstart.sh
```
來開啓數據庫,不過建議多手動執行,這樣這些命令就會成爲習慣成爲本能

```Shell
#!/bin/sh
#dbstart.sh
lsnrctl start
echo "lsnrctl監聽服務成功開啓!"
isqlplusctl start
echo "isqlplusctl服務成功開啓!"
sqlplus /nolog <<EOF
connect / as sysdba
startup;
quit
EOF
echo "數據庫成功開啓!"

#!/bin/sh
#dbshut.sh
lsnrctl stop
echo "lsnrctl監聽成功關閉"
isqlplusctl stop
echo "isqlplusctl服務成功關閉"
$SQLDBA <<EOF
connect / as sysdba
shutdown immediate
quit
EOF
echo "數據庫成功關閉"
#sqlplus /nolog <<EOF
#connect / as sysdba
#shutdown immediate;
#exit
#EOF
```
