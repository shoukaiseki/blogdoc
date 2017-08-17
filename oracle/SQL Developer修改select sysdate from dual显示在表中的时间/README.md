# SQL Developer修改select sysdate from dual显示在表中的时间  

修改Oracle SQL Developer的时间显示格式http://blog.csdn.net/virgoboy2004/article/details/6000958
<br>

<br>
Tools(工具) --> Preferences(首选项) --> Database(数据库) --> NLS Parameters(NLS)
<br>
默认为:
<br>
DD-MON-RR
<br>
DD-MON-RR HH.MI.SSXFF AM
<br>
DD-MON-RR HH.MI.SSXFF AM TZR
<br>
修改如下：
<br>
1、想显示时分秒
<br>
Date Format的值由"RR-MM-DD" 改为 "RR-MM-DD HH24:MI:SS"，这样显示的时间就包含时分秒了。
<br>
2、想显示全部全时间
<br>
Date Format的值由"RR-MM-DD" 改为 "RRRR-MM-DD HH24:MI:SS"，这样显示的时间就包含时完整的时间了
<br>

<br>
修改PL/SQL Developer的时间显示格式
<br>
Tools--> Preferences--> User Interface--> NLS
<br>
修改Date为"yyyy-MM-dd"
<br>
修改Time为"hh:mm:ss"
<br>

