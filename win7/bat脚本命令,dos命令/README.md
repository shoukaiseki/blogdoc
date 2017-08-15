# bat脚本命令,dos命令  

```Bat
dir /s >>a.txt    输出该目录下的文件名(有无日期,有扩展名)到a.txt

dir  /b >>a.txt  输出该目录下的文件名(无日期,有扩展名)到a.txt

for /f "delims=" %i in ('dir/b')do echo %~ni>>a.txt  输出该目录下的文件名(无日期,无扩展名)到a.txt
```
