# tomcat 安裝時出現 Failed to install Tomcat7 service  

應該是你卸載時直接刪除目錄導致的.
```
Failed to install Tomcat7 service  Check your settings and permissions Ignore and continue anyway (not recommended)?
```
Alt+R(開始->運行)  services.msc
查看Apache Tomcat 7.0 Tomcat7對應的服務名
然後 cmd中執行 
```
sc delete Tomcat7
```
這樣就可以了

Tomcat 日誌
```
atalina.out                                                  //即時輸出
atalina.2012=06-12.log     
```


tomcat 改了服务名 tomcat7w.exe 启动不了等问题

自定义服务名安装

```
service.bat install userservice
```

卸载自定义服务名
```
service.bat uninstall userservice
```

tomcat7w自定义服务名启动方式
```
tomcat7w.exe //ES//userservice
```

如果将快捷方式放到桌面,则快捷方式后面添加参数即可,
如:
```
C:\apache-tomcat-7.0.35\bin\tomcat7w.exe //ES//userservice
```

如果想要用bat脚本
```
set tomcat_bin=C:/apache-tomcat-7.0.35/bin
cd /D %tomcat_bin%
start /d "%tomcat_bin%" tomcat7w.exe  //ES//userservice
```


注意事项:使用管理员方式运行
