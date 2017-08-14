# maximo7.5 顶部 启动中心,概要信息,退出 等文字修改  

导出 LIBRARY.xml 里面 mxevent="signout" 所在行的label即显示名称,可以随意修改
<br />
可以看到,在maxapps表中,如果ismobile字段为1,则显示的titlebar将会不同
<br />
还能从该文件中找到页面中 保存查询,查找,选择操作,工具栏按钮,工作流按钮相关组件信息都在此xml中配置

```Xml
	<header id="pageHeader">
		<titlebar hidewhen="{mobile}==true" id="pageTitlebar">
			<accessiblelink classname="powerwhite" id="accessibilityhelp" imagecss="pwimg" label="辅助功能选项帮助" link="../webclient/utility/accessibility.jsp" targetid="{PAGE}"/>
			<webreplaylink classname="powerwhite" id="webreplaylink" image="btn_webreplay.gif" imagecss="pwimg" label="Web 重放" mxevent="togglewebreplay" targetid="{PAGE}"/>
			<performancelink classname="powerwhite" eventvalue="performance" id="perflink" image="btn_performance.gif" imagecss="pwimg" label="性能" mxevent="showmenu" targetid="pageTitlebar"/>
			<bulletinboardlink accesskey="ALT+B" id="bboardlink" image="btn_bboard.gif" imagecss="pwimg" label="公告:" mboname="BULLETINBOARD" mxevent="showbboard" pageTitlebarclassname="powerwhite"/>
			<gotolink accesskey="ALT+G" classname="powerwhite goto" eventvalue="goto" id="gotolink" image="btn_goto.gif" imagecss="pwimg" label="转到" mxevent="showmenu" targetid="pageTitlebar"/>
			<hyperlink accesskey="ALT+R" classname="powerwhite" eventvalue="reportsmenu" id="reportslink" image="btn_reporting.gif" imagecss="pwimg" label="报告" mxevent="showmenu" targetid="pageTitlebar"/>
			<hyperlink accesskey="ALT+C" classname="powerwhite" id="sslink" image="btn_startcenter.gif" imagecss="pwimg" label="启动中心" mxevent="startcenter" separator="false"/>
			<hyperlink accesskey="ALT+P" classname="powerwhite" eventvalue="profile" id="profilelink" image="btn_profile.gif" imagecss="pwimg" label="概要信息" mxevent="showmenu" targetid="pageTitlebar"/>
			<hyperlink accesskey="ALT+S" classname="powerwhite" id="signoutlink" image="btn_signout.gif" imagecss="pwimg" label="退出" mxevent="signout"/>
			<hyperlink accesskey="ALT+H" classname="powerwhite" eventvalue="help" id="helplink" image="btn_help.gif" imagecss="pwimg" label="帮助" mxevent="showmenu" targetid="pageTitlebar"/>
		</titlebar>
		<titlebar height="20" hidewhen="{mobile}==false" id="pageTitlebarMobile">
			<hyperlink accesskey="ALT+C" classname="powerwhite" id="sslink_m" image="btn_startcenter.gif" imagecss="pwimg" label="启动中心" mxevent="startcenter" separator="false"/>
			<hyperlink accesskey="ALT+S" classname="powerwhite" id="signoutlink_m" image="btn_signout.gif" imagecss="pwimg" label="退出" mxevent="signout"/>
		</titlebar>
		<toolbar id="pageToolbar">
			<toolbarsection align="right" id="toolbarsection0">
				<toolbarcombobox event="query" hidelabel="true" id="querydropdown" label="查询" width="110"/>
				<quicksearch event="find" id="quicksearch" label="查找：" width="90"/>
			</toolbarsection>
			<toolbarsection align="right" hidewhen="{mobile}==true" id="toolbarsection1">
				<toolbarcombobox event="action" hidelabel="true" id="actiondropdown" label="选择操作" width="180"/>
			</toolbarsection>
			<toolbarsection align="right" hidewhen="{mobile}==true" id="toolbarsection2">
				<toolbaractions align="left" id="toolactions"/>
			</toolbarsection>
			<toolbarsection align="right" hidewhen="{mobile}==true" id="WFtoolbarsection">
				<dynamictoolbar align="left" id="workflowbuttons" keyattribute="processname" label="" mboname="wfapptoolbar" mxevent="ROUTEWF" npmboname="wftoolbar"/>
			</toolbarsection>
			<toolbarsection align="right" hidewhen="{mobile}==true" id="Reporttoolbarsection">
				<dynamictoolbar align="left" id="reportbuttons" keyattribute="reportnum" mboname="quickprint" mxevent="RUNAREPORT" visibleicons="3"/>
			</toolbarsection>
			<toolbarsection align="right" hidewhen="{mobile}==true" id="migrationtoolsection">
				<dynamictoolbar align="left" id="migrationtoolbutton" keyattribute="appname" mboname="dmcollapptoolbar" mxevent="addcoll"/>
			</toolbarsection>
		</toolbar>
		<toolbar hidewhen="{designmode}==true or {mobile}==false" id="pageToolbar2">
			<toolbarsection align="right" id="toolbarsection3">
				<toolbaractions align="left" id="toolactionsmobile"/>
			</toolbarsection>
			<toolbarsection align="right" id="WFtoolbarsection2">
				<dynamictoolbar align="left" id="workflowbuttons2" keyattribute="processname" mboname="wfapptoolbar" mxevent="ROUTEWF" npmboname="wftoolbar"/>
			</toolbarsection>
		</toolbar>
	</header>

```

