# postman



## 登录之后设置token
tests 添加设置全局变量脚本
```
var jsondata=JSON.parse(responseBody);
var token=jsondata.token;
pm.globals.set("token",token);
```

## 接口调用中设置token
在要设置的token中使用全局变量 {{token}} ,postman会根据全局变量名替换为已保存全局变量

![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/postman/img/001.png)

![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/postman/img/002.png)

