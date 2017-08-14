# maximo设置某字段为快速查找  

设置该应用快速查找字段为 SINGLENUM ,有应用xml中 presentation 节点下的 keyattribute 属性定义

```Xml
<presentation apprestrictions="type='结账'" beanclass="com.shuto.mam.webclient.beans.single.SingleInventoryAppBean" id="invqc" mboname="SINGLE" resultstableid="results_showlist"  keyattribute="SINGLENUM" version="7.1.0.0">
```

