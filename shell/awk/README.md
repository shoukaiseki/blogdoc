# awk  

```
#以下爲大家提供更多的關鍵字能夠搜索到該問題,無實際意義

akw執行akw命令

akw執行shell 
awk內鑲akw命令
zip -v 每行顯示文件名 
```
查找zip壓縮包中的文件
```
find -name "*.zip" |awk '{print system("unzip -v "$0"|awk '\''{print \""$0" \"$0}'\''")}'\
|grep filename
```
