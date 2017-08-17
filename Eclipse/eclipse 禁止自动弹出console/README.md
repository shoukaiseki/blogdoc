# eclipse 禁止自动弹出console

转自:http://blog.csdn.net/xubo578/article/details/6572355
<br />
禁止弹出：
 
Preferences-〉 Run/Debug-〉Console里边
<br />
取消勾选 Show when program writes to standard out（当console中有值时弹出）前的选项
<br />
和 Show when program writes to standard error（当console中有错误时弹出） 前的选项

Eclipse无法打开解决方案:
<br />
修改根目录下的eclipse.ini文件
```
-showsplash
org.eclipse.platform
--launcher.XXMaxPermSize
256M
-framework
plugins\org.eclipse.osgi_3.4.3.R34x_v20081215-1030.jar
-vmargs
-Dosgi.requiredJavaVersion=1.5
-Xms40m
-Xmx512m
```

修改 最后两行的-Xms40m和  -Xmx512m 

```
-showsplash
org.eclipse.platform
--launcher.XXMaxPermSize
256M
-framework
plugins\org.eclipse.osgi_3.4.3.R34x_v20081215-1030.jar
-vmargs
-Dosgi.requiredJavaVersion=1.5
-Xms40m
-Xmx256m
```

Eclipse的SVN插件 Subclipse http://subclipse.tigris.org/servlets/ProjectDocumentList?expandFolder=2240&folderID=2240
