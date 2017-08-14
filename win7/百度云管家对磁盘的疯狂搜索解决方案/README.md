# 百度云管家对磁盘的疯狂搜索解决方案  

下载软媒魔方,运行软媒内存盘(ramdisk.exe),创建内存盘,盘符设置为Z盘
<br />
我是创建了512MB的内存盘作为硬盘使用,勾选关机保存选项
<br />
当出现Z盘之后,关闭百度云管家,删除百度云管家安装目录子目录下面的 BaiduYunCacheFileV0.db 文件
<br />
执行以下命令(将BaiduYunCacheFileV0.db路径更换为实际路径)

```Bat
echo. > Z:/BaiduYunCacheFileV0.db
mklink D:\usr\baidu\BaiduYunGuanjia\users\6f5f149de6c1c21df3f9b17f0bda8f13\BaiduYunCacheFileV0.db z:\BaiduYunCacheFileV0.db
pause
```


执行之后就可以了,打开云管家,这样云管家对BaiduYunCacheFileV0.db文件的写入会先写到内存上,减少对磁盘的伤害
