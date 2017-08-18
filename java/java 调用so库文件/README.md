# java 调用so库文件  


本文参考自 http://www.cnblogs.com/yangxia-test/p/4065242.html

//---1.首先创建java类--- //{{{1

```Shell
mkdir -p /tmp/win/javaso/test
vim /tmp/win/javaso/test/Hello.java
```

```Java
package test;
public class Hello
{
    static
    {
        System.loadLibrary("goodluck");
    }
    public native static int get();
    public native static void set(int i);
    public static void main(String[] args)
    {
        Hello hello = new Hello();
        System.out.println("before="+hello.get());
        hello.set(10);
        System.out.println("after="+hello.get());
    }
}
```




//---2.编译java类  --- //{{{1
```Shell
javac test/Hello.java
```


//---3.生成对应的.h头文件,本例中生成的头文件名为 test_Hello.h--- //{{{1

```Shell
javah test.Hello
```


//---4.编写HelloJavaSO.c文件，实现引用第3步中生成的.h头文件，并实现其中声明的方法。--- //{{{1

vim /tmp/win/javaso/HelloJavaSO.c
```C
#include "test_Hello.h"
int i = 0;
JNIEXPORT jint JNICALL Java_test_Hello_get(JNIEnv *env, jclass jc)
{
    return i;
}
JNIEXPORT void JNICALL Java_test_Hello_set(JNIEnv *env, jclass jc, jint j)
{
    i = j;
}
```


//---5.将第4步中编写的HelloJavaSO.c文件，编译成.o文件--- //{{{1

```Shell
gcc -fPIC -D_REENTRANT -I/opt/java/ibm-java-x86-60/include -I/opt/java/ibm-java-x86-60/include/linux -c HelloJavaSO.c
gcc -fPIC -D_REENTRANT -I$JAVA_HOME/include -I$JAVA_HOME/include/linux -c HelloJavaSO.c
```

注: /opt/java/ibm-java-x86-60/include是jni.h头文件所在的路径

/opt/java/ibm-java-x86-60/include/linux 是jni_md.h或者jawt_md.h所在的路径

因为设置了JAVA_HOME，所以直接用 ￥JAVA_HOME代替

//---6.将第5步中生成的HelloJavaSO.o文件编译成.so库文件--- //{{{1
```Shell
gcc -shared HelloJavaSO.o -o libgoodluck.so
```

注:和windows下不同，linux的库文件必须是以libxxx.so形式命令的(或者 libxxx.so.y，y是版本号)，lib前缀是为了系统能够识别它，xxx是java代码System.loadLibrary("xxx");中引用库的名字。

//---7.将第6步中生成的libgoodluck.so文件拷贝到java的加载库LD_LIBRARY_PATH指向的路径中。--- //{{{1
```Shell
mkdir /tmp/win/javaso/lib
cp libgoodluck.so /tmp/win/javaso/lib/
```


//---8.测试执行--- //{{{1
```Shell
java test.Hello 
```

正常运行后的结果如下：
```
before=0
after=10
```

//---错误一--- //{{{2
如果出现此类情况，有两种方式可以处理
```Shell
线程 "main" 中发生异常java.lang.UnsatisfiedLinkError: goodluck (Not found in java.library.path)
	at java.lang.ClassLoader.loadLibraryWithPath(ClassLoader.java:1007)
	at java.lang.ClassLoader.loadLibraryWithClassLoader(ClassLoader.java:971)
	at java.lang.System.loadLibrary(System.java:470)
	at test.Hello.<clinit>(Hello.java:6)
	at java.lang.J9VMInternals.initializeImpl(Native Method)
	at java.lang.J9VMInternals.initialize(J9VMInternals.java:200)
Could not find the main class: test.Hello.  Program will exit.
```

//---第一种：设置 java.library.path 参数--- //{{{3
```Shell
java -Djava.library.path=/tmp/win/javaso/lib/ test.Hello
```
//---第二种：设置 LD_LIBRARY_PATH 变量--- //{{{3
```Shell
export LD_LIBRARY_PATH=/tmp/win/javaso/lib
java test.Hello
```

//---错误二--- //{{{2

加入出现以下情况，则因为gcc编译的为64位库文件，32位jdk无法识别，改用64位jdk即可

```Shell
线程 "main" 中发生异常java.lang.UnsatisfiedLinkError: goodluck (/tmp/win/javaso/lib/libgoodluck.so: 错误 ELF 类: ELFCLASS64)
	at java.lang.ClassLoader.loadLibraryWithPath(ClassLoader.java:1007)
	at java.lang.ClassLoader.loadLibraryWithClassLoader(ClassLoader.java:971)
	at java.lang.System.loadLibrary(System.java:470)
	at test.Hello.<clinit>(Hello.java:6)
	at java.lang.J9VMInternals.initializeImpl(Native Method)
	at java.lang.J9VMInternals.initialize(J9VMInternals.java:200)
Could not find the main class: test.Hello.  Program will exit.
```




//---x32,x64不同编译方式不同jdk测试--- //{{{2

经过gcc -m32 编译32位程序测试，64位jdk无法加载32位库文件
切换32位jdk之后执行编译

```Shell
gcc -m32 -fPIC -D_REENTRANT -I$JAVA_HOME/include -I$JAVA_HOME/include/linux -c HelloJavaSO.c

gcc -m32 -shared HelloJavaSO.o -o libgoodluck.so

java -Djava.library.path=/tmp/win/javaso/ test.Hello
```
切换64位jdk之后运行 java -Djava.library.path=/tmp/win/javaso/ test.Hello 出错

64位jdk正确库文件编译方式
```Shell
gcc -fPIC -D_REENTRANT -I$JAVA_HOME/include -I$JAVA_HOME/include/linux -c HelloJavaSO.c

gcc -shared HelloJavaSO.o -o libgoodluck.so

java -Djava.library.path=/tmp/win/javaso/ test.Hello
```

64位方式编译的在32位jdk同样无法运行



设置不同版本的的so
```Shell
java -Djava.library.path=/tmp/win/javaso/libx32 test.Hello
java -Djava.library.path=/tmp/win/javaso/libx64 test.Hello
```

实例文件下载路径  http://pan.baidu.com/s/1pK3ire7
