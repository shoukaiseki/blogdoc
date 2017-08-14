# 应用转到错误发生 BMXAA4107E 错误  

BMXAA4107E - 由于实施或定制问题，系统无法确定对象
 PAYMENTPZ 的属性如何对应对象 PO 的属性 
SITEID,PONUM,REVISIONNUM。 您可能需要填充
 MAXLOOKUPMAP 表并重新启动服务器。



执行一下语句即可
INSERT INTO MAXLOOKUPMAP	
  (TARGET,  LOOKUPATTR, TARGETATTR, SOURCEKEY,	SOURCE,SEQNUM,ALLOWNULL,MAXLOOKUPMAPID	)
VALUES
  ( 'PO', 'PONUM', 'PONUM', 'PONUM', 'PAYMENTPZ','1','1',MAXLOOKUPMAPseq.nextval) ;




---转至应用程序错误,查找返回值自定义表---{{{1

INSERT INTO MAXLOOKUPMAP --软连接 
  (TARGET,  	--目标表(查找中的属性值的表)
  LOOKUPATTR,  	--查找属性(正在查找的属性)
  TARGETATTR,	--目标属性(将在查找退回时设置的属性)
  SOURCEKEY,	--源关键字(有退回值的查找表关键字段。)
  SOURCE,		--源对象(查找或应用程序链接指向的源对象名称。)
  SEQNUM,		--序号(在目标记录中属性的设定顺序。)
  ALLOWNULL,		--允许空 (指示当设置查找属性时，该属性是否允许为空。)
  MAXLOOKUPMAPID	--maxlookupmapseq.nextval
  )
VALUES
 ( 'A', 'B', 'B', 'Y', 'X','1','1',maxlookupmapseq.nextval) 
--A表的字段b转到X表y字段
--A表的字段b选择X表y字段
INSERT INTO MAXLOOKUPMAP	
  (TARGET,  LOOKUPATTR, TARGETATTR, SOURCEKEY,	SOURCE,SEQNUM,ALLOWNULL,MAXLOOKUPMAPID	)
VALUES
  ( 'A', 'B', 'B', 'Y', 'X','1','1',maxlookupmapseq.nextval) 


INSERT INTO MAXLOOKUPMAP	
  (TARGET,   LOOKUPATTR, TARGETATTR, SOURCEKEY,	SOURCE	)
VALUES
  ( 'OPLOG', 'OPLOGNUM', 'OPLOGNUM', 'OPLOGNUM', 'OPLOG') 
 

Insert Into MAXLOOKUPMAP	
  (TARGET,  LOOKUPATTR, TARGETATTR, SOURCEKEY,	SOURCE,SEQNUM,ALLOWNULL,Maxlookupmapid	)
Values
  ( 'OPLOG', 'OPLOGNUM', 'OPLOGNUM', 'OPLOGID', 'OPLOG','1','1',maxlookupmapseq.nextval) 
 


---解释.以person表为例---{{{4
Insert Into MAXLOOKUPMAP	
  (TARGET,  LOOKUPATTR, TARGETATTR, SOURCEKEY,	SOURCE,SEQNUM,ALLOWNULL,Maxlookupmapid	)
Values
  ( 'PERSON', 'LOCATION', 'LOCATION', 'LOCATION', 'LOCATIONS','2','1',maxlookupmapseq.nextval) ;
在人员表中,可选择/转到location

Insert Into MAXLOOKUPMAP	
  (TARGET,  LOOKUPATTR, TARGETATTR, SOURCEKEY,	SOURCE,SEQNUM,ALLOWNULL,Maxlookupmapid	)
Values
  ( 'PERSON', 'LOCATION', 'LOCATIONSITE', 'SITEID', 'LOCATIONS','1','1',maxlookupmapseq.nextval) ;

在人员表中,在location选择值之后,还将设置LOCATIONSITE的值,该值取自LOCATIONS的SITEID字段(SOURCE.SOURCEKEY)


##### 常见缺省

```Sql
INSERT INTO MAXLOOKUPMAP	
  (TARGET,  LOOKUPATTR, TARGETATTR, SOURCEKEY,	SOURCE,SEQNUM,ALLOWNULL,MAXLOOKUPMAPID	)
VALUES
  ( 'PO', 'PONUM', 'PONUM', 'PONUM', 'PAYMENTPZ','1','1',MAXLOOKUPMAPseq.nextval) ;

```
