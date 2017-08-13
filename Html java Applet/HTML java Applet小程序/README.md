# HTML java Applet小程序

新建HelloWorld.java
```
import java.awt.*;
import java.applet.*;
public class HelloWorld extends Applet //继承Appelet类，这是Applet Java程序的特点
{
    public void paint(Graphics g )
    {
        g.drawString("Hello World!",5,35);
    }
}
```

新建HelloWorld.html(复制script之间的内容,因为高亮时有些不自动换行,所以在高亮显示中加了script做换行显示)
```
<HTML>
<TITLE>HelloWorld! Applet</TITLE>
    <APPLET
        codebase="."        //指定运行目录,不放此句是为本目录
        CODE="HelloWorld.class" //这里应该是HelloWorld.class
        WIDTH=200
        NAME = "TestApplet"
        HEIGHT=100>
    </APPLET>
</HTML>
```

在cmd中输入appletviewer HelloWorld.html运行Applet程序,也可直接用浏览器打开HelloWorld.html
