# public方法返回值参数  

```Java
// 以下程序是关于方法的返回类型是整型的范例
public class array008
{
 public static void main(String[] args)
 {
  int num;
  num=star(7);// 输入7给star(),并以num接收返回的数值 
  System.out.println(num+" stars printed");
 }
 public static int star(int n)//返回值int类型,无返回值改成void
 {
  for(int i=1;i<=2*n;i++)
   System.out.print("*");
  System.out.print("\n");
  return 2*n;
 }
}
/*
至于在 star() 方法之前要加上 static 关键字,这是因为 main()方法本身也声明成
static,
而在 static 方法内只能访问到 static 成员变量
(包括数据成员和方法成员)
之故,
因 star()方法被 main()方法所调用,自然也要把 star()声明成 static 才行。此时如果还不
了解 static 的真正用意也没有关系,
本书将在以后的章节对 static 关键字做详尽的介绍。
*/
```
