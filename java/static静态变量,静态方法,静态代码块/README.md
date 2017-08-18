# static静态变量,静态方法,静态代码块  

```Java
class Person
{
 String name ;
 static String city = "中国";//静态变量,不管对象有几个,此变量只有一个
 int age ;
 public Person(String name,int age)
 {
  this.name = name ;
  this.age = age ;
 }
 public String talk()
 {
  return "我是:"+this.name+",今年:"+this.age+"岁,来自:"+city;
 }
 //静态方法,只能调用静态变量,否则编译出错
 public static void setCity(String c)
 {
  city = c ;//静态方法可以调用静态变量
  //age=22;//非法语句,启用后编译错误,静态方法不了调用非静态变量
 }
 //此class被Load时,静态代码块会被自动执行,且只执行一次
 static
 {
  System.out.println("koreha Person no static class");
 }

}
public class TestStatic 
{
 public static void main(String[] args)
 {
  Person p1 = new Person("张三",25) ;
  Person p2 = new Person("李四",30) ;
  Person p3 = new Person("王五",35) ;
  System.out.println("修改之前信息:"+p1.talk()) ;
  System.out.println("修改之前信息:"+p2.talk()) ;
  System.out.println("修改之前信息:"+p3.talk()) ;
  System.out.println(" ************* 修改之后信息 **************");
  // 修改后的信息
  p1.city = "美国" ;
  System.out.println("修改之后信息:"+p1.talk()) ;
  System.out.println("修改之后信息:"+p2.talk()) ;
  System.out.println("修改之后信息:"+p3.talk()) ;
  System.out.println(" ************* 静态方法修改之后信息 **************");
  //静态方法修改
  Person.setCity("japan") ;
  System.out.println("静态方法修改之后信息:"+p1.talk()) ;
  System.out.println("静态方法修改之后信息:"+p2.talk()) ;
  System.out.println("静态方法修改之后信息:"+p3.talk()) ;
 }
 //本class被Load时,静态代码块会被自动执行,且只执行一次
 static
 {
  System.out.println("koreha TestStatic no static class");
 }
}
```
