# 清理workorder的工作流记录信息
```Sql
select * from MAXATTRIBUTE where ATTRIBUTENAME='WFID';

select * from WFASGNGROUP where wfid in (select wfid from WFINSTANCE where ownerid in (select workorderid from workorder where DESCRIPTION like '测试工单%') and  OWNERTABLE = 'WORKORDER');  

select * from WFCALLSTACK  where wfid in (select wfid from WFINSTANCE where ownerid in (select workorderid from workorder where DESCRIPTION like '测试工单%') and  OWNERTABLE = 'WORKORDER');  

select * from WFINSTANCE where ownerid in (select workorderid from workorder where DESCRIPTION like '测试工单%') and  OWNERTABLE = 'WORKORDER';

select * from WFTRANSACTION where ownerid in (select workorderid from workorder where DESCRIPTION like '测试工单%') and  OWNERTABLE = 'WORKORDER';

select * from WFASSIGNMENT where ownerid in (select workorderid from workorder where DESCRIPTION like '测试工单%') and  OWNERTABLE = 'WORKORDER';

select * from workorder where DESCRIPTION like '测试工单%';

delete from WFASGNGROUP where wfid in (select wfid from WFINSTANCE where ownerid in (select workorderid from workorder where DESCRIPTION like '测试工单%') and  OWNERTABLE = 'WORKORDER');  

delete from WFCALLSTACK  where wfid in (select wfid from WFINSTANCE where ownerid in (select workorderid from workorder where DESCRIPTION like '测试工单%') and  OWNERTABLE = 'WORKORDER');  

delete from WFINSTANCE where ownerid in (select workorderid from workorder where DESCRIPTION like '测试工单%') and  OWNERTABLE = 'WORKORDER';

delete from WFTRANSACTION where ownerid in (select workorderid from workorder where DESCRIPTION like '测试工单%') and  OWNERTABLE = 'WORKORDER';

delete from WFASSIGNMENT where ownerid in (select workorderid from workorder where DESCRIPTION like '测试工单%') and  OWNERTABLE = 'WORKORDER';

delete from workorder where DESCRIPTION like '测试工单%';

```

