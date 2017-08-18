# JAVA变量path , classpth ,java_home设置和作用及HelloWorld的实现  

JAVA变量path , classpth ,java_home设置和作用及HelloWorld的实现
<br>
 
<br>
本人win下测试安装的是jdk-7-windows-i586.zip
<br>
http://115.com/file/bhyej24e#
<br>
默认安装在C:\Program Files\Java\jdk1.7.0目录下
<br>
环境变量配置为
<br>
PATH=.;%JAVA_HOME%\bin
<br>
CLASSPATH=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\toos.jar;
<br>
JAVA_HOME=C:\Program Files\Java\jdk1.7.0
<br>
 
<br>
在把jdk安装到计算机中之后，我们来进行设置使java环境能够使用。 首先右键点我的电脑。打开属性。
<br>
 
<br>
然后选择“高级”里面的“环境变量”，在新的打开界面中的系统变量需要设置三个属性“JAVA_HOME”
<br>
 
<br>
、“path”、“classpath”,其中在没安装过jdk的环境下。path属性是可能存在的(安装过其它软件可能
<br>
 
<br>
会自动增加,如暴风影音,)。而JAVA_HOME和classpath是不存在的。 
<br>
 
<br>
 
<br>
一：点“新建”，然后在变量名写上JAVA_HOME，顾名其意该变量的含义就是java的安装路径，呵呵，然
<br>
 
<br>
后在变量值写入刚才安装的路径“C:\Program Files\Java\jdk1.7.0”。 
<br>
 
<br>
二：其次在系统变量里面找到path，没有就新建,然后点编辑，path变量的含义就是系统在任何路径下都
<br>
 
<br>
可以识别java命令，则变量值为“.;%JAVA_HOME%\bin”，(其中“%JAVA_HOME%”的意思为刚才设置
<br>
 
<br>
JAVA_HOME的值），也可以直接写上“C:\Program Files\Java\jdk1.7.0\bin” 
<br>
三： 最后再点“新建”，然后在变量名上写classpath,该变量的含义是为java加载类(class or lib)路
<br>
 
<br>
径，只有类在classpath中，java命令才能识别。其值为“.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%
<br>
 
<br>
\lib\toos.jar; (要加.表示当前路径)”，与相同“%JAVA_HOME%有相同意思” 
<br>
 
<br>
 
<br>
以上三个变量设置完毕，则按“确定”直至属性窗口消失，下来是验证看看安装是否成功。先打开“开始
<br>
 
<br>
”-> “运行”，打入“cmd”，进入dos系统界面。然后打“java -version”，如果安装成功。系统会显
<br>
 
<br>
示java version jdk"1.7.0"。 
<br>
确保安装在C:\Program Files\Java\jdk1.7.0，环境变量直接复制就可以了，在dos界面中输入javac来查
<br>
 
<br>
看该命令是否合法，同样输入java来查看该命令是否合法 
<br>
 
<br>
这样环境变量就设置好了，下面进行对PATH,CLASSPTH,JAVA_HOME的讲解 
<br>
 
<br>
以下为置JAVA_HOME,CLASSPATH,PATH的目的: 
<br>
1,设置JAVA_HOME: 
<br>
一、为了方便引用，比如，你JDK安装在C:\Program Files\Java\jdk1.7.0目录里，则设置JAVA_HOME为该
<br>
 
<br>
目录路径, 那么以后你要使用这个路径的时候, 只需输入%JAVA_HOME%即可, 避免每次引用都输入很长的
<br>
 
<br>
路径串; 
<br>
二、归一原则, 当你JDK路径被迫改变的时候, 你仅需更改JAVA_HOME的变量值即可, 否则,你就要更改任
<br>
 
<br>
何用绝对路径引用JDK目录的文档, 要是万一你没有改全, 某个程序找不到JDK, 后果是可想而知的----系
<br>
 
<br>
统崩溃! 
<br>
三、第三方软件会引用约定好的JAVA_HOME变量, 不然, 你将不能正常使用该软件, 以后用JAVA久了就会
<br>
 
<br>
知道, 要是某个软件不能正常使用, 不妨想想是不是这个问题. 
<br>
 
<br>
2，设置CLASSPATH: 
<br>
这是一个很有趣,当然也比较折磨初学者的问题, 这个变量设置的目的是为了程序能找到相应的".class"
<br>
 
<br>
文件, 不妨举个例子: 你编译一个JAVA程序---A.java, 会得到一个A.class的类文件,你在当前目录下执
<br>
 
<br>
行java A, 将会得到相应的结果(前提是你已经设置CLASSPATH为"."). 现在, 你把A.class移到别的目录
<br>
 
<br>
下(例如:"e:\"), 执行java A, 将会有NoClassDefFindError的异常,原因就是找不到.class文件, 现在你
<br>
 
<br>
把CLASSPATH增加为:".;e:\"再在任何目录下运行java A, 看看会有什么结果~~:)~~~, 一切正常, java命
<br>
 
<br>
令通过CLASSPATH找到了.class文件! 
<br>
 
<br>
3，设置PATH: 
<br>
道理很简单, 你想在任何时候都使用%JAVA_HOME%\bin\java 等来执行java命令吗, 当然不会, 于是, 你
<br>
 
<br>
可以选择把 %JAVA_HOME%\bin添加到PATH路径下, 这样, 我们在任何路径下就可以仅用java来执行命令了
<br>
 
<br>
.(当你在命令提示符窗口输入你个代码时,操作系统会在当前目录和PATH变量目录里查找相应的应用程序, 
<br>
 
<br>
并且执行.)
<br>
 
<br>
配置好了那我们就测试下吧
<br>
在C盘创建一个java的文件夹,再创建一个HelloWorld.java的文件,复制一下内容保存
<br>
 
<br>
public class HelloWorld
<br>

<br>
{
<br>
 public static void main(String args[]) 
<br>

<br>
 {
<br>
  System.out.println("Hello World"); 
<br>
 }
<br>
} 
<br>

<br>
开始->运行->cmd 打开命令行
<br>
C:\Documents and Settings\Administrator>cd c:\java
<br>
 
<br>
C:\java>javac HelloWorld.java
<br>
 
<br>
C:\java>java  HelloWorld
<br>
Hello World
<br>

<br>
C:\java>
<br>
 
<br>
 
<br>
注:CLASSPATH值的最后没;(分号)会出现以下错误
<br>
错误：找不到或无法加载主类 HelloWorld。
<br>
java HelloWorld时,字母大小写搞错也出错
<br>

<br>
手动加载环境变量,只对此次打开的终端有效
<br>
set classpath=.;%JAVA_HOME%\lib\dt.jar;%JAVA_HOME%\lib\toos.jar;
<br>

