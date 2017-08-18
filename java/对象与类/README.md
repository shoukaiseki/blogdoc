# 对象与类  

```Java
/*
建立对象
相当于C语言的Struc
不过功能更强大
*/
class Person
{
 String name;
 int age;
 void talk()
 {
  System.out.println("我是: "+name+",今年: "+age+"岁");
 }
}
public class TestPerson001
{
 public static void main(String[] args)
 {
  Person p1= new Person();//声明并实例化一 Person 对象 p1
  Person p2;// 声明 Person 对象 p2
  p2=new Person();// 实例化一 Person 对象 p2开辟内存空间
  // 给 p1 的属性赋值
  p1.name="张三";
  p1.age=25;
  // 给 p2 的属性赋值
  p2.name="李四";
  p2.age=30;
  // 分别用 p1、p2 调用 talk()方法
  p1.talk();
  p2.talk();
 }
}
 
/**
   * let's test generics
   * @param args the command line arguments
   */
```
