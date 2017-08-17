# 递归 SQL 级别 1 出现错误 ORA-01000 超出打开游标的最大数


```Java
package oraclesql;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class 游标最大值测试 {

 static Connection con = null;
 static Statement sm = null;
 static ResultSet rs = null;
 static String tableName = null;
 static String cName = null;
 static String result = null;
 static String url = "jdbc:oracle:thin:@localhost:1521:orcl";
 static String driver = "oracle.jdbc.driver.OracleDriver";
 static String user = "maximo_75";
 static String password = "maximo_75";

 public void setDefuorutoConnection() {
  try {
   // （1）装载并注册数据库的JDBC驱动程序
   // 载入JDBC驱动：oracle安装目录下的jdbc\lib\classes12.jar
   println("正在试图加载驱动程序 " + driver);
   Class.forName(driver);
   println("驱动程序已加载");
   // 注册JDBC驱动：有些地方可不用此句
   println("url=" + url);
   println("user=" + user);
   println("password=" + password);
   println("正在试图连接数据库--------");
   java.sql.DriverManager
     .registerDriver(new oracle.jdbc.driver.OracleDriver());

   con = DriverManager.getConnection(url, user, password);

   println("OK,成功连接到数据库");

   /**
    * 关闭自动更新
    */
   con.setAutoCommit(false);
  } catch (Exception ex) {
   ex.printStackTrace();
   println(ex.getMessage(), true);
  }
 }



 public static void main(String[] args) throws SQLException {
  游标最大值测试 jd = new 游标最大值测试();
  jd.setDefuorutoConnection();
  //show parameter open_cursors;--查询允许的游标最大值
  //alter system set open_cursors=1000 scope=both;--修改游标最大值为1000
  
  //在该程序运行时执行下列语句,查询"执行  SELECT sysdate FROM dual 时"占用的游标数
  //select count(*) from v$open_cursor where sql_text like 'select rowid, sysdate FROM dual';
  
  //j为 游标最大值+1
  int j=3001;
  for (int i = 0; i < j; i++) {
   jd.readData();
   System.out.println("i="+(i+1));
  }
 }

 public  void readData() {
  try {
   /*
    * 查询数据
    */
   Statement st = con.createStatement();
   st = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
   ResultSet r = st
     .executeQuery("SELECT sysdate FROM dual");
   r.last();
   System.out.println("行数"+r.getRow());
   r.beforeFirst() ;//将光标移动到此 ResultSet 对象的开头，正好位于第一行之前。
   
   ResultSetMetaData rsmd=r.getMetaData();
   int column=rsmd.getColumnCount();
   System.out.println("列数为"+column);
   for (int i = 0; i < rsmd.getColumnCount() ; i++) {
    System.out.print(rsmd.getColumnName(i+1)+"\t");
   }
   System.out.println();
   while (r.next()) {
    for (int i = 0; i < column; i++) {
     System.out.print(r.getString(i+1)+"\t");
    }
    System.out.println();
   }

//   r.close();
//   st.close();
//   con.close();
   System.out.println("查询结束!");
  } catch (Exception ex) {
   ex.printStackTrace();
  }
 }


 public static void println() {

 }

 public static void println(String s, boolean b) {
  System.out.println(s);
 }

 public static void println(String s) {
  System.out.println(s);
 }
}

```
