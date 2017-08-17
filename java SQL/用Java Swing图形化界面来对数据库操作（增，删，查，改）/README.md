# 用Java Swing图形化界面来对数据库操作（增，删，查，改）  

查看数据库配置方法

http://hi.baidu.com/jiangxinyi21/blog/item/727ab287f60533e1503d92e2.html?timeStamp=1315385401523


```Java
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;
import java.awt.*;
import javax.swing.*;
/*
* 实例：用Java Swing图形化界面来对数据库操作（增，删，查，改）
数据库版本：SQLServer2000
数据库名：dxaw
用户名：sa
密码：
表名：bankAccount
表结构：id(int[自动增长]),ownerName(varchar),accountValue(varchar),accountLevel(varchar)

列名
数据类型
长度
允许空

accountID
int
4
不可空
标示:不用于复制;标示种子:1;表示增量:1;
ownerName
varchar
50
可空
accountValue
varchar
50
可空
accountLevel
varchar
50
可空

赵 钱 孙 李
周 吴 郑 王
冯 陈 褚 卫
蒋 沈 韩 杨
程序代码：
*/
public class sqldata extends JFrame implements ActionListener{

JButton add,select,del,update;
    JTable table;
    Object body[][]=new Object[50][4];
    String title[]={"编号","姓名","分数","级别"};
    Connection conn;
    Statement stat;
    ResultSet rs;
    JTabbedPane tp;
    public sqldata() {
        super("数据库操作");
        this.setSize(400,300);
        this.setLocation(300,200);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        JPanel ps=new JPanel();
        add=new JButton("添加");
        select=new JButton("显示");
        update=new JButton("更改");
        del=new JButton("删除");
        add.addActionListener(this);
        select.addActionListener(this);
        update.addActionListener(this);
        del.addActionListener(this);
        ps.add(add);ps.add(select);ps.add(update);ps.add(del);
        table=new JTable(body,title);
        tp=new JTabbedPane();
        tp.add("bankAccount表",new JScrollPane(table));
        this.getContentPane().add(tp,"Center");
        this.getContentPane().add(ps,"South");
        this.setVisible(true);
        this.connection();


    }
    public void connection(){
    try {
        Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
        String url="jdbc:microsoft:sqlserver://127.0.0.1:1433;DatabaseName=dxaw";
        conn=DriverManager.getConnection(url,"sa","");
        stat = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
ResultSet.CONCUR_READ_ONLY);
    } catch (Exception ex) {
    }
    }
    public static void main(String[] args) {
        sqldata data = new sqldata();
    }

    public void actionPerformed(ActionEvent e) {
        if(e.getSource()==add)
        {adddata();}
        if(e.getSource()==select)
        {select();}
        if(e.getSource()==update)
        {updata();}
        if(e.getSource()==del)
        {del();}
    }


    public void del() {
    try {

    int row=table.getSelectedRow();
    stat.executeUpdate("delete bankAccount where accountID='"+body[row][0]+"'");
    JOptionPane.showMessageDialog(null,"数据已成功删除");
       this.select();
    } catch (SQLException ex) {
        }
    }

    public void updata() {
    try {
            int row=table.getSelectedRow();

            JTextField t[]=new JTextField[6];
               t[0]=new JTextField("输入姓名:");
               t[0].setEditable(false);
               t[1]=new JTextField();
               t[2]=new JTextField("输入分数:");
               t[2].setEditable(false);
               t[3]=new JTextField();
               t[4]=new JTextField("输入级别:");
               t[4].setEditable(false);
               t[5]=new JTextField();
               String but[]={"确定","取消"};
               int go=JOptionPane.showOptionDialog(
null,t,"插入信息",JOptionPane.YES_OPTION,
JOptionPane.INFORMATION_MESSAGE,null,but,but[0]);
   if(go==0){
   //String ownerName=new String(t[1].getText().getBytes("ISO-8859-1"),"GBK");//数据库设为中文编码取消此句
   String ownerName=new String(t[1].getText());//数据库设为中文编码采用此句
   String accountValue=t[3].getText();
   int accountLevel=Integer.parseInt(t[5].getText());
   stat.executeUpdate("update bankAccount set ownerName='"
   +ownerName+"',accountValue='"+accountValue+"',accountLevel='"

   +accountLevel+"' where accountID='"+body[row][0]+"'");
   JOptionPane.showMessageDialog(null,"修改数据成功");
    this.select();
    }

     } catch (Exception ex) {
    }
    }

    public void select() {
        try {
            for(int x=0;x<body.length;x++){
            body[x][0]=null;
            body[x][1]=null;
            body[x][2]=null;
            body[x][3]=null;
            }
            int i=0;
            rs=stat.executeQuery("select * from bankAccount");
            while(rs.next()){
            body[0]=rs.getInt(1);
            body[1]=rs.getString(2);
            body[2]=rs.getString(3);
            body[3]=rs.getInt(4);
            i=i+1;
            }
            this.repaint();
        } catch (SQLException ex) {
        } 

    }

    private void adddata() {

        try {

            JTextField t[]=new JTextField[6];
            t[0]=new JTextField("输入姓名:");
            t[0].setEditable(false);
            t[1]=new JTextField();
            t[2]=new JTextField("输入分数:");
            t[2].setEditable(false);
            t[3]=new JTextField();
            t[4]=new JTextField("输入级别:");
            t[4].setEditable(false);
            t[5]=new JTextField();
            String but[]={"确定","取消"};

            int go=JOptionPane.showOptionDialog(null,t,"插入信息",
            
JOptionPane.YES_OPTION,JOptionPane.INFORMATION_MESSAGE,null,but,but[0]);
            if(go==0){
            
try{
            
//String ownerName=new String(t[1].getText().getBytes("ISO-8859-1"),"GBK");//数据库设为中文编码取消此句
            
String ownerName=new String(t[1].getText());//数据库设为中文编码采用此句
            
String accountValue=t[3].getText();
            
int accountLevel=Integer.parseInt(t[5].getText());
            
stat.executeUpdate("insert into bankAccount(ownerName,accountValue,accountLevel) values('"
            
+ownerName+"','"+accountValue+"','"+accountLevel+"')");
            
JOptionPane.showMessageDialog(null,"数据已成功插入！");
            
}catch(Exception ee){
            
JOptionPane.showMessageDialog(null,"插入数据错误！");
            
} 
            }

        }
        catch (Exception ex) {}
    }
}
```
