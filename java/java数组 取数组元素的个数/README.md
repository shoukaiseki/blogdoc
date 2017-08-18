# java数组 取数组元素的个数 

```Java
 public class array001
 {
         public static void main(String args[])
         {
                 int i;
                 int a[];
                 int b[]=new int[3];
                 int c[]={3,3,2};
                 a=new int[3];
                 for(i=0;i<3;i++)
                         System.out.print("a["+i+"]="+a[i]+",\t");
                 for(i=0;i<3;i++)
                         System.out.print("b["+i+"]="+b[i]+",\t");
                 for(i=0;i<a.length;i++)
                         System.out.print("c["+i+"]="+c[i]+",\t");
                 System.out.println("\n数组长度是: "+a.length);
         }
 }
```
