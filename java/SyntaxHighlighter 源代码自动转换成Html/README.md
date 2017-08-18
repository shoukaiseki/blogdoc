# SyntaxHighlighter 源代码自动转换成Html  


下载地址  webhttp.7z http://115.com/file/e7lmpsoy#
<br>
文件读入时的编码设置及自动检测,写入时的编码设置.里面包含我使用的其它Java源码,SQL语句
<br>
解压至F:\后执行F:\webhttp\syntaxhighlighter_3.0.83\thisjavaw.cmd运行

```Java

package syntaxhighlighter;
/**SyntaxHighlighter为源码高亮插件
 *本程序通过将读入的源码插入Html代码中
 *插入方式为将读入的文件依次插入到String syntaxhighlighter的尾部
 *依次为
 *./Insert_SyntaxHighlighter/Public_Head.html 公用首部内容
 *LINE_BREAKS         换行符
 *./Insert_SyntaxHighlighter/java.html    源码后缀名.html
 *LINE_BREAKS         换行符
 *源码内容
 *LINE_BREAKS         换行符
 *./Insert_SyntaxHighlighter/Public_Last.html 公用末尾内容
 *输出为Html格式,输出位置及读入位置配置文件为./Insert_SyntaxHighlighter/AutoSyntaxHighlighter.ora
 *extension=java,sql,h       此为需要转换为Html的后缀名,用','格开,注意区分大小写
 *sourceCode=F://webhttp//src      此为需要转换的源码路径,递归查找该目录下的源码文件
 *htmlCode=F://webhttp//bin      此为源码转换为Html后的输出路径,拥有递归功能
 */
import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Cursor;
import java.awt.Label;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextPane;

import bennkyou.gui.jtextpane.JTextPaneOperating;

import shoukaiseki.characterdetector.CharacterEncoding;
import shoukaiseki.constantlib.CharacterEncodingName;
import shoukaiseki.file.FindFile;
import shoukaiseki.math.PrintText;
import shoukaiseki.string.ConCatLineBreaks;


public class AutoSyntaxHighlighter {
 public static final String UTF_8 = "UTF-8";
 public static final String GBK = "GBK";
 public static PrintText printText=new PrintText(true);//输出模式为GUI模式
 public static ConCatLineBreaks content=null;//显示到jtextpane的内容
 /**
  * 换行符,因UTF8与GBK编码换行符不同
  */
 public static final  String LINE_BREAKS="\r\n";
 /**
  * 配置文件目录
  */
 public static final  String EXTENSION_PATH="./Insert_SyntaxHighlighter/";
 public static int zenkai = 0;// 前回输出的字符数
 public static SimpleDateFormat bartDateFormat = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss ");
 public static Calendar cal =Calendar.getInstance();
 public static Date date = new Date();
 public static Date rundate = new Date();//开始正常运行时间
 
 public static String urlstring = "";
 public static File file = new File("./Insert_SyntaxHighlighter");
 public static File txtfile = new File("./Insert_SyntaxHighlighter/AutoSyntaxHighlighter.ora");

 public static String publicHead="";//保存Public_Head.html内容
 public static String publicLast="";//保存Public_Last.html内容
 public static String extension="";
 public static String sourceCode="";
 public static String htmlCode="";
 public static JFrame frame;
 public static JTextPaneOperating textPane;
 public static JTextPane textPane2;//文本框2
 public AutoSyntaxHighlighter() throws UnsupportedEncodingException {
  // 初始化所有模块
  frame = new JFrame("Maximo监控程序");
  textPane = new JTextPaneOperating();
  textPane.setCursor(new Cursor(Cursor.TEXT_CURSOR));
  textPane.setText("java版本为:" + System.getProperty("java.version")
    + "\n换行");
  // 设置主框架的布局
  Container c = frame.getContentPane();
  // c.setLayout(new BorderLayout())


  JScrollPane jsp = new JScrollPane(textPane);// 新建一个滚动条界面，将文本框传入
  c.add(jsp, BorderLayout.CENTER);
  
  /**
   *  文本框二
   */
  textPane2 = new JTextPane();
  textPane2.setCursor(new Cursor(Cursor.TEXT_CURSOR));
  JScrollPane jsp2 = new JScrollPane(textPane2);// 新建一个滚动条界面，将文本框传入
  c.add(jsp2, BorderLayout.SOUTH);


  /**
   * 增加标签
   */
  Label label = new Label("java Version:" + System.getProperty("java.version"));
  c.add(label, BorderLayout.NORTH);
  
  // 利用无名内隐类，增加窗口事件
  frame.addWindowListener(new WindowAdapter() {
   public void WindowClosing(WindowEvent e) {
    // 释放资源，退出程序
    frame.dispose();
    System.exit(0);
   }
  });

  frame.setSize(700, 500);
  // 隐藏frame的标题栏,此功暂时关闭，以方便使用window事件
  // setUndecorated(true);
  frame.setLocation(200, 150);
  frame.show();
 }
 public static void main(String ages[]) throws IOException{
  new AutoSyntaxHighlighter();
  printText.setTextPane(textPane);
  readini();  
  try {
      FindFile star=new FindFile(); 
   File[] files = star.getFiles("./", "*.java");//查找运行目录下的所有文件
         files = star.getFiles(sourceCode, extension);//查找sourceCode目录下的extension后缀名的文件
         for(int i=0;i<files.length;i++){   
             printText.addLastLine(files[i].getPath());
             allToHtml(files[i]);
         }
  } catch (Exception e) {
   // TODO: handle exception
   printText.addLastLine("目录下无任何文件或无此目录!");
  }
 }   
 
 public static void readini() throws IOException{
  mkDir();//新建文件夹
  newFile();//无配置文件则自动新建文件
  reFile();//读取文件
  rePublicFile();//读取公用头文件内容
  extensionDecoding();//将extension解码为可以进行查找的通配符格式String
 }
 
 public static File newMkDir(String fileName) {
  File htmlFile=new File(fileName);
  File folder=new File(htmlFile.getParent());
  try {
    if(!folder.isDirectory()){
     if(!folder.mkdirs()){
      printText.addLastLine("####创建目录"+folder+"失败,可能为权限不足!####");
     }
    }
    if(!htmlFile.exists()){
     if (!htmlFile.createNewFile()) {
      printText.addLastLine("####创建文件"+htmlFile+"失败,可能为权限不足!####");
    }
    }
  } catch (Exception e) {
   // TODO: handle exception
  }
  return htmlFile;
 }
 public static void mkDir(){
  if (!file.isDirectory()) {
   file.mkdir();
   printText.addLastLine("成功创建一个文件夹"+file+"！");
  }
 }
 public static void newFile() throws IOException{
  // 新建文件
  if (!txtfile.exists()) {
   if (txtfile.createNewFile()){
    printText.addLastLine("配置文件创建成功!");
    wrFile();//写入文件
   }else{
    printText.addLastLine("创建新文件失败!");
   }
  } else {
   printText.addLastLine("发现配置文件"+txtfile+"!");
  }
 }

 public static void wrFile(){
  //写入文件
  printText.addLastLine("\n写入文件!");
  try {
   FileWriter fw = new FileWriter(txtfile);
   /**FileWriter(File file)
    *写入文件对象(文件号):覆盖原文件
    *FileWriter(File file, boolean append)
    *写入文件对象(文件号,是否覆盖原文件)
    */
   
   String s=wrString();
   printText.addLastLine(s);
   fw.write(s); // 再写内容
   printText.addLastLine("写入成功");
   fw.close();
  } catch (IOException e) {
   e.printStackTrace();
  }
 }
 

 private static void reFile() {
  //读取文件
  printText.addLastLine("\n\n读取文件!");
  try {
   FileReader fr = new FileReader(txtfile);
   BufferedReader br=new BufferedReader(fr);
   br.mark((int)txtfile.length()+1);//标记当前位置  
   /**mark.(int readAheadLimit)
    * 关键是参数readAheadLimit的解释，从字面上看是往前读的限制 ，也就是表示“可以再读多少”。再看详细解释：
    * 是指当还保留有此mark时（i.e.mark未变化），可以再读入字符数的限制。当所读字符数达到此限制（即等于该限制）
    * 或超过此限制之后尝试重设该流的话(reset the stream)，就会导致失败，比方说上例中的异常（产生的原因就是
    * 读入的字符数等于readAheadLimit，都是4）。当限制值大于输入缓存（所谓输入缓存，BufferedReader类
    * 有两个构造子，其一就有这个参数，无参版本就以默认值替代，大小是8192）时，就会分配一个大小不小于限制值的新缓存
    * （这里说不小于其实就是等于）.因此要小心使用大数值。
    */
   int i=0;
   while(br.read()!=-1){
    i++;
   }

   br.reset();//复位到最近的标记位  
   String sr=null;
   String a=null;
   String b=null;
   while ((sr=br.readLine()) != null)
         {
//    sr=new String(sr.getBytes(),"UTF8");
    if(sr.isEmpty()){
     continue;
    }
    a=sr.substring(0, 1);
    if(a.equals("#")){
     continue;
    }
    //取等号位置
    int value = sr.indexOf("=");
    a=sr.substring(0, value).trim();//=号前面取首尾空
    b=sr.substring(value+1,sr.length()).trim();//=号后面取首尾空
    if(a.equals("extension")){
     extension=b;
     printText.addLastLine("extension="+extension);
     continue;
    }if(a.equals("sourceCode")){
     //将\\替换为/,//也替换为/
     sourceCode=b.replace("\\", "/").replace("//", "/");
     if (sourceCode.substring(sourceCode.length()-1, sourceCode.length()).equals("/")) {
      sourceCode=sourceCode.substring(0,sourceCode.length()-1);
     }
     printText.addLastLine("sourceCode="+sourceCode);
     continue;
    }if(a.equals("htmlCode")){
     //将\\替换为/,//也替换为/
     htmlCode=b.replace("\\", "/").replace("//", "/");
     if (htmlCode.substring(htmlCode.length()-1, htmlCode.length()).equals("/")) {
      htmlCode=htmlCode.substring(0,htmlCode.length()-1);
     }
     printText.addLastLine("htmlCode="+htmlCode);
     continue;
    }
         }
   br.close();
   fr.close();
  } catch (IOException e) {
   e.printStackTrace();
  }
 }
 
 public static String wrString() throws UnsupportedEncodingException{
  String s="";
  s=s+"#注释符号为#"+LINE_BREAKS;  
  s=s+"#此为需要转换为Html的后缀名,用','格开,注意区分大小写"+LINE_BREAKS;
  s=s+"extension=java,sql,h,sh"+LINE_BREAKS;
  s=s+"#此为需要转换的源码路径,递归查找该目录下的源码文件"+LINE_BREAKS;
  s=s+"sourceCode=F:/webhttp/src"+LINE_BREAKS;
  s=s+"#此为源码转换为Html后的输出路径,拥有递归功能"+LINE_BREAKS;
  s=s+"htmlCode=F:/webhttp/bin"+LINE_BREAKS;
  return s; 
 }
    /**  
     * 将extension解码为可以进行查找的通配符格式String
     */   
 public static void extensionDecoding(){
  String[] as=extension.split(",");
  extension="";
  for (int i = 0; i < as.length; i++) {
   extension=extension+"||*."+as[i];
  }
 }
 /**
  * 读入公用文件内容
  */
 private static void rePublicFile() {
   publicHead=readFile(EXTENSION_PATH+"Public_Head.html");
//   System.out.println(publicHead);
   
   publicLast=readFile(EXTENSION_PATH+"Public_Last.html");
//   System.out.println(publicLast);
 }
 public static void allToHtml(File thisfile){
  ConCatLineBreaks writeConten=new ConCatLineBreaks();
        String fileName=thisfile.getPath();
        //将\\替换为/,//也替换为/
        fileName=fileName.replace("\\", "/").replace("//", "/");
        String htmlFileName=fileName.replace(sourceCode, htmlCode)+".html";
        String extensionName=fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());
        newMkDir(htmlFileName);
//        System.out.println(htmlFileName);
        

  writeConten.addLastLine(publicHead);
  writeConten.addLastLineBreaks();
  /**
   * 读取源码相应配置文件
   */
  String extensionContent=readFile(EXTENSION_PATH+extensionName+".html");
  writeConten.addLastLine(extensionContent);
  writeConten.addLastLineBreaks();
//  System.out.println(extensionContent);
  
  /**
   * 读取源码内容
   */
  String s=readFile(fileName);
  writeConten.addLastLine(s);
  writeConten.addLastLineBreaks();

  writeConten.addLastLine(publicLast);
  writeConten.addLastLineBreaks();
  wrFile(new File(htmlFileName), writeConten.getContent());
 }
 public static void wrFile(File file,String age0){
  printText.addLastLine("正在创建文件"+file.getPath());
  try {
   //常量类:各编码名称
   CharacterEncodingName ce=new CharacterEncodingName();
   FileOutputStream o=new FileOutputStream(file);
   //采用UTF-8编码格式输出
   OutputStreamWriter out =new OutputStreamWriter(o, ce.UTF_8);
   out.write(age0);
   printText.addLastLine("文件创建写入成功");
   out.close();
  } catch (Exception e) {
   // TODO: handle exception
   System.out.println(e);
  }
 }
 /**
  * 读入文件,自动编码转换,返回文件内容
  * @param fileName  完整文件名
  * @return content  文件内容
  */
 
 public static String readFile(String fileName){
  String content="";
  try {
   FileInputStream in = new FileInputStream(fileName);
   System.out.println("文件字数为="+in.available());
   
   byte[] bytes = new byte[in.available()];
   while((in.read(bytes)) != -1);
   String code=CharacterEncoding.getLocalteFileEncode(fileName);
   System.out.println("文件编码格式为"+code); 
   
   content= new String(bytes,code);//按照文件编码格式进行转换为系统编码
//   System.out.println("文件内容为\n"+content); 
//   printText.addLastLine(content);
   in.close();
  } catch (Exception e) {
   // TODO: handle exception
  }
  return content;
 }
}    
        
```
