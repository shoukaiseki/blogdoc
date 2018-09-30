# vim神器
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/%E6%8A%80%E6%9C%AF%E5%88%86%E4%BA%AB/01vim%E7%A5%9E%E5%99%A8/img/vim.gif)

## 摘要
演讲时候的系统:linux mint19 (基于ubuntu和deppin的桌面操作系统)

终端:guake

vim: win版本安装vim在本git下面files目录下,解压到d:/usr目录后,执行 D:\usr\Vim\vim_win7.reg 即可,右键点击文件会有提示列表"I VIM打开",选择这个选项的快捷键为"I"

常用命令笔记: http://sksweb.shoukaiseki.top/html/web/vim.html

### chrome 精品插件
#### undo close tab
查看之前关闭浏览的网页


#### SwitchyOmega
代理

#### Fullscreen Anything
最大化视频图片整个网页

## zencoding插件emmet

<c-y> 代表 Ctrl + y 
<c-y>, 代表 Ctrl + y再加逗号

vim中输入
```
html:5
```
之后按 <c-y>, 就出现下列代码

```Html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	
</body>
</html>
```

html:5 ,生成 HTML5 doctype 
html:xt, 生成 XHTML transitional doctype 
html:4s, 生成 HTML4 strict doctype

```
div#olDiv>ol>li.item*6>span{ZenCoding$$}.red	
```
```Html
<div id="olDiv">
	<ol>
		<li class="item">
			<span>ZenCoding01</span>
			<div class="red"></div>
		</li>
		<li class="item">
			<span>ZenCoding02</span>
			<div class="red"></div>
		</li>
		<li class="item">
			<span>ZenCoding03</span>
			<div class="red"></div>
		</li>
		<li class="item">
			<span>ZenCoding04</span>
			<div class="red"></div>
		</li>
		<li class="item">
			<span>ZenCoding05</span>
			<div class="red"></div>
		</li>
		<li class="item">
			<span>ZenCoding06</span>
			<div class="red"></div>
		</li>
	</ol>
</div>
```

```
div#i$-test.class$$$*5
```

```Html
<div id="i1-test" class="class001"></div>
<div id="i2-test" class="class002"></div>
<div id="i3-test" class="class003"></div>
<div id="i4-test" class="class004"></div>
<div id="i5-test" class="class005"></div>
```
