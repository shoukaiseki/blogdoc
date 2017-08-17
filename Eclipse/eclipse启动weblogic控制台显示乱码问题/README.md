# eclipse启动weblogic控制台显示乱码问题  

解决方法： 


1.找到weblogic安装目录,当前项目配置的domain  

2.找到bin下的setDomainEnv.cmd文件  

3.打开文件,从文件最后搜索第一个set JAVA_OPTIONS=%JAVA_OPTIONS%(应该是倒数第四行,空行除外),

修改为set JAVA_OPTIONS=%JAVA_OPTIONS% -Dfile.encoding=utf-8 
