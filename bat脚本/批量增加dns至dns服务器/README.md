# 批量增加dns至dns服务器  

批处理文件,将hosts替换为下方格式

RecordAdd  后面的第二个 . 代表 只匹配本域名
```Bat
Dnscmd . /ZoneAdd material.io /Primary
Dnscmd . /RecordAdd material.io  . A 216.239.38.21
pause
```
