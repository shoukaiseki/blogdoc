package com.shoukaiseki.birt;


import java.io.File;
import java.io.PrintWriter;

import org.eclipse.birt.report.engine.api.script.IReportContext;
import org.eclipse.birt.report.engine.api.script.element.IDataSet;
import org.eclipse.birt.report.engine.api.script.element.IReportDesign;
import org.eclipse.birt.report.engine.api.script.eventadapter.ReportEventAdapter;
import org.eclipse.birt.report.model.api.CellHandle;
import org.eclipse.birt.report.model.api.ColumnHandle;
import org.eclipse.birt.report.model.api.DataItemHandle; 
import org.eclipse.birt.report.model.api.ElementFactory;
import org.eclipse.birt.report.model.api.LabelHandle;
import org.eclipse.birt.report.model.api.OdaDataSetHandle;
import org.eclipse.birt.report.model.api.PropertyHandle;
import org.eclipse.birt.report.model.api.RowHandle;
import org.eclipse.birt.report.model.api.ScriptDataSetHandle;
import org.eclipse.birt.report.model.api.StructureFactory;
import org.eclipse.birt.report.model.api.TableHandle;
import org.eclipse.birt.report.model.api.elements.structures.ComputedColumn;
import org.eclipse.birt.report.model.elements.OdaDataSet;
/**
 *  com.shoukaiseki.birt.TableColumnHandle
 * @author 蒋カイセキ
 *
 */
public class TableColumnHandle extends ReportEventAdapter {
	private static String[] dynamicColumns; //动态列
	
	private static PrintWriter pw;
	
	@Override
	public void initialize(IReportContext reportContext) {
		// TODO Auto-generated method stub
		try{
			super.initialize(reportContext);
		
			//输出日志
			pw = new PrintWriter(new File("c:/tmp/TableColumnHandle.txt"));
			pw.println("initialize: ok");
			
			String columnsStr = (String)reportContext.getParameterValue("columnNames");
			pw.println("columnsStr:" + columnsStr);
			
			dynamicColumns = doSplit(columnsStr, ",");
			
			if(null != dynamicColumns){
				for(String s : dynamicColumns){
					pw.print("\tdynamicColumns:" + s);
				}
			}
			pw.println();
		}catch (Exception e) {
			e.printStackTrace(pw);
			if(null != pw){
				pw.println("close pw!");
				pw.close();
			}
		}
	}
	
	@Override
	public void beforeFactory(IReportDesign report, IReportContext reportContext) {
		// TODO Auto-generated method stub
		super.beforeFactory(report, reportContext);
		pw.println("beforeFactory");
		try{
			ElementFactory elementFactory = reportContext.getDesignHandle().getElementFactory();
			TableHandle mytable = (TableHandle) reportContext.getDesignHandle().findElement("table");//table名称 General-name设置
			mytable.setWidth("100%");
			
			pw.println("beforeFactory add columns doing");  
			
			
			RowHandle myheader = (RowHandle) mytable.getHeader( ).get( 0 );//获得表格头
			RowHandle mydetail = (RowHandle) mytable.getDetail().get( 0 );//获得明细行
			ColumnHandle mycolumn0 = (ColumnHandle) mytable.getColumns().get(0);//获取固定列
			mycolumn0.setProperty("width", "2cm");
			mycolumn0.setProperty("backgroundColor", "white");
//			mycolumn0.drop(); //drop the 0 column
			
			String[] colors = {"#1C1D1E","red","green","orange","yellow","blue","navy","purple"};
			String[] columnName = {"DISPLAYNAME","DISPLAYNAME","PERSONID","location","TITLE","STATUS","navy","purple"};
			
			columnName = new String[]{"STATUS","PERSONID","DISPLAYNAME"};
			int i=0;//计列数
			for(String column : dynamicColumns){
				mytable.insertColumn(i+1,1);//循环插入新列，每次加在最后一列的后面
				ColumnHandle mycolumn = (ColumnHandle) mytable.getColumns().get(i+1);
				mycolumn.setProperty("width", "2cm");
				mycolumn.setProperty("backgroundColor", colors[i%7]);//设置列背景色
				mycolumn.setProperty("color", "#FF8C00");//设置列字体颜色black
				
				CellHandle dcell = (CellHandle) mydetail.getCells().get(i+1);//取得明细行单元格
				//设置样式
				dcell.setProperty("borderBottomColor","#000000");
				dcell.setProperty("borderBottomStyle","solid");
				dcell.setProperty("borderBottomWidth","1px");
				dcell.setProperty("borderLeftColor","#000000");
				dcell.setProperty("borderLeftStyle","solid");
				dcell.setProperty("borderLeftWidth","1px");
				dcell.setProperty("borderRightColor","#000000");
				dcell.setProperty("borderRightStyle","solid");
				dcell.setProperty("borderRightWidth","1px");
				dcell.setProperty("borderTopColor","#000000");
				dcell.setProperty("borderTopStyle","solid");
				dcell.setProperty("borderTopWidth","1px");

//				IDataSet rss=report.getDataSet("maximoDataSource");
				
//				pw.println("getExtensionID:" + rss.getDataSource().getExtensionID());
//				OdaDataSetHandle ods=elementFactory.newOdaDataSet("Data Set");
				
				DataItemHandle myDataItem2 = elementFactory.newDataItem(column);//column
				pw.println("myDataItem2:" + myDataItem2.getName());
//				pw.println("elementFactory:" + elementFactory.newOdaDataSet("Data Set").getName());
				myDataItem2.setResultSetColumn(columnName[i]);//列数据 column
				dcell.getContent().add(myDataItem2);
				
				
//				 ScriptDataSetHandle dataSetHandle = elementFactory.newScriptDataSet("maximoDataSource");
//				 dataSetHandle.setDataSource("Data Source");
				 
				 
//				PropertyHandle colbinds = mytable.getColumnBindings( );
//				ComputedColumn cs = StructureFactory.createComputedColumn( );
//				cs.setName( column);
//				cs.setExpression( "dataSetRow[\""+column+"\"]");
//				
				
				CellHandle hcell = (CellHandle) myheader.getCells( ).get(i+1);
				//设置样式
				hcell.setProperty("borderBottomColor","#000000");
				hcell.setProperty("borderBottomStyle","solid");
				hcell.setProperty("borderBottomWidth","1px");
				hcell.setProperty("borderLeftColor","#000000");
				hcell.setProperty("borderLeftStyle","solid");
				hcell.setProperty("borderLeftWidth","1px");
				hcell.setProperty("borderRightColor","#000000");
				hcell.setProperty("borderRightStyle","solid");
				hcell.setProperty("borderRightWidth","1px");
				hcell.setProperty("borderTopColor","#000000");
				hcell.setProperty("borderTopStyle","solid");
				hcell.setProperty("borderTopWidth","1px");

				LabelHandle myLabel = elementFactory.newLabel(column);
				myLabel.setText(column);//表头名称  column
				
				hcell.getContent().add(myLabel);
				i++;
				pw.println("insert column:" + column);
			}
		
		pw.println("beforeFactory add tables done");
		}catch (Exception e) {
			e.printStackTrace(pw);
		}finally{
			if(null != pw){
				pw.println("close pw!!!");
				pw.close();
			}
		}
	}
	
	public String[] doSplit(String s, String rep){
		if(null == s || "".equals(s)){
			throw new  NullPointerException();
		}
		
		return s.split(rep);
	
	}

}
