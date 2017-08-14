# maximo中执行sql语句收藏（摘自csdn博客-xczheng）

## 1、在 maximo中执行一个完整的sql语句

在maximo中执行sql语句首先获取一个连接：

```Java
Connection con = MXServer.getMXServer().getDBManager().getSystemConnection();

Statement st=null;


ResultSet rs=null;

String sql = "select * from asset where ........";

try{

     st = con.createStatement();

     rs = null;

     st.execute(sql);

     rs = st.getResultSet();

     while(rs.next){

         dosomething

     }

}catch(SQLException e){

     e.printStackTrace();

}finally{

     try{

         if(rs!=null)

             rs.close();

     }catch(SQLException e){

        

     }

     try{

         if(st != null)

             st.close();

     }catch(SQLException e){

        

     }

}
```

## 2、执行mboset.setWhere():

```Java
String sql = "assetnum = '"+.......+"'";//sql中只有where语句部分，而且mboset对应的表中必须有assetnum这个字段
```

## 3、在DataBean中执行mbsetQbe(字段名,String)，用来对数据进行过滤，有点像hibernate中的数据过滤，呵呵

     也可以mboset.setQbe();

     例如：

     在一个表绑定的DataBean中：

```Java
     setQbe("assetnum",app.getappBean().getString("assetnum"));
```

     这样就对这个表中的数据进行了过滤

    

## 4、SqlFormat sqf = new SqlFormat(asset,"assetnum =: assetnum");

```Java
     mboset.setWhere(sqf.format());
```
