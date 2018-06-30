package com.shoukaiseki;

import com.wmc.jfinal.kernel.utils.FileUtils;
import oracle.sql.BLOB;

import javax.sql.rowset.serial.SerialBlob;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.*;
import java.util.UUID;

/**
 * com.shoukaiseki.TestUpdateImglibuser <br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  2017-12-14 08:31:08<br>
 * ブログ http://shoukaiseki.blog.163.com/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/
public class TestUpdateblob {
    private String url = "jdbc:oracle:thin:@localhost:1521:orcl";
    private String userName = "C##maximo";
    private String password = "maximo";
    private String driver   = "oracle.jdbc.driver.OracleDriver";
    private Connection con;

    public TestUpdateblob(){
        try {
            Class.forName(driver);
            con = DriverManager.getConnection(url, userName, password);
            //获得数据库连接
            con.setAutoCommit(false);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void insert(String filepath) throws Exception {

        Statement st = null;
        //st=con.createStatement();
        //插入一个空对象empty_blob()
        String sql = "insert into imglibuser(imglibuserid,IMAGENAME,MIMETYPE,REFOBJECT,REFOBJECTID,SN,IMAGE) values(?,?,?,?,?,?,?)";
//        st.executeUpdate(sql);
        PreparedStatement pst=con.prepareStatement(sql);
        pst.setObject(1,new Long(1));
        pst.setObject(2,"ceshi");
        pst.setObject(3,"ceshi");
        pst.setObject(4,"ceshi");
        pst.setObject(5,new Long(2));
        pst.setNull(6,Types.NUMERIC);
        BLOB emptyBLOB = null;
        //BLOB.getEmptyBLOB();
        emptyBLOB=BLOB.createTemporary(con,true,BLOB.DURATION_SESSION);
        OutputStream os = emptyBLOB.setBinaryStream(0);
        // 读取想要存储的图片文件
        InputStream is = new FileInputStream(filepath);
        // 依次读取流字节,并输出到已定义好的数据库字段中.
        int i = 0;
        while ((i = is.read()) != -1) {
            os.write(i);                                               //Blob的输入流，相当于输入到数据库中
        }
        os.flush();
        os.close();
        pst.setObject(7, emptyBLOB);
        pst.executeUpdate();
        con.commit();
    }

    public void update(String imglibuserid,String filepath) throws Exception{
        String sql="select imglibuserid,refobject,image,IMAGENAME from IMGLIBUSER where IMGLIBUSERID=? for update";
        PreparedStatement pst=con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
        pst.setObject(1,imglibuserid);
        ResultSet rs = pst.executeQuery();
        if(rs.next()){
            long id = rs.getLong("IMGLIBUSERID");
            rs.updateString("IMAGENAME", UUID.randomUUID().toString());
            BLOB image = (oracle.sql.BLOB) rs.getBlob("IMAGE");
            //getBinaryOutputStream setBinaryStream 都可已用
            OutputStream outStream = image.getBinaryOutputStream();
//            outStream = image.setBinaryStream(0);
            // 读取想要存储的图片文件
            InputStream is = new FileInputStream(filepath);
            // 依次读取流字节,并输出到已定义好的数据库字段中.
            int i = 0;
            while ((i = is.read()) != -1) {
                outStream.write(i);                                               //Blob的输入流，相当于输入到数据库中
            }

            outStream.flush();
            outStream.close();
            rs.updateRow();
            System.out.println("id="+id);
        }
        con.commit();

    }

    public void update2(String imglibuserid,String filepath) throws Exception{
        String sql="select imglibuserid,refobject,image,IMAGENAME from IMGLIBUSER where IMGLIBUSERID=? for update";
        PreparedStatement pst=con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
        pst.setObject(1,imglibuserid);
        ResultSet rs = pst.executeQuery();
        if(rs.next()){
            long id = rs.getLong("IMGLIBUSERID");
            rs.updateString("IMAGENAME", UUID.randomUUID().toString());
            BLOB image = BLOB.createTemporary(con,true,BLOB.DURATION_SESSION);
            OutputStream outStream = image.getBinaryOutputStream();
//            outStream = image.setBinaryStream(0);
            // 读取想要存储的图片文件
            InputStream is = new FileInputStream(filepath);
            // 依次读取流字节,并输出到已定义好的数据库字段中.
            int i = 0;
            while ((i = is.read()) != -1) {
                outStream.write(i);                                               //Blob的输入流，相当于输入到数据库中
            }

            outStream.flush();
            outStream.close();
            rs.updateBlob("image",image);
            rs.updateRow();
            System.out.println("id="+id);
        }
        con.commit();
    }

    public void updateEmptyImage(String imglibuserid) throws Exception{
        String sql="select imglibuserid,refobject,image,IMAGENAME from IMGLIBUSER where IMGLIBUSERID=? for update";
        PreparedStatement pst=con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
        pst.setObject(1,imglibuserid);
        ResultSet rs = pst.executeQuery();
        if(rs.next()){
            long id = rs.getLong("IMGLIBUSERID");
            rs.updateString("IMAGENAME", UUID.randomUUID().toString());
            rs.updateObject("image",BLOB.getEmptyBLOB());
            rs.updateRow();
            System.out.println("id="+id);
        }
        con.commit();
    }

    public void updateImageByBytes(String imglibuserid,String filepath) throws Exception{
        String sql="select imglibuserid,refobject,image,IMAGENAME from IMGLIBUSER where IMGLIBUSERID=? for update";
        PreparedStatement pst=con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
        pst.setObject(1,imglibuserid);
        ResultSet rs = pst.executeQuery();
        if(rs.next()){
            long id = rs.getLong("IMGLIBUSERID");
            System.out.println("image="+new String(rs.getBytes("image")));
            rs.updateString("IMAGENAME", UUID.randomUUID().toString());
            byte[] bytes = "linux".getBytes();
            bytes=FileUtils.readFileToBytes(filepath);
            rs.updateBytes("image",bytes);
            rs.updateRow();
            System.out.println("id="+id);
        }
        con.commit();
    }

    public void updateImageByBytesWithBlob(String imglibuserid,String filepath) throws Exception{
        String sql="select imglibuserid,refobject,image,IMAGENAME from IMGLIBUSER where IMGLIBUSERID=? for update";
        PreparedStatement pst=con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
        pst.setObject(1,imglibuserid);
        ResultSet rs = pst.executeQuery();
        if(rs.next()){
            long id = rs.getLong("IMGLIBUSERID");
            rs.updateString("IMAGENAME", UUID.randomUUID().toString());
            byte[] bytes = "linux".getBytes();
            bytes=FileUtils.readFileToBytes(filepath);
            BLOB image = BLOB.createTemporary(con,true,BLOB.DURATION_SESSION);
            OutputStream outStream = image.getBinaryOutputStream();
//            outStream = image.setBinaryStream(0);

            outStream.write(bytes);//Blob的输入流，相当于输入到数据库中

            outStream.flush();
            outStream.close();
            rs.updateObject("image",image);
            rs.updateRow();
            System.out.println("id="+id);
        }
        con.commit();
    }

    /**
     * 使用第三方连接池时,BLOB.createTemporary(con,true,BLOB.DURATION_SESSION) 使用不了,需使用通用方式创建
     * @param filepath
     * @throws Exception
     */
    public void insertOtherDataSource(String filepath) throws Exception {

        Statement st = null;
        //st=con.createStatement();
        //插入一个空对象empty_blob()
        String sql = "insert into imglibuser(imglibuserid,IMAGENAME,MIMETYPE,REFOBJECT,REFOBJECTID,SN,IMAGE) values(?,?,?,?,?,?,?)";
//        st.executeUpdate(sql);
        PreparedStatement pst=con.prepareStatement(sql);
        pst.setObject(1,new Long(3));
        pst.setObject(2,"ceshi");
        pst.setObject(3,"ceshi");
        pst.setObject(4,"ceshi");
        pst.setObject(5,new Long(2));
        pst.setNull(6,Types.NUMERIC);
        Blob emptyBLOB = null;
        //BLOB.getEmptyBLOB();
        emptyBLOB=con.createBlob();
        OutputStream os = emptyBLOB.setBinaryStream(0);
        // 读取想要存储的图片文件
        InputStream is = new FileInputStream(filepath);
        // 依次读取流字节,并输出到已定义好的数据库字段中.
        int i = 0;
        while ((i = is.read()) != -1) {
            os.write(i);                                               //Blob的输入流，相当于输入到数据库中
        }
        os.flush();
        os.close();
        pst.setObject(7, emptyBLOB);
        pst.executeUpdate();
        con.commit();
    }

    public void close() throws Exception {
        con.close();
    }

    public static void main(String[] args) throws Exception {
        TestUpdateblob tui=new TestUpdateblob();
//        tui.insert("C:/temp/001.jpg");
//        tui.update("1","C:/temp/002.jpg");
//        tui.update2("1","C:/temp/003.jpg");
//        tui.updateImageByBytes("1","C:/temp/003.jpg");
        tui.updateImageByBytesWithBlob("1","C:/temp/002.jpg");
//        tui.insertOtherDataSource("C:/temp/001.jpg");
//        tui.updateEmptyImage("1");
        tui.close();
    }

}
