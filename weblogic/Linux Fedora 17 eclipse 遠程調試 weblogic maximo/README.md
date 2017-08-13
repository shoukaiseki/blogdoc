# Linux Fedora 17 eclipse 遠程調試 weblogic maximo  

參考地址 http://topic.csdn.net/u/20071023/15/e696fb21-8e68-4f0a-be33-33aa993337fa.html
```Bat
#以下爲大家提供更多的關鍵字能夠搜索到該問題,無實際意義
weblogic 不用重啓服務,自動重載類 開啓遠程調試
```


startweblogic.cmd添加以下內容

```Bat
set JAVA_OPTIONS=%JAVA_OPTIONS% -Djava.compiler=NONE -Xdebug -Xnoagent  -Xrunjdwp:transport=dt_socket,address=5000,server=y,suspend=n 


@REM Call setDomainEnv here.  我是添加在這一行前
```

然後
```Bat
    echo Starting WLS with line: 看下%JAVA_OPTIONS% 在下句中的位置 
     echo %JAVA_HOME%\bin\java  %JAVA_VM% %MEM_ARGS%  -Dweblogic.Name=%SERVER_NAME%  -Djava.security.policy=%WL_HOME%\server\lib\weblogic.policy  %JAVA_OPTIONS% %PROXY_SETTINGS% %SERVER_CLASS% 
     %JAVA_HOME%\bin\java %JAVA_VM% %MEM_ARGS%  -Dweblogic.Name=%SERVER_NAME%  -Djava.security.policy=%WL_HOME%\server\lib\weblogic.policy  %JAVA_OPTIONS% %PROXY_SETTINGS% %SERVER_CLASS%
```

之後可以用以下命令查看端口是否已經打開
```
netstat -an 
```

Myeclipse中設置遠程調試端口,

Run->Debug->Configurations  右鍵點擊Remote Java Application 選擇新建,Project是你想遠程調試的Eclipse對應的項目名稱
 
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/weblogic/Linux%20Fedora%2017%20eclipse%20%E9%81%A0%E7%A8%8B%E8%AA%BF%E8%A9%A6%20weblogic%20maximo/img/001.png)
 
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/weblogic/Linux%20Fedora%2017%20eclipse%20%E9%81%A0%E7%A8%8B%E8%AA%BF%E8%A9%A6%20weblogic%20maximo/img/002.png)

#常見問題
當weblogic重啓後,遠程端口關閉,eclipse不會自動重連,
#以下爲大家提供更多的關鍵字能夠搜索到該問題,無實際意義

weblogic 服務重啓 eclipse 斷開連接 

weblogic 遠程調試 服務重啓 eclipse 斷開連接
weblogic 遠程調試 服務器重啓後失效

Show View as a Fast View->Debug(即最左下圖標)
在Debug窗口選中Remote Java Application建立時候的名字右鍵點擊->relaunch
ようし!
