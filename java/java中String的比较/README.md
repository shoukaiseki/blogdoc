# java中String的比较

```Java
public class StringCompare {

 public static void main(String[] args) {

  String a = "asus!";

  String b = "linux";

  if (a.length() == b.length())

   System.out.println("a.length() = b.length() = " + a.length());

  else

   System.out.println("a.length() = " + a.length() + "\tb.length() = "

     + b.length());

  if (a.equals(b))

   System.out.println(a + " = " + b);

  else

   System.out.println(a + " != " + b);

  if (a == b)// 比较内存地址

   System.out.println("address a==b");

  else

   System.out.println("address a!=b");

  a = "java";// 字符串重新赋值是先断开原来的内存地址再开辟新的地址

  b = "java";// 内存中有这个字符串了,所以不必浪费空间,直接指向地址即可

  System.out.println();

  if (a.length() == b.length())// 比较数据长度

   System.out.println("a.length() = b.length() = " + a.length());

  else

   System.out.println("a.length() = " + a.length() + "\tb.length() = "

     + b.length());

  if (a.equals(b))// 比较字符内容

   System.out.println(a + " = " + b);

  else

   System.out.println(a + " != " + b);

  if (a == b)// 比较内存地址

   System.out.println("address a==b");

  else

   System.out.println("address a!=b");

  b = new String("java");// 开辟新内存空间给b,所以a的地址不等于b

  System.out.println();

  if (a.length() == b.length())// 比较数据长度

   System.out.println("a.length() = b.length() = " + a.length());

  else

   System.out.println("a.length() = " + a.length() + "\tb.length() = "

     + b.length());

  if (a.equals(b))// 比较字符内容

   System.out.println(a + " = " + b);

  else

   System.out.println(a + " != " + b);

  if (a == b)// 比较内存地址

   System.out.println("address a==b");

  else

   System.out.println("address a!=b");

 }

}
```



查看高亮显示方式http://hi.baidu.com/jiangxinyi21/blog/item/b81476f33a91530d6c22eb63.html
