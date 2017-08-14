# Maximo监控程序

高亮源码:http://user.qzone.qq.com/438658902/blog/1325835896

Maximo监控程序weblogic.7z http://115.com/file/c2z3dnfr#

Maximo监控程序weblogic12.01.11.7z http://115.com/file/dp5k8quf#

```Java
package weblogic;
/*
 * 
    ######################################################################
    ## Developed by Chiang Kai-shek(shoukaiseki) <jiang28555@gmail.com> ##
    ##                 12-01-06 Tokyo japan                             ##
    ######################################################################

执行thisjava运行监控
监控原理为访问Maximo页面,获取cooking,查找cooking中是否还有初次进入页面时的信息,默认设置为"欢迎使用 Maximo"


PATH=E:/bea/user_projects/domains/base_domain/bin
为方便执行startweblogic.cmd而设置的环境变量


java运行版本为jdk1.7.0
此监控还不算完美,有待更新
因对使用HttpClient进行账号登录web不是很了解
 */
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Timer;
import java.util.TimerTask;

import com.sun.javadoc.ThrowsTag;

public class AgentTime {

 public static int zenkai = 0;// 前回输出的字符数
 public static SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss ");
 public static Calendar cal =Calendar.getInstance();
 public static Date data = new Date();
 
 public static String urlstring = "";
 public static File txtfile = new File("weblogic.ora");
 public static boolean bool = true;// 上次定时器检测到服务停止标志

 public static long delay=1000;
 public static long period=6000;
 public static boolean cmdbool = true;// 上次定时器检测到服务停止标志
 public static String cmdstop="cmd /k start stopWebLogic.cmd";
 public static String cmdstart="cmd /k start startWebLogic.cmd";
 public static String logo="欢迎使用 Maximo";
 // Maximo网址
 public static String theurl = "http://localhost:7001/maximo/webclient/login/login.jsp";
 public static int a = 0;


 public static long status=1;//检测状态,1为服务正在启动,2为下在运行,3为停止
 public static void main(String[] args) throws IOException {
  readini();
  System.out.println("    ######################################################################");
  System.out.println("    ## Developed by Chiang Kai-shek(shoukaiseki) <jiang28555@gmail.com> ##");
  System.out.println("    ##                 12-01-06 Tokyo japan                             ##");
  System.out.println("    ######################################################################");
  System.out.println();
  cal.setTime(data);//设置时间为当前时间
  long  timeOne=cal.getTimeInMillis();
  data = new Date();
  System.out.println("现在时间为:"+bartDateFormat.format(data));
  
  Timer timer = new Timer();
  System.out.println(new GregorianCalendar(2011, 8, 19, 23, 59, 59)
    .getTime());
  timer.schedule(new TimerTask() {

   @Override
   public void run() {// 实例中的的方法
    try {
      method1();
    } catch (IOException e) {
     // TODO Auto-generated catch block
     e.printStackTrace();
    }// 定时器到后执行的方法,一般在定时器到后的内容具体在外面写
 catch (Exception e) {
     // TODO Auto-generated catch block
//     e.printStackTrace();
    }
   }
  }, delay, period);
  /*
   * schedule(TimerTask task, long delay) 大意是在延时delay毫秒后执行task
   * schedule(TimerTask task, long delay, long period)
   * 在延时delay毫秒后重复的执行task，周期是period毫秒
   */
 }

 public static void method1() throws Exception {
  // 文件保存路径
  URL url = null;
  HttpURLConnection httpConn = null;
  InputStream in = null;

  try {
   url = new URL(theurl);
   httpConn = (HttpURLConnection) url.openConnection();
   HttpURLConnection.setFollowRedirects(true);
   httpConn.setRequestMethod("GET");
   httpConn.setRequestProperty("User-Agent",
     "Mozilla/4.0 (compatible; MSIE 6.0; Windows 2000)");

   // logger.info(httpConn.getResponseMessage());
   in = httpConn.getInputStream();
   // 将URL读入的网页信息转换为String输出
   urlstring = convertStreamToString(in);
   urlstring=new String(urlstring.getBytes(),"UTF8");
   data = new Date();
   if(urlstring.indexOf(logo)<0){
//     System.out.println(urlstring);
//     System.out.println("logo="+logo);
     System.out.println("Maximo服务异常,无法得到正确的页面信息!");
     status=88;
     throw new MalformedURLException();
   }
   String string = bartDateFormat.format(data)+" Maximo服务运行正常!";
   if(status==2){
    //
    String clean="";
    for (int k = 0; k < zenkai; k++) {
     clean+="\b";
     // 删除前次输出的字符
    }
    System.out.print(clean);
   }else{
    System.out.println(); 
    string=string+"\n";
   }

   zenkai=shoukaiseki.math.PrintPercent.length(string);
   System.out.print(string);
   status=2;
   bool = true;// 服务停止后等再次启动能够连接后才重新检测
   
  } catch (MalformedURLException e) {
   resetWeblogic();//重启服务
   // e.printStackTrace();
  } catch (IOException e) {
   resetWeblogic();//重启服务
   // e.printStackTrace();
  } finally {
   try {
    in.close();
    httpConn.disconnect();

   } catch (Exception ex) {
    resetWeblogic();//重启服务
   }
  }
 }

 public static  void resetWeblogic() throws IOException{
  if (bool) {
   bool = false;// 服务停止后等再次启动能够连接后才重新检测
   // ex.printStackTrace();
   // Runtime.getRuntime().exec("cmd /k start E:\\bea\\user_projects\\domains\\base_domain\\bin\\stopWebLogic.cmd");
   // //java调用bat文件
   if(cmdbool){
    Runtime.getRuntime().exec(cmdstop); // java调用bat文件
   }
   Runtime.getRuntime().exec(cmdstart); // java调用bat文件
   status=3;

   System.out.println(bartDateFormat.format(data)+" 服务已经停止!");
   System.out.println(bartDateFormat.format(data)+" サービスが停止されています!");
   System.out.println(bartDateFormat.format(data)+" Service has been stopped!");
  } else {
   data = new Date();
   String string = bartDateFormat.format(data)+" Maximo监控:服务正在启动!";
   if(status==1){
    //
    String clean="";
    for (int k = 0; k < zenkai; k++) {
     clean+="\b";
     // 删除前次输出的字符
    }
    System.out.print(clean);
   }else{
    System.out.println(); 
    string=string+"\n";
   }
   zenkai=shoukaiseki.math.PrintPercent.length(string);
   System.out.print(string);
   status=1;
  }
 }
 public static String convertStreamToString(InputStream is) {
  /*
   * To convert the InputStream to String we use the
   * BufferedReader.readLine() method. We iterate until the BufferedReader
   * return null which means there's no more data to read. Each line will
   * appended to a StringBuilder and returned as String.
   */
  BufferedReader reader = new BufferedReader(new InputStreamReader(is));
  StringBuilder sb = new StringBuilder();

  String line = null;
  try {
   while ((line = reader.readLine()) != null) {
    sb.append(line + "\n");
   }
  } catch (IOException e) {
   e.printStackTrace();
  } finally {
   try {
    is.close();
   } catch (IOException e) {
    e.printStackTrace();
   }
  }

  return sb.toString();
 }
 public static void readini() throws IOException{
  newFile();//无配置文件则自动新建文件
  reFile();//读取文件
 }

 public static void newFile() throws IOException{
  // 新建文件
  if (!txtfile.exists()) {
   if (txtfile.createNewFile()){
    System.out.println("配置文件创建成功!");
    wrFile();//写入文件
   }else{
    System.out.println("创建新文件失败!");
   }
  } else {
   System.out.println("\n\n发现配置文件weblogic.ora!");
  }
 }

 public static void wrFile(){
  //写入文件
  System.out.println("\n写入文件!");
  try {
   FileWriter fw = new FileWriter(txtfile);
   /*FileWriter(File file)
    *写入文件对象(文件号):覆盖原文件
    *FileWriter(File file, boolean append)
    *写入文件对象(文件号,是否覆盖原文件)
    */
   
   String s=wrString();
   System.out.println(s);
   fw.write(s); // 再写内容
   System.out.println("写入成功");
   fw.close();
  } catch (IOException e) {
   e.printStackTrace();
  }
 }
 

 private static void reFile() {
  //读取文件
  System.out.println("\n\n读取文件!");
  try {
   FileReader fr = new FileReader(txtfile);
   BufferedReader br=new BufferedReader(fr);
   br.mark((int)txtfile.length()+1);//标记当前位置  
   /*mark.(int readAheadLimit)
    * 关键是参数readAheadLimit的解释，从字面上看是往前读的限制 ，也就是表示“可以再读多少”。再看详细解释：
    * 是指当还保留有此mark时（i.e.mark未变化），可以再读入字符数的限制。当所读字符数达到此限制（即等于该限制）
    * 或超过此限制之后尝试重设该流的话(reset the stream)，就会导致失败，比方说上例中的异常（产生的原因就是
    * 读入的字符数等于readAheadLimit，都是4）。当限制值大于输入缓存（所谓输入缓存，BufferedReader类
    * 有两个构造子，其一就有这个参数，无参版本就以默认值替代，大小是8192）时，就会分配一个大小不小于限制值的新缓存
    * （这里说不小于其实就是等于）.因此要小心使用大数值。
    */
   int i=0;
   while(br.read()!=-1){
    i++;
   }

   br.reset();//复位到最近的标记位  
   String sr=null;
   String a=null;
   String b=null;
   while ((sr=br.readLine()) != null)
         {
//    sr=new String(sr.getBytes(),"UTF8");
    System.out.println(sr);
    if(sr.isEmpty()){
     continue;
    }
    a=sr.substring(0, 1);
    if(a.equals("#")){
     continue;
    }
    //取等号位置
    int value = sr.indexOf("=");
    a=sr.substring(0, value).trim();//=号前面取首尾空
    b=sr.substring(value+1,sr.length()).trim();//=号后面取首尾空
    if(a.equals("delay")){
     delay=Long.parseLong(b);
     continue;
    }if(a.equals("period")){
     period=Long.parseLong(b);
     continue;
    }if(a.equals("cmdbool")){
     if(Integer.parseInt(b)==0){
      cmdbool=false;
     }else{
      cmdbool=true;
     }
     continue;
    }if(a.equals("cmdstop")){
     cmdstop=b;
     continue;
    }if(a.equals("cmdstart")){
     cmdstart=b;
     continue;
    }if(a.equals("theurl")){
     theurl=b;
     continue;
    }if(a.equals("logo")){
     logo=b;
     continue;
    }
         }
   br.close();
   fr.close();
  } catch (IOException e) {
   e.printStackTrace();
  }
  System.out.println("delay="+delay);
  System.out.println("period="+period);
  System.out.println("cmdbool="+cmdbool);
  System.out.println("cmdstop="+cmdstop);
  System.out.println("cmdstart="+cmdstart);
  System.out.println("logo="+logo);
  System.out.println("theurl="+theurl+"\n\n");
 }
 
 public static String wrString() throws UnsupportedEncodingException{
  String s="";
  s=s+"#注释符号为#\r\n";
  s=s+"#注意要区分大小写\r\n";
  s=s+"#time的delay值,默认为delay=1000\r\n";
  s=s+"delay=1000\r\n";
  s=s+"#time的period值,默认为period=6000\r\n";
  s=s+"period=6000\r\n";
  s=s+"#是否在启动时先停止weblogic服务标志位,1为停止,默认为cmdbool=1\r\n";
  s=s+"cmdbool=1\r\n";
  s=s+"#stopWebLogic.cmd启动脚本名,默认在设置环境变量的情况下为cmd /k start stopWebLogic.cmd\r\n";
  s=s+"#也可为cmd /k start E://bea//user_projects//domains//base_domain//bin//stopWebLogic.cmd\r\n";
  s=s+"cmdstop=cmd /k start stopWebLogic.cmd\r\n";
  s=s+"cmdstart=cmd /k start startWebLogic.cmd\r\n";
  s=s+"#页面标识字符,即为访问时为确保得到正确页面信息,默认为logo=欢迎使用 Maximo\r\n";
  s=s+"logo=欢迎使用 Maximo\r\n";
  s=s+"#监控时访问的网站名,默认为theurl=http://localhost:7001/maximo/webclient/login/login.jsp\r\n";
  s=s+"theurl=http://localhost:7001/maximo/webclient/login/login.jsp\r\n";
  String ds=new String(s.getBytes(),"UTF8");
//  System.out.println(ds);
  System.out.println(s);
  return s; 
 }
}
```
