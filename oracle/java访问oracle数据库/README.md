# java访问oracle数据库  

查看高亮显示方式 http://hi.baidu.com/jiangxinyi21/blog/item/6e813944da69fde4d62afc61.html

```Java
package oraclesql;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Arrays;
import java.sql.*;
import java.io.*;
import java.util.*;
public class JdbcDrive {

 public static void main(String[] args) 
 { 
  Connection con=null; 
  Statement sm=null; 
  String command=null; 
  ResultSet rs=null; 
  String tableName=null; 
  String cName=null; 
  String result=null; 
  String url="jdbc:oracle:thin:@127.0.0.1:1521:orcl";
//  mxe.db.driver=oracle.jdbc.OracleDriver
  String user="asus";
  String password="asus";
  BufferedReader input=new BufferedReader(new InputStreamReader(System.in)); 
  try 
  { 
   //（1）装载并注册数据库的JDBC驱动程序    
   //载入JDBC驱动：oracle安装目录下的jdbc\lib\classes12.jar
   Class.forName("oracle.jdbc.driver.OracleDriver"); 
   System.out.println("驱动程序已加载"); 
   //注册JDBC驱动：有些地方可不用此句
   java.sql.DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());

   con = DriverManager.getConnection(url, user, password);
   System.out.println("OK,成功连接到数据库"); 
   
  }
  catch(Exception ex)
  { 
   ex.printStackTrace(); 
  } 
  try 
  { 
   /*
    * 插入数据
    */
//    PreparedStatement pst = con.prepareStatement(
//           "insert into test12(ID,SBMC) values(?,?)");
//    System.out.println("要5");
//       pst.setString(1, "131");
//   System.out.println("要4");
//
//   System.out.println("要2");
////       pst.setCharacterStream(2,
////                              new InputStreamReader(new ByteArrayInputStream(s.
////           getBytes())), s.length());
//       pst.setString(2,"有机会");
//
//       //pst.setString(2,s);  //用此句则异常
//       pst.execute();

   /*
    * 查询数据
    */
       Statement st = con.createStatement();
       ResultSet r = st.executeQuery("SELECT * from test12");
       
       while (r.next()) {
      //
      int id=r.getInt(1);
      String s = r.getString(2);
      if (s==null) {
       s ="";
   }
         String xggym =r.getString(3);
      if (xggym==null) {
       xggym ="";
   }
         String ddcsm =r.getString(5);
      if (ddcsm==null) {
       ddcsm ="";
   }
         
         /*
          * 方法0
          */
//         System.out.print(id+"\t");
//         
//         /*
//          * StringBuilder为字符串合并,在此做左对齐不理想
//          */
//         StringBuilder sb = new StringBuilder(String.valueOf(s));
//         while(sb.length() < 44){
//    sb.insert(s.length(), "x");
//   }
//         System.out.print(sb.toString());
////         System.out.print(s);
//         System.out.print("\t"+xggym+"\t"+ddcsm+"\t字符数"+s.length()+"\t字符数");
//         System.out.println(sb.length());
         /*
          * 方法1
          * 
          对齐,如果用Eclipse显示不齐则改变下字体
          更改java文件大小设置
          Window->preferences->General->Appearance->Colors   and   Fonts->Java->Java Editor Text Font->右边按钮Change
          英文版默认的是Courier New 常规 10
          */
         System.out.print(id+"\t");
         
         System.out.print(stringLength(s,40));//加字符总长度为40
         System.out.print(stringLength(xggym,20));
         System.out.println(ddcsm);
         
         
       }

       r.close();
       st.close();
       con.close(); 
   System.out.println("查询结束!");
  }
  catch(Exception ex)
  { 
   ex.printStackTrace(); 
  } 
 } 
 /* 参数为stringLength(字符串,输出总长度)
  * 对齐方法2,返回只包含空格的字符串
  */
 public static String stringLength(String s,int count) {
    String str=s;
    int j=0;
    int i=0;
         if (str!=null) {//字符为空则长度为零
          j=length(str);
   }
    for ( i = 0; i < count-j; i++) {
     str+=" ";
    }
    
    return str;
 }
 /*
  * 参数为字符总长度对齐方法,返回只包含空格的字符串
  *能够整齐了,复制后到记事本能对齐
  */
  public static String getPlace(int count){
    String str="";
    for (int i = 0; i < count; i++) {
     str+="\t";
     i+=7;//一个空格4个字符
    }
    return str;
   }
  
  /*
   * 对齐方法2,返回只包含空格的字符串
   */
  public static String getPlaceb(int count){
    String str="";
    int i = 0;
    for ( i = 0; i < count; i++) {
     str+=" ";
    }
    return str;
   }
  
  /** 
   *   判断一个字符是Ascill字符还是其它字符（如汉，日，韩文字符） 
   *   @param   char   c,   需要判断的字符 
   *   @return   boolean,   返回true,Ascill字符 
   */ 
   public static boolean isLetter(char c)   { 
    int k = 0x80; 
    return c/k == 0?true:false; 
   } 
   /** 
   *   得到一个字符串的长度,显示的长度,一个汉字或日韩文长度为2,英文字符长度为1 
   *   @param   String   s   ,需要得到长度的字符串 
   *   @return   int,   得到的字符串长度 
   */ 
   public static int length(String s){ 
    char[] c=s.toCharArray(); 
    int len=0; 
    for(int i=0;i<c.length;i++) 
    { 
     len++; 
     if(!isLetter(c[i])) 
     { 
      len++; 
     } 
    } 
    return   len; 
   } 
}



/*
 *  在Java程序中，通过JDBC访问Oracle数据库的步骤
2006-01-01 19:05 3041人阅读 评论(1) 收藏 举报
（1）装载并注册数据库的JDBC驱动程序    
载入JDBC驱动：
Class.forName("oracle.jdbc.driver.OracleDriver");
注册JDBC驱动：
java.sql.DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
 
（2）建立与数据库的连接
要建立与数据库的连接，首先要创建指定数据库的URL。连接数据库的URL对象，利用DriverManager 的getConnection方法建立的。数据库URL对象与网络资源的统一资源定位类似，其构成格式如下：
jdbc:subProtocol:subName://hostname:port;DatabaseName=ⅹⅹⅹ
其中：
jdbc表示当前通过Java的数据库连接进行数据库访问；
subProtocol表示通过某种驱动程序支持的数据库连接机制；
subName表示在当前连接机制下的具体名称；
hostname表示主机名；
port表示相应的连接端口；
DatabaseName表示要连接的数据库的名称。
这里以与Oracle数据库的连接为例：
连接Oracle 8/8i/9i数据库(用thin模式)
url = jdbc:oracle:thin:@hostip:1521:oracleSID;
注意：hostip指主机的ip地址，oracleSID指数据库的SID。
再者确定连接数据库的用户名与密码，即user和password 的值：
user = “ⅹⅹⅹ “;
password = “ⅹⅹⅹ“;
最后使用如下语句：
Connection con=java.sql.DriverManager.getConnection(url,user,password);
 
（3）创建Statement对象
例如：
Statement stmt = con.createStatement();
 
（4）调用并执行SQL语句
例如：
String sql = “select a,b,c  from table1";//table1为你所要查询的表名,a,b,c为所要查询的字段
ResultSet rs = stmt.executeQuery(sql);
 
（５）访问ResultSet中的记录集并从中取出记录
例如：
rs.next( );
rs.absolute(4);
String col1=rs.getString(1);
……..
 
（6）依次关闭ResultSet、Statement和Connection对象
例如：
rs.close();
stmt.close();
con.close();
 */
```
