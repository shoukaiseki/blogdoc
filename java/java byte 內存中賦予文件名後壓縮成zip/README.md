# java byte 內存中賦予文件名後壓縮成zip  

```Java
package bennkyou.zip;

import java.io.*;
import java.lang.reflect.Array;
import java.util.*;
import java.util.zip.*;

/**
 * 直接將二進制byte流指定文件名後壓縮成zip格式,不必寫出文件再壓縮,
 * 可增加安全性
 * 可於數據傳輸,web接口傳輸數據
 * @author 蒋カイセキ    Japan-Tokyo 2012-6-15
 * @ブログ http://shoukaiseki.blog.163.com/
 * @E-メール jiang28555@Gmail.com
 */
public class BufferedZip {
 public static final int BUFFER = 1024;// 缓存大小

 public static void main(String[] args) throws Exception {
  String s = "/**\n * 直接將二進制byte流指定文件名後壓縮成zip格式,不必寫出文件再壓縮,\n * 可增加安全性\n * 可於數據傳輸,web接口傳輸數據\n * @author 蒋カイセキ    Japan-Tokyo 2012-6-15\n * @ブログ http://shoukaiseki.blog.163.com/\n * @E-メール jiang28555@Gmail.com\n */\n\n";
  zipFile(s, "222.xml", "/tmp/del/zip/333.zip");
  
  //指定字符串壓縮後的文件名
  byte[] bytes = zipString(s, "2.xml");

  System.out.println("stored=" + ZipEntry.STORED);// 設置壓縮方法
  System.out.println("deflated=" + ZipEntry.DEFLATED);// 設置壓縮方法

  //可以測試直接將二進制寫出到zip文件
//  FileOutputStream fos=new FileOutputStream("/tmp/del/zip/zipa/1.zip");
//  fos.write(bytes);
//  fos.close();
  
  //
  Map<String, byte[]> map = unZipBytes(bytes);
  Set<String> keysSet = map.keySet();
  Iterator<String> iterator = keysSet.iterator();
  for (int i = 1; iterator.hasNext(); i++) {
   Object key = iterator.next();// key
   byte[] value = map.get(key);// value
   System.out.println(i + "\tkey=" + key + "\n" + new String(value));
  }
  System.out.println("KO");
 }

 /**
  * 解压缩zip文件流功能. 将ZIP_Byte二進制文件解壓並存放至map<文件名,二進制>中.
  * 
  * @return
  * @throws Exception
  */
 public static Map<String, byte[]> unZipBytes(byte[] bytes) throws Exception {
  ByteArrayInputStream bai = new ByteArrayInputStream(bytes);
  ZipInputStream zis = new ZipInputStream(bai);

  // ByteArrayOutputStream os=new ByteArrayOutputStream();
  // byte buf[] = new byte[1024];
  // // 省略循环
  // int numread = zis.read(buf);
  // os.write(buf, 0, numread);
  // InputStream is2 = new ByteArrayInputStream(os.toByteArray());

  ZipEntry ze = null;
  Map<String, byte[]> map = new HashMap();
  ByteArrayOutputStream bao = new ByteArrayOutputStream();
  while ((ze = zis.getNextEntry()) != null) {
   // 解压文件到指定的目录
   int size = 2048;
   // System.out.println(ze.getSize());
   // System.out.println(ze.getName());
   // System.out.println(ze.getMethod());
   // 緩衝區大小,分幾次寫入到流
   byte[] bs=new byte[0];
   while (true) {
    byte[] data = new byte[1024];
//    size = zis.read(data);
     size = zis.read(data, 0, 1024);
//     System.out.println("size="+size);
    if (size > 0) {
     //因爲讀入的流不足data設置的緩衝區大小的話,byte數組遇到null,之後的值將會無效
     //故必須指定size
     bao.write(data,0,size);
//    System.out.println("data="+new String(data));
    } else {
     break;
    }
    //在這裏不能用,因爲讀入的流不足data設置的緩衝區大小的話,byte數組遇到null之後的值將會無效
    //如要使用需要將size作爲參數,作爲dest的有效長度
     bs=(byte[]) appEndArray(bs, data);
//     System.out.println("bs.size="+bs.length);
//     System.out.println("bs="+new String(bs));
   }
//   System.out.println(new String(bao.toByteArray()));
   //可以測試直接將二進制寫出到文件
//   FileOutputStream fos=new FileOutputStream("/tmp/del/zip/zipx/1.xml");
//   fos.write(bao.toByteArray());
//   fos.close();
   
   //
   map.put(ze.getName(), bao.toByteArray());
//   System.out.println(new String(bs));
  }
  bao.close();
  zis.close();
  bai.close();
  return map;
 }
 
 static Object appEndArray(Object source,Object destination){
//  System.out.println("source="+new String((byte[])source));
//  System.out.println("destination="+new String((byte[])destination));
  Class componentType=source.getClass().getComponentType();
  int length=Array.getLength(source);
  int lengthD=Array.getLength(destination);
  Object newArray=Array.newInstance(componentType, length+lengthD);
  System.arraycopy(source, 0, newArray,0,length);
  System.arraycopy(destination,0,newArray,length,lengthD);
//  System.out.println("newArray="+new String((byte[])newArray));
  return newArray;
 }


 /**
  * 直接將字符串壓縮成帶文件的zip進行傳送,文件名爲nodeName,value爲字符串內容
  * 
  * @param value
  * @param nodeName
  * @return
  * @throws IOException
  */
 public static byte[] zipString(String value, String nodeName)
   throws IOException {
  ByteArrayOutputStream bao = new ByteArrayOutputStream();
  ZipOutputStream zos = new ZipOutputStream(bao);
  ZipEntry ze = null;
  ze = new ZipEntry(nodeName);
  // ze.setMethod(ze.STORED);//設置壓縮方法
  ze.setSize(value.getBytes().length);
  ze.setTime(System.currentTimeMillis());
  zos.putNextEntry(ze);
  System.out.println(value.length());
  System.out.println(value.getBytes().length);
  byte[] buf = new byte[BUFFER];
  // zos.write(value.getBytes(), 0, value.length());
  zos.write(value.getBytes());

  // while ((readLen=bao.read(buf, 0, BUFFER))!=-1) {
  // zos.write(buf, 0, readLen);
  // }
  zos.close();
  return bao.toByteArray();
 }

 /**
  * zip压缩功能. 压缩baseDir(文件夹目录)下所有文件，包括子目录
  * 
  * @throws Exception
  */
 public static void zipFile(String value, String nodeName, String fileName)
   throws Exception {
  byte[] bytes = zipString(value, nodeName);
  File file = new File(fileName);
  FileOutputStream fos = new FileOutputStream(file);
  fos.write(bytes);
 }
 // /**
 // * 解压缩zip文件流功能.
 // * 将ZIP_Byte二進制文件解壓並存放至map<文件名,二進制>中.
 // * @return
 // * @throws Exception
 // */
 // public Map<String, byte[]> upZipBytes(byte[] bytes) throws Exception{
 // ByteArrayInputStream bai = new ByteArrayInputStream(bytes);
 // ZipInputStream zis=new ZipInputStream(bai);
 // ZipEntry ze=null;
 // Map<String,byte[]> map=new HashMap();
 // while((ze=zis.getNextEntry()) != null){
 // System.out.println(ze.getExtra());
 // map.put(ze.getName(), ze.getExtra());
 // }
 // zis.close();
}
```
