# maximo列表中显示自动换行 

## 事例为标准作业计划

### 列表的xml配置如下

```Xml
<table id="main_jpop_table" label="标准作业流程任务" listeners="specification_jobtaskspectable" orderby="tasksequence,jptask" relationship="JOBTASK">
	<tablebody displayrowsperpage="4" filterable="true" id="main_jpop_table_tablebody">
		<tablecol filterable="false" id="main_jpop_table_tablebody_1" mxevent="toggledetailstate" mxevent_desc="显示详细信息" sortable="false" type="event"/>
		<tablecol dataattribute="jptask" id="main_jpop_table_tablebody_3" label="编号"/>
		<tablecol dataattribute="JO1" id="main_jpop_table_tablebody_2" label="任务步骤" linkedcontrolid="main_jpop_table_1_grid4_3"/>
		<!--想要自动换行,必须是只读模式(inputmode="readonly")
			并增加 wraplength 属性,设置每行的字符长度-->
		<tablecol dataattribute="description" id="main_jpop_table_tablebody_4" lookup="longdesc" width="600" inputmode="readonly" wraplength="30"/>
		<tablecol filterable="false" id="main_jpop_table_tablebody_8" mxevent="toggledeleterow" mxevent_desc="标记要删除的行" mxevent_icon="btn_garbage.gif" sortable="false" type="event"/>
	</tablebody>
	<tabledetails id="main_jpop_table_1">
		<section id="main_jpop_table_1_sec1" label="详细信息">
			<sectionrow id="main_jpop_table_1_sec1_row1">
				<sectioncol id="main_jpop_table_1_sec1_row1_col1">
					<section id="main_jpop_table_1_sec1_row1_col1_sec1">
						<textbox dataattribute="orgid" defaultfocus="true" id="main_jpop_table_1_grid2_1" lookup="org"/>
						<textbox dataattribute="siteid" id="main_jpop_table_1_grid2_2" lookup="site"/>
						<textbox dataattribute="JPTASK" id="1500346880045" inputmode="required" label="编号"/>
						<textbox dataattribute="JO1" id="main_jpop_table_1_grid4_3" inputmode="required" label="任务步骤"/>
						<multilinetextbox dataattribute="DESCRIPTION" id="1500346846336" inputmode="required" label="任务步骤描述"/>
						<checkbox dataattribute="apptrequired" id="main_jpop_table_1_grid6_11" licensekey="SCHEDULER_OPT"/>
						<checkbox dataattribute="inctasksinsched" id="main_jpop_table_1_grid6_12" licensekey="SCHEDULER_OPT"/>
					</section>
				</sectioncol>
				<sectioncol id="main_jpop_table_1_sec2_row1_col1"/>
				<sectioncol id="main_jpop_table_1_sec3_row1_col1">
					<section id="main_jpop_table_1_sec3_row1_col1_sec1">
						<attachments event="drviewattachments" id="jobtask_doclinks" menutype="drattachments"/>
					</section>
				</sectioncol>
			</sectionrow>
		</section>
	</tabledetails>
	<buttongroup id="main_jpop_table_2">
		<pushbutton default="true" id="main_jpop_table_2_1" label="新建行" mxevent="addrow"/>
	</buttongroup>
</table>
```
wraplength="50" 效果

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/maximo%E5%88%97%E8%A1%A8%E4%B8%AD%E6%98%BE%E7%A4%BA%E8%87%AA%E5%8A%A8%E6%8D%A2%E8%A1%8C/img/001.png)

wraplength="30" 效果

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/maximo%E5%88%97%E8%A1%A8%E4%B8%AD%E6%98%BE%E7%A4%BA%E8%87%AA%E5%8A%A8%E6%8D%A2%E8%A1%8C/img/002.png)
