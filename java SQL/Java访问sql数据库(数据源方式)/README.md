# Java访问sql数据库(数据源方式)  

建立(ODBC)数据源和驱动程序
<br>
　　在控制面板上通过“管理工具”的“数据源(ODBC)”打开“ODBC数据源管理器”对话框，单击“系统DSN”选项卡，然后单击“添加”按钮，得到“创建数据源”对话框，选择“SQL Server”并单击“完成”按钮，在出现的“建立新的数据源到SQL Server”对话框中的“数据源名称”项填写“wzgl”并选取“服务器名”，然后单击“下一步”按钮，选择“使用网络登录ID的Windows NT验证”项目，单击“下一步”按钮，把默认的数据库改为“mydata”，再单击“下一步”，单击“完成”按钮，然后可以单击“测试数据源”，成功后，单击“确定”按钮，完成了(ODBC)数据源和驱动程序的建立。
<br>
新建表 wuzi
<br>
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/java%20SQL/Java%E8%AE%BF%E9%97%AEsql%E6%95%B0%E6%8D%AE%E5%BA%93(%E6%95%B0%E6%8D%AE%E6%BA%90%E6%96%B9%E5%BC%8F)/img/001.jpg)

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/java%20SQL/Java%E8%AE%BF%E9%97%AEsql%E6%95%B0%E6%8D%AE%E5%BA%93(%E6%95%B0%E6%8D%AE%E6%BA%90%E6%96%B9%E5%BC%8F)/img/002.jpg)
<br>
运行结果
<br>
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/java%20SQL/Java%E8%AE%BF%E9%97%AEsql%E6%95%B0%E6%8D%AE%E5%BA%93(%E6%95%B0%E6%8D%AE%E6%BA%90%E6%96%B9%E5%BC%8F)/img/003.jpg)
<br>

源代码jdbc.java http://115.com/file/e6e8907z#

查看高亮显示源码  http://hi.baidu.com/jiangxinyi21/blog/item/77aa742446f19af78a1399af.html
```Java
import java.awt.*;

import java.awt.event.*;

import java.sql.*;

import java.util.*;

import javax.swing.*;

public class jdbc //定义主类

{

 public static void main(String args[])

 {

  GUI gui=new GUI(); //创建类GUI的对象

  gui.pack(); //装载执行GUI类

 }

}

class GUI extends Frame implements ActionListener

{

 TextArea text;Panel panel;TextField sno; Button btn;

 GUI() //构造方法

 {

  super("物资情况查询");setLayout(new BorderLayout());

  setBackground(Color.cyan);

  setVisible(true);text=new TextArea();

  btn=new Button("查询");//加载按钮

  sno=new TextField(16);//加载输入框宽带16

  panel=new Panel();

  panel.add(new Label("输入被查询的物资编号："));

  panel.add(sno); panel.add(btn);

  add("North",panel); add(text,"Center");

  text.setEditable(false);btn.addActionListener(this);

  addWindowListener(new WindowAdapter()

  {

    public void windowClosing(WindowEvent e)

    {

     setVisible(false);

     System.exit(0);

    }

  });

 }

 public void actionPerformed(ActionEvent e)

 {

  if(e.getSource()==btn) //当用户按下查询按钮时

  {

   text.setText("查询结果"+'\n'); //显示提示信息

   try

   {

    Liststudent();

   }

   catch(SQLException ee) { }

  }

 }

 public void Liststudent() throws SQLException //针对数据库的操作

 {

  String bh,mc,xh,lb,dw,sj;

  int sl; float dj,je;

  try

  {

   Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");

  }

  catch(ClassNotFoundException e) { } 

  Connection con=DriverManager.getConnection("jdbc:odbc:wzgl");

  Statement sql=con.createStatement(); //创建Statement对象

  ResultSet rs=sql.executeQuery("select * from wuzi");

  while(rs.next()) //输出被查询的情况

  {

   bh=rs.getString("物资编号");

   mc=rs.getString("物资名称");

   xh=rs.getString("规格型号");

   lb=rs.getString("类别");

   dw=rs.getString("计量单位");

   sl=rs.getInt("数量");

   dj=rs.getFloat("单价");

   je=rs.getFloat("金额");

   sj=rs.getDate("时间").toString();

   if(bh.trim().equals(sno.getText().trim()))

   {

    text.append('\n'+"物资编号"+" "+"物资名称"+" "+"规格型号"+" "+"类别"+" "+"计量单位"+" "+"数量"+" "+"单价"+" "+"金额"+" "+"时间"+'\n');

    text.append('\n'+bh+" "+mc+" "+xh+" "+lb+" "+dw+" "+sl+" "+dj+" "+je+" "+sj+" "+'\n');

   }

  }

 }

}



/**

 * This is about <code>ClassName</code>.

 * {@link com.yourCompany.aPackage.Interface}

 * @author author

 * @deprecated use <code>OtherClass</code>

 */
```
