# BIRT连接oracle12c错误

### DataSet [personSet] ORA-28040: 没有匹配的验证协议

#### 方法一
在$ORACLE_HOME\NETWORK\ADMIN\sqlnet.ora中配置添加以下配置

```
 SQLNET.ALLOWED_LOGON_VERSION=8
```

#### 方法二

jdbc采用ojdbc7

birt2.3.2.2\plugins\org.eclipse.birt.report.viewer_2.3.2.r232_20090212\birt\WEB-INF\classes\oracle 删除掉

然后解压ojdbc7.jar里面的类到该目录

