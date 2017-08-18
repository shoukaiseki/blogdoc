# 传递二维数组

```Java
//一下程序说明了如何将一个二维数组作为参数传递到方法中
public class array012
{
 public static void main(String[] args)
 {
  int A[][]={{51,38,22,12,34},{72,64,19,31}};
  print_mat(A);
 }
 public static void print_mat(int arr[][])
 {
  for(int i=0;i<arr.length;i++)
  {
   for(int j=0;j<arr[i].length;j++)
    System.out.print(arr[i][j]+" ");
   System.out.println();
  }
 }
}
```
