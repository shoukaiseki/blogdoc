# oracle 12c安装出现错误解决方案 

[INS-30131] 执行安装程序验证所需的初始设置失败。
<br />
更多关键字搜索本文章词组:win7 oracle 12c 安装第一步慢 第一次下一步慢
<br />
首先进入cmd命令行,执行以下命令

```Bat
C:\Users\Administrator>net share C$ /delete
用户打开了 C$ 上的文件，继续这项操作会强制关闭文件。

您想继续此操作吗? (Y/N) [N]: y
C$ 已经删除。
C:\Users\Administrator>mkdir C:\tmp

C:\Users\Administrator>mklink /D C:\tmp\Users C:\Users
为 C:\tmp\Users <<===>> C:\Users 创建的符号链接

C:\Users\Administrator>mklink /D C:\tmp\Windows C:\Windows
为 C:\tmp\Windows <<===>> C:\Windows 创建的符号链接
```
然后右键C盘下面的tmp文件夹,选择属性-共享-高级共享,共享名改为 C$,权限设置为全部控制(如图)
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/oracle/oracle%2012c%E5%AE%89%E8%A3%85%E5%87%BA%E7%8E%B0%E9%94%99%E8%AF%AF%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88/img/001.png)
 
安装完毕之后把共享关了就好,然后将C:\tmp文件夹直接删除即可
<br>
虽然有的方法说采用命令

```Bat
net share C$=C:
```
开启共享,但是oracle安装文件没法进行对该共享进行写入操作,所以无效果,而且在第一次点下一步的时候也相当的慢,只有允许写入的时候验证才会快
<br>
如果在这一步有其它疑问可以留言
<br>

