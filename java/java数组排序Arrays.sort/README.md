# java数组排序Arrays.sort

```Java
// 以下程序是数组的排序操作,在这里使用了 sort 方法对数组进行排序
import java.util.*;
public class array004
{
	public static void main(String[] args)
	{
		int a[] = {4,32,45,32,65,32,2} ;
		System.out.print("数组排序前的顺序:");
		for(int i=0;i<a.length;i++)
			System.out.print(a[i]+" ");
		Arrays.sort(a);// 数组的排序方法
		System.out.print("\n数组排序后的顺序:");
		for(int i=0;i<a.length;i++)
			System.out.print(a[i]+" ");
		System.out.print("\n");
	}
}
```
