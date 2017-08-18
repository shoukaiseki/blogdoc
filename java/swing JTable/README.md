# swing JTable  

之前碰到添加列,添加行Exception in thread "AWT-EventQueue-0" java.lang.NullPointerException报错问题,现在终于解决了
```Java

package shoukaiseki.gui.jtable;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.DefaultCellEditor;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.ListSelectionModel;
import javax.swing.SwingUtilities;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableModel;

public class JTableOperating extends JTable {
 /**
  * 表格模型对象
  */
 private DefaultTableModel tableModel;
 /**
  * 表格列名
  */
 private Object[] columns = {};
 /**
  * 表格内容
  */
 private Object[][] rows = {};
 private Object[] addRowData = {};
 // 为true说明有线程使用;
 private boolean status = false;
 private boolean bFull = false;
 /**
  * 线程的操作类型,为removeRowsALl,addRow
  */
 // Thread thread;
 private Runnable runnable;
 private String type = "";
 private int waittime = 10;
 private int columnCount = 0;

 public JTableOperating(int arg0, int arg1) {
  super(arg0, arg1);
  initDefuoruto();
  columnCount = this.getColumnCount();
 }

 public JTableOperating(TableModel dm) {

  super(dm);
  tableModel = (DefaultTableModel) dm;
  initDefuoruto();
  columnCount = tableModel.getColumnCount();
 }

 /**
  * 默认初始化时开启功能
  */
 public void initDefuoruto() {
  /**
   * 双击单元格时单元格内容全选
   */
  this.setDefaultEditor(Object.class, new DefaultCellEditor(
    new JTextField()) {

   @Override
   public Component getTableCellEditorComponent(JTable table,
     Object value, boolean isSelected, int row, int column) {
    final Component textField = super.getTableCellEditorComponent(
      table, value, isSelected, row, column);

    if (textField instanceof JTextField) {
     SwingUtilities.invokeLater(new Runnable() {

      public void run() {
       ((JTextField) textField).selectAll();
      }
     });
    }
    return textField;
   }
  });

  // thread = new Thread() {
  // public void run() {
  // while (1 == 1) {
  // if (status) {
  // for (int i = tableModel.getColumnCount(); i < addRowData.length; i++)
  // {
  // int column = i + 65;
  // tableModel.addColumn((char) column);
  // removeEditor();
  // clearSelection();
  // tableModel.fireTableDataChanged();
  // // try {
  // // sleep(1000);
  // // } catch (InterruptedException e) {
  // // // TODO Auto-generated catch block
  // // e.printStackTrace();
  // // }
  // }
  // // try {
  // // sleep(waittime);
  // // } catch (InterruptedException e) {
  // // // TODO Auto-generated catch block
  // // e.printStackTrace();
  // // }
  // removeEditor();
  // clearSelection();
  // tableModel.addRow(addRowData);
  // tableModel.fireTableDataChanged();
  // status = false;
  // }
  // try {
  // sleep(waittime);
  // } catch (InterruptedException e) {
  // // TODO Auto-generated catch block
  // e.printStackTrace();
  // }
  // }
  // }
  // };
  //
  // thread.start();
 }

 public void init() {

  // this.setPreferredScrollableViewportSize(new Dimension(600, 100));//
  // 设置表格的大小
  // this.setRowHeight(30);// 设置每行的高度为20
  // this.setRowHeight(0, 20);// 设置第1行的高度为15
  // this.setRowMargin(5);// 设置相邻两行单元格的距离
  // this.setRowSelectionAllowed(true);// 设置可否被选择.默认为false
  // this.setSelectionBackground(Color.white);// 设置所选择行的背景色
  this.setSelectionForeground(Color.red);// 设置所选择行的前景色
  // this.setGridColor(Color.black);// 设置网格线的颜色
  // this.setRowSelectionInterval(0, 2);// 设置初始的选择行,这里是1到3行都处于选择状态
  // this.clearSelection();// 取消选择
  // this.setDragEnabled(false);// 不懂这个
  // this.setShowGrid(false);// 是否显示网格线
  // this.setShowHorizontalLines(true);// 是否显示水平的网格线
  // this.setShowVerticalLines(true);// 是否显示垂直的网格线
  // this.setValueAt("tt", 0, 0);// 设置某个单元格的值,这个值是一个对象
  // this.doLayout();
  // this.setBackground(Color.lightGray);//背景色
  // this.selectAll();// 选择所有行

  /**
   * 是否只选择单个(否则选中的为正行),开启此项之后才使用下面三种模式
   */
  // "单一选择"
  // table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
  // "连续区间选择"
  // table.setSelectionMode(ListSelectionModel.SINGLE_INTERVAL_SELECTION);
  // "多重选择"
  // table.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);

  this.setCellSelectionEnabled(true);
  this.setColumnSelectionAllowed(true);
  
  runnable = new Runnable() {
   public void run() {
//    System.out.println("Runnable--bFull->" + bFull + "---" + type);

    if (type.equals("addRow")) {
     threadAddRow();
    } else if (type.equals("removeRowsAll")) {
//     System.out.println("tableModel.setRowCount(0)->" + "start");
     tableModel.setRowCount(0);
//     System.out.println("tableModel.setRowCount(0)->" + "end");

     while (tableModel.getColumnCount() == 0) {
//      System.out.println(tableModel.getColumnCount());
      try {
       Thread.sleep(10);
      } catch (InterruptedException e) {
       // TODO Auto-generated catch block
       e.printStackTrace();
      }
     }
//     System.out.println("tableModel.setRowCount(0)->" + bFull+ "---" + type);
    }
//    tableModel.fireTableDataChanged();
//    tableModel.fireTableStructureChanged();

    bFull = false;
//    System.out.println("Runnable--bFull->" + bFull);
   }
  };
 }

 /**
  * 清空表格
  */
 public void clearRowsAll() {
  // TODO Auto-generated method stub
  int hight = this.getRowCount();
  removeRowsAll();
  tableModel.setRowCount(hight);

 }

 /**
  * 删除表格
  */
 public void removeRowsAll() {
//  System.out.println("removeRowsAll--->" + status);
  operatingTabelThread("removeRowsAll");
//  System.out.println("removeRowsAll--->" + status);

 }

 /**
  * 如果列不够则自动增加,已ABCDE按照在第几列命名 添加一行到模型的结尾。如果未指定 rowData，则新行将包含 null
  * 值。生成添加行的通知。 synchronized
  * 
  * @param rowData
  */
 public synchronized void addRow(Object[] rowData)
   throws ArrayIndexOutOfBoundsException {
//  System.out.println("addRow--->" + status);

  if (status) {
   try {
    wait();
   } catch (InterruptedException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
   } // 后来的线程要等待
  }
  status = true;
  addRowData = rowData;
  operatingTabelThread("addRow");
//  System.out.println("addRow--->" + status);
  while (status) {

  }// 完成后才能唤醒其它线程
  notify(); // 唤醒最先到达的线程
 }

 public synchronized void operatingTabelThread(String ttype) {
  /**
   * 忙标识
   */
//  System.out.println("operatingTabelThread--status->" + status);
  if (bFull) {
   try {
//    System.out.println("operatingTabelThread-wait-bFull->" + bFull);
    wait();
//    System.out.println("operatingTabelThread-wait-bFull->" + bFull);
   } catch (InterruptedException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
   } // 后来的线程要等待
  }
  bFull = true;
  type = ttype;
  SwingUtilities.invokeLater(runnable);
  // asus();
//  System.out.println("operatingTabelThread--bFull->" + bFull);
  
  while (bFull) {
   try {
    Thread.sleep(10);
   } catch (InterruptedException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
   }

  }
  status = false;
  notify(); // 唤醒最先到达的线程
//  System.out.println("operatingTabelThread--status->" + status);

 }

 /**
  * 线程调用的addrow方法
  */
 private void threadAddRow() {
//  System.out.println("Runnable--threadAddRow->" + "start");
  int rowcount = this.getRowCount();
  if (columnCount < addRowData.length) {
   tableModel.setColumnCount(addRowData.length);
//   System.out.println(this.getColumnCount() + "------>"
//     + addRowData.length);
   columnCount = addRowData.length;
//   tableModel.fireTableDataChanged();
//   tableModel.fireTableStructureChanged();
  }
  while (this.getColumnCount() < addRowData.length) {
//   System.out.println(this.getColumnCount() + "------>"
//     + addRowData.length);
  }
  tableModel.addRow(addRowData);
//  tableModel.fireTableDataChanged();
//  tableModel.fireTableStructureChanged();

  while (this.getRowCount() <= rowcount) {
//   System.out.println(this.getRowCount() + "------>" + rowcount);
  }

//  System.out.println("Runnable--threadAddRow->" + "end");
 }

 public DefaultTableModel getDefaultTableModel() {
  return this.tableModel;
 }

 /**
  * @param args
  */
 public static void main(String[] args) {
  // TODO Auto-generated method stub
  JFrame frame = new JFrame("JTableOperating");
  Container c = frame.getContentPane();
  JTableOperating table = null;
  // table = new JTableOperating(50, 18);

  Object rows[][] = {};
  String columns[] = { "姓名", "国籍", "年龄" };
  table = new JTableOperating(new DefaultTableModel(columns, 55));
  JScrollPane scrollPane = new JScrollPane(table); // 支持滚动
  table.init();
  // table.se

  // jp.add(scrollPane);
  c.add(scrollPane);
  frame.setSize(700, 500);
  frame.setLocation(200, 150);
  frame.setTitle("表格");
  frame.setVisible(true);
  frame.setDefaultCloseOperation(frame.EXIT_ON_CLOSE);

//  ExcelAdapter myAd = new ExcelAdapter(table);


  for (int i = 0; i < 99009; i++) {
   final JTableOperating table1 = table;
   if (table1.getRowCount() > 8) {
    table1.removeRowsAll();
   } else {
    table1.addRow(new Object[]{"A","B","C"});
   }
   try {
    Thread.sleep(100);
   } catch (InterruptedException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
   }
  }
 }


}


```
