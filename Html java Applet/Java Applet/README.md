# Java Applet 

HTML中插入Applet程序的源码如下:
HTML <applet> 标签  http://www.w3school.com.cn/tags/tag_object.asp

```
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My applet 'DbaAppl' starting page</title>
    
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
    
  </head>
  
  <body>
    
    <applet 
   //codebase:class存放目录,不放此句是为本目录
      codebase="file:///E:/Eclipse/Workspace/hello/bin/" 
   //code:class文件名
            code="TestJava2_1.class" 
   //name:定义applet的名字以区别于网页上的其他applet
            name="TestJava2_1" 
   //width:定义applet的宽度
   //height:定义applet的高度
            width="700" 
            height="500">
      
      <!--<param name="p0" value="">
          <param name="p1" value="">-->
    
    </applet>
  </body>
</html>
```


修改重新编译Applet的class后刷新页面时无法载入最新class的原因为:

java已经在页面上运行了class,关闭页面之后java可能还在运行,所以得结束java应用程序

windows下为在cmd中输入  taskkill /f /im java.exe

关于Applet中定义class目录在其它盘符的方法为:

codebase="file:///E:/Eclipse/Workspace/hello/bin/" 

请注意,前面加file:///
