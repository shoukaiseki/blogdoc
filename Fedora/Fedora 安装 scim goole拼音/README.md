# Fedora 安装 scim goole拼音  

参考文章

http://hi.baidu.com/wukaijj1314/blog/item/8e7ff42423722f3e8744f958.html

http://linux.xiazhengxin.name/index.php?entry=entry090906-144949
```Shell
yum install git-core
git clone git://github.com/tchaikov/scim-googlepinyin.git 
cd scim-googlepinyin 
yum install scim 
yum install scim-libs
 yum install scim-devel 
./autogen.sh 
make make install 
```
启动scim 
```Shell
scim -d 
```

关闭scim 
```Shell
pkill scim
```

http://www.linuxidc.com/Linux/2008-08/14629.htm

应用程序－其他－输入法选择器  设置为SCIM就行了

［前端－> 全局设置］ 里的 ［热键 ］设置，在 ［选择输入法开关］ 对话框里，点击 ［... ］按钮，出现提示对话框，在键盘上选择热键（例如，CTRL+ALT)

不过版本太老了，没法自定义短句，还是换回 I－bus吧
