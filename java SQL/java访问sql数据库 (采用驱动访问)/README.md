# java访问sql数据库 (采用驱动访问)  

1.安装microsoft SQL Server2000 开发版 SQLServer20004in1cn.iso 下载地址http://115.com/file/cljh65o1#
<br>
   安装过程请查看SQL_Server_2000安装图解说明.doc 下载地址http://115.com/file/dn3zsxpk#
<br>
   安装过程中的sa密码建议设置为空,当然也可设置自己想要的密码
<br>
2.安装SQL SP4补丁SQL2000.MSDE-KB884525-SP4-x86-CHS.exe 下载地址http://115.com/file/e6enx9hs#
<br>
   安装过程跟第一步一样,只是密码设置要安装第一步设置的密码,如果第一步密码为空这次也为空
<br>
3.安装java访问sql驱动sqlserver2000jdbcsericepack3.exe 下载地址http://115.com/file/cljh6eu2#
<br>
   安装后的目录为C:\Program Files\Microsoft SQL Server 2000 Driver for JDBC\lib
<br>
   可查看Java连接SQL_Server_2000.pdf 下载地址http://115.com/file/e6enxnma#
<br>
4.开始->程序->Microsoft SQL Server->企业管理器--->Microsoft SQL server->SQL server组->local->右键点击数据库
<br>
   ->新建数据库mydata->mydata->右键点击表->
<br>
新建表java访问sql数据库 (采用驱动访问) 

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/java%20SQL/java%E8%AE%BF%E9%97%AEsql%E6%95%B0%E6%8D%AE%E5%BA%93%20(%E9%87%87%E7%94%A8%E9%A9%B1%E5%8A%A8%E8%AE%BF%E9%97%AE)/img/001.jpg)

->保存名为asus->右键点击表asus->打开表->返回所有行->

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/java%20SQL/java%E8%AE%BF%E9%97%AEsql%E6%95%B0%E6%8D%AE%E5%BA%93%20(%E9%87%87%E7%94%A8%E9%A9%B1%E5%8A%A8%E8%AE%BF%E9%97%AE)/img/002.jpg)


5.查看高亮源代码

```Java

import java.sql.*; 

import java.io.*; 

public class DBColumn 

{

 public static void main(String[] args) 

 { 

  Connection con=null; 

  Statement sm=null; 

  String command=null; 

  ResultSet rs=null; 

  String tableName=null; 

  String cName=null; 

  String result=null; 

  BufferedReader input=new BufferedReader(new InputStreamReader(System.in)); 

  try 

  { 

   Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver"); 

   System.out.println("驱动程序已加载"); 

   //SQL SERVER的登陆方式必须为使用SQL SERVER密码登陆认证方式 

   //("jdbc:microsoft:sqlserver://服务器地址:访问端口","SQL用户名","SQL密码"); 

   con=DriverManager.getConnection("jdbc:microsoft:sqlserver://127.0.0.1:1433","sa",""); 

   con.setCatalog("mydata");//数据库名

   System.out.println("OK,成功连接到数据库mydata"); 

  }

  catch(Exception ex)

  { 

   ex.printStackTrace(); 

  } 

  try 

  { 

   sm=con.createStatement(); 

   System.out.println("输入表名asus "); 

   //tableName=input.readLine(); //手动输入表名

   //tableName="TeacherBasicInf";//设置表名为TeacherBasicInf 

   tableName="asus";//设置表名为asus

   while(true)

   { 

    System.out.println("输入列名(为空时程序结束):"); 

    cName=input.readLine(); //输入列名name

    if(cName.equalsIgnoreCase("")) 

     break; 

    command="select "+cName+" from "+tableName; 

    rs=sm.executeQuery(command); 

    if(!rs.next()) 

     System.out.println("表名或列名输入有误"); 

    else

    { 

     System.out.println("查询结果为:"); 

     do 

     { 

      //result=rs.getString(cName); 

      //result=new String(result.getBytes("ISO-8859-1"),"GB2312"); 

      System.out.println(rs.getString(1));//System.out.println(result); 

     }

     while(rs.next()); 

     } 

   } 

   System.out.println("查询结束!");

  }

  catch(Exception ex)

  { 

   ex.printStackTrace(); 

  } 

 } 

}
```
