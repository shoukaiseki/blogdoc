# 引用数据类型的传递 相对与C的指针  

```Java
/*
封装的重要性
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
class Person01
{
 private String name;
 private int age=1;//设置该变量为私有,其它类不能访问
 private void talk()//设置该方法为私有
 {
  System.out.println("P01  我是: "+name+",今年: "+age+"岁");
 }
 public void say()//设置为公有方法
 {
  talk();
 }
 public void setName(String str)
 {
  name=str;
 }
 public void setAge(int a)
 {
  if(a>0)
   age=a;//不能赋值小于1的数值给该类中的age变量,可以认为这是检查关卡
  else
   System.out.println(a+"不是一个有效的数值,进关检查未通过,不得进入修改变量age!");

 }
 public String getName()
 {
  return name;
 }
 public int getAge()
 {
  return age;
 }
}
public class TestPerson001
{
 public static void main(String[] args)
 {
  Person p1= new Person();//声明并实例化一 Person 对象 p1
  Person01 p2,p3,p4;// 声明 Person 对象 p2
  p2=new Person01();// 实例化一 Person 对象 p2开辟内存空间
  // 给 p1 的属性赋值
  p1.name="张三";
  p1.age=25;
  // 给 p2 的属性赋值
  p2.setName("李四");//因类中的name变量为私有(不公开)所以不能直接调用
  p2.setAge(-25);
  // 分别用 p1、p2 调用 talk()方法
  p1.talk();
  p2.say();
  p2.setAge(30);
  p2.say();
  System.out.println("p3=p2,p2=null,输出p3");
  p3=p2;
  p2=null;
  p3.say();
  System.out.println("p2已经没指向任何内存地址,无法进行任何操作输出");
  System.out.println("p3.name=周五,p4=p2=p3,p3=null,p4.age=22,fun(p4),输出p4和p2");
  p3.setName("周五");
  p4=p2=p3;
  p3=null;
  p4.setAge(22);
  fun(p4);
  p4.say();
  p2.say();
  System.out.println("p2 and p4 point to the same memory address");
 }
  public static void fun(Person01 p)
  {
   p.setAge(26);
  }
}
```
