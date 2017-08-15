# 显示隐藏扩展名

```Bat
@echo off

　　mode con cols=100 lines=10

　　title 右键隐藏扩展名

　　color 0b

　　if not exist "%windir%\SuperExtension.vbs" goto setup

　　reg delete "HKCR\CLSID\{00000000-0000-0000-0000-000000000014}" /f >nul 2>nul

　　del /f /q "%windir%\SuperExtension.vbs" >nul 2>nul

　　echo.&echo 卸除完毕。 要重新安装请再执行一遍本bat

　　pause>nul

　　exit

　　:setup

　　color 0a

　　>"%windir%\SuperExtension.vbs" echo Dim WSHShell

　　>>"%windir%\SuperExtension.vbs" echo Set WSHShell = WScript.CreateObject("WScript.Shell")

　　>>"%windir%\SuperExtension.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000014}\Instance\InitPropertyBag\CLSID", "{13709620-C279-11CE-A49E-444553540000}", "REG_SZ"

　　>>"%windir%\SuperExtension.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000014}\Instance\InitPropertyBag\method", "ShellExecute", "REG_SZ"

　　>>"%windir%\SuperExtension.vbs" echo if WSHShell.RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt") = 0 then

　　>>"%windir%\SuperExtension.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "1", "REG_DWORD"

　　>>"%windir%\SuperExtension.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000014}\Instance\InitPropertyBag\command", "显示扩展名", "REG_SZ"

　　>>"%windir%\SuperExtension.vbs" echo WSHShell.SendKeys "{F5}+{F10}e"

　　>>"%windir%\SuperExtension.vbs" echo else


　　>>"%windir%\SuperExtension.vbs" echo WSHShell.RegWrite "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\HideFileExt", "0", "REG_DWORD"

　　>>"%windir%\SuperExtension.vbs" echo WSHShell.RegWrite "HKCR\CLSID\{00000000-0000-0000-0000-000000000014}\Instance\InitPropertyBag\command", "隐藏扩展名", "REG_SZ"

　　>>"%windir%\SuperExtension.vbs" echo WSHShell.SendKeys "{F5}+{F10}e"

　　>>"%windir%\SuperExtension.vbs" echo end if

　　>>"%windir%\SuperExtension.vbs" echo Set WSHShell = Nothing

　　>>"%windir%\SuperExtension.vbs" echo WScript.Quit(0)

　　reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "%temp%\__.reg" >nul

　　for /f "tokens=2 delims==" %%. in ('find/i "HideFileExt" "%temp%\__.reg"') do set v=%%~.

　　del "%temp%\__.reg"

　　set v=%v:~-1%

　　if %v% equ 0 set vv=隐藏扩展名

　　if %v% equ 1 set vv=显示扩展名

　　>"%temp%\_.reg" echo REGEDIT4

　　>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\SuperExtension]

　　>>"%temp%\_.reg" echo @="{00000000-0000-0000-0000-000000000014}"

　　>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000014}\InProcServer32]

　　>>"%temp%\_.reg" echo @=hex(2):25,53,79,73,74,65,6d,52,6f,6f,74,25,5c,73,79,73,74,65,6d,33,32,5c,73,\

　　>>"%temp%\_.reg" echo 68,64,6f,63,76,77,2e,64,6c,6c,00

　　>>"%temp%\_.reg" echo "ThreadingModel"="Apartment"

　　>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000014}\Instance]

　　>>"%temp%\_.reg" echo "CLSID"="{3f454f0e-42ae-4d7c-8ea3-328250d6e272}"

　　>>"%temp%\_.reg" echo [HKEY_CLASSES_ROOT\CLSID\{00000000-0000-0000-0000-000000000014}\Instance\InitPropertyBag]

　　>>"%temp%\_.reg" echo "method"="ShellExecute"

　　>>"%temp%\_.reg" echo "Param1"="SuperExtension.vbs"

　　>>"%temp%\_.reg" echo "CLSID"="{13709620-C279-11CE-A49E-444553540000}"

　　>>"%temp%\_.reg" echo "command"="%vv%"

　　regedit /s "%temp%\_.reg"

　　del /f /q "%temp%\_.reg"

　　echo.&echo 已添加至右键 再次执行本bat清除出右键菜单

　　pause>nul

　　exit
```
