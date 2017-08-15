# oracle 11G 11.2.0.1.0 jdbc bug  

當時主機名称為:蒋カイセキ

工具 oracle sqldeveloper

```
java.lang.NullPointerException
 java.lang.String.<init>(String.java:173)
 oracle.sql.CharacterSet.AL32UTF8ToString(CharacterSet.java:1517)
 oracle.jdbc.driver.DBConversion.CharBytesToString(DBConversion.java:589)
 oracle.jdbc.driver.DBConversion.CharBytesToString(DBConversion.java:542)
 oracle.jdbc.driver.T4CTTIoauthenticate.receiveOauth(T4CTTIoauthenticate.java:816)
 oracle.jdbc.driver.T4CConnection.logon(T4CConnection.java:362)
 oracle.jdbc.driver.PhysicalConnection.<init>(PhysicalConnection.java:414)
 oracle.jdbc.driver.T4CConnection.<init>(T4CConnection.java:165)
 oracle.jdbc.driver.T4CDriverExtension.getConnection(T4CDriverExtension.java:35)
 oracle.jdbc.driver.OracleDriver.connect(OracleDriver.java:801)
```
剛開始碰到這個问题,google了好久,當時把10G的classes12.jar換成了11G的ojdbc6.jar
```Sql
SELECT ROWNUM,UTL_INADDR.get_host_name() ,sysdate,user,dbms_random.random FROM dual CONNECT BY LEVEL <= 1
```
査出來  UTL_INADDR.get_host_name()  為亂碼, sqldeveloper也亂碼
```Sql
select '你媽好嗎?','asus' from dual
```
查詢這個少了點中文,英文正常,而採用sqldeveloper倒是都正常,
<br />
新建了表,插入中文,java应用查詢出來正常,想著將就這用這新的jdbc吧,
<br />
用 weblogic10啟動maximo应用,報了個錯

```
javax.servlet.ServletException: BMXAA6539E - Failed to initialize the MAXIMOStartupServlet with exception: invalid authority: rmi://蒋カイセキ:13400/MXServer
```

接口無法正常运行,改主機名為shoukaiseki
<br />
之後一切正常,換回classes12.jar也能访问了
