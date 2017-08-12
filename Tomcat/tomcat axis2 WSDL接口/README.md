# tomcat axis2 WSDL接口

本文製作概述及主要操作,詳細請查看源參考地址

http://apps.hi.baidu.com/share/detail/63211085

```
#以下爲大家提供更多的關鍵字能夠搜索到該問題,無實際意義
tomcat 部署 WSDL
WSDL hello world 實現
```
下載包axis2的,war爲部署,bin爲生成接口java代碼 wsdl2java.sh

http://115.com/file/e7yx3fd7#axis2-1.6.2-bin.zip

http://115.com/file/dp6udlya#axis2-1.6.2-war.zip

將war解壓到tomcat的webapps目錄,訪問 

http://localhost:8080/axis2/

能訪問就正常,然後新建類,

```
cd到tomcat/webapps/axis2/WEB-INF目錄 

mkdir pojo                               #創建pojo目錄


[root@fedora pojo]# pwd
/media/linux/data/opt/tomcat/webapps/axis2/WEB-INF/pojo
[root@fedora pojo]# vim SimpleService.java                     #新建SimpleService.java文件

javac SimpleService.java                                                   #javac 編譯成class 
```
源代碼如下
```
import java.util.Date;

public class SimpleService
{
    public String getGreeting(String name)
     {
     String s="asusお早う 、馬鹿野郎！" + name;
     System.out.println(name);
        return s; 
     }    
    public int getPrice()
     {
        return new java.util.Random().nextInt(10000);
     }    
    public String getString(){
     
     return "俺我倒す!!asas??";
    }
    public Date getDate(){
     System.out.println(new Date());
     System.out.println("11111111");
     return new Date();
    }
}

```
好了,之後就可以用以下地址測試接口吧

http://127.0.0.1:8080/axis2/services/listServices

http://localhost:8080/axis2/services/SimpleService/getString

http://localhost:8080/axis2/services/SimpleService/getGreeting?name=bill

http://localhost:8080/axis2/services/SimpleService/getPrice

http://localhost:8080/axis2/services/SimpleService/getDate

瀏覽器是能觀看效果了,但是java怎麼調用呢,下面得由 wsdl來生成接口類
```

export AXIS2_HOME=/media/linux/data/opt/axis2-1.6.2                 #設置環境變量,必須的,不然無法正常編譯,因爲axis2.sh中用到該變量
#在當前stub目錄生成java代碼
$AXIS2_HOME/bin/wsdl2java.sh -uri http://localhost:8080/axis2/services/SimpleService?wsdl -p client -s -o stub         

#將/media/linux/data/opt/axis2-1.6.2/lib下的jar包加入CLASSPATH
find /media/linux/data/opt/axis2-1.6.2/lib/ -name \*.jar |awk '{print "CLASSPATH=$CLASSPATH"$1":"}' > bash_profile

#生成文件後修改成如下
#生成文件後修改成如下
#!/bin/sh                  #自己添加
CLASSPATH=$CLASSPATH/media/linux/data/opt/axis2-1.6.2/lib/commons-cli-1.2.jar:
CLASSPATH=$CLASSPATH/media/linux/data/opt/axis2-1.6.2/lib/jaxb-impl-2.1.7.jar:
.......中間太多,省略吧
CLASSPATH=$CLASSPATH/media/linux/data/opt/axis2-1.6.2/lib/activation-1.1.jar:
export CLASSPATH     #自己添加
source bash_profile             #加載文件設置的環境變量
javac -Xlint -nowarn client/SimpleServiceStub.java      #出現編譯警告,不必理會,有空可以去google下,多多瞭解eclipse無法學到的東西
```

[fedora@fedora src]$ vim hello.java #源代碼如下
```
import java.text.SimpleDateFormat;
import java.util.Date;
import client.SimpleServiceStub;
import client.SimpleServiceStub.GetDate;
import client.SimpleServiceStub.GetPrice;
import client.SimpleServiceStub.GetString;
/**
 * @author 蒋カイセキ    Japan-Tokyo  平成24年6月12日
 * @ブログ http://shoukaiseki.blog.163.com/
 * @E-メール jiang28555@Gmail.com
 */
public class hello {
 public static void main(String[] args) throws Exception  
    {
        SimpleServiceStub stub = new SimpleServiceStub();
        SimpleServiceStub.GetGreeting gg = new SimpleServiceStub.GetGreeting();
        //這個方法不一定是這個setArgs0,具體查看SimpleServiceStub的子類GetGreeting中的方法
        gg.setArgs0("Linux Fedora Asus Shoukaiseki");
        
        System.out.println( stub.getGreeting(gg).get_return());
        System.out.println(stub.getPrice(new GetPrice()).get_return());
        System.out.println(stub.getString(new GetString()).get_return());
        Date da=stub.getDate(new GetDate()).get_return();
        SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
               
        System.out.println(bartDateFormat.format(da));
    } 
}
```
 [fedora@fedora src]$ javac hello.java 

[fedora@fedora src]$ java hello 
```
log4j:WARN No appenders could be found for logger (org.apache.axis2.description.AxisOperation).
log4j:WARN Please initialize the log4j system properly.
asusお早う 、馬鹿野郎！Linux Fedora Asus Shoukaiseki
4728
俺我倒す!!asas??
2012-06-12 00:00:00
```

3.Axis2在默认情况下可以热发布WebService，也就是说，将WebService的.class文件复制到pojo目录中时，Tomcat不需要重新启动就可以自动发布WebService。如果想取消Axis2的热发布功能，可以打开<Tomcat安装目录>\webapps\axis2\WEB-INF\conf\axis2.xml，找到如下的配置代码：
```
<parameter name="hotdeployment">true</parameter>
```
    将true改为false即可。要注意的是，Axis2在默认情况下虽然是热发布，但并不是热更新，也就是说，一旦成功发布了WebService，再想更新该WebService，就必须重启Tomcat。这对于开发人员调试WebService非常不方便，因此，在开发WebService时，可以将Axis2设为热更新。在axis2.xml文件中找到<parameter name="hotupdate">false</parameter>，将false改为true即可。

4.发布WebService的pojo目录只是默认的，如果读者想在其他的目录发布WebService，可以打开axis2.xml文件，并在<axisconfig>元素中添加如下的子元素：
```
    <deployer extension=".class" directory="my" class="org.apache.axis2.deployment.POJODeployer"/>
```

上面的配置允许在<Tomcat安装目录>\webapps\axis2\WEB-INF\my目录中发布WebService。例如，将本例中的SimpleService.class复制到my目录中也可以成功发布（但要删除pojo目录中的SimpleService.class，否则WebService会重名）。

