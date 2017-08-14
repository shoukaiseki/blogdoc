# win自动填写IP地址脚本

```Shell
@echo off
rem 设置变量
set Nic=无线网络连接
rem //可以根据你的需要更改,
set Addr=192.168.2.166
set Mask=255.255.255.0
set Gway=192.168.2.1
set Dns1=202.102.152.3
set Dns2=202.102.154.3
rem //以上依次为IP地址、子网掩码、网关、首选DNS、备用DNS
echo ------------------------------------------------------
echo 正在进行IP设置，请稍等
rem //可以根据你的需要更改
echo. IP地址 = %Addr%
echo. 子网掩码 = %Mask%
netsh interface ip set address name=%Nic% source=static addr=%Addr% mask=%Mask% >nul
echo. 网关 = %Gway%
netsh interface ip set address name=%Nic% gateway=%Gway% gwmetric=1 >nul
echo. 首选DNS = %Dns1%
netsh interface ip set dns name=%Nic% source=static addr=%Dns1% register=PRIMARY >nul
echo. 备用DNS = %Dns2%
netsh interface ip add dns name=%Nic% addr=%Dns2% index=2 >nul
echo ------------------------------------------------------
echo IP设置完成!
netsh interface ip add dns name=%Nic% addr=%Dns3% index=2 >nul
rem pause >nul
```
