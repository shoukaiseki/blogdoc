# java中的enum枚举,C的用法,显示本月星期

```Java
/* enum是Java中一个特殊的类 Java提供了一个static方法values()
 * 返回一个数组包含所有声明的该枚举 类型的值并且按照声明时的顺序。 
 * for(type var : array) 表示循环遍历每一个array中的值，也就是将weekday.values()返回的数组 中的值一个一个赋予变量k，然后执行循环体。 
 */
public class weekdayenum {     
	public static void main(String[] args)  {
		int i,a;   
		weekday imasyuu=weekday.sun;
		//imasyuu显示输出起始位置为sunday   
		weekday j;
		j=weekday.mon;
		//本月1号为星期1     
		/*"""""""""""""""""""""""""""""""""""   
		 * var.ordinal() 返回enum类中的索引值   
		 * enum是Java中一个特殊的类，Java提供了一个static方法values()
		 * 返回一个数组包含所有声明的该枚举类型的值，并且按照声明时的顺序。
		 * for(type var : array)表示循环遍历每一个array中的值，也就是将weekday.values()返回的数组中的值一个一个赋予变量k，然后执行循环体。   
		 *"""""""""""""""""""""""""""""""""""*/   
		System.out.println("weekday枚举值中一共有"+weekday.values().length+"个成员");
		for(weekday k : weekday.values())   {   
			System.out.println(k+"在枚举weekday中的枚举索引值为"+k.ordinal());
		}   
		/* 
		 * 通过values()获得枚举值的数组   ""weekday k 声明枚举变量k   
		 */   
		for(weekday k : weekday.values())    {    
			System.out.print("\t"+k);
		}   
		System.out.print("\n\t");
		for(i=1; imasyuu!=j; i++)   
		{    
			System.out.print("\t");
			imasyuu=next(imasyuu);
			//imasyuu=weekday.mon;
		}   
		/*
		 * 输出日期1-31
		 **/
		for(i=1; i<=31; i++)   {    
			System.out.print(i+"\t");
			if(j==weekday.sat)    {
				j=weekday.sun;
				System.out.print("\n\t");
			}    else    {     
				j=weekday.values()[j.ordinal()+1];
				/*j指向下一个枚举变量,相当于C的j++     
				 * weekday.values()是一个数组     
				 * j.ordinal()当前j的数组位置,+1后就是下个位置   
				 *   将weekday数组中的下一个成员赋值给j     
				 *   */    
			}
		}   
		System.out.println();
	}   
	/*""""""""""""""""""  
	 * 让enum类的变量指向下一个元素  
	 *********************/  
	public static weekday next(weekday day) {
		weekday kyo=weekday.sun;
		switch(day)  {
		case sun:   kyo=weekday.mon;
		break;
		case mon:   kyo=weekday.tue;
		break;
		case tue:   kyo=weekday.wed;
		break;
		case wed:   kyo=weekday.thu;
		break;
		case thu:   kyo=weekday.fri;
		break;
		case fri:   kyo=weekday.sat;
		break;
		case sat:   kyo=weekday.sun;
		break;
		}  
		return kyo;
	}  
}     
enum weekday  {     sun,mon,tue,wed,thu,fri,sat }  

```
