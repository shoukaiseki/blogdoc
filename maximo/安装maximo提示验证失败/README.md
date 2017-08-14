# 安装maximo提示验证失败

安装 maximo 时，用户需要拥有sysdba权限
<br>

<br>
比如用户为： maximo
<br>
密码为：maximo
<br>
那么执行下列语句就ok了
```Sql
grant sysdba to maximo;
```

<br>
因为登录方式采用 conn maximo/maximo as sysdba
<br>
可以用sqlplus尝试，只要sqlplus尝试成功了，那么验证也就不会有问题
<br>

