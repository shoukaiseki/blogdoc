# java数组复制arraycopy

```Java
// 以下这段程序说明数组的拷贝操作
public class array003
{
	public static void main(String[] args)
	{
		int a1[] = {1,2,3,4,5} ; //声明两个整型数组 a1、a2,并进行静态初始化
		int a2[] = {9,8,7,6,5,4,3} ; 
		System.arraycopy(a1,0,a2,0,3);// 执行数组拷贝的操作
		System.out.print("a1 数组中的内容:");
		for(int i=0;i<a1.length;i++)// 输出 a1 数组中的内容
			System.out.print(a1[i]+" ");
		System.out.println();
		System.out.print("a2 数组中的内容:"); 
		for(int i=0;i<a2.length;i++)//输出 a2 数组中的内容
			System.out.print(a2[i] +" ");
		System.out.println("\n 数组拷贝完成!");
	}
}
```
