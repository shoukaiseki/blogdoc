# maximo图片操作

测试代码使用主项目(ITEM)应用

按照[测试配置]配置完成之后,点击按钮

1.如果之前该项目之前有图片,则会更改为 001.jpg 图片
2.如果之前该项目无图片,则会更改为 002.jsp 图片


# 测试配置

## 测试图片存放
将 img 中的 001.jpg 和 002.jpg放到 C:/tmp 目录


## 修改说明

应用中增加一个测试按钮,appbean类绑定更改为 org.shoukaiseki.webclient.beans.test.TestItemAppBean

并在页面中填写按钮

```Xml
			<buttongroup id="main_altitem_table_2aa">
				<pushbutton default="true" id="main_altitem_table_2_1aa" label="测试" mxevent="ASUS"/>
			</buttongroup>
```

## item.xml测试代码
```Xml
<?xml version="1.0" encoding="UTF-8"?>

<presentation apphelp="com.ibm.mbs.doc,item/c_item_master_app.html" beanclass="org.shoukaiseki.webclient.beans.test.TestItemAppBean" id="item" keyattribute="itemnum" mboname="ITEM" resultstableid="results_showlist" version="7.1.0.0">
	<page id="mainrec">
		<include id="pageHeader"/>
		<clientarea id="clientarea">
			<tabgroup id="maintabs" style="form">
				<tab default="true" id="results" label="列表" type="list">
					<menubar event="search" id="actiontoolbar" sourcemethod="getAppSearchOptions"/>
					<table beanclass="psdi.webclient.beans.item.ItemResultsBean" id="results_showlist" inputmode="readonly" label="项目" mboname="ITEM" selectmode="multiple">
						<tablebody displayrowsperpage="20" filterable="true" filterexpanded="true" id="results_showlist_tablebody">
							<tablecol dataattribute="itemnum" filterable="false" hidden="false" id="results_showlist_tablebody_1" mxevent="toggleselectrow" mxevent_desc="选择行{0}" sortable="false" type="event"/>
							<tablecol dataattribute="itemnum" id="results_showlist_tablebody_2" menutype="item" mxevent="selectrecord" mxevent_desc="转到 %1" type="link" usefieldsizegroup="false"/>
							<tablecol dataattribute="description" id="results_showlist_tablebody_3"/>
							<tablecol dataattribute="commoditygroup" id="results_showlist_tablebody_4"/>
							<tablecol dataattribute="rotating" id="results_showlist_tablebody_5"/>
							<tablecol dataattribute="iskit" id="results_showlist_tablebody_6"/>
							<tablecol dataattribute="conditionenabled" id="results_showlist_tablebody_7"/>
							<tablecol dataattribute="status" id="results_showlist_tablebody_7a"/>
							<tablecol filterable="false" hidden="false" id="results_bookmark" mxevent="BOOKMARK" mxevent_desc="添加到书签" mxevent_icon="btn_addtobookmarks.gif" sortable="false" type="event"/>
						</tablebody>
					</table>
				</tab>
				<tab id="main" label="项目" type="insert">
					<section border="true" id="main_gridd">
						<sectionrow id="main_gridg">
							<sectioncol id="main_gride">
								<section id="main_gridf">
									<multiparttextbox dataattribute="ITEMNUM" descdataattribute="DESCRIPTION" id="main_grid2_1" longdescription="true" menutype="item"/>
									<textbox dataattribute="ITEMSETID" id="main_grid2_2"/>
									<multiparttextbox dataattribute="COMMODITYGROUP" descdataattribute="COMMODITYGROUP.DESCRIPTION" descinputmode="readonly" id="main_grid2_3" longdescreadonly="true" lookup="commoditygroup"/>
									<multiparttextbox dataattribute="COMMODITY" descdataattribute="COMMODITIES.DESCRIPTION" descinputmode="readonly" id="main_grid2_4" longdescreadonly="true" lookup="commodities"/>
									<multiparttextbox applink="metergrp" dataattribute="GROUPNAME" descdataattribute="METERGROUP.DESCRIPTION" descinputmode="readonly" id="main_grid2_5" longdescreadonly="true" lookup="metergroup" menutype="normal"/>
									<multiparttextbox applink="meter" dataattribute="METERNAME" descdataattribute="METER.DESCRIPTION" descinputmode="readonly" id="main_grid2_6" longdescreadonly="true" lookup="meter" menutype="normal"/>
									<textbox dataattribute="LOTTYPE" id="main_grid2_7" lookup="valuelist"/>
									<textbox dataattribute="MAXISSUE" id="main_grid2_8"/>
									<textbox dataattribute="ORDERUNIT" id="main_grid2_9" lookup="measureunit"/>
									<textbox dataattribute="ISSUEUNIT" id="main_grid2_10" lookup="measureunit"/>
									<textbox dataattribute="MSDSNUM" id="main_grid2_11"/>
									<textbox dataattribute="RECEIPTTOLERANCE" id="main_grid2_11A"/>
								</section>
							</sectioncol>
							<sectioncol id="main_gridh">
								<section border="false" id="main_attachments">
									<attachments id="doclinks"/>
									<textbox dataattribute="STATUS" id="main_grid2_12" inputmode="readonly"/>
									<checkbox dataattribute="ROTATING" id="main_grid2_14"/>
									<checkbox dataattribute="CONDITIONENABLED" id="main_grid2_15"/>
									<checkbox dataattribute="ISKIT" id="main_grid2_16"/>
									<checkbox dataattribute="CAPITALIZED" id="main_grid2_18"/>
									<checkbox dataattribute="INSPECTIONREQUIRED" id="main_grid2_19"/>
									<checkbox dataattribute="SPAREPARTAUTOADD" id="main_grid2_20"/>
									<checkbox dataattribute="ATTACHONISSUE" id="main_grid2_21"/>
									<checkbox dataattribute="TAXEXEMPT" id="main_grid2_22"/>
								</section>
							</sectioncol>
							<sectioncol id="main_gridj">
								<section id="main_recordimage">
									<recordimage height="120" id="main_recordimage_1" label="单击以实际大小查看图像" width="120"/>
								</section>
							</sectioncol>
						</sectionrow>
					</section>
						<buttongroup id="main_altitem_table_2aa">
							<pushbutton default="true" id="main_altitem_table_2_1aa" label="测试" mxevent="ASUS"/>
						</buttongroup>
					<table id="main_altitem_table" label="替代项目" relationship="ALTITEM">
						<tablebody displayrowsperpage="10" filterable="true" id="main_altitem_table_tablebody">
							<tablecol filterable="false" hidden="false" id="main_altitem_table_tablebody_1" mxevent="toggledetailstate" mxevent_desc="显示详细信息" sortable="false" type="event"/>
							<tablecol dataattribute="altitemnum" id="main_altitem_table_tablebody_2">
								<textbox dataattribute="altitemnum" id="altitem_item" lookup="itemwithitemset" menutype="itemwithitemset"/>
							</tablecol>
							<tablecol dataattribute="altitem.description" id="main_altitem_table_tablebody_3" sortable="false">
								<textbox dataattribute="altitem.description" id="altitem_desc" inputmode="readonly" longdescreadonly="true" lookup="longdesc"/>
							</tablecol>
							<tablecol dataattribute="altitem.commoditygroup" id="main_altitem_table_tablebody_4" linkedcontrolid="main_altitem_table_1_grid3_3" sortable="false"/>
							<tablecol dataattribute="altitem.commodity" id="main_altitem_table_tablebody_7" linkedcontrolid="main_altitem_table_1_grid3_5" sortable="false"/>
							<tablecol dataattribute="altitem.rotating" id="main_altitem_table_tablebody_5" linkedcontrolid="main_altitem_table_1_grid3_4" sortable="false"/>
							<tablecol filterable="false" hidden="false" id="main_altitem_table_tablebody_6" mxevent="toggledeleterow" mxevent_desc="标记要删除的行" mxevent_icon="btn_garbage.gif" sortable="false" type="event"/>
						</tablebody>
						<tabledetails id="main_altitem_table_1">
							<section id="main_altitem_table_1_grid3" label="详细信息">
								<sectionrow id="main_altitem_table_1_grid3a">
									<sectioncol id="main_altitem_table_1_grid3b">
										<section id="main_altitem_table_1_grid3c">
											<multiparttextbox dataattribute="altitemnum" defaultfocus="true" descdataattribute="altitem.description" descinputmode="readonly" id="main_altitem_table_1_grid3_1" longdescreadonly="true" lookup="itemwithitemset" menutype="itemwithitemset"/>
											<textbox dataattribute="altitem.commoditygroup" id="main_altitem_table_1_grid3_3" inputmode="readonly"/>
										</section>
									</sectioncol>
									<sectioncol id="main_altitem_table_1_grid3d">
										<section id="main_altitem_table_1_grid3e">
											<textbox dataattribute="altitem.commodity" id="main_altitem_table_1_grid3_5" inputmode="readonly"/>
											<checkbox dataattribute="altitem.rotating" id="main_altitem_table_1_grid3_4" inputmode="readonly"/>
										</section>
									</sectioncol>
								</sectionrow>
							</section>
						</tabledetails>
						<buttongroup id="main_altitem_table_2">
							<pushbutton default="true" id="main_altitem_table_2_1" label="新建行" mxevent="addrow"/>
						</buttongroup>
					</table>
					<table id="main_conditioncode_table" label="条件代码" relationship="ITEMCONDITION">
						<tablebody displayrowsperpage="10" filterable="true" id="main_conditioncode_table_tablebody">
							<tablecol filterable="false" hidden="false" id="main_conditioncode_table_tablebody_1" mxevent="toggledetailstate" mxevent_desc="显示详细信息" sortable="false" type="event"/>
							<tablecol dataattribute="conditioncode" id="main_conditioncode_table_tablebody_2">
								<textbox dataattribute="conditioncode" id="main_conditioncode_table_tablebody_2a" lookup="conditioncode"/>
							</tablecol>
							<tablecol dataattribute="description" id="main_conditioncode_table_tablebody_3">
								<textbox dataattribute="description" id="main_conditioncode_table_tablebody_3a" lookup="longdesc"/>
							</tablecol>
							<tablecol dataattribute="condrate" id="main_conditioncode_table_tablebody_4"/>
							<tablecol filterable="false" hidden="false" id="main_conditioncode_table_tablebody_5" mxevent="toggledeleterow" mxevent_desc="标记要删除的行" mxevent_icon="btn_garbage.gif" sortable="false" type="event"/>
						</tablebody>
						<tabledetails id="main_conditioncode_table_1">
							<section id="main_conditioncode_table_1_grid3" label="详细信息">
								<sectionrow id="main_conditioncode_table_1_grid3_row">
									<sectioncol id="main_conditioncode_table_1_grid3_row_col1">
										<section id="main_conditioncode_table_1_grid3_row_col1_sec">
											<multiparttextbox dataattribute="conditioncode" defaultfocus="true" descdataattribute="description" id="main_conditioncode_table_1_grid3_1" lookup="conditioncode"/>
										</section>
									</sectioncol>
									<sectioncol id="main_conditioncode_table_1_grid3_row_col2">
										<section id="main_conditioncode_table_1_grid3_row_col2_sec">
											<textbox dataattribute="condrate" id="main_conditioncode_table_1_grid3_3"/>
										</section>
									</sectioncol>
								</sectionrow>
							</section>
						</tabledetails>
						<buttongroup id="main_conditioncode_table_2">
							<pushbutton default="true" id="main_conditioncode_table_2_1" label="新建行" mxevent="addrow"/>
						</buttongroup>
					</table>
				</tab>
				<tab id="storeroom" label="库房">
					<section border="true" id="store_grida">
						<sectionrow id="store_grida_1">
							<sectioncol id="store_grida_1_1">
								<section id="store_grida_1_1_1">
									<multiparttextbox dataattribute="ITEMNUM" descdataattribute="DESCRIPTION" id="store_grid2_1" longdescription="true" menutype="item"/>
								</section>
							</sectioncol>
							<sectioncol id="store_gridb">
								<section id="store_gridc">
									<textbox dataattribute="ITEMSETID" id="store_grid2_4"/>
								</section>
							</sectioncol>
						</sectionrow>
					</section>
					<table id="storeroom_inventorytable" label="库房信息" relationship="INVENTORY">
						<tablebody displayrowsperpage="10" filterable="true" id="storeroom_inventorytable_tablebody">
							<tablecol dataattribute="location" id="storeroom_inventorytable_tablebody_1"/>
							<tablecol dataattribute="category" id="storeroom_inventorytable_tablebody_2"/>
							<tablecol dataattribute="invcost_cond.stdcost" id="storeroom_inventorytable_tablebody_3" inputmode="readonly" sortable="false"/>
							<tablecol dataattribute="invcost_cond.avgcost" id="storeroom_inventorytable_tablebody_4" inputmode="readonly" sortable="false"/>
							<tablecol dataattribute="invcost_cond.lastcost" id="storeroom_inventorytable_tablebody_5" inputmode="readonly" sortable="false"/>
							<tablecol dataattribute="lifofifocost" id="storeroom_inventorytable_tablebody_6" inputmode="readonly" label="后进先出/先进先出单位成本" sortable="false"/>
							<tablecol dataattribute="curbaltotal" filterable="false" id="storeroom_inventorytable_tablebody_7" sortable="false"/>
							<tablecol dataattribute="binnum" id="storeroom_inventorytable_tablebody_8"/>
							<tablecol dataattribute="status" id="storeroom_inventorytable_tablebody_9"/>
							<tablecol dataattribute="siteid" id="storeroom_inventorytable_tablebody_10"/>
						</tablebody>
					</table>
				</tab>
				<tab id="vendors" label="供应商">
					<section border="true" id="vendor_grida">
						<sectionrow id="vendor_grida_1">
							<sectioncol id="vendor_grida_1_1">
								<section id="vendor_grida_1_1_1">
									<multiparttextbox dataattribute="ITEMNUM" descdataattribute="DESCRIPTION" id="vendor_grid2_1" longdescription="true" menutype="item"/>
								</section>
							</sectioncol>
							<sectioncol id="vendor_gridb">
								<section id="vendor_gridc">
									<textbox dataattribute="ITEMSETID" id="vendor_grid2_4"/>
								</section>
							</sectioncol>
						</sectionrow>
					</section>
					<table id="vendors_prec_table" label="供应商" relationship="INVVENDOR" startrow="0">
						<tablebody displayrowsperpage="5" filterable="true" id="vendors_prec_table_tablebody">
							<tablecol filterable="false" hidden="false" id="vendors_prec_table_tablebody_1" mxevent="toggledetailstate" mxevent_desc="显示详细信息" sortable="false" type="event"/>
							<tablecol applink="company" applinkkey="company" dataattribute="vendor" id="vendors_prec_table_tablebody_2" lookup="companies" menutype="normal"/>
							<tablecol applink="company" dataattribute="manufacturer" id="vendors_prec_table_tablebody_3" lookup="companies" menutype="normal" smartfilloff="true"/>
							<tablecol dataattribute="modelnum" id="vendors_prec_table_tablebody_4"/>
							<tablecol dataattribute="catalogcode" id="vendors_prec_table_tablebody_5"/>
							<tablecol dataattribute="lastcost" id="vendors_prec_table_tablebody_8"/>
							<tablecol dataattribute="lastdate" id="vendors_prec_table_tablebody_9" lookup="datelookup"/>
							<tablecol dataattribute="orderunit" id="vendors_prec_table_tablebody_10" lookup="measureunit"/>
							<tablecol dataattribute="orgid" id="vendors_prec_table_tablebody_6" lookup="org"/>
							<tablecol dataattribute="siteid" id="vendors_prec_table_tablebody_7" lookup="site"/>
							<tablecol filterable="false" hidden="false" id="vendors_prec_table_tablebody_11" mxevent="toggledeleterow" mxevent_desc="标记要删除的行" mxevent_icon="btn_garbage.gif" sortable="false" type="event"/>
						</tablebody>
						<tabledetails id="vendors_prec_table_1">
							<section id="vendors_prec_table_1_grid9" label="详细信息">
								<sectionrow id="vendors_prec_table_1_grid9_row">
									<sectioncol id="vendors_prec_table_1_grid9_row_col1">
										<section id="vendors_prec_table_1_grid9_row_col1_sec">
											<multiparttextbox applink="company" applinkkey="company" dataattribute="vendor" defaultfocus="true" descdataattribute="vendor.name" descinputmode="readonly" id="vendors_prec_table_1_grid9_1" longdescreadonly="true" lookup="companies" menutype="normal" title="供应商表窗口"/>
											<multiparttextbox applink="company" dataattribute="manufacturer" descdataattribute="manufacturer.name" descinputmode="readonly" id="vendors_prec_table_1_grid9_3" longdescreadonly="true" lookup="companies" menutype="normal" smartfilloff="true" title="制造商表窗口"/>
											<textbox dataattribute="modelnum" id="vendors_prec_table_1_grid9_5" title="型号表窗口"/>
											<textbox dataattribute="catalogcode" id="vendors_prec_table_1_grid9_6" title="目录代码表窗口"/>
											<textbox dataattribute="promdeliverytime" id="vendors_prec_table_1_grid9_7" title="承诺交货期表窗口"/>
											<textbox dataattribute="tax1code" id="vendors_prec_table_1_grid9_11" lookup="taxcode" title="税代码表窗口"/>
											<textbox dataattribute="vendor.currencycode" id="vendors_prec_table_1_grid9_8" inputmode="readonly" title="当前代码表窗口"/>
											<textbox dataattribute="RECEIPTTOLERANCE" id="vendors_prec_table_1_grid9_11A"/>
											<checkbox dataattribute="isdefault" id="vendors_prec_table_1_grid9_13" title="缺省供应商表窗口"/>
										</section>
									</sectioncol>
									<sectioncol id="vendors_prec_table_1_grid9_row_col2">
										<section id="vendors_prec_table_1_grid9_row_col2_sec">
											<checkbox dataattribute="vendor.disabled" id="vendors_prec_table_1_grid9_12" inputmode="readonly" title="被取消资格的供应商表窗口"/>
											<textbox dataattribute="lastcost" id="vendors_prec_table_1_grid9_9" title="最终价格表窗口"/>
											<textbox dataattribute="lastdate" id="vendors_prec_table_1_grid9_10" lookup="datelookup" title="上次订购日期表窗口"/>
											<textbox dataattribute="orderunit" id="vendors_prec_table_1_grid9_15" lookup="measureunit" title="订购单位表窗口"/>
											<textbox dataattribute="catalogwebpage" id="vendors_prec_table_1_grid9_14" title="目录 Web 页面表窗口"/>
											<checkbox dataattribute="TAXEXEMPT" id="vendors_prec_table_1_grid9_14a"/>
											<textbox dataattribute="orgid" id="vendors_prec_table_1_grid9_16" lookup="org"/>
											<textbox dataattribute="siteid" id="vendors_prec_table_1_grid9_17" lookup="site"/>
										</section>
									</sectioncol>
								</sectionrow>
							</section>
						</tabledetails>
						<buttongroup id="vendors_prec_table_2">
							<pushbutton default="true" id="vendors_prec_table_2_1" label="新建行" mxevent="addrow"/>
						</buttongroup>
					</table>
				</tab>
				<tab id="specification" label="规范">
					<section border="true" id="specifications_grid2_row_col1_sec">
						<multiparttextbox dataattribute="ITEMNUM" descdataattribute="DESCRIPTION" id="specification_grid2_1" menutype="item"/>
						<textbox applink="assetcat" dataattribute="CLASSSTRUCTURE.HIERARCHYPATH" id="specification_grid3_1_1_3" menutype="classification" ondatachange="resetchildren"/>
						<textbox dataattribute="CLASSSTRUCTURE.description_class" id="specification_grid3_1_1_4" lookup="classification" ondatachange="resetchildren"/>
					</section>
					<table id="specification_itemspectable" label="规范" orderby="displaysequence" relationship="ITEMSPECCLASS">
						<tablebody displayrowsperpage="10" filterable="true" id="specification_itemspectable_tablebody">
							<tablecol filterable="false" hidden="false" id="specification_itemspectable_tablebody_1" mxevent="toggledetailstate" mxevent_desc="显示详细信息" sortable="false" type="event"/>
							<tablecol dataattribute="assetattrid" id="specification_itemspectable_tablebody_2" lookup="assetattribute"/>
							<tablecol dataattribute="assetattribute.description" id="specification_itemspectable_tablebody_3" inputmode="readonly" showfilterfield="true" sortable="false"/>
							<tablecol dataattribute="assetattribute.datatype" id="specification_itemspectable_tablebody_4" linkedcontrolid="specification_itemspectable_1_griddetails_3" showfilterfield="true" sortable="false"/>
							<tablecol dataattribute="alnvalue" id="specification_itemspectable_tablebody_5" linkedcontrolid="specification_itemspectable_1_griddetails_4"/>
							<tablecol dataattribute="numvalue" id="specification_itemspectable_tablebody_6" linkedcontrolid="specification_itemspectable_1_griddetails_5"/>
							<tablecol dataattribute="measureunitid" id="specification_itemspectable_tablebody_7" linkedcontrolid="specification_itemspectable_1_griddetails_6"/>
							<tablecol dataattribute="tablevalue" id="specification_itemspectable_tablebody_8" linkedcontrolid="specification_itemspectable_1_griddetails_5a"/>
							<tablecol filterable="false" hidden="false" id="specification_itemspectable_tablebody_9" mxevent="toggledeleterow" mxevent_desc="标记要删除的行" mxevent_icon="btn_garbage.gif" sortable="false" type="event"/>
						</tablebody>
						<tabledetails id="specification_itemspectable_1">
							<section id="specification_itemspectable_1_griddetails" label="详细信息">
								<sectionrow id="specifications_specifications_table_1_griddetails1_row">
									<sectioncol id="specifications_specifications_table_1_griddetails1_row_col1">
										<section id="specifications_specifications_table_1_griddetails1_row_col1_sec">
											<multiparttextbox dataattribute="assetattrid" defaultfocus="true" descdataattribute="assetattribute.description" descinputmode="readonly" id="specification_itemspectable_1_griddetails_1" lookup="assetattribute"/>
											<textbox dataattribute="assetattribute.datatype" id="specification_itemspectable_1_griddetails_3" inputmode="readonly"/>
										</section>
									</sectioncol>
									<sectioncol id="specifications_specifications_table_1_griddetails1_row_col2">
										<section id="specifications_specifications_table_1_griddetails1_row_col2_sec">
											<textbox dataattribute="alnvalue" id="specification_itemspectable_1_griddetails_4" lookup="alndomain" smartfilloff="true"/>
											<textbox dataattribute="numvalue" id="specification_itemspectable_1_griddetails_5" lookup="numericdomain" smartfilloff="true"/>
											<textbox dataattribute="measureunitid" id="specification_itemspectable_1_griddetails_6" lookup="measureunit"/>
											<textbox dataattribute="tablevalue" id="specification_itemspectable_1_griddetails_5a" menutype="normal"/>
											<textbox dataattribute="section" id="specification_itemspectable_1_griddetails_7"/>
											<textbox dataattribute="classspec.inheritedfrom" id="specification_itemspectable_1_griddetails_5b" inputmode="readonly"/>
											<textbox dataattribute="classspec.applydownhier" id="specification_itemspectable_1_griddetails_5c" inputmode="readonly"/>
										</section>
									</sectioncol>
								</sectionrow>
							</section>
						</tabledetails>
						<buttongroup id="specification_itemspectable_2">
							<pushbutton default="true" id="specification_itemspectable_2_1" label="新建行" mxevent="addrow"/>
						</buttongroup>
					</table>
				</tab>
				<tab id="ias_tab" label="项目组装结构">
					<datasrc beanclass="psdi.webclient.beans.item.TopItemStructBean" id="ias" parentdatasrc="MAINRECORD" relationship="TOPITEMSTRUCT_1"/>
					<datasrc beanclass="psdi.webclient.beans.item.MoveToItemStructBean" id="parentitem" parentdatasrc="ias" relationship="PARENT"/>
					<section border="true" id="ias_tab_grid2">
						<multiparttextbox dataattribute="itemnum" descdataattribute="description" id="ias_tab_grid2_1" label="顶级项目" menutype="item"/>
						<multiparttextbox dataattribute="itemnum" datasrc="ias" descdataattribute="item.description" descdatasrc="ias" descinputmode="readonly" id="ias_tab_grid2_3" label="当前级别" longdescreadonly="true" menutype="item"/>
						<multiparttextbox applink="item" dataattribute="itemnum" datasrc="parentitem" descdataattribute="item.description" descdatasrc="ias" descinputmode="readonly" id="ias_tab_grid2_5" label="所属" longdescreadonly="true" lookup="itemwithitemset" menutype="itemhier" movetodatasrc="ias" movetoqbe="false"/>
						<textbox dataattribute="remark" datasrc="ias" id="ias_tab_grid2_7" lookup="longdesc"/>
					</section>
					<table beanclass="psdi.webclient.beans.item.MoveToItemStructBean" id="ias_tab_children_table" label="子级" parentdatasrc="ias" relationship="CHILDREN">
						<tablebody displayrowsperpage="10" filterable="true" id="ias_tab_children_table_tablebody">
							<tablecol filterable="false" hidden="false" id="ias_tab_children_table_tablebody_1" mxevent="toggledetailstate" mxevent_desc="显示详细信息" sortable="false" type="event"/>
							<tablecol applink="item,inventor" dataattribute="itemnum" defaultfocus="true" id="ias_tab_children_table_tablebody_2" lookup="itemwithitemset" menutype="itemhier" movetodatasrc="ias" movetoqbe="false"/>
							<tablecol dataattribute="item.description" id="ias_tab_children_table_tablebody_3" sortable="false">
								<textbox dataattribute="item.description" id="ias_item_desc" inputmode="readonly" longdescreadonly="true" lookup="longdesc"/>
							</tablecol>
							<tablecol dataattribute="quantity" id="ias_tab_children_table_tablebody_4"/>
							<tablecol dataattribute="remark" id="ias_tab_children_table_tablebody_5" linkedcontrolid="ias_tab_children_table_1_grid3_4"/>
							<tablecol filterable="false" hidden="false" id="ias_tab_children_table_tablebody_6" mxevent="toggledeleterow" mxevent_desc="标记要删除的行" mxevent_icon="btn_garbage.gif" sortable="false" type="event"/>
						</tablebody>
						<tabledetails id="ias_tab_children_table_1">
							<section id="ias_tab_children_table_1_grid3" label="详细信息">
								<sectionrow id="ias_tab_children_table_1_grid3_row">
									<sectioncol id="ias_tab_children_table_1_grid3_row_col1">
										<section id="ias_tab_children_table_1_grid3_row_col1_sec">
											<multiparttextbox applink="item,inventor" dataattribute="itemnum" defaultfocus="true" descdataattribute="item.description" descinputmode="readonly" id="ias_tab_children_table_1_grid3_1" longdescreadonly="true" longdescription="true" lookup="itemwithitemset" menutype="itemhier" movetodatasrc="ias" movetoqbe="false"/>
											<textbox dataattribute="quantity" id="ias_tab_children_table_1_grid3_3"/>
										</section>
									</sectioncol>
									<sectioncol id="ias_tab_children_table_1_grid3_row_col2">
										<section id="ias_tab_children_table_1_grid3_row_col2_sec">
											<textbox dataattribute="remark" id="ias_tab_children_table_1_grid3_4" lookup="longdesc"/>
										</section>
									</sectioncol>
								</sectionrow>
							</section>
						</tabledetails>
						<buttongroup id="ias_tab_children_table_2">
							<pushbutton default="true" id="ias_tab_children_table_2_1" label="新建行" mxevent="addrow"/>
						</buttongroup>
					</table>
				</tab>
			</tabgroup>
		</clientarea>
		<include id="pageFooter"/>
	</page>

	<dialog beanclass="psdi.webclient.beans.common.ClassificationBean" id="searchmore" inputmode="query" label="更多搜索字段">
		<section id="qbe_grid5">
			<sectionrow id="qbe_grid5_r1">
				<sectioncol id="qbe_grid5_r1_c1">
					<section id="qbe_grid5_r1_c1_s1">
						<multiparttextbox dataattribute="ITEMNUM" descdataattribute="DESCRIPTION" descinputmode="query" id="qbe_grid5_1_1_1" inputmode="query" menutype="item"/>
						<multiparttextbox dataattribute="ITEMSETID" descdataattribute="SETS.DESCRIPTION" descinputmode="query" id="qbe_grid5_1_1_3" inputmode="query" lookup="itemset"/>
						<textbox dataattribute="commoditygroup" id="qbe_grid5_1_1_5" inputmode="query" lookup="commoditygroup"/>
						<textbox applink="metergrp" dataattribute="GROUPNAME" id="qbe_grid5_1_1_14" inputmode="query" lookup="metergroup" menutype="normal"/>
						<textbox applink="meter" dataattribute="METERNAME" id="qbe_grid5_1_1_15" inputmode="query" lookup="meter" menutype="normal"/>
						<textbox dataattribute="MSDSNUM" id="qbe_grid5_1_1_9" inputmode="query"/>
						<textbox applink="assetcat" dataattribute="CLASSSTRUCTURE.HIERARCHYPATH" id="qbe_classificationhierarchy" inputmode="query" menutype="classificationqbe"/>
						<textbox dataattribute="itemorginfo.category" id="qbe_itemorgstatus" inputmode="query" lookup="valuelist"/>
						<textbox dataattribute="status" id="qbe_grid5_1_1_9a" inputmode="query"/>
					</section>
				</sectioncol>
				<sectioncol id="qbe_grid5_r1_c2">
					<section id="qbe_grid5_r1_c2_s1">
						<textbox dataattribute="LOTTYPE" id="qbe_grid5_1_1_8" inputmode="query" lookup="valuelist"/>
						<textbox dataattribute="CAPITALIZED" id="qbe_grid5_1_1_12" inputmode="query"/>
						<textbox dataattribute="iskit" id="qbe_grid5_1_1_16" inputmode="query"/>
						<textbox dataattribute="conditionenabled" id="qbe_grid5_1_1_17" inputmode="query"/>
						<textbox dataattribute="ROTATING" id="qbe_grid5_1_1_11" inputmode="query"/>
						<textbox dataattribute="INSPECTIONREQUIRED" id="qbe_grid5_1_1_10" inputmode="query"/>
						<textbox dataattribute="SPAREPARTAUTOADD" id="qbe_grid5_1_1_7" inputmode="query"/>
						<textbox dataattribute="TAXEXEMPT" id="qbe_grid5_1_1_8a" inputmode="query"/>
					</section>
				</sectioncol>
			</sectionrow>
		</section>
		<buttongroup id="qbe_grid5_1_1_grid6">
			<pushbutton default="true" id="qbe_grid5_1_1_grid6_1" label="查找" mxevent="dialogok"/>
			<pushbutton id="qbe_grid5_1_1_grid6_2" label="清除" mxevent="qbeclear"/>
			<pushbutton id="qbe_grid5_1_1_grid6_3" label="取消" mxevent="qbecancel"/>
		</buttongroup>
	</dialog>

	<dialog beanclass="psdi.webclient.beans.item.SelectStoreroomBean" id="additems" label="将项目添加到库房" mboname="LOCATIONS">
		<section border="true" id="additems_grid1">
			<textbox dataattribute="addToStoreSiteId" id="additems_grid1_1_1_grid3_3" lookup="site"/>
			<multiparttextbox applink="storeroom,ipc" dataattribute="addToStoreLoc" descdataattribute="LOCATIONS_ADDTOSTORE.DESCRIPTION" descinputmode="readonly" desclongdescreadonly="true" desclookup="longdesc" id="additems_grid1_1_1_grid3_1" lookup="locations" menutype="normal"/>
		</section>
		<buttongroup id="additems_buttongroup" show="true">
			<pushbutton default="true" id="additems_buttongroup_3" label="确定" mxevent="nextdialog" value="additemstostoreroom"/>
			<pushbutton id="additems_buttongroup_4" label="取消" mxevent="dialogcancel"/>
		</buttongroup>
	</dialog>

	<dialog beanclass="psdi.webclient.beans.item.AddItemsBean" designermboname="INVENTORY" id="additemstostoreroom" label="将项目添加到库房" listaction="true">
		<table id="additems_grid1_1_1_inventorytable" label="库房信息">
			<tablebody displayrowsperpage="10" id="additems_grid1_1_1_inventorytable_tablebody">
				<tablecol filterable="false" hidden="false" id="additems_grid1_1_1_inventorytable_tablebody_1" mxevent="toggledetailstate" mxevent_desc="显示详细信息" sortable="false" type="event"/>
				<tablecol dataattribute="itemnum" id="additems_grid1_1_1_inventorytable_tablebody_2" linkedcontrolid="additems_grid1_1_1_inventorytable_1_grid3_1"/>
				<tablecol dataattribute="costtype" id="additems_grid1_1_1_inventorytable_tablebody_5" linkedcontrolid="additems_grid1_1_1_inventorytable_1_grid3_5"/>
				<tablecol dataattribute="unitcost" id="additems_grid1_1_1_inventorytable_tablebody_4" linkedcontrolid="additems_grid1_1_1_inventorytable_1_grid3_4" sigoption="NOTASSETCOST"/>
				<tablecol dataattribute="binnum" id="additems_grid1_1_1_inventorytable_tablebody_3" linkedcontrolid="additems_grid1_1_1_inventorytable_1_grid3_3"/>
				<tablecol dataattribute="curbal" id="additems_grid1_1_1_inventorytable_tablebody_8" linkedcontrolid="additems_grid1_1_1_inventorytable_1_grid3_7"/>
				<tablecol dataattribute="lotnum" id="additems_grid1_1_1_inventorytable_tablebody_9" linkedcontrolid="additems_grid1_1_1_inventorytable_1_grid3_9"/>
				<tablecol dataattribute="issueunit" id="additems_grid1_1_1_inventorytable_tablebody_10" linkedcontrolid="additems_grid1_1_1_inventorytable_1_grid3_10"/>
				<tablecol dataattribute="orderunit" id="additems_grid1_1_1_inventorytable_tablebody_11" linkedcontrolid="additems_grid1_1_1_inventorytable_1_grid3_11"/>
				<tablecol dataattribute="siteid" id="additems_grid1_1_1_inventorytable_tablebody_12" linkedcontrolid="additems_grid1_1_1_inventorytable_1_grid3_12"/>
				<tablecol filterable="false" hidden="false" id="additems_grid1_1_1_inventorytable_tablebody_13" mxevent="toggledeleterow" mxevent_desc="标记要删除的行" mxevent_icon="btn_garbage.gif" sortable="false" type="event"/>
			</tablebody>
			<tabledetails id="additems_grid1_1_1_inventorytable_1">
				<section id="additems_grid1_1_1_inventorytable_1_grid3" label="详细信息">
					<sectionrow id="additems_grid1_1_1_inventorytable_1_row1">
						<sectioncol id="additems_grid1_1_1_inventorytable_1_row1_col1">
							<section id="additems_grid1_1_1_inventorytable_1_row1_col1_sec1">
								<textbox dataattribute="itemnum" defaultfocus="true" id="additems_grid1_1_1_inventorytable_1_grid3_1" lookup="itemwithitemset"/>
								<textbox dataattribute="conditioncode" id="additems_grid1_1_1_inventorytable_1_grid3_2" lookup="conditioncode"/>
								<textbox dataattribute="lotnum" id="additems_grid1_1_1_inventorytable_1_grid3_9" lookup="invlot" smartfilloff="true"/>
								<textbox dataattribute="costtype" id="additems_grid1_1_1_inventorytable_1_grid3_5" lookup="valuelist"/>
								<textbox dataattribute="unitcost" id="additems_grid1_1_1_inventorytable_1_grid3_4" sigoption="NOTASSETCOST"/>
								<textbox dataattribute="binnum" id="additems_grid1_1_1_inventorytable_1_grid3_3" sizeintable="8" smartfilloff="true"/>
								<textbox dataattribute="curbal" id="additems_grid1_1_1_inventorytable_1_grid3_7"/>
							</section>
						</sectioncol>
						<sectioncol id="additems_grid1_1_1_inventorytable_1_row1_col2">
							<section id="additems_grid1_1_1_inventorytable_1_row1_col2_sec1">
								<textbox dataattribute="siteid" id="additems_grid1_1_1_inventorytable_1_grid3_12" inputmode="readonly" sizeintable="8"/>
								<textbox dataattribute="issueunit" id="additems_grid1_1_1_inventorytable_1_grid3_10" lookup="measureunit" sizeintable="8"/>
								<textbox dataattribute="orderunit" id="additems_grid1_1_1_inventorytable_1_grid3_11" lookup="measureunit" sizeintable="8"/>
								<checkbox dataattribute="consignment" id="additems_grid1_1_1_inventorytable_1_grid3_14" synchronous="true"/>
								<textbox applink="company" applinkkey="company" dataattribute="consvendor" id="additems_grid1_1_1_inventorytable_1_grid3_19" lookup="companies" menutype="normal" sigoption="consignment"/>
								<textbox applink="company" dataattribute="manufacturer" id="additems_grid1_1_1_inventorytable_1_grid3_20" lookup="companies" menutype="normal" sigoption="consignment" smartfilloff="true"/>
								<textbox dataattribute="modelnum" id="additems_grid1_1_1_inventorytable_1_grid3_21" sigoption="consignment"/>
							</section>
						</sectioncol>
						<sectioncol id="additems_grid1_1_1_inventorytable_1_row1_col3">
							<section id="additems_grid1_1_1_inventorytable_1_row1_col3_sec1">
								<textbox dataattribute="catalogcode" id="additems_grid1_1_1_inventorytable_1_grid3_22" sigoption="consignment"/>
								<textbox dataattribute="invgentype" id="additems_grid1_1_1_inventorytable_1_grid3_15" lookup="valuelist" sigoption="consignment"/>
								<textbox dataattribute="frequency" id="additems_grid1_1_1_inventorytable_1_grid3_16" sigoption="consignment"/>
								<textbox dataattribute="frequnit" id="additems_grid1_1_1_inventorytable_1_grid3_17" lookup="valuelist" sigoption="consignment"/>
								<textbox dataattribute="nextinvoicedate" id="additems_grid1_1_1_inventorytable_1_grid3_18" lookup="datelookup" sigoption="consignment"/>
							</section>
						</sectioncol>
					</sectionrow>
				</section>
			</tabledetails>
		</table>
		<buttongroup id="additemstostoreroom_buttongroup" show="true">
			<pushbutton default="true" id="additemstostoreroom_buttongroup_3" label="确定" mxevent="dialogok"/>
			<pushbutton id="additemstostoreroom_buttongroup_4" label="取消" mxevent="dialogcancel"/>
		</buttongroup>
	</dialog>

	<dialog beanclass="psdi.webclient.beans.item.CopyIasBean" id="copyias" label="复制项目组装结构" relationship="COPYIASDLG">
		<table id="copyias_grid1_1_1_virtualset1" label="项目">
			<tablebody displayrowsperpage="15" filterable="true" filterexpanded="true" id="copyias_grid1_1_1_virtualset1_tablebody">
				<tablecol dataattribute="itemnum" id="copyias_grid1_1_1_virtualset1_tablebody_2" mxevent="selectrecord" sortable="false" type="link"/>
				<tablecol dataattribute="item.description" id="copyias_grid1_1_1_virtualset1_tablebody_3" showfilterfield="true" sortable="false"/>
			</tablebody>
		</table>
		<buttongroup id="copyias_2">
			<pushbutton default="true" id="copyias_2_1" label="取消" mxevent="dialogcancel"/>
		</buttongroup>
	</dialog>

	<dialog beanclass="psdi.webclient.beans.item.ItemOrgInfoBean" id="itemorg" label="项目/组织详细信息" relationship="ITEMORGINFO" width="900">
		<table id="itemorg_grid1_1_1_itemorginfo_table">
			<tablebody displayrowsperpage="5" filterable="true" id="itemorg_grid1_1_1_itemorginfo_table_tablebody">
				<tablecol filterable="false" hidden="false" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_1" mxevent="toggledetailstate" mxevent_desc="显示详细信息" sortable="false" type="event"/>
				<tablecol dataattribute="orgid" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_2" inputmode="readonly"/>
				<tablecol dataattribute="organization.description" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_3" inputmode="readonly" sortable="false"/>
				<tablecol dataattribute="category" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_3a" linkedcontrolid="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_1a" lookup="valuelist"/>
				<tablecol dataattribute="status" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_3b" inputmode="readonly"/>
				<tablecol dataattribute="hazardid" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_4" linkedcontrolid="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_2" lookup="hazards"/>
				<tablecol dataattribute="tax1code" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_5" label="税代码" linkedcontrolid="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_3" lookup="taxcode"/>
				<tablecol dataattribute="taxexempt" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_6" linkedcontrolid="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_5"/>
				<tablecol dataattribute="receipttolerance" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_6a" linkedcontrolid="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_3a"/>
				<tablecol filterable="false" hidden="false" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_10" mxevent="iorgstatus" mxevent_desc="变更状态" mxevent_icon="nav_icon_changestatus.gif" sortable="false" type="event"/>
				<tablecol filterable="false" hidden="false" id="itemorg_grid1_1_1_itemorginfo_table_tablebody_11" mxevent="iorghistory" mxevent_desc="查看状态历史记录" mxevent_icon="information.gif" sortable="false" type="event"/>
			</tablebody>
			<tabledetails id="itemorg_grid1_1_1_itemorginfo_table_1">
				<section id="itemorg_grid1_1_1_itemorginfo_table_1_grid3" label="详细信息">
					<sectionrow id="itemorg_grid1_1_1_itemorginfo_table_1_grid3_row">
						<sectioncol id="itemorg_grid1_1_1_itemorginfo_table_1_grid3_row_col1">
							<section id="itemorg_grid1_1_1_itemorginfo_table_1_grid3_row_col1_sec">
								<multiparttextbox dataattribute="orgid" defaultfocus="true" descdataattribute="organization.description" descinputmode="readonly" descsizeintable="30" id="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_1" inputmode="readonly" longdescreadonly="true"/>
								<textbox dataattribute="category" id="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_1a" lookup="valuelist"/>
								<multiparttextbox dataattribute="hazardid" descdataattribute="hazard.description" descinputmode="readonly" id="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_2" longdescreadonly="true" lookup="hazards"/>
								<textbox dataattribute="tax1code" id="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_3" label="税代码" lookup="taxcode"/>
								<checkbox dataattribute="taxexempt" id="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_5"/>
								<textbox dataattribute="receipttolerance" id="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_3a"/>
								<textbox dataattribute="status" id="itemorg_grid1_1_1_itemorginfo_table_1_grid3_1_1_4" inputmode="readonly"/>
							</section>
						</sectioncol>
					</sectionrow>
				</section>
			</tabledetails>
		</table>
		<buttongroup id="itemorg_2">
			<pushbutton default="true" id="itemorg_2_1" label="确定" mxevent="dialogok"/>
			<pushbutton id="itemorg_2_2" label="取消" mxevent="dialogcancel"/>
		</buttongroup>
	</dialog>

	<dialog beanclass="psdi.webclient.beans.item.ItemChangeStatusBean" id="status" label="变更状态" relationship="ITEMCHANGESTATUS" savemode="ONLOADUNLOAD">
		<section id="changeitemstatus_grid1">
			<sectionrow id="changeitemstatus_grid1_1">
				<sectioncol id="changeitemstatus_grid1_1_1">
					<section border="true" id="changeitemstatus_grid1_1_1_grid3">
						<multiparttextbox dataattribute="itemnum" descdataattribute="description" descinputmode="readonly" id="changeitemstatus_grid1_1_1_grid3_1" inputmode="readonly" longdescinputmode="readonly"/>
						<multiparttextbox dataattribute="itemstatus" descdataattribute="statusdesc.description" descinputmode="readonly" id="changeitemstatus_grid1_1_1_grid3_2" inputmode="readonly"/>
					</section>
					<section id="changeitemstatus_grid1_1_1_grid4">
						<combobox dataattribute="status" id="changeitemstatus_grid1_1_1_grid4_1" smartfilloff="true"/>
						<checkbox dataattribute="rolldown" id="changeitemstatus_grid1_1_1_grid4_2" label="将新状态滚动到组织和库存"/>
						<textbox dataattribute="Memo" id="changeitemstatus_grid1_1_1_grid4_3"/>
					</section>
				</sectioncol>
			</sectionrow>
		</section>
		<buttongroup id="changeitemstatus_2">
			<pushbutton default="true" id="changeitemstatus_2_1" label="确定" mxevent="dialogok"/>
			<pushbutton id="changeitemstatus_2_2" label="取消" mxevent="dialogcancel"/>
		</buttongroup>
	</dialog>

	<dialog beanclass="psdi.webclient.beans.item.ItemChangeStatusBean" id="list_status" label="变更状态" listaction="false" relationship="ITEMCHANGESTATUS" savemode="ONUNLOAD">
		<section id="list_changeitemstatus_grid1">
			<sectionrow id="list_changeitemstatus_grid1_1">
				<sectioncol id="list_changeitemstatus_grid1_1_1">
					<section id="list_changeitemstatus_grid1_1_1_grid4">
						<combobox dataattribute="status" id="list_changeitemstatus_grid1_1_1_grid4_1" smartfilloff="true"/>
						<checkbox dataattribute="rolldown" id="list_changeitemstatus_grid1_1_1_grid4_2" label="将新状态滚动到组织和库存"/>
						<textbox dataattribute="Memo" id="list_changeitemstatus_grid1_1_1_grid4_3"/>
					</section>
				</sectioncol>
			</sectionrow>
		</section>
		<buttongroup id="list_changeitemstatus_2">
			<pushbutton default="true" id="list_changeitemstatus_2_1" label="确定" mxevent="dialogok"/>
			<pushbutton id="list_changeitemstatus_2_2" label="取消" mxevent="dialogcancel"/>
		</buttongroup>
	</dialog>

	<dialog id="viewstatus" label="查看状态历史记录" relationship="ITEMSTATUS">
		<table id="viewstatus_contracts_table" inputmode="readonly" label="状态历史记录" orderby="changedate desc">
			<tablebody displayrowsperpage="20" filterable="true" filterexpanded="true" id="viewstatusracts_table_tablebody">
				<tablecol dataattribute="status" id="viewstatusracts_tablebody_1" sortable="false"/>
				<tablecol dataattribute="changedate" id="viewstatusracts_tablebody_2" sortable="false"/>
				<tablecol dataattribute="changeby" id="viewstatusracts_tablebody_3" sortable="false"/>
				<tablecol dataattribute="memo" id="viewstatusracts_table_tablebody_4" sortable="false"/>
			</tablebody>
		</table>
		<buttongroup id="viewstatus_contracts_2">
			<pushbutton default="true" id="viewstatus_contracts_2_1" label="确定" mxevent="dialogclose"/>
		</buttongroup>
	</dialog>

	<dialog id="iorghistory" label="查看状态历史记录" relationship="ITEMORGSTATUS">
		<table id="iorghistory_contracts_table" inputmode="readonly" label="状态历史记录" orderby="changedate desc">
			<tablebody displayrowsperpage="20" filterable="true" filterexpanded="true" id="iorghistoryracts_table_tablebody">
				<tablecol dataattribute="status" id="iorghistoryracts_tablebody_1" sortable="false"/>
				<tablecol dataattribute="changedate" id="iorghistoryracts_tablebody_2" sortable="false"/>
				<tablecol dataattribute="changeby" id="iorghistoryracts_tablebody_3" sortable="false"/>
				<tablecol dataattribute="memo" id="iorghistoryracts_table_tablebody_4" sortable="false"/>
			</tablebody>
		</table>
		<buttongroup id="iorghistory_contracts_2">
			<pushbutton default="true" id="iorghistory_contracts_2_1" label="确定" mxevent="dialogclose"/>
		</buttongroup>
	</dialog>

	<dialog id="viewcont" label="查看合同" relationship="CONTRACTLINE_NOHIST">
		<helpgrid id="viewcont_helpgrid" innerhtml="要优化搜索，请输入列的过滤条件并按 &lt;b&gt;Enter&lt;/b&gt; 键或单击 &lt;IMG border=&quot;0&quot; SRC=&quot;qf_find.gif&quot;&gt;。"/>
		<table id="viewcont_contracts_table" inputmode="readonly" label="合同">
			<tablebody displayrowsperpage="20" filterable="true" filterexpanded="true" id="viewcontracts_table_tablebody">
				<tablecol dataattribute="contractnum" id="viewcontracts_tablebody_1" sortable="false"/>
				<tablecol dataattribute="revisionnum" id="viewcontracts_tablebody_2" sortable="false"/>
				<tablecol dataattribute="CONTRACT.description" id="viewcontracts_tablebody_3" sortable="false"/>
				<tablecol dataattribute="contracttype" id="viewcontracts_table_tablebody_4" sortable="false"/>
				<tablecol dataattribute="CONTRACT.startdate" id="viewcontracts_tablebody_5" sortable="false"/>
				<tablecol dataattribute="CONTRACT.enddate" id="viewcontracts_tablebody_6" sortable="false"/>
				<tablecol dataattribute="CONTRACT.status" id="viewcontracts_table_tablebody_7" sortable="false"/>
			</tablebody>
		</table>
		<buttongroup id="viewcont_contracts_2">
			<pushbutton default="true" id="viewcont_contracts_2_1" label="确定" mxevent="dialogclose"/>
		</buttongroup>
	</dialog>

	<dialog beanclass="psdi.webclient.system.beans.ViewBookmarksBean" id="searchbook" label="我的书签" mboname="ITEM">
		<table id="bookmarks_table" inputmode="readonly" label="项目" selectmode="single">
			<tablebody displayrowsperpage="20" filterable="true" id="bookmarks_table_tablebody">
				<tablecol dataattribute="itemnum" id="bookmarks_tablebody_1" mxevent="selectrecord" type="link"/>
				<tablecol dataattribute="description" id="bookmarks_table_tablebody_2"/>
				<tablecol filterable="false" hidden="false" id="bookmarks_table_tablebody_delete" mxevent="instantdelete" mxevent_desc="删除" mxevent_icon="btn_delete.gif" sortable="false" type="event"/>
			</tablebody>
		</table>
		<buttongroup id="bookmarks_2">
			<pushbutton default="true" id="bookmarks_2_1" label="确定" mxevent="dialogok"/>
		</buttongroup>
	</dialog>
</presentation>
```

## 测试源代码

```Java
package org.shoukaiseki.webclient.beans.test;

import psdi.mbo.MboRemote;
import psdi.util.CipherPlusBase64;
import psdi.webclient.applet.attachimage.Base64;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

/**
 * org.shoukaiseki.webclient.beans.test.TestItemAppBean <br>
 *
 * @author 蒋カイセキ    Japan-Tokyo  2017-09-27 16:20:04<br>
 * ブログ http://shoukaiseki.blog.163.com/<br>
 * E-メール jiang28555@Gmail.com<br>
 **/
public class TestItemAppBean extends psdi.webclient.beans.item.ItemAppBean{


    public void ASUS()throws  Exception{
        System.out.println("asus.....");
        MboRemote mbo = getMbo();
        MboRemote imglib = mbo.getMboSet("IMGLIB").getMbo(0);
        InputStream in = null;
        if(imglib!=null){
            imglib.delete();
            imglib=mbo.getMboSet("IMGLIB").add();
            imglib.setValue("IMAGENAME","001.jpg");
            imglib.setValue("MIMETYPE","image/jpeg");
            System.out.println("imglib is not null");
            System.out.println("image="+imglib.getBytes("IMAGE"));
            System.out.println("image="+imglib.getDatabaseValue("IMAGE"));
            // base64加密
//            String image = Base64.encode(imglib.getBytes("IMAGE"));
//            System.out.println("image="+image);
            System.out.println("isnull="+imglib.isNull("IMAGE"));
            try {
                File file=new File("C:\\tmp\\001.jpg");
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                // 根据文件创建文件的输入流
                in = new FileInputStream(file);
                // 创建字节数组
                // 读取内容，放到字节数组里面
                byte[] buffer = new byte[256];
                int n;
                while ((n = in.read(buffer)) >= 0) {
                    out.write(buffer, 0, n);
                }
                byte[] bytes = out.toByteArray();
                System.out.println("bytes="+bytes);
                imglib.setValue("IMAGE",bytes);
                imglib.getThisMboSet().save();
                System.out.println("save..");
            }catch (Exception e){
                e.printStackTrace();
            }
        }else{
            imglib=mbo.getMboSet("IMGLIB").add();
            imglib.setValue("IMAGENAME","002.jpg");
            imglib.setValue("MIMETYPE","image/jpeg");

            try {
                File file=new File("C:\\tmp\\002.jpg");
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                // 根据文件创建文件的输入流
                in = new FileInputStream(file);
                // 创建字节数组
                // 读取内容，放到字节数组里面
                byte[] buffer = new byte[256];
                int n;
                while ((n = in.read(buffer)) >= 0) {
                    out.write(buffer, 0, n);
                }
                byte[] bytes = out.toByteArray();
                imglib.setValue("IMAGE",bytes);
                imglib.getThisMboSet().save();

                System.out.println("save....");
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        if(in!=null){
            try {
                // 关闭输入流
                in.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        psdi.webclient.beans.common.RecordImageBean sadfsd;
        psdi.app.system.ImgLibSet safs;

    }
}
```

