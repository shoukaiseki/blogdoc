# tomcat下部署润乾报表

```
---tomcat部署---{{{1
数据源测试应用下载(内含下文用到的jar) http://pan.baidu.com/s/1gds2tJd
tomcat版本号:Apache Tomcat/7.0.59 
java版本号: 1.6.0_24 
http://pan.baidu.com/s/1gds2tJd
---tomcat 下布置数据源---{{{2
以下按照润乾报表应用目录为 rqreport 进行讲解
在rqreport下建立一个META-INF/context.xml文件
文件内容为

<?xml version='1.0' encoding='utf-8'?>
<Context>


	 <Resource name="reportdb"
		 factory="com.alibaba.druid.pool.DruidDataSourceFactory"  
		 auth="Container"
		 type="javax.sql.DataSource"  
		 url="jdbc:oracle:thin:localhost:1521:orcl"
		 username="maximo"
		 password="maximo"
		 initialSize="10"  
		 minPoolSize="15"
		 maxPoolSize="30"
		 maxActive="25"  
		 testOnBorrow="false"  
		 filters="stat"  
		 />  
</Context>


然后将oracle的驱动包 classes12.jar 复制到 rqreport\WEB-INF\lib下面
还需将阿里巴巴的数据源管理包 druid-0.2.9.jar 和 druid-wrapper-0.2.9.jar 也复制到rqreport\WEB-INF\lib下面
阿里巴巴的数据源管理包下载地址 http://pan.baidu.com/s/1kTikNrh

---修改数据源文件---{{{2
编辑rqreport\WEB-INF\reportConfig.xml
将

    <config>
      <name>dataSource</name>
      <value>reportdb,reportdb,oracle,GBK,0</value>
    </config>

更改为

    <config>
      <name>dataSource</name>
	  <!--tomcat下用 java:comp/env/reportdb-->
	  <!--weblogic下用 reportdb-->
      <value>java:comp/env/reportdb,reportdb,oracle,GBK,0</value>
    </config>

到此数据源已经配置完成

---测试数据源---{{{2
在rqreport下面建立一个 test.jsp 文件,内容如下

<%@ page language="java" import="java.util.*,java.text.*" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%
	 InitialContext ctx = new InitialContext();
	//tomcat下面调用数据源方式
	DataSource ds = (DataSource) ctx.lookup("java:comp/env/reportdb");

	//weblogic下面调用数据源方式
	//DataSource ds = (DataSource) ctx.lookup("reportdb");
	Connection conn = ds.getConnection();
	Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
	ResultSet.CONCUR_READ_ONLY);
	ResultSet rs = st.executeQuery("select sysdate from dual");
	String asus="空";
	if(rs.next()){
		asus=new SimpleDateFormat ("yyyy年MM月dd日 HH:mm:ss").format(rs.getTimestamp(1));
	}

	conn.close();
%>
tomcat版本号:<%= application.getServerInfo() %>
<br>
java版本号:
<%=System.getProperty("java.version")%>
<br>
数据库时间=
<%=asus%>


---测试访问---{{{3
浏览器输入 http://localhost:8080/rqreport/test.jsp 
如果无报错,正确显示出时间则证明配置的数据源是可以使用的


---weblogic部署---{{{1
weblogic数据源添加方式请搜狗(为什么推荐用搜狗,因为百度已经彻底商业化了,很多答案无法第一时间搜索到了)
测试数据源的方式请参考tomcat部署的说明(注意备注)
下面简单讲解下

---编辑rqreport\WEB-INF\reportConfig.xml---{{{2
使用

    <config>
      <name>dataSource</name>
      <value>reportdb,reportdb,oracle,GBK,0</value>
    </config>


---test.jsp---{{{2

<%@ page language="java" import="java.util.*,java.text.*" pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%
	 InitialContext ctx = new InitialContext();
	//tomcat下面调用数据源方式
	//DataSource ds = (DataSource) ctx.lookup("java:comp/env/reportdb");

	//weblogic下面调用数据源方式
	DataSource ds = (DataSource) ctx.lookup("reportdb");
	Connection conn = ds.getConnection();
	Statement st = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
	ResultSet.CONCUR_READ_ONLY);
	ResultSet rs = st.executeQuery("select sysdate from dual");
	String asus="空";
	if(rs.next()){
		asus=new SimpleDateFormat ("yyyy年MM月dd日 HH:mm:ss").format(rs.getTimestamp(1));
	}

	conn.close();
%>
tomcat版本号:<%= application.getServerInfo() %>
<br>
java版本号:
<%=System.getProperty("java.version")%>
<br>
数据库时间=
<%=asus%>

---数据源获取方式比较---{{{1
从上文可以得知
---tomcat的数据源获取比较繁琐---{{{2
DataSource ds = (DataSource) ctx.lookup("java:comp/env/reportdb");

---而weblogic下面调用数据源方式相对简洁---{{{2
DataSource ds = (DataSource) ctx.lookup("reportdb");

因此在润乾报表中获取数据源时就需要做出调整
---tomcat---{{{3
    <config>
      <name>dataSource</name>
      <value>java:comp/env/reportdb,reportdb,oracle,GBK,0</value>
    </config>
---weblogic---{{{3
    <config>
      <name>dataSource</name>
      <value>reportdb,reportdb,oracle,GBK,0</value>
    </config>
以上说明可以通过创建修改test.jsp测试便可熟知

---注---{{{1
jdk1.7使用将会异常,因为在java的新版本接口有变动,跟classes12.jar老驱动不兼容
tomcat8.0不支持jdk1.6版本
所以采用了 tomcat7.0和jdk1.6的搭配使用

```
