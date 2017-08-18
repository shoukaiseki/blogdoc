# 二维数组元素的引用及访问 array

```Java
// 二维数组的使用说明,这里采用静态赋值的方式
public class array005
{
 public static void main(String args[])
 {
  int i,j,sum=0;
  int num[][]={{30,35,26,32},{33,34,30,29}};
  for(i=0;i<num.length;i++)
  {
   System.out.print("第 "+(i+1)+"个人的成绩为:");
   for(j=0;j<num[i].length;j++)
   {
    System.out.print(num[i][j]+" ");
    sum+=num[i][j];
   }
    System.out.println();
  }
  System.out.println("\n总成绩是 "+sum+" 分! ");
 }
}
```
