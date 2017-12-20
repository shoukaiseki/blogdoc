set define off;


----------------ApplicationDeleteScript----------------

delete from maxmodules  where MODULE='SECURITY';
delete from maxapps where APP= 'TESTPO';
delete from maxpresentation where APP= 'TESTPO';
delete from maxlabels where app='TESTPO';
delete from Maxmenu where KEYVALUE='TESTPO' or MODULEAPP='TESTPO';
delete from Sigoption where APP='TESTPO';


----------------ApplicationInsertScript----------------



----------------CreateModuleScript----------------

insert into maxmodules ( MODULE, DESCRIPTION, MAXMODULESID) values ( 'SECURITY', '组织架构', MAXMODULESSEQ.nextval);
insert into maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'MODULE', 'SECURITY', 10830, 0, 'MODULE', 'SECURITY', null, null, 1, 'modimg_security.gif', null, null, MAXMENUSEQ.nextval);


----------------CreateAppScript----------------

insert into maxapps ( APP, DESCRIPTION, APPTYPE, RESTRICTIONS, ORDERBY, ORIGINALAPP, CUSTAPPTYPE, MAINTBNAME, MAXAPPSID, ISMOBILE, LOCKENABLED) values ( 'TESTPO', 'TESTPO', 'RUN', null, null, 'CUSTAPP', null, 'TEST2', MAXAPPSSEQ.nextval, 0, 0);


----------------CreateMaxmenuScript----------------

insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'MODULE', 'SECURITY', 10962, 0, 'APP', 'TESTPO', null, null, 1, null, null, null, MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPMENU', 'TESTPO', 11, 0, 'OPTION', 'DUPLICATE', null, null, 1, null, null, '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPMENU', 'TESTPO', 12, 0, 'OPTION', 'DELETE', null, null, 1, null, null, '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPMENU', 'TESTPO', 13, 0, 'OPTION', 'BOOKMARK', null, null, 1, null, null, '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPO', 1, 1, 'OPTION', 'INSERT', null, null, 1, 'nav_icon_insert.gif', 'CTRL+ALT+I', '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPO', 1, 2, 'OPTION', 'SAVE', null, null, 1, 'nav_icon_save.gif', 'CTRL+ALT+S', '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPO', 1, 3, 'OPTION', 'CLEAR', null, null, 1, 'nav_icon_clear.gif', 'CTRL+ALT+C', '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPO', 2, 0, 'SEP', 'AT2', null, null, 1, null, null, null, MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPO', 2, 1, 'OPTION', 'PREVIOUS', null, null, 1, 'nav_icon_previous.gif', 'CTRL+ALT+P', '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPO', 2, 2, 'OPTION', 'NEXT', null, null, 1, 'nav_icon_next.gif', 'CTRL+ALT+N', '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPO', 10, 0, 'HEADER', 'SM10', '高级搜索', null, 1, 'atb_search.gif', null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPO', 10, 10, 'OPTION', 'SEARCHMORE', null, null, 1, null, null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPO', 10, 20, 'OPTION', 'SEARCHWHER', null, null, 1, null, null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPO', 10, 30, 'OPTION', 'SEARCHTIPS', null, null, 1, null, null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPO', 20, 0, 'HEADER', 'SM20', '保存查询', null, 1, 'atb_save.gif', null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPO', 20, 10, 'OPTION', 'SEARCHSQRY', null, null, 1, null, null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPO', 20, 20, 'OPTION', 'SEARCHVMQR', null, null, 1, null, null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPO', 30, 0, 'OPTION', 'SEARCHBOOK', null, null, 1, 'atb_bookmark.gif', null, '所有', MAXMENUSEQ.nextval);


----------------CreateSigoptionScript----------------

insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'BMXVIEWMANAGEWHER', '用于控制“查看/管理查询”对话框中“详细信息”部分的可视性的签名选项', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'BMXVIEWMANAGEWHERRO', '用于控制“查看/管理查询”对话框中“子句”字段的可编辑性的签名选项', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'BOOKMARK', '添加到书签', 0, 0, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'CLEAR', '清除变更', 0, 0, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'DELETE', '删除 TESTPO', 0, 1, null, null, 'SAVE', SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'DUPLICATE', '复制 TESTPO', 0, 1, null, null, 'INSERT', SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'INSERT', '新建 TESTPO', 0, 1, 'SAVE', 'DUPLICATE', null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'NEXT', '下一个 TESTPO', 0, 0, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'PREVIOUS', '上一个 TESTPO', 0, 0, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'READ', '读取 TESTPO', 0, 1, 'CLEAR,BOOKMARK,NEXT,PREVIOUS', 'ALL', null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'SAVE', '保存 TESTPO', 0, 1, null, 'INSERT,DUPLICATE, DELETE', null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'SEARCHBOOK', '书签', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'SEARCHMORE', '更多搜索字段', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'SEARCHSQRY', '保存当前查询', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'SEARCHTIPS', '查看搜索提示', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'SEARCHVMQR', '查看/管理查询', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPO', 'SEARCHWHER', 'WHERE 子句', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);


----------------CreatePresentationScript----------------

insert into maxpresentation (app, maxpresentationid, presentation)
 Values ('TESTPO',maxpresentationseq.nextval,
'<?xml version="1.0" encoding="UTF-8"?> <presentation id="testpo" ismobile="false" mboname="TEST2" resultstableid="results_showlist" 
version="6.0.0" viewport="1041x600"> <page id="mainrec" scroll="false"> <include controltoclone="pageHeader" id="INCLUDE-
pageHeader"/> <clientarea id="clientarea"> <tabgroup id="maintabs" style="form"> <tab default="true" id="results" label="List" 
type="list"> <menubar event="search" id="actiontoolbar1" sourcemethod="getAppSearchOptions"/> <table id="results_showlist" 
inputmode="readonly" label="TABLE TITLE" mboname="TEST2" selectmode="multiple"> <tablebody displayrowsperpage="20" 
filterable="true" filterexpanded="true" id="results_showlist_tablebody"> <tablecol dataattribute="TEST2ID" filterable="false" 
id="results_showlist_column_select" mxevent="toggleselectrow" mxevent_desc="Select Row {0}" sortable="false" type="event"/> 
<tablecol dataattribute="TEST2ID" id="results_showlist_column_link" mxevent="selectrecord" mxevent_desc="Go To %1" type="link" 
usefieldsizegroup="false"/> <tablecol dataattribute="TEST2ID" id="results_showlist_column1"/> <tablecol dataattribute="DESCRIPTION" 
id="results_showlist_column2"/> <tablecol filterable="false" id="results_bookmark" mxevent="BOOKMARK" mxevent_desc="Add to 
Bookmarks" mxevent_icon="btn_addtobookmarks.gif" sortable="false" type="event"/> </tablebody> </table> </tab> <tab id="main" 
label="Main" type="insert"> <section id="maintab_section"> <textbox dataattribute="TEST2ID" id="maintab_attr1" 
inputmode="readonly"/> <textbox dataattribute="DESCRIPTION" id="maintab_attr2" lookup="longdesc"/> <textbox dataattribute="type" 
id="1508231454907" lookup="valuelist"/> <textbox applink="testpr" dataattribute="testprnum" id="1513592766606" menutype="normal"/> 
<textbox dataattribute="ORGID" id="maintab_attr4" inputmode="readonly"/> <textbox dataattribute="SITEID" id="maintab_attr6" 
inputmode="readonly"/> </section> <table id="poline" label="POLINE" relationship="TEST2A"> <defaultvalue dataattribute="TEST2ID" d');


--------------------------------

update maxpresentation set presentation=presentation ||
'efaulttype="insert" fromattribute="TEST2ID" fromdatasrc="mainrecord" id="1369664492323"/> <tablebody id="1508230861965"> <tablecol 
id="1510393207667" mxevent="toggledetailstate"/> <tablecol dataattribute="TEST2AID" id="1508230861968" inputmode="readonly"/> 
<tablecol dataattribute="TEST2ID" id="1508230903351" inputmode="readonly"/> <tablecol dataattribute="A" id="1508231496371"/> 
<tablecol dataattribute="B" id="1508231496372"/> <tablecol dataattribute="description" id="1508230900682" inputmode="readonly"/> 
<tablecol id="1510304896846" mxevent="toggledeleterow" type="event"/> </tablebody> <buttongroup id="1369664594114"> <pushbutton 
id="1369664594122" label="新建行" mxevent="addrow"/> </buttongroup> <tabledetails id="1508230861971"> <section id="1518230861971"/> 
</tabledetails> </table> </tab> </tabgroup> </clientarea> <include controltoclone="pageFooter" id="INCLUDE-pageFooter"/> </page> 
<dialog beanclass="psdi.webclient.system.beans.QbeBean" id="searchmore" inputmode="query" label="More Search Fields"> <section 
id="searchmore_1"> <textbox dataattribute="TEST2ID" id="searchmore_attr1"/> <textbox dataattribute="DESCRIPTION" 
id="searchmore_attr2"/> <textbox dataattribute="DESCRIPTION_LONGDESCRIPTION" id="searchmore_attr3"/> <checkbox 
dataattribute="HASLD" id="searchmore_attr4"/> <textbox dataattribute="TYPE" id="searchmore_attr5"/> <textbox dataattribute="SITEID" 
id="searchmore_attr6"/> <textbox dataattribute="ORGID" id="searchmore_attr7"/> </section> <buttongroup id="searchmore_buttongroup"> 
<pushbutton default="true" id="searchmore_buttongroup_1" label="Find" mxevent="dialogok"/> <pushbutton 
id="qbe_restoreappdefault_button" label="恢复应用程序缺省值" mxevent="qbeclear"/> <pushbutton id="qbe_revisebutton" label="修订" 
menutype="SEARCHMOREREVISE" targetid="searchmore"/> <pushbutton id="searchmore_buttongroup_3" label="Cancel" mxevent="qbecancel"/> 
</buttongroup> </dialog> <dialog beanclass="psdi.webclient.system.beans.ViewBookmarksBean" id="searchbook" label="我的书签" 
mboname="TEST2">'
where app='TESTPO';


--------------------------------

update maxpresentation set presentation=presentation ||
' <table id="bookmarks_table" inputmode="readonly" selectmode="single"> <tablebody displayrowsperpage="20" filterable="true" 
id="bookmarks_table_tablebody"> <tablecol dataattribute="TEST2ID" id="bookmarks_tablecolumn_1" mxevent="selectrecord" type="link"/> 
<tablecol dataattribute="description" id="bookmarks_tablecolumn_2"/> <tablecol filterable="false" id="bookmarks_tablecolumn_3" 
mxevent="instantdelete" mxevent_desc="Delete" mxevent_icon="btn_delete.gif" sortable="false" type="event"/> </tablebody> </table> 
<buttongroup id="bookmarks_2"> <pushbutton default="true" id="bookmarks_2_1" label="确定" mxevent="dialogok"/> </buttongroup> 
</dialog> <configurationblock id="datastore_configurationblock"> </configurationblock> </presentation>'
where app='TESTPO';
commit;


----------------CreateMaxlabelsScript----------------

insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', '1369664594122', 'label', '新建行', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'bookmarks_tablecolumn_3', 'mxevent_desc', 'Delete', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'main', 'label', 'Main', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'results', 'label', 'List', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'results_bookmark', 'mxevent_desc', 'Add to Bookmarks', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'results_showlist', 'label', 'TABLE TITLE', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'results_showlist_column_link', 'mxevent_desc', 'Go To %1', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'results_showlist_column_select', 'mxevent_desc', 'Select Row {0}', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'searchmore', 'label', 'More Search Fields', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'searchmore_buttongroup_1', 'label', 'Find', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'searchmore_buttongroup_3', 'label', 'Cancel', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPO', 'poline', 'label', 'POLINE', MAXLABELSSEQ.nextval);


----------------ApplicationDeleteScript----------------

delete from maxmodules  where MODULE='SECURITY';
delete from maxapps where APP= 'TESTPR';
delete from maxpresentation where APP= 'TESTPR';
delete from maxlabels where app='TESTPR';
delete from Maxmenu where KEYVALUE='TESTPR' or MODULEAPP='TESTPR';
delete from Sigoption where APP='TESTPR';


----------------ApplicationInsertScript----------------



----------------CreateModuleScript----------------

insert into maxmodules ( MODULE, DESCRIPTION, MAXMODULESID) values ( 'SECURITY', '组织架构', MAXMODULESSEQ.nextval);
insert into maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'MODULE', 'SECURITY', 10830, 0, 'MODULE', 'SECURITY', null, null, 1, 'modimg_security.gif', null, null, MAXMENUSEQ.nextval);


----------------CreateAppScript----------------

insert into maxapps ( APP, DESCRIPTION, APPTYPE, RESTRICTIONS, ORDERBY, ORIGINALAPP, CUSTAPPTYPE, MAINTBNAME, MAXAPPSID, ISMOBILE, LOCKENABLED) values ( 'TESTPR', 'TESTPR', 'RUN', null, null, 'CUSTAPP', null, 'TEST2', MAXAPPSSEQ.nextval, 0, 0);


----------------CreateMaxmenuScript----------------

insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'MODULE', 'SECURITY', 10963, 0, 'APP', 'TESTPR', null, null, 1, null, null, null, MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPMENU', 'TESTPR', 11, 0, 'OPTION', 'DUPLICATE', null, null, 1, null, null, '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPMENU', 'TESTPR', 12, 0, 'OPTION', 'DELETE', null, null, 1, null, null, '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPMENU', 'TESTPR', 13, 0, 'OPTION', 'BOOKMARK', null, null, 1, null, null, '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPR', 1, 1, 'OPTION', 'INSERT', null, null, 1, 'nav_icon_insert.gif', 'CTRL+ALT+I', '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPR', 1, 2, 'OPTION', 'SAVE', null, null, 1, 'nav_icon_save.gif', 'CTRL+ALT+S', '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPR', 1, 3, 'OPTION', 'CLEAR', null, null, 1, 'nav_icon_clear.gif', 'CTRL+ALT+C', '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPR', 2, 0, 'SEP', 'AT2', null, null, 1, null, null, null, MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPR', 2, 1, 'OPTION', 'PREVIOUS', null, null, 1, 'nav_icon_previous.gif', 'CTRL+ALT+P', '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'APPTOOL', 'TESTPR', 2, 2, 'OPTION', 'NEXT', null, null, 1, 'nav_icon_next.gif', 'CTRL+ALT+N', '主要', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPR', 10, 0, 'HEADER', 'SM10', '高级搜索', null, 1, 'atb_search.gif', null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPR', 10, 10, 'OPTION', 'SEARCHMORE', null, null, 1, null, null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPR', 10, 20, 'OPTION', 'SEARCHWHER', null, null, 1, null, null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPR', 10, 30, 'OPTION', 'SEARCHTIPS', null, null, 1, null, null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPR', 20, 0, 'HEADER', 'SM20', '保存查询', null, 1, 'atb_save.gif', null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPR', 20, 10, 'OPTION', 'SEARCHSQRY', null, null, 1, null, null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPR', 20, 20, 'OPTION', 'SEARCHVMQR', null, null, 1, null, null, '所有', MAXMENUSEQ.nextval);
insert into Maxmenu ( MENUTYPE, MODULEAPP, POSITION, SUBPOSITION, ELEMENTTYPE, KEYVALUE, HEADERDESCRIPTION, URL, VISIBLE, IMAGE, ACCESSKEY, TABDISPLAY, MAXMENUID) values ( 'SEARCHMENU', 'TESTPR', 30, 0, 'OPTION', 'SEARCHBOOK', null, null, 1, 'atb_bookmark.gif', null, '所有', MAXMENUSEQ.nextval);


----------------CreateSigoptionScript----------------

insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'BMXVIEWMANAGEWHER', '用于控制“查看/管理查询”对话框中“详细信息”部分的可视性的签名选项', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'BMXVIEWMANAGEWHERRO', '用于控制“查看/管理查询”对话框中“子句”字段的可编辑性的签名选项', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'BOOKMARK', '添加到书签', 0, 0, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'CLEAR', '清除变更', 0, 0, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'DELETE', '删除 TESTPR', 0, 1, null, null, 'SAVE', SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'DUPLICATE', '复制 TESTPR', 0, 1, null, null, 'INSERT', SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'INSERT', '新建 TESTPR', 0, 1, 'SAVE', 'DUPLICATE', null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'NEXT', '下一个 TESTPR', 0, 0, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'PREVIOUS', '上一个 TESTPR', 0, 0, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'READ', '读取 TESTPR', 0, 1, 'CLEAR,BOOKMARK,NEXT,PREVIOUS', 'ALL', null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'SAVE', '保存 TESTPR', 0, 1, null, 'INSERT,DUPLICATE, DELETE', null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'SEARCHBOOK', '书签', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'SEARCHMORE', '更多搜索字段', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'SEARCHSQRY', '保存当前查询', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'SEARCHTIPS', '查看搜索提示', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'SEARCHVMQR', '查看/管理查询', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);
insert into Sigoption ( APP, OPTIONNAME, DESCRIPTION, ESIGENABLED, VISIBLE, ALSOGRANTS, ALSOREVOKES, PREREQUISITE, SIGOPTIONID, LANGCODE, HASLD, MEMO) values ( 'TESTPR', 'SEARCHWHER', 'WHERE 子句', 0, 1, null, null, null, SIGOPTIONSEQ.nextval, 'ZH', 0, null);


----------------CreatePresentationScript----------------

insert into maxpresentation (app, maxpresentationid, presentation)
 Values ('TESTPR',maxpresentationseq.nextval,
'<?xml version="1.0" encoding="UTF-8"?> <presentation beanclass="com.wmc.webclient.test2.TestAdjustmentAppBean" id="testpr" 
ismobile="false" mboname="TEST2" resultstableid="results_showlist" version="6.0.0" viewport="1041x600"> <page id="mainrec" 
scroll="false"> <include controltoclone="pageHeader" id="INCLUDE-pageHeader"/> <clientarea id="clientarea"> <tabgroup id="maintabs" 
style="form"> <tab default="true" id="results" label="List" type="list"> <menubar event="search" id="actiontoolbar1" 
sourcemethod="getAppSearchOptions"/> <table id="results_showlist" inputmode="readonly" label="TABLE TITLE" mboname="TEST2" 
selectmode="multiple"> <tablebody displayrowsperpage="20" filterable="true" filterexpanded="true" id="results_showlist_tablebody"> 
<tablecol dataattribute="TEST2ID" filterable="false" id="results_showlist_column_select" mxevent="toggleselectrow" 
mxevent_desc="Select Row {0}" sortable="false" type="event"/> <tablecol dataattribute="TEST2ID" id="results_showlist_column_link" 
mxevent="selectrecord" mxevent_desc="Go To %1" type="link" usefieldsizegroup="false"/> <tablecol dataattribute="TEST2ID" 
id="results_showlist_column1"/> <tablecol dataattribute="DESCRIPTION" id="results_showlist_column2"/> <tablecol filterable="false" 
id="results_bookmark" mxevent="BOOKMARK" mxevent_desc="Add to Bookmarks" mxevent_icon="btn_addtobookmarks.gif" sortable="false" 
type="event"/> </tablebody> </table> </tab> <tab id="main" label="Main" type="insert"> <section id="maintab_section"> <textbox 
dataattribute="TEST2ID" id="maintab_attr1" inputmode="readonly"/> <textbox dataattribute="DESCRIPTION" id="maintab_attr2" 
lookup="longdesc"/> <textbox dataattribute="type" id="1508231454907" lookup="valuelist"/> <textbox dataattribute="ORGID" 
id="maintab_attr4" inputmode="readonly"/> <textbox dataattribute="SITEID" id="maintab_attr6" inputmode="readonly"/> </section> 
<table id="testprline" label="PRLINE" relationship="TEST2A"> <defaultvalue dataattribute="TEST2ID" defaulttype="insert" fromattri');


--------------------------------

update maxpresentation set presentation=presentation ||
'bute="TEST2ID" fromdatasrc="mainrecord" id="1369664492323"/> <tablebody id="1508230861965"> <tablecol id="1510393207667" 
mxevent="toggledetailstate"/> <tablecol dataattribute="TEST2AID" id="1508230861968" inputmode="readonly"/> <tablecol 
dataattribute="TEST2ID" id="1508230903351" inputmode="readonly"/> <tablecol dataattribute="A" id="1508231496371"/> <tablecol 
dataattribute="B" id="1508231496372"/> <tablecol id="1510304896846" mxevent="toggledeleterow" type="event"/> </tablebody> 
<buttongroup id="1369664594114"> <pushbutton id="1369664594122" label="新建行" mxevent="addrow"/> </buttongroup> <tabledetails 
id="1508230861971"> <section id="1518230861971"/> </tabledetails> </table> </tab> </tabgroup> </clientarea> <include 
controltoclone="pageFooter" id="INCLUDE-pageFooter"/> </page> <dialog beanclass="psdi.webclient.system.beans.QbeBean" 
id="searchmore" inputmode="query" label="More Search Fields"> <section id="searchmore_1"> <textbox dataattribute="TEST2ID" 
id="searchmore_attr1"/> <textbox dataattribute="DESCRIPTION" id="searchmore_attr2"/> <textbox 
dataattribute="DESCRIPTION_LONGDESCRIPTION" id="searchmore_attr3"/> <checkbox dataattribute="HASLD" id="searchmore_attr4"/> 
<textbox dataattribute="TYPE" id="searchmore_attr5"/> <textbox dataattribute="SITEID" id="searchmore_attr6"/> <textbox 
dataattribute="ORGID" id="searchmore_attr7"/> </section> <buttongroup id="searchmore_buttongroup"> <pushbutton default="true" 
id="searchmore_buttongroup_1" label="Find" mxevent="dialogok"/> <pushbutton id="qbe_restoreappdefault_button" label="恢复应用程序缺
省值" mxevent="qbeclear"/> <pushbutton id="qbe_revisebutton" label="修订" menutype="SEARCHMOREREVISE" targetid="searchmore"/> 
<pushbutton id="searchmore_buttongroup_3" label="Cancel" mxevent="qbecancel"/> </buttongroup> </dialog> <dialog 
beanclass="psdi.webclient.system.beans.ViewBookmarksBean" id="searchbook" label="我的书签" mboname="TEST2"> <table 
id="bookmarks_table" inputmode="readonly" selectmode="single"> <tablebody displayrowsperpage="20" fil'
where app='TESTPR';


--------------------------------

update maxpresentation set presentation=presentation ||
'terable="true" id="bookmarks_table_tablebody"> <tablecol dataattribute="TEST2ID" id="bookmarks_tablecolumn_1" 
mxevent="selectrecord" type="link"/> <tablecol dataattribute="description" id="bookmarks_tablecolumn_2"/> <tablecol 
filterable="false" id="bookmarks_tablecolumn_3" mxevent="instantdelete" mxevent_desc="Delete" mxevent_icon="btn_delete.gif" 
sortable="false" type="event"/> </tablebody> </table> <buttongroup id="bookmarks_2"> <pushbutton default="true" id="bookmarks_2_1" 
label="确定" mxevent="dialogok"/> </buttongroup> </dialog> <configurationblock id="datastore_configurationblock"> 
</configurationblock> </presentation>'
where app='TESTPR';
commit;


----------------CreateMaxlabelsScript----------------

insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', '1369664594122', 'label', '新建行', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'bookmarks_tablecolumn_3', 'mxevent_desc', 'Delete', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'main', 'label', 'Main', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'results', 'label', 'List', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'results_bookmark', 'mxevent_desc', 'Add to Bookmarks', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'results_showlist', 'label', 'TABLE TITLE', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'results_showlist_column_link', 'mxevent_desc', 'Go To %1', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'results_showlist_column_select', 'mxevent_desc', 'Select Row {0}', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'searchmore', 'label', 'More Search Fields', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'searchmore_buttongroup_1', 'label', 'Find', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'searchmore_buttongroup_3', 'label', 'Cancel', MAXLABELSSEQ.nextval);
insert into maxlabels ( APP, ID, PROPERTY, VALUE, MAXLABELSID) values ( 'TESTPR', 'testprline', 'label', 'PRLINE', MAXLABELSSEQ.nextval);
commit;
