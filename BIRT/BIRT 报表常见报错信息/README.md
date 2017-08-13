# BIRT 报表常见报错信息



Maximo   Birt 常见执行错误

birt 'page' is not defined.        

birt 'xxx' is not defined.    出现这种情况

说明js中使用了变量没有事先声明,常出现在,报表之间copy某个组件,而该组件有js代码,而js中的变量如果是在initialize中声明的,就会报这种错



"report/images/Signimg/zhangz001x.gif"

images 采用url方法时须加双引号,否则被视为変数,不加双引号会出现

birt 'images' is not defined.


