# java中的匿名对象

```Java
/*
“匿名对象”
,顾名思义,就是没有明确的声明的对象。读者也可以简单的理解
为只使用一次的对象,即没有任何一个具体的对象名称引用它。请看下面的范例:
注:JAVA匿名对象会被分配到堆内存,分配到内存后运行一次就变成垃圾了,不过内存处理机制会对一定时间内无指针指向的对象进行 destrory()
*/
class Person02
{
 String name="张三";
 int age=25;
 String talk()
 {
  return "我是: "+name+",今年: "+age+"岁";
 }
}
public class TestPerson002
{
 public static void main(String[] args)
 {
  System.out.println(new Person02().talk());//声明了一 Person 匿名对象,调用 Person 类中的 talk()方法。
 }
}
```
