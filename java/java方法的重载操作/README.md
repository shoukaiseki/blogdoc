# java方法的重载操作  

```Java
// 以下程序说明了方法的重载操作
public class array010
{
 public static void main(String[] args)
 {
  int int_sum;
  double double_sum;
  int_sum=add(3,5);
  System.out.println("int_sum = add(3,5) is : "+int_sum);
  int_sum=add(3,5,6);
  System.out.println("int_sum = add(3,5,6) is : "+int_sum);
  double_sum=add(3.2,6.5);
  System.out.println("double_sum = double(3.2,6.5) is : "+double_sum);
 }
 public static int add(int x,int y)//返回值int类型
 {
  return x+y;
 }
 public static int add(int x,int y,int z)//返回值int类型
 {
  return x+y+z;
 }
 public static double add(double x,double y)//返回值double类型
 {
  return x+y;
 }
}
/*
方法的重载就是在同一个类中允许同时存在一个以上的同名方法,只要它们的参
数个数或类型不同即可。在这种情况下,该方法就叫被重载了,这个过程称为方法的
重载。

输出结果:
int_sum = add(3,5) is : 8
int_sum = add(3,5,6) is : 14
double_sum = double(3.2,6.5) is : 9.7

可以发现上题中的 add 被重载了三次,但每个重载了的方法所能接受参数的个数
和类型不同,相信读者现在应该可以明白方法重载的概念了。

*/
```
