# win7 无法设置 在同一窗口打开文件夹

单击开始-控制面板-文件夹选项-常规-在同一窗口中打开每个文件夹点确定
<br />
常规选项卡设置了再同一窗口打开也无效,安装下面的就可以解决了
<br />


1. 点击开始—〉所有程序—〉附件，右击命令行提示符，选择以管理员身份运行，如果出现用户帐户控制窗口，点击继续。
<br />
2. 复制或输入下列命令
<br />

```Bat
regsvr32 "%SystemRoot%\System32\actxprxy.dll"
regsvr32 "%ProgramFiles%\Internet Explorer\ieproxy.dll"
```

重新启动计算机查看问题，如果问题依旧，就可能需要sfc了：
<br />
1. 点击开始—〉所有程序—〉附件，右击命令行提示符，选择以管理员身份运行，如果出现用户帐户控制窗口，点击继续。
<br />
2. 输入 sfc /scannow   并回车。
<br />
3. 等待计算机扫描修复后，查看问题是否存在。
