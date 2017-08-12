# 悬浮框  

```
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">用这一行悬浮框不正常

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"> 得用这个

<html>
	<head>

	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	</head>

	<body style="width:2000px; height:4000px">
        <div  style="position:fixed; width:100px; height:200px; *position:relative; top:100px; left:30px; background-color:red;">
        </div>
	</body>
</html>
```



整了半天,IE悬浮框不正常,而firefox,chrome,猎豹都可以,专用IE内核就不行了.问题出在引用描述
