# MyEclipse设置  

window->show view->navigator   MyEclipse查看复制Class    
<br>
window-->Preferences-->Java-->compiler 在这里选择你的jdk版本每个版本的MyEclipse默认不同，我的MyEclipse6.5是5.0即jdk1.5 
<br>
window-->Preferences-->Java-->Installed  JREs在右侧点击ADD，然后浏览你的jdk目录，只后你必备在看上去是复选框的框框把你心增加的jdk选中。表便是复选框实际是单选的，不许重复选择。 
<br>
你还得再你的web容器的jdk里把你刚才加的jdk版本选上，比如我的web容器是tomcat5.5： 
<br>
window-->Preferences-->MyEclipse Enterprise Workbench-->Servers-->Tomcat-->tomcat 5X-->JDK 选择好点击Apply 
<br>

<br>
加快eclipse启动速度--取消打开时加载的插件
<br>
Preferences->general->Startup and shutdown
<br>

<br>
把里面不需要一开始就加载的plug-in给去掉
<br>

<br>
在Eclipse的启动快捷方式中添加
<br>
指定JVM -vm D:\Java\jdk1.6.0\bin\javaw.exe
<br>

