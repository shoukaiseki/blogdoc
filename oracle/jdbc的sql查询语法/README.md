## 创建测试数据


```Sql
SET DEFINE OFF;
drop table "TESTDT"  ;
CREATE TABLE TESTDT 
(
name VARCHAR2(20)
,  A DATE 
, B DATE 
);

Insert into TESTDT (NAME,A,B) values ('GddrB',to_date('1970-01-01 21:31:43','RRRR-MM-DD HH24:MI:SS'),to_date('1970-01-01 21:31:43','RRRR-MM-DD HH24:MI:SS'));
Insert into TESTDT (NAME,A,B) values ('FbJGc',to_date('1970-01-01 12:06:18','RRRR-MM-DD HH24:MI:SS'),to_date('1970-01-01 12:06:18','RRRR-MM-DD HH24:MI:SS'));
Insert into TESTDT (NAME,A,B) values ('_sad',to_date('1970-01-01 12:46:18','RRRR-MM-DD HH24:MI:SS'),to_date('1970-01-01 12:46:18','RRRR-MM-DD HH24:MI:SS'));
Insert into TESTDT (NAME,A,B) values ('ioCdl',to_date('1970-01-01 12:46:18','RRRR-MM-DD HH24:MI:SS'),to_date('1970-01-01 12:46:18','RRRR-MM-DD HH24:MI:SS'));
```


## 测试查询的sql
### 只限 ODBC,OLEDB 方式查询,也可用 oracle sql developer 用脚本模式进行查询 

https://docs.oracle.com/database/121/JJDBC/apxref.htm#JJDBC28913

select * from TESTDT where a ={ts '1970-01-01 12:46:18'}

select {ts '1970-01-01 12:46:18'} from dual


## 测试java代码

```Java

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Random;

/**
 * TestJDBCSQL <br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  2018-06-30 22:10:00<br>
 * ブログ http://shoukaiseki.blog.163.com/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/
public class TestJDBCSQL {

    //数据库连接对象
    private static Connection conn = null;

    private static String driver = "oracle.jdbc.driver.OracleDriver"; //驱动

    private static String url = "jdbc:oracle:thin:@127.0.0.1:1521:orcl"; //连接字符串

    private static String username = "C##maximo"; //用户名

    private static String password = "maximo"; //密码

   public TestJDBCSQL(){
       try {
           Class.forName(driver);
           conn = DriverManager.getConnection(url, username, password);
           conn.setAutoCommit(true);
       } catch (ClassNotFoundException e) {
           e.printStackTrace();
       }catch (SQLException e) {
           e.printStackTrace();
       }
   }


    //执行查询语句
    public void query(String sql) throws SQLException{
        PreparedStatement pstmt;

        try {
            pstmt = conn.prepareStatement(sql);
            //建立一个结果集，用来保存查询出来的结果
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString(1);
                System.out.println(name);
            }
            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }





    public void exec(String sql,Object... paras) throws SQLException{

        PreparedStatement pstmt = conn.prepareStatement(sql);
        int i=0;
        for (Object obj:paras ) {
            i++;
           pstmt.setObject(i,obj);
        }
         pstmt.executeUpdate();
        conn.commit();
    }

    public void close(){
       if(conn!=null){
           try {
               conn.close();
           } catch (SQLException e) {
               e.printStackTrace();
           }
       }
    }

    public static void main(String[] args) throws SQLException {
        TestJDBCSQL test = new TestJDBCSQL();
        String name;
        try {
            name = randomEN(5);
            test.exec("INSERT INTO TESTDT (name,A, B) VALUES ('"+name+"1',{t '12:46:18'}, {t '12:46:18'})");

            //time类型参数为要查询的 时,分,秒
            // 这样初始化的时间类型,默认日期为 1970-01-02
            Time time = new Time(12, 46, 18);
            test.exec("INSERT INTO TESTDT (name,A, B) VALUES ('"+name+"2',:1, :2)",
                    time,time);
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String sql = "select * from TESTDT where a ={ts '" + sdf.format(time) + "'}";
            System.out.println("sql="+sql);
            test.query(sql);

            System.out.println("---------查询格式化后的时间----------");
            time = new Time(12, 46, 18);
            sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            sql = "select {ts '" + sdf.format(time) + "'} from dual";
            System.out.println("sql="+sql);
            test.query(sql);

            //自定义转义符
            sql = "SELECT * FROM TESTDT WHERE name LIKE '&_%' {ESCAPE '&'}";
            System.out.println("sql="+sql);
            test.query(sql);



        } catch (SQLException e) {
            e.printStackTrace();
        }



        test.close();
    }


    private static Random random = new Random();

    /** 随机生成英文字符
     * @param length 需要的长度
     * @return
     */
    public static String randomEN(int length){
        String str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < length; ++i) {
            int number = random.nextInt(52);// [0,51)
            sb.append(str.charAt(number));
        }
        return sb.toString();
    }
}

```


## 自定义转义符

同样需要jdbc方式查询

```Sql
SELECT * FROM TESTDT WHERE name LIKE '&_%' {ESCAPE '&'}
```
