# 解决windows下的vim打开unicode格式编码乱码问题  

解决 gVIM 打开 Unicode、Unicode big endian、UTF-8 编码文件乱码问题的办法，试着下载 iconv.dll 文件（http://mbbill.googlepages.com/iconv.dll），并把它放置在 gvim.exe 所在文件夹中。
<br>
iconv.dll   http://115.com/file/ansu1qcx#


```Vim
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
```
