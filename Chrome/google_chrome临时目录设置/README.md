# google_chrome临时目录设置 

几个实用的参数收集：(转自http://apps.hi.baidu.com/share/detail/31172887)
<br />
1  --user-data-dir="[PATH]"            指定用户文件夹User Data路径，可以把书签这样的用户数据保存在系统分区以外的分区。
<br />
2  --disk-cache-dir="[PATH]"           指定缓存Cache路径
<br />
3  --disk-cache-size=                  指定Cache大小，单位Byte
<br />
4  --Firstrun                          重置到初始状态
<br />
5  --incognito                         隐身模式启动
<br />
6  --disable-javascript                禁用Javascript


将快捷方式修改为
```
"C:\Users\Administrator.NF5PELI6IUOHCU5\AppData\Local\Google\Chrome\Application\chrome.exe" -disk-cache-dir="w:\googlewap" "%1" 
```

下文转自http://blog.lihaixin.name/search/label/chrome
<br />
最后修改一下注册表：在注册表修改操作系统默认的游览器，操作如下：
<br />
1、开始→运行→输入regedit，打开注册表编辑器
<br />
2、找到HKEY_CLASSES_ROOT\http\shell\open\command，在右边的窗口中双击"默认"，将要用浏览器的可执行文件的完全路径输入到这里，例如设置IE为默认浏览器：输入"C:\Documents and Settings\lihx\Local Settings\Application Data\Google\Chrome\Application\chrome.exe"  -disk-cache-dir="w:\googlewap" "%1"  这里请修改自己chrome执行文件的绝对路径。
<br />
3、然后找到 HKEY_CLASSES_ROOT\http\shell\open\ddeexec\Application，在右边的窗口中双击"默认"，设置浏览器名，如果是Firefox则输入Firefox，如果是IE则输入IExplore。我输入：chrome（小提示：切记不能写错名称，如果你不知道浏览器的标准名称是什么，只需要到安装目录下查看该浏览器的名称即可）
<br />
还有的说要修改以下

```Reg
HKEY_CLASSES_ROOT\ChromeHTML\shell\open\command
"C:\Users\Administrator.NF5PELI6IUOHCU5\AppData\Local\Google\Chrome\Application\chrome.exe" -disk-cache-dir="w:\googlewap" "%1"
```

win7下更方便,采用类似Linux下的链接方式mklink,Linux下为ln,当然功能还是没有Linux下的强大
<br />
下面说明转自http://hi.baidu.com/xdz66/blog/item/6e6d074fb3b89b25afc3ab02.html

```Bat
MKLINK [[/D] | [/H] | [/J]] Link Target

        /D      创建目录符号链接。默认为文件
                符号链接。
        /H      创建硬链接，而不是符号链接。
        /J      创建目录联接。
        Link    指定新的符号链接名称。
        Target  指定新链接引用的路径
                (相对或绝对)。
```
建立链接之前,首先要删除该目录,下面的Administrator.NF5PELI6IUOHCU5为用户名

```Bat
rd /S "C:\Users\Administrator.NF5PELI6IUOHCU5\AppData\Local\Google\Chrome\User Data\Default\Cache"
mklink /D "C:\Users\Administrator.NF5PELI6IUOHCU5\AppData\Local\Google\Chrome\User Data\Default\Cache"  "W:\googlewap"
```
既然这么方便,顺便把Media Cache目录也建立一个链接吧

```Bat
rd /S "C:\Users\Administrator.NF5PELI6IUOHCU5\AppData\Local\Google\Chrome\User Data\Default\Media Cache"
mklink /D "C:\Users\Administrator.NF5PELI6IUOHCU5\AppData\Local\Google\Chrome\User Data\Default\Media Cache"  "W:\googlemwap"
```
