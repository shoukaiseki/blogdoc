# Swing JTable Excel复制粘贴兼容  

把swing JTable源码中的 //  ExcelAdapter myAd = new ExcelAdapter(table);注释取消即可

```Java
package shoukaiseki.gui.jtable;
/**
 * 经过修改,已完美兼容excel,源程序常用空格,现已修改用\n(下一单元格)\t(右边单元格)
 * 只对java Swing JTables的表有效
 * 实现Swing的JTables和Excel间的复制和粘贴功能
 * 单元格兼容,但是多个单元格不兼容
 */
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.StringSelection;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.util.StringTokenizer;

import javax.swing.JComponent;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.KeyStroke;

public class ExcelAdapter implements ActionListener {
 private String rowstring, value;
 private Clipboard system;
 private StringSelection stsel;
 private JTable jTable1;

 /**
  * Excel 适配器由 JTable 构成， 它实现了 JTable 上的复制粘贴 功能，并充当剪贴板监听程序。
  */
 public ExcelAdapter(JTable myJTable) {
  jTable1 = myJTable;
  KeyStroke copy = KeyStroke.getKeyStroke(KeyEvent.VK_C,
    ActionEvent.CTRL_MASK, false);
  // 确定复制按键用户可以对其进行修改
  // 以实现其它按键组合的复制功能。
  KeyStroke paste = KeyStroke.getKeyStroke(KeyEvent.VK_V,
    ActionEvent.CTRL_MASK, false);
  // 确定粘贴按键用户可以对其进行修改
  // 以实现其它按键组合的复制功能。
  jTable1.registerKeyboardAction(this, "Copy", copy,
    JComponent.WHEN_FOCUSED);
  jTable1.registerKeyboardAction(this, "Paste", paste,
    JComponent.WHEN_FOCUSED);
  system = Toolkit.getDefaultToolkit().getSystemClipboard();
 }

 /**
  * 此适配器运行图表的公共读方法。
  */
 public JTable getJTable() {
  return jTable1;
 }

 public void setJTable(JTable jTable1) {
  this.jTable1 = jTable1;
 }


 public void actionPerformed(ActionEvent e) {
  /**源语句if (e.getActionCommand().compareTo("Copy") == 0) {
   * 现取消copy
   */
  if (e.getActionCommand().compareTo("Copy") == 0) {
//   System.out.println("copy");
   StringBuffer sbf = new StringBuffer();
   // 检查以确保我们仅选择了单元格的
   // 相邻块
   int numcols = jTable1.getSelectedColumnCount();
   int numrows = jTable1.getSelectedRowCount();
   int[] rowsselected = jTable1.getSelectedRows();
   int[] colsselected = jTable1.getSelectedColumns();
   if (!((numrows - 1 == rowsselected[rowsselected.length - 1]
     - rowsselected[0] && numrows == rowsselected.length) && (numcols - 1 == colsselected[colsselected.length - 1]
     - colsselected[0] && numcols == colsselected.length))) {
    JOptionPane.showMessageDialog(null, "Invalid Copy Selection",
      "Invalid Copy Selection", JOptionPane.ERROR_MESSAGE);
    return;
   }
   for (int i = 0; i < numrows; i++) {
    for (int j = 0; j < numcols; j++) {
     sbf.append(jTable1.getValueAt(rowsselected[i],
       colsselected[j]));
     if (j < numcols - 1)
      sbf.append("\t");
    }
    sbf.append("\n");
   }
   stsel = new StringSelection(sbf.toString());
   system = Toolkit.getDefaultToolkit().getSystemClipboard();
   system.setContents(stsel, stsel);
  }
  if (e.getActionCommand().compareTo("Paste") == 0) {
//   System.out.println("Trying to Paste");
   int startRow = (jTable1.getSelectedRows())[0];
   int startCol = (jTable1.getSelectedColumns())[0];
   try {
    String trstring = (String) (system.getContents(this)
      .getTransferData(DataFlavor.stringFlavor));
//       byte[] b=trstring.getBytes();
//
//    System.out.println("将String型转换为二进制,十六进制");
//       for (int i = 0; i < b.length; i++) {
//        System.out.print(Integer.parseInt(Integer.toHexString(b[i]&0xff), 16)+"\t");
////        System.out.print(Integer.toHexString(b[i]&0xff)+"\t");
//           if((i+1)%10==0&&i!=0){
//            System.out.println();
//           }
//       }
//          System.out.println();
          
//    System.out.println("String is:" + trstring);
    String[] st1 = trstring.split("\n",-1);//分割符为\n,空字符不丢弃
    /**
     * t1.length-1为最后一个\n后面不做一个数组处理
     */
    for (int i = 0; i < st1.length-1; i++) {
     rowstring = st1[i];
//     rowstring=rowstring.replace("\n", "");//
     String[]  st2 = rowstring.split("\t",-1);//分割符为\t
     for (int j = 0; j<st2.length; j++) {
      value =st2[j];
//      value=value.replace("\t", "");//
//      System.out.println(value);
      if (startRow + i < jTable1.getRowCount()
        && startCol + j < jTable1.getColumnCount())
       jTable1.setValueAt(value, startRow + i, startCol
         + j);
//      System.out.println("Putting " + value + " atrow="
//        + startRow + i + " column=" + startCol + j);
     }
    }
   } catch (Exception ex) {
    ex.printStackTrace();
   }
  }
 }
}
```
