# Windows添加右键菜单  

给右键菜单加入CMD命令行快速通道(转自 http://www.hackbase.com/tech/2008-10-31/42126.html )
<br />
 很多人都很喜欢在CMD命令行下来操作计算机，我也是其中之一。 如何快速打开CMD并且定位到指定的路径呢？很多优化软件（比如优化大师）都提供了往右键菜单中加入“CMD快速通道”的功能，当右键点击文件夹时，就打开CMD并定位到该文件夹。网上也有修改注册表来实现的，其实根本不用这么麻烦。
<br />
      打开“我的电脑”，点击菜单中的“工具”－“文件夹选项”，选择“文件类型”，找到“(无)资料夹”，点“高级”，“新建”，在“操作”中填入 “CMD快速通道”（其实爱填什么都可以），“用于执行操作的应用程序”中填入“cmd.exe /k cd %1”（这个是关键），确定即可。
<br />
右键打开任何一个文件夹、分区，点击“CMD快速通道”，就可以打开CMD命令行了。
<br />
     PS：其实所有的实现方法都是对注册表做了同样的修改：在HKEY_CLASSES_ROOT\Folder\shell下增加一个“CMD”子键，将该子键的“(默认)”键值修改为“CMD快速通道”，然后在该子键下再建立一个子键“command”，将“command”的“(默认)”键值修改为“cmd.exe /k cd %1”。用注册表文件表示就是：
<br />

```Reg
Windows Registry Editor Version 5.00
[HKEY_CLASSES_ROOT\folder\shell\cmd]
@="CMD快速通道"
[HKEY_CLASSES_ROOT\folder\shell\cmd\command]
@="cmd.exe /k cd %1"
另外，网上很多修改注册表的方法，修改的是HKEY_CLASSES_ROOT\Directory这个键值，这样的效果基本相同，但是只有在右键点击文件夹的时候才能显示“CMD快速通道”，当点击分区、我的文档等特殊文件夹时就不行了，使用上没有上面的方式那么方便。

右键扩展功能 (显示隐藏扩展名)
       @echo off
　　mode con cols=100 lines=10
　　title 右键隐藏文件+扩展名
　　color 0b
　　if not exist "%windir%\SuperHidden.vbs" goto setup
　　reg delete "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}" /f >nul 2>nul
　　del /f /q "%windir%\SuperHidden.vbs" >nul 2>nul
　　echo.&echo 卸除完毕。 要重新安装请再执行一遍本bat
　　pause>nul
　　exit
　　:setup
　　color 0a
　　>"%windir%\SuperHidden.vbs" echo Dim WSHShell
　　>>"%windir%\SuperHidden.vbs" echo Set WSHShell = WScript.CreateObject("WScript.Shell")
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\CLSID", "{13709620-C279-11CE-A49E-444553540000}", "REG_SZ"
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\method", "ShellExecute", "REG_SZ"
　　>>"%windir%\SuperHidden.vbs" echo if WSHShell.RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt") = 0 then
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "0", "REG_DWORD"
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "2", "REG_DWORD"
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "1", "REG_DWORD"
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\command", "显示文件+扩展名", "REG_SZ"
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}+{F10}e"
　　>>"%windir%\SuperHidden.vbs" echo else
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden", "1", "REG_DWORD"
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden", "1", "REG_DWORD"
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "0", "REG_DWORD"
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag\command", "隐藏+不显示扩展名", "REG_SZ"
　　>>"%windir%\SuperHidden.vbs" echo WSHShell.SendKeys "{F5}+{F10}e"
　　>>"%windir%\SuperHidden.vbs" echo end if
　　>>"%windir%\SuperHidden.vbs" echo Set WSHShell = Nothing
　　>>"%windir%\SuperHidden.vbs" echo WScript.Quit(0)
　　reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "%temp%\__.reg" >nul
　　for /f "tokens=2 delims==" %%. in ('find/i "HideFileExt" "%temp%\__.reg"') do set v=%%~.
　　del "%temp%\__.reg"
　　set v=%v:~-1%
　　if %v% equ 0 set vv=隐藏+不显示扩展名
　　if %v% equ 1 set vv=显示文件+扩展名
　　>"%temp%\_.reg" echo REGEDIT4
　　>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\SuperHidden]
　　>>"%temp%\_.reg" echo @="{00000000-0000-0000-0000-000000000012}"
　　>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000012}\InProcServer32]
　　>>"%temp%\_.reg" echo @=hex(2):25,53,79,73,74,65,6d,52,6f,6f,74,25,5c,73,79,73,74,65,6d,33,32,5c,73,\
　　>>"%temp%\_.reg" echo 68,64,6f,63,76,77,2e,64,6c,6c,00
　　>>"%temp%\_.reg" echo "ThreadingModel"="Apartment"
　　>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000012}\Instance]
　　>>"%temp%\_.reg" echo "CLSID"="{3f454f0e-42ae-4d7c-8ea3-328250d6e272}"
　　>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000012}\Instance\InitPropertyBag]
　　>>"%temp%\_.reg" echo "method"="ShellExecute"
　　>>"%temp%\_.reg" echo "Param1"="SuperHidden.vbs"
　　>>"%temp%\_.reg" echo "CLSID"="{13709620-C279-11CE-A49E-444553540000}"
　　>>"%temp%\_.reg" echo "command"="%vv%"
　　regedit /s "%temp%\_.reg"
　　del /f /q "%temp%\_.reg"
　　echo.&echo 已添加至右键 再次执行本bat清除出右键菜单
　　pause>nul
　　exit
```
