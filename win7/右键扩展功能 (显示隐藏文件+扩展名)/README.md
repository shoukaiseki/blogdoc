# 右键扩展功能 (显示隐藏文件+扩展名)  

```Bat
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
