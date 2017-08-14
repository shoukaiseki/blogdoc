# 难找到的提示sql错误  

最终根据ROWSTAMP分析,该问题应从于 2015年3月 开始出现
## 找不到sql的提示
### 问题描述
```
23 十二月 2015 16:21:12:303 [ERROR] BMXAA6714E - 无法为 SQL 查询 select * from rldhtz  where '5536'  in (select rljsdhtz.rldhtznum from rljsd,rljsdhtz where rljsd.status <> '新建' rljsdhtz.rljsdlx='煤款与运杂费'  and rljsdhtz.rljsdnum=rljsd.rljsdnum and  '5536' =rljsdhtz.rldhtznum) 检索 mboset 中下一条记录的数据。有关错误的更多详细信息，请参阅日志文件。
```

### 问题追踪
Debug模式下,修改MboSet.getDBValue(String dbFunction, String dbColumn, int maxType)方法

```Java
      if ((correlator != null) && (logCorrelationIDInSql()))
      {
        formattedQuery = formattedQuery + " /* " + correlator.getCombinedId() + " */ ";
      }
	//添加日志输出
	  System.out.println("name="+getName());
	  System.out.println("getRelationName="+getRelationName());
	  System.out.println("getRelationship="+getRelationship());
      System.out.println("formattedQuery="+formattedQuery);
      
      resultset = stmt.executeQuery(formattedQuery);
```

#### 输出内容
```
name=DUMMY_TABLE
getRelationName=$SqlStmt1450858872222
getRelationship= '5536'  in (select rljsdhtz.rldhtznum from rljsd,rljsdhtz where rljsd.status <> '新建' rljsdhtz.rljsdlx='煤款与运杂费'  and rljsdhtz.rljsdnum=rljsd.rljsdnum and  '5536' =rljsdhtz.rldhtznum)
formattedQuery=select count(*) from dummy_table  where '5536'  in (select rljsdhtz.rldhtznum from rljsd,rljsdhtz where rljsd.status <> '新建' rljsdhtz.rljsdlx='煤款与运杂费'  and rljsdhtz.rljsdnum=rljsd.rljsdnum and  '5536' =rljsdhtz.rldhtznum)

```
### 解决方案
查询条件表达式 条件名
```Sql
select * from condition where lower(EXPRESSION) like '%rljsd.status%'
```

进入应用  条件表达式管理器 修改对应表达式

### 高级功能类
```
maxcondition			//条件表达式处理类
MaxConditionCache		//实例化条件表达式处理类MaxCondition
ParserService			//$SqlStmt 关系在此类创建
```

### 详细提示

```
java.sql.SQLSyntaxErrorException: ORA-00907: 缺失右括号

	at oracle.jdbc.driver.SQLStateMapping.newSQLException(SQLStateMapping.java:91)
	at oracle.jdbc.driver.DatabaseError.newSQLException(DatabaseError.java:133)
	at oracle.jdbc.driver.DatabaseError.throwSqlException(DatabaseError.java:206)
	at oracle.jdbc.driver.T4CTTIoer.processError(T4CTTIoer.java:455)
	at oracle.jdbc.driver.T4CTTIoer.processError(T4CTTIoer.java:413)
	at oracle.jdbc.driver.T4C8Oall.receive(T4C8Oall.java:1034)
	at oracle.jdbc.driver.T4CStatement.doOall8(T4CStatement.java:183)
	at oracle.jdbc.driver.T4CStatement.executeForDescribe(T4CStatement.java:780)
	at oracle.jdbc.driver.T4CStatement.executeMaybeDescribe(T4CStatement.java:855)
	at oracle.jdbc.driver.OracleStatement.doExecuteWithTimeout(OracleStatement.java:1187)
	at oracle.jdbc.driver.OracleStatement.executeQuery(OracleStatement.java:1378)
	at oracle.jdbc.driver.OracleStatementWrapper.executeQuery(OracleStatementWrapper.java:387)
	at psdi.mbo.MboSet.getDBValue(MboSet.java:2812)
	at psdi.mbo.MboSet.getDBValue(MboSet.java:2717)
	at psdi.mbo.MboSet.getDBCalc(MboSet.java:2875)
	at psdi.mbo.MboSet.count(MboSet.java:2407)
	at psdi.mbo.MboSet.count(MboSet.java:2413)
	at psdi.mbo.MboSet.count(MboSet.java:2395)
	at psdi.common.parse.ParserService.getBoolean(ParserService.java:193)
	at psdi.common.condition.ExpressionCondition.evaluateCondition(ExpressionCondition.java:46)
	at psdi.common.condition.MaxCondition.evaluate(MaxCondition.java:131)
	at psdi.mbo.Mbo.evaluateCondition(Mbo.java:8076)
	at psdi.mbo.Mbo.evaluateCondition(Mbo.java:8091)
	at psdi.mbo.Mbo.evaluateRestriction(Mbo.java:5113)
	at psdi.mbo.Mbo.andEvaluateConditions(Mbo.java:4268)
	at psdi.mbo.Mbo.getAttrRestrictionFlag(Mbo.java:5163)
	at psdi.mbo.MboValue.getAttrRestrictionFlag(MboValue.java:2272)
	at psdi.mbo.MboValue.isFlagSet(MboValue.java:2369)
	at psdi.mbo.MboValue.checkFieldAccess(MboValue.java:2247)
	at psdi.mbo.MboValue.isReadOnly(MboValue.java:1753)
	at psdi.mbo.MboValueData.<init>(MboValueData.java:98)
	at psdi.mbo.MboValueData.<init>(MboValueData.java:80)
	at psdi.mbo.MboValue.getMboValueData(MboValue.java:422)
	at psdi.mbo.Mbo.getMboValueData(Mbo.java:1193)
	at psdi.mbo.Mbo.getMboValueData(Mbo.java:1196)
	at psdi.mbo.MboData.<init>(MboData.java:98)
	at psdi.mbo.Mbo.getMboData(Mbo.java:1273)
	at psdi.mbo.MboSet.getMboData(MboSet.java:607)
	at psdi.mbo.MboSet.getMboSetData(MboSet.java:494)
	at psdi.webclient.system.beans.DataBean.getMboSetData(DataBean.java:4419)
	at psdi.webclient.system.beans.DataBean.fetchTableData(DataBean.java:4337)
	at psdi.webclient.system.beans.DataBean.fetchTableData(DataBean.java:4327)
	at psdi.webclient.system.beans.DataBean.getPageRowCount(DataBean.java:5277)
	at psdi.webclient.controls.Table.render(Table.java:910)
	at psdi.webclient.system.controller.ControlInstance.renderChildren(ControlInstance.java:1032)
	at psdi.webclient.controls.Tab.renderChildren(Tab.java:107)
	at jsp_servlet._webclient._components.__tabbodies._jspService(__tabbodies.java:663)
```
