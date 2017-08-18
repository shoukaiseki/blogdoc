# java date类 Calendar类  

```Java
import java.util.*;

public class Example7_2 {
 public static void main(String args[]) {
  Calendar calendar = Calendar.getInstance(); // 创建一个日历对象
  calendar.setTime(new Date()); // 用当前时间初始化日历时间
  String 年 = String.valueOf(calendar.get(Calendar.YEAR)), 月 = String
    .valueOf(calendar.get(Calendar.MONTH) + 1), 日 = String
    .valueOf(calendar.get(Calendar.DAY_OF_MONTH)), 星期 = String
    .valueOf(calendar.get(Calendar.DAY_OF_WEEK) - 1);
  int hour = calendar.get(Calendar.HOUR_OF_DAY), minute = calendar
    .get(Calendar.MINUTE), second = calendar.get(Calendar.SECOND);
  System.out.println("现在的时间是：");
  System.out.print("" + 年 + "年" + 月 + "月" + 日 + "日 " + "星期" + 星期);
  System.out.println(" " + hour + "时" + minute + "分" + second + "秒");
  calendar.set(1931, 8, 18); // 将日历翻到1931年九月十八日，8表示九月
  long timeOne = calendar.getTimeInMillis();
  calendar.set(1945, 7, 15); // 将日历翻到1945年八月十五日,7表示八月
  long timeTwo = calendar.getTimeInMillis();
  long 相隔天数 = (timeTwo - timeOne) / (1000 * 60 * 60 * 24);
  System.out.println("1945年8月15日和1931年9月18日相隔" + 相隔天数 + "天");
 }
}
```

这是一个关于日历的程序，主要是输出了两条信息，第一条是现在是哪年哪月哪日星期几，输出的第二个信息就是1945年8月15日和1931年9月18日相隔多少天。想看明白这个程序并不难，他就是通过Calenar对象来获得一些时间信息，比如calendar.get(Calendar.YEAR))这句就是获取现在是多少年，这些方法你记住就行了，具体是怎么获得到得都是sun公司自己实现的，你没必要去知道他是怎么实现的，如果你要是对源代码感兴趣也可以看看。

<br>
MONTH加1的原因：
<br>
public static final int MONTH
<br>
指示月份的 get 和 set 的字段数字。这是一个特定于日历的值。在格里高利历和罗马儒略历中一年中的第一个月是 JANUARY，它为 0；最后一个月取决于一年中的月份数。
<br>
简单来说，因为这个值的初始值是0，因此我们要用它来表示正确的月份时就需要加1。
<br>
WEEK减1的原因：
<br>
public static final int DAY_OF_WEEK
<br>
get 和 set 的字段数字，指示一个星期中的某天。该字段可取的值为 SUNDAY、MONDAY、TUESDAY、WEDNESDAY、THURSDAY、FRIDAY 和 SATURDAY
<br>
观察代码，你会发现其实week是用来确定随后的字符串week1该如何截取的，我们知道DAY_OF_WEEK是获取当前日期是一周中的第几天，而一周从周日算起，因此当我们取得这个值之后，为了要正确的截取出随后的字符串week1中的那个中文字符，因此它需要减1来达到目的。你只要跟踪一下程序运行，观察变量的赋值就会理解它这样编写的用意了。
<br>
定义day时不用的原因：
<br>
public static final int DATE
<br>
get 和 set 的字段数字，指示一个月中的某天。它与 DAY_OF_MONTH 是同义词。一个月中第一天的值为 1。 
<br>
根据定义我们可以知道，这个值取得后不需要做任何变更就是程序需要的值。
<br>
substring(week, week+1)：
<br>
public String substring(int beginIndex,
<br>
                        int endIndex)
<br>
返回一个新字符串，它是此字符串的一个子字符串。该子字符串从指定的 beginIndex 处开始，直到索引 endIndex - 1 处的字符。因此，该子字符串的长度为 endIndex-beginIndex。
<br>
根据定义，我们就知道这个方法的用途了。举例来说，假如今天是星期四，那么之前获得的week的值就是4，因为我们取到了DAY_OF_WEEK（这里是5）后又减了1，然后我们用这个变量week来帮助我们截取字符串week1,这里调用了substring(4,5),所以取到的字符就是“四，正是我们需要的字符。
<br>

