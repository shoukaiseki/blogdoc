# eclipse birt for ibm maximo  

http://pan.baidu.com/s/1dEcrQLF
```
该补丁包为ibm 旗下的 maximo 产品使用

---安装方法---{{{1
将其中的 classes 解压到
eclipse/plugins/org.eclipse.birt.report.viewer_4.5.0.v201506092134/birt/WEB-INF
目录下(具体路径按照对应eclipse的birt插件版本而定),



jdbc数据源配置在 classes/mxreportdatasources.properties 文件中,修改后需要重启eclipse生效

其中的 classes/oracle 为 lib/ojdbc6.jar 驱动解压的,如使用其它数据库,将对应的jdbc驱动解压到 classes目录即可


test.rptdesign  文件为birt报表示例
```
