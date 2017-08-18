# 传递一维数组

```Java
// 一维数组作为参数来传递,这里的一维数组采用静态方式赋值
public class array011
{
 public static void main(String[] args)
 {
  int score[]={7,3,8,19,6,22};
  largest(score);
 }
 public static void largest(int arr[])//返回值double类型
 {
  int tmp=arr[0];
  for(int i=0;i<arr.length;i++)
   if(tmp<arr[i])
    tmp=arr[i];
  System.out.println("Maximum Number is "+tmp);
 }
}

```
