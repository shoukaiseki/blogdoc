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
