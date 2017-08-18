# 返回数组的方法  

```Java
// 以下的程序说明了方法中返回一个二维数组的实现过程
public class array013 
{
 public static void main(String args[])
 {
  int A[][]={{51,38,82,12,34},{72,64,19,31}}; // 定义二维数组
  int B[][]=new int[2][5];
  B=add10(A);// 调用 add10(),并把返回的值设给数组 B
  for(int i=0;i<B.length;i++)// 输出数组的内容
  {
   for(int j=0;j<B[i].length;j++)
    System.out.print(B[i][j]+" ");
   System.out.print("\n");
  }
 }
 public static int[][] add10(int arr[][])
 {
  for(int i=0;i<arr.length;i++)
   for(int j=0;j<arr[i].length;j++)
    arr[i][j]+=10;// 将数组元素加 10
  return arr;// 返回二维数组
 }
}

```
