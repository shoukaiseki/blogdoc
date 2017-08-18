# 构造器重载 继承 this super extends

```Java
class Person
{
 String name ;
 int age ;
 public Person()//构造器无返回值,故无需void
 {
  System.out.println("1. public Person()");
 }
 public Person(String name,int age)
 { 
  this();//调用类中的主无参构造器,调用的是最前的构造器,有参放前面则调用有参的
  this.name = name ;//this.name指该类中的主变量,即对象本身
  this.age = age ;
  // 用 this 调用构造方法,此时不是放在构造方法的首行
 // this() ;//调用令一个构造,this只能放在本构造第一句
  talk();//可以调用本类中的方法 Persion(); 
  System.out.println("2. public Person(String name,int age)");
 }
 public void talk()
 {
  //this();//方法中不能调用构造器
  // 在这里也用一个 this
  System.out.println("我是:"+name+",今年:"+age+"岁");
 } 
}
/*"""""""""""""""""""""""""""""""""
""extends 子类
""下面语句中声明Person是SuperPerson的父类
"""""""""""""""""""""""""""""""""*/
class SuperPerson extends Person
{
 String kuni;
 public SuperPerson(String name,int age)
 {
  super(name,age);//调用父类构造器
  System.out.println("1 this is super command");//比父类多一句输出

 }
 public SuperPerson(String name,int age,String kuni)
 {
  this(name,age);//调用此类中的构造器
  this.kuni=kuni;
  System.out.println("我是:"+name+",今年:"+age+"岁,form:"+kuni);//多一句输出
 }
 public SuperPerson()
 {
  super();//调用父类无参构造器
  System.out.println("2 this is super command");//比父类多一句输出
 }
 public void talk()
 {
  super.talk();//调用父类talk方法
  System.out.println("3 this is super command");//比父类方法多一句输出
 }
}
public class TestJavaThis1
{
 public static void main(String[] args)
 {
  new Person("张三",25) ;
  System.out.println("\n");
  new Person();
  System.out.println("\n\n");
  new SuperPerson("李四",27);
  System.out.println("\n");
  new SuperPerson();
  System.out.println("\n\n");
  new SuperPerson("王五",27,"japan");
 }
}
```
