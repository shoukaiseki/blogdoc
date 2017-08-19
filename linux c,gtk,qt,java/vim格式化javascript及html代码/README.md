# vim格式化javascript及html代码

转自:http://atim.cn/read.php/1020.htm
<br>

<br>
使用vim默认的格式化工具容易在格式化html与javascript混合的代码时很容易出现javascript没有按预想的规则显示代码.
<br>
所以推荐使用
<br>
http://www.vim.org/scripts/script.php?script_id=3081
<br>
只需要将indent下的文件放入vim安装目录下 vimfiles/indent
<br>
我在win下测试后是放置压缩包中的html.vim和javascript.vim文件到.\vimfiles\plugin目录
<br>
重启vim使用"=G"命令就可以对html与javascript混合的代码进行格式化.
<br>

<br>

<br>
另转：http://blog.csdn.net/ph123456789/article/details/6369018
<br>
最近在逛CSDN论坛时经常会苦恼一个问题——有些网友贴上去的代码没有用规范的格式贴上去，我贴到VIM里常常会需要手动调整格式，非常麻烦。每当这个时候就异常怀念以前用VC6.0时的ALT+F8……想下VIM作为一个程序员们最贴心的编辑器，显然不会对此坐视不理。经过一番的Search，果然就找到了一些最常用的简单技巧，笔记一下以备后来不时之需。 
<br>
VIM格式化代码： 
<br>
格式化全文指令 gg=G 
<br>
自动缩进当前行指令 == 
<br>
      格式化当前光标接下来的8行 8= 
<br>
      格式化选定的行 v 选中需要格式化的代码段 = 
<br>
      备注： 
<br>
gg —— 到达文件最开始 
<br>
= —— 要求缩进 
<br>
G     —— 直到文件尾 
<br>
注释代码：(这个原理上就是使用VIM的正则替换) 
<br>
以C++和Python为例。 
<br>
注释连续行： 
<br>
指令格式 :起始行,终止行s/要替换的字符/替换为字符/g 
<br>
如， 
<br>
      C++源文件中注释掉10~20行，指令为： 
<br>
:10,20s/^/////g 
<br>
Python源文件中注释掉10~20行，指令为： 
<br>
:10,20s/^/#/g 
<br>
取消连续行注释： 
<br>
指令格式同上。只是要替换字符与替换为字符要互换： 
<br>
如， 
<br>
      取消C++源文件中的10~20行的注释，指令为： 
<br>
:10,20s/^//////g 
<br>
取消Python源文件中的10~20行的注释，指令为： 
<br>
:10,20s/^#//g
<br>

