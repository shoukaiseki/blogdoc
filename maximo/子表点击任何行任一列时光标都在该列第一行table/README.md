# 子表点击任何行任一列时光标都在该列第一行table
如果在详情中添加标签页组,如果标签页中含有table,那么签名隐藏时候就会出现光标焦点始终在子表第一行,用"子表点击任何行任一列时光标都在该列第一行"中的解决方案无法解决

那么需要采用另一种方案

那就是使用appbean进行控制子表的隐藏

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/%E5%AD%90%E8%A1%A8%E7%82%B9%E5%87%BB%E4%BB%BB%E4%BD%95%E8%A1%8C%E4%BB%BB%E4%B8%80%E5%88%97%E6%97%B6%E5%85%89%E6%A0%87%E9%83%BD%E5%9C%A8%E8%AF%A5%E5%88%97%E7%AC%AC%E4%B8%80%E8%A1%8Ctable/img/001.png)

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/%E5%AD%90%E8%A1%A8%E7%82%B9%E5%87%BB%E4%BB%BB%E4%BD%95%E8%A1%8C%E4%BB%BB%E4%B8%80%E5%88%97%E6%97%B6%E5%85%89%E6%A0%87%E9%83%BD%E5%9C%A8%E8%AF%A5%E5%88%97%E7%AC%AC%E4%B8%80%E8%A1%8Ctable/img/002.png)


应用xml如下

```Xml
<?xml version="1.0" encoding="UTF-8"?>

<presentation id="test2" ismobile="false" mboname="TEST2" resultstableid="results_showlist" version="6.0.0" viewport="1041x600" beanclass="com.wmc.webclient.test2.Test2AppBean">
	<page id="mainrec" scroll="false">
		<include controltoclone="pageHeader" id="INCLUDE-pageHeader"/>
		<clientarea id="clientarea">
			<tabgroup id="maintabs" style="form">
				<tab default="true" id="results" label="List" type="list">
					<menubar event="search" id="actiontoolbar1" sourcemethod="getAppSearchOptions"/>
					<table id="results_showlist" inputmode="readonly" label="TABLE TITLE" mboname="TEST2" selectmode="multiple">
						<tablebody displayrowsperpage="20" filterable="true" filterexpanded="true" id="results_showlist_tablebody">
							<tablecol dataattribute="TEST2ID" filterable="false" id="results_showlist_column_select" mxevent="toggleselectrow" mxevent_desc="Select Row {0}" sortable="false" type="event"/>
							<tablecol dataattribute="TEST2ID" id="results_showlist_column_link" mxevent="selectrecord" mxevent_desc="Go To %1" type="link" usefieldsizegroup="false"/>
							<tablecol dataattribute="TEST2ID" id="results_showlist_column1"/>
							<tablecol dataattribute="DESCRIPTION" id="results_showlist_column2"/>
							<tablecol filterable="false" id="results_bookmark" mxevent="BOOKMARK" mxevent_desc="Add to Bookmarks" mxevent_icon="btn_addtobookmarks.gif" sortable="false" type="event"/>
						</tablebody>
					</table>
				</tab>
				<tab id="main" label="Main" type="insert">
					<section id="maintab_section">
						<textbox dataattribute="TEST2ID" id="maintab_attr1"/>
						<textbox dataattribute="DESCRIPTION" id="maintab_attr2" lookup="longdesc"/>
						<textbox dataattribute="type" id="1508231454907" inputmode="required" lookup="valuelist"/>
						<textbox dataattribute="ORGID" id="maintab_attr4" inputmode="readonly"/>
						<textbox dataattribute="SITEID" id="maintab_attr6" inputmode="readonly"/>
					</section>
					<!--
					<table id="1508233018061" label="华硕技嘉" relationship="TEST2A">
						<defaultvalue dataattribute="TEST2ID" defaulttype="insert" fromattribute="TEST2ID" fromdatasrc="mainrecord" id="1508233018065"/>
						<tablebody id="1508233018070">
							<tablecol dataattribute="TEST2AID" id="1508233018072" inputmode="readonly"/>
							<tablecol dataattribute="TEST2ID" id="1508233018074" inputmode="readonly"/>
							<tablecol dataattribute="a" id="1508233029544"/>
							<tablecol dataattribute="B" id="1508233018077"/>
							<tablecol dataattribute="description" id="1508233018079"/>
						</tablebody>
						<buttongroup id="1508233018082">
							<pushbutton id="1508233018084" label="新建行" mxevent="addrow"/>
						</buttongroup>
						<tabledetails id="1508233018087"/>
					</table>
-->
							<!--
					<section id="section_showasus"   sigoption="SHOWALL">
					</section>
					<section id="section_showgia" sigoption="SHOWALL">
					</section>
							     -->
						<table id="table_showgia" label="技嘉" relationship="TEST2A">
							<defaultvalue dataattribute="TEST2ID" defaulttype="insert" fromattribute="TEST2ID" fromdatasrc="mainrecord" id="1369664492323"/>
							<tablebody id="1508230861965">
								<tablecol dataattribute="TEST2AID" id="1508230861968" inputmode="readonly"/>
								<tablecol dataattribute="TEST2ID" id="1508230903351" inputmode="readonly"/>
								<tablecol dataattribute="B" id="1508231496372"/>
								<tablecol dataattribute="description" id="1508230900682"/>
							</tablebody>
							<buttongroup id="1369664594114">
								<pushbutton id="1369664594122" label="新建行" mxevent="addrow"/>
							</buttongroup>
							<tabledetails id="1508230861971"/>
						</table>
						<table id="table_showasus" label="华硕" relationship="TEST2A">
							<defaultvalue dataattribute="TEST2ID" defaulttype="insert" fromattribute="TEST2ID" fromdatasrc="mainrecord" id="1508231552487"/>
							<tablebody id="1508231552492">
								<tablecol dataattribute="TEST2AID" id="1508231552494" inputmode="readonly"/>
								<tablecol dataattribute="TEST2ID" id="1508231552497" inputmode="readonly"/>
								<tablecol dataattribute="A" id="1508231552499"/>
								<tablecol dataattribute="description" id="1508231552501"/>
							</tablebody>
							<buttongroup id="1508231552504">
								<pushbutton id="1508231552506" label="新建行" mxevent="addrow"/>
							</buttongroup>
							<tabledetails id="1508231552509"/>
						</table>
						<!-- beanclass="com.wmc.webclient.test2.Test2DataBean"
					<tabgroup id="1508232719195">
						<tab id="tab_showgia" label="技嘉"   sigoption="SHOWALL">
						</tab>
						<tab id="tab_showasus" label="华硕"   sigoption="SHOWALL">
						</tab>
					</tabgroup>
-->
				</tab>
			</tabgroup>
		</clientarea>
		<include controltoclone="pageFooter" id="INCLUDE-pageFooter"/>
	</page>

	<dialog beanclass="psdi.webclient.system.beans.QbeBean" id="searchmore" inputmode="query" label="More Search Fields">
		<section id="searchmore_1">
			<textbox dataattribute="TEST2ID" id="searchmore_attr1"/>
			<textbox dataattribute="DESCRIPTION" id="searchmore_attr2"/>
			<textbox dataattribute="DESCRIPTION_LONGDESCRIPTION" id="searchmore_attr3"/>
			<textbox dataattribute="ORGID" id="searchmore_attr4"/>
			<checkbox dataattribute="HASLD" id="searchmore_attr5"/>
			<textbox dataattribute="SITEID" id="searchmore_attr6"/>
		</section>
		<buttongroup id="searchmore_buttongroup">
			<pushbutton default="true" id="searchmore_buttongroup_1" label="Find" mxevent="dialogok"/>
			<pushbutton id="qbe_restoreappdefault_button" label="恢复应用程序缺省值" mxevent="qbeclear"/>
			<pushbutton id="qbe_revisebutton" label="修订" menutype="SEARCHMOREREVISE" targetid="searchmore"/>
			<pushbutton id="searchmore_buttongroup_3" label="Cancel" mxevent="qbecancel"/>
		</buttongroup>
	</dialog>

	<dialog beanclass="psdi.webclient.system.beans.ViewBookmarksBean" id="searchbook" label="我的书签" mboname="TEST2">
		<table id="bookmarks_table" inputmode="readonly" selectmode="single">
			<tablebody displayrowsperpage="20" filterable="true" id="bookmarks_table_tablebody">
				<tablecol dataattribute="TEST2ID" id="bookmarks_tablecolumn_1" mxevent="selectrecord" type="link"/>
				<tablecol dataattribute="description" id="bookmarks_tablecolumn_2"/>
				<tablecol filterable="false" id="bookmarks_tablecolumn_3" mxevent="instantdelete" mxevent_desc="Delete" mxevent_icon="btn_delete.gif" sortable="false" type="event"/>
			</tablebody>
		</table>
		<buttongroup id="bookmarks_2">
			<pushbutton default="true" id="bookmarks_2_1" label="确定" mxevent="dialogok"/>
		</buttongroup>
	</dialog>
	<configurationblock id="datastore_configurationblock">
	</configurationblock>
</presentation>
```

AppBean代码如下

```Java
package com.wmc.webclient.test2;

import org.apache.log4j.Logger;
import org.shoukaiseki.expand.StringExpand;
import psdi.mbo.MboRemote;
import psdi.util.MXException;
import psdi.webclient.system.beans.AppBean;

import java.rmi.RemoteException;

/**
 * com.wmc.webclient.test2.Test2AppBean <br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  2017-10-17 19:20:10<br>
 * ブログ http://shoukaiseki.blog.163.com/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/
public class Test2AppBean extends AppBean{
    public static final Logger logger=Logger.getLogger("org.shoukaiseki");

    public  Test2AppBean(){
        super();
    }


    @Override
    protected void setCurrentRecordData(MboRemote mbo) throws MXException, RemoteException {
        super.setCurrentRecordData(mbo);
        logger.debug("appbean.setCurrentRecordData="+getId());
        inittable();
    }

    public void inittable() throws RemoteException, MXException {
        logger.debug("id="+getId());
        logger.debug("returnComponent.getId="+this.clientSession.getCurrentAppId());

        MboRemote mbo = app.getAppBean().getMbo();

            if ("Gigabyte".equalsIgnoreCase(mbo.getString("TYPE"))) {
                logger.debug("隐藏 ASUS");
                app.getDataBean("table_showgia").getCreator().setProperty("display","true");
                app.getDataBean("table_showasus").getCreator().setProperty("display","false");
            } else if("ASUS".equalsIgnoreCase(mbo.getString("TYPE"))){
                logger.debug("显示 ASUS");
                app.getDataBean("table_showgia").getCreator().setProperty("display","false");
                app.getDataBean("table_showasus").getCreator().setProperty("display","true");
            }
    }

}
```
