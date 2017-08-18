# java计算今天是今年的第几天  

查看高亮显示方式http://hi.baidu.com/jiangxinyi21/blog/item/556f2a2c98c49930d507421c.html

```Java
/*查看高亮显示方式http://hi.baidu.com/jiangxinyi21/blog/item/556f2a2c98c49930d507421c.html
 */
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class sd {
 public static void main(String[] args) {
  int year, month, today, day;// 年月日
  int manydays = 1;// 今天是今年的第几天,今年的1月1日是今年的第一天
  // TODO Auto-generated method stub
  // 1
  // 定义时间格式，如：2011-08-25-22-43
  SimpleDateFormat bartDateFormat = new SimpleDateFormat(
    "yyyy-MM-dd-HH-mm");
  Date date = new Date(); // 取现在时间
  Calendar cal = Calendar.getInstance();
  cal.setTime(date);// 设置时间
  year = cal.get(Calendar.YEAR);// 取年份
  month = cal.get(Calendar.MONTH) + 1;// 取月份
  today = cal.get(Calendar.DAY_OF_MONTH);
  // 按照规定格式输出当前时间
  System.out.println(bartDateFormat.format(date)); // 2011-08-25-22-43
  System.out.println(year + "-" + month + "-" + next(month, year));
  for (int i = 1; i <= month; i++) {
   day = next(i, year);// 本月一共几天
   System.out.println(day + "nichi " + i + " kongetsu no goukei");
   // 循环条件,j<=每月的天数,如果在i==month的情况下j>=today也不循环
   for (int j = 1; j <= day && !(i == month && j >= today); j++)
    manydays++;
   System.out.println("manydays=" + manydays);
  }
  System.out.println("houhou1: kyo ha kotoshi no " + manydays
    + " nichi medesu");
  /*
   * """"""""""""""""""""' ""方法二 """""""""""""""""""""
   */
  cal.set(2011, 0, 1);// 设置今年的1月1日
  long timeOne = cal.getTimeInMillis();
  cal.setTime(date);// 将日历翻到1945年八月十五日,7表示八月
  // System.out.println(
  long timeTwo = cal.getTimeInMillis();
  long daysapart = (timeTwo - timeOne) / (1000 * 60 * 60 * 24) + 1;// 二者时间相隔天数,第几天要加1
  System.out.println("houhou2: kyo ha kotoshi no " + daysapart
    + " nichi medesu");

  cal.set(1931, 8, 18);// 将日历翻到1931年九月十八日，8表示九月
  timeOne = cal.getTimeInMillis();
  cal.set(1945, 7, 15);// 将日历翻到1945年八月十五日,7表示八月
  timeTwo = cal.getTimeInMillis();
  daysapart = (timeTwo - timeOne) / (1000 * 60 * 60 * 24);// 二者时间相隔天数
  System.out.println("1945年8月15日和1931年9月18日相隔" + daysapart + "天");

 }

 /*
  * """""""""""""""""" 让enum类的变量指向下一个元素******************
  */
 public static int next(int month, int year) {
  int kyo = 0;
  switch (month) {
  case 1:
   kyo = 31;
   break;
  case 2:
   if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
    kyo = 29;
   else
    kyo = 28;
   break;
  case 3:
   kyo = 31;
   break;
  case 4:
   kyo = 30;
   break;
  case 5:
   kyo = 31;
   break;
  case 6:
   kyo = 30;
   break;
  case 7:
   kyo = 31;
   break;
  case 8:
   kyo = 31;
   break;
  case 9:
   kyo = 30;
   break;
  case 10:
   kyo = 31;
   break;
  case 11:
   kyo = 30;
   break;
  case 12:
   kyo = 31;
   break;
  }
  return kyo;
 }

}


```
