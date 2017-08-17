# 64位windows7 上安装32位oracle 10g 的方法  

转载:64位windows7 上安装32位oracle 10g 的方法 
<br />
     http://hi.baidu.com/injava/blog/item/096d6d89ddb9a8a20e2444fe.html 
<br />
操作系统: windows7 中文旗舰版 
<br />
oracle安装版本: 10.2.0.1 中文版，升级补丁至 10.2.0.3 

下面说正题 
<br />
首先，我们要解除oracle安装的windows版本检测 
<br />
1、编辑安装包内文件  database\stage\prereq\db\refhost.xml 
<br />
      增加下面节点 
```Xml
      <OPERATING_SYSTEM>      
          <VERSION VALUE="6.1"/> 
      </OPERATING_SYSTEM>     
```
2、编辑安装包内文件    database\install\oraparam.ini 
<br />
      找到[Certified Versions]小节 在下面的第二行中增加windows版本6.1，如下面所示 
<br />
      Windows=4.0,5.0,5.1,5.2,6.1 
<br />
      注意要把windows 前面的"#"去掉，否则无效 
<br />
其次我们必须关闭window7的 UAC。不要心存侥幸，这东西开着安装到一半就会被卡住，而且没有任何提示窗体。 
<br />
3、执行C:\Windows\System32\UserAccountControlSettings.exe 把旁边的控制块拉到最下面。 
<br />
最后，要以兼容形式运行安装程序。 
<br />
4、右击setup.exe  点击属性-兼容性- 勾选以兼容模式运行这个程序 ，下拉列表中选择windos xp sp3 

一切完成以后点击setup开始安装吧。
<br />

refhost.xml文件插入位置
```Xml
    <OPERATING_SYSTEM>
      <VERSION VALUE="5.2"/>
    </OPERATING_SYSTEM>
 <OPERATING_SYSTEM>      
          <VERSION VALUE="6.1"/> 
      </OPERATING_SYSTEM> 
  </CERTIFIED_SYSTEMS>
  <ORACLE_HOME>
```

oraparam.ini文件修改位置
```
[Certified Versions]
#You can customise error message shown for failure, provide value for CERTIFIED_VERSION_FAILURE_MESSAGE
Windows=4.0,5.0,5.1,5.2,6.1
```
