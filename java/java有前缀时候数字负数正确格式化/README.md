# java有前缀时候数字负数正确格式化  

```Java
import java.text.DecimalFormat;


public class test {
	
	public static void main(String[] args) {
		int num=-19;
		DecimalFormat df = new DecimalFormat("0");
		System.out.println(df.format(num));
		df = new DecimalFormat("_00;_-0");
		System.out.println(df.format(num));
		
		num=19;
		df = new DecimalFormat("￥00;￥-0");
		System.out.println(df.format(num));
		num=-19;
		df = new DecimalFormat("￥00;￥-0");
		System.out.println(df.format(num));
		
	}

}
```
