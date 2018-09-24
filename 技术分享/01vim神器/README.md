# vim神器
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/%E6%8A%80%E6%9C%AF%E5%88%86%E4%BA%AB/01vim%E7%A5%9E%E5%99%A8/img/vim.gif)

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
