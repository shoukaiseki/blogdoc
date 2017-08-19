# tail 輸出gbk日誌文件

google到的來自 http://q.hatena.ne.jp/1168874438 

```Shell
tail -f logfile | while read LINE ; do echo $LINE | iconv -f GBK -t UTF-8 ; done

#nkf是轉換爲日文編碼的,不支持中文
tail -f logfile | nkf -u -S -w
```
