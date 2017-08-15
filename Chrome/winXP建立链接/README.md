# winXP建立链接  

winXP建立链接
<br />
http://technet.microsoft.com/en-us/sysinternals/bb896768.aspx

```Bat
@echo off
rd /S "C:\Documents and Settings\Administrator\Local Settings\Application Data\Google\Chrome\User Data\Default\Cache"

junction -s "C:\Documents and Settings\Administrator\Local Settings\Application Data\Google\Chrome\User Data\Default\Cache" "W:\googletmp"

rd /S "C:\Documents and Settings\Administrator\Local Settings\Application Data\Google\Chrome\User Data\Default\Media Cache"
junction -s "C:\Documents and Settings\Administrator\Local Settings\Application Data\Google\Chrome\User Data\Default\Media Cache"  "W:\googlemtmp"
echo.&echo 设置完成
pause>nul
exit

```
