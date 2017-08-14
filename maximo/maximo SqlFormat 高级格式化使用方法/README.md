# maximo SqlFormat 高级格式化使用方法  

```Java
//sourceMbo为要将 :字段名 替换的 Mbo

SqlFormat sqf = new SqlFormat(sourceMbo, "需您审核编号为 :CONTRACTNUM :VENDOR.NAME 合同");
sqf.setIgnoreUnresolved(true);
String val = sqf.resolveContent();
System.out.println("val="+val);



sqf = new SqlFormat(sourceMbo,"CONTRACTNUM=':CONTRACTNUM' and name=':VENDOR.NAME'");
sqf.setIgnoreUnresolved(true);
val = sqf.resolveContent();
System.out.println("val="+val);
```
输出结果如下: 

需您审核编号为 10364  东京人体工程学文化研究中心 合同

CONTRACTNUM='10364' and name='东京人体工程学文化研究中心'
