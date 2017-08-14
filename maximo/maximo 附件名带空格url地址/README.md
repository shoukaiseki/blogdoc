# maximo 附件名带空格url地址  

当附件中存在空格的时候,maximo进行URL转码会将空格转换为+
<br>
为什么会这样呢?
<br>
编译下面的代码
```Java
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;


public class Test {
    
    
    public static void main(String args[]) throws UnsupportedEncodingException
    {
    	String file_encoding = System.getProperty("file.encoding");
    	System.out.println("file_encoding="+file_encoding);
        String encodedPercentSign = URLEncoder.encode(" ", System.getProperty("file.encoding"));
        System.out.println("encodedPercentSign="+encodedPercentSign);

    }
}
```

可以看到输出信息,URLEncoder.encode方法会将空格转换为+号
```
shoukaiseki@shoukaiseki:/tmp/win/candelfile$ javac Test.java && java Test
file_encoding=UTF-8
encodedPercentSign=+
```
如果在webclient目录新建一个文件,12 3.txt
<br>
你在访问 http://localhost:9081/maximo/webclient/12+3.txt 
<br>
如果你的maximo服务中间件容器是websphere,那么是能够正常访问的
<br>
如果容器是weblogic或者tomcat,很遗憾,不能正常访问
<br>
这样看来,这种方式只适用与你的附件服务是在websphere容器中运行才有效
<br>
而一般我们的附件都是在ibm httpd或者apache httpd服务中运行的,所以此方式无效
<br>

<br>
问题解决方案:
<br>
系统属性中,将 mxe.doclink.multilang.linux.websphere 设置为 false 即可
<br>

<br>
追踪关联:
<br>
该属性的描述为 "应用程序是否正在 Linux WebSphere 平台上运行" ,然而通过doclink 一词我们可以理解为,"附件应用程序是否正在 Linux WebSphere 平台上运行" ,因为该属性只在3个类中用到

```
psdi/webclient/servlet/RedirectServlet
psdi/webclient/system/controller/AppInstance
psdi/util/CommonUtil
```

其中CommonUtil中有个 EncodeFilePath 方法,会将 + 转换为 %20
<br />
但是该方法只在 psdi/webclient/beans/report/SilentPrintServlet.java 类中存在调用



