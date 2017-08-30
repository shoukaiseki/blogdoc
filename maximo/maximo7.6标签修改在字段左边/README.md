# maximo7.6标签修改在字段左边

## 修改系统属性(如图1效果)
mxe.webclient.verticalLabels  使基本叶子级控件使用上方（垂直而不是水平）的标签。

### 图1
![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/maximo7.6%E6%A0%87%E7%AD%BE%E4%BF%AE%E6%94%B9%E5%9C%A8%E5%AD%97%E6%AE%B5%E5%B7%A6%E8%BE%B9/img/001.png)

## 复选框checkbox标签修改到右边,框在左边(如图1效果)

修改 control-registry.xml,找到 <control-descriptor name="checkbox"> ,修改成以下配置

```Xml
	<!--
	<label id="lb" labelcss="@{labelcss}" dataattribute="@{dataattribute}" title="@{label}" align="right" hideontable="true" textcss="@{textcss}" oninput="true" requiredlabel="false" labelfor="cb"/>
	<group id="gr" align="left">
		<required-indicator id="ri" hide="true" hideontable="true" />
		<checkbox id="cb" imagename="@{imagename}" imagetype="@{imagetype}" dataattribute="@{dataattribute}" cssclass="checkbox" inputmode="@{inputmode}" msgtrue="@{msgtrue}" msgfalse="@{msgfalse}" cbsize="@{size}" title="@{label}" synchronous="@{synchronous}" notifyportlets="@{notifyportlets}" mxeventjshandler="@{mxeventjshandler}" labelledby="lb"/>
	</group>
	     -->
	<group id="gr" align="right">
		<required-indicator id="ri" hide="true" hideontable="true" />
		<checkbox id="cb" imagename="@{imagename}" imagetype="@{imagetype}" dataattribute="@{dataattribute}" cssclass="checkbox" inputmode="@{inputmode}" msgtrue="@{msgtrue}" msgfalse="@{msgfalse}" cbsize="@{size}" title="@{label}" synchronous="@{synchronous}" notifyportlets="@{notifyportlets}" mxeventjshandler="@{mxeventjshandler}" labelledby="lb"/>
	</group>
	<label id="lb" labelcss="@{labelcss}" dataattribute="@{dataattribute}" title="@{label}" align="left" hideontable="true" textcss="@{textcss}" oninput="true" requiredlabel="false" labelfor="cb"/>
```
