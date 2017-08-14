# 流程发送结束之时出现异常  

## maximo发送工作流异常
<br />
该问题具体发生状况有: 在流程结束之后会触发不关联的action操作

### 问题追踪
<br />
将sql日志级别设置为  log4j.logger.maximo.sql=INFO

之前一直在下面一段日志找(请查看[日志1]),找了半天没找出问题,后来在源代码中找含有关键字,"processname = :processname and processrev = :processrev" 的源文件,还是没有找到,找出的一堆都有nodeid的(请查看[代码1])

最后 查了下关系表:
```Sql
select * from Maxrelationship where lower(Whereclause ) like '%:processname%' and  lower(Whereclause )  like '%:processrev%';
```
发现 有个 WFCALLSTACK 没查过,数据库配置描述是:进程和子进程调用堆栈。

<br />
然后用oracle sql developer 执行 select * from WFCALLSTACK  where wfid = 5123;  找到了相关的 PROCESSNAME='KAIZENITEM' 的记录

![image](https://raw.githubusercontent.com/shoukaiseki/blogdoc/master/maximo/%E6%B5%81%E7%A8%8B%E5%8F%91%E9%80%81%E7%BB%93%E6%9D%9F%E4%B9%8B%E6%97%B6%E5%87%BA%E7%8E%B0%E5%BC%82%E5%B8%B8/img/001.png)
 
最后问题找到了,之前导的库,没清理流程历史造成的


### 代码1

```Java
                    MboValue mv = ((Mbo)mbo).getMboValue("subprocessname");
                        ((Mbo)mbo).getMboValue("subprocessname").setToBeValidated(false);
            setValue("PROCESSNAME", ownerTask.getString("PROCESSNAME"), 11L);
            return (WFTask)getMboSet("$task", "WFTask", "processname = :processname and processrev=:processrev and nodeid=:nodeid").getMbo(0);
            return (WFNodeRemote)getMboSet("$node", "WFNode", "processname = :processname and processrev=:processrev and nodeid=:nodeid").getMbo(0);
        String getProcessClause = "processname = :processname and processrev = (select processrev from wfrevision where mainprocess = :processname and revision = :revision and processname = :processname)";
                getString("PROCESSNAME"), getString("PROCESSREV")
            escAssign.setValue("PROCESSNAME", getString("PROCESSNAME"), 2L);
        activeAssignment.setValue("PROCESSNAME", getString("PROCESSNAME"), 3L);
        "ASSIGNCODE", "ASSIGNSTATUS", "NODEID", "WFID", "OWNERTABLE", "OWNERID", "PROCESSNAME", "PROCESSREV"
        "PROCESSNAME", "PROCESSREV", "OBJECTNAME", "DISPLAYONE", "USERSQL", "OWNERDESCRIPTION", "LASTMEMO"
        setValue("PROCESSNAME", wfProcess.getString("PROCESSNAME"));
        Workflow workflow = new Workflow((new StringBuilder()).append(getString("PROCESSNAME")).append("-").append(getString("PROCESSREV")).toString());
                        currentNode.getString("PROCESSNAME")
                    getMbo(0).getString("PROCESSNAME")
                    String processName = instance.getString("PROCESSNAME");
                            inputName, processName, instance.getString("WFID")
                        inputName, processName
                getMbo(0).getString("PROCESSNAME")
                getMbo(0).getString("PROCESSNAME")
                getString("WFID"), getString("PROCESSNAME"), getString("REVISION")
        "ACTIVE", "WFID", "ORIGINATOR", "REVISION", "STARTTIME", "CURRTASKSTARTTIME", "PROCESSNAME", "OWNERTABLE", "OWNERID", "DELETABLE"
            setValue("PROCESSNAME", getOwner().getString("PROCESSNAME"), 11L);
        MboSetRemote actions = getMboSet("$scratch", "WFAction", "processname = :processname and processrev=:processrev and membernodeid=:nodeid");
        if(copyField.equals("PROCESSNAME"))
        "NODEID", "PROCESSNAME", "PROCESSREV", "POINTEDTO"
            "NODEID", "PROCESSNAME", "PROCESSREV"
        setValue("PROCESSNAME", getOwner().getString("PROCESSNAME"), 11L);
            return (WFNode)getMboSet("$msnode", "WFNode", "processname = :processname and processrev=:processrev and nodeid=:nodeid").getMbo(0);
        if(copyField.equals("PROCESSNAME"))
    public void buildSubProcessList(Hashtable h, String processName, String processrev)
        SqlFormat s = new SqlFormat(getUserInfo(), (new StringBuilder()).append("processname=:1 and processrev=:2 and nodetype in (").append(wantedNodeTypes).append(")").toString());
        s.setObject(1, "WFNODE", "PROCESSNAME", processName);
                            node.getString("TITLE"), processName, processrev, process.getString("PROCESSNAME")
                        node.getString("TITLE"), processName, processrev, process.getString("PROCESSNAME")
                String subprocessname = node.getCompanionSet().getMbo(0).getString("SUBPROCESSNAME");
                if(!hinfo.containsKey(subprocessname))
                    hinfo.put(subprocessname, subprocessname);
            params[0] = getOwner().getString("processname");
    public boolean hasPositiveStop(String processName, String processrev)
        SqlFormat s = new SqlFormat(getUserInfo(), (new StringBuilder()).append("processname =:1 and processrev=:2 and nodetype in (").append(wantedNodeTypes).append(")").toString());
        s.setObject(1, "WFNODE", "PROCESSNAME", processName);
    public boolean hasNegativeStop(String processName, String processrev)
        SqlFormat s = new SqlFormat(getUserInfo(), (new StringBuilder()).append("processname =:1 and processrev=:2 and nodetype in (").append(wantedNodeTypes).append(")").toString());
        s.setObject(1, "WFNODE", "PROCESSNAME", processName);
        setValue("PROCESSNAME", owner.getString("PROCESSNAME"), 11L);
        String getProcessClause = "processname = :processname and processrev = (select processrev from wfrevision where mainprocess = :processname and revision = :revision and processname = :processname)";
                getString("PROCESSNAME"), getString("PROCESSREV")
        if(copyField.equals("PROCESSNAME"))
        "NOTIFICATIONID", "NODEID", "PROCESSNAME", "ACTIONID", "PROCESSREV"
                setFieldFlag("PROCESSNAME", 7L, true);
            MboSetRemote fetchActions = getMboSet("$FETCH_ACTIONS", "WFACTION", "processname = :processname and processrev = :processrev");
        hinfo.put(getString("PROCESSNAME"), getString("PROCESSNAME"));
            getString("processname"), getString("description")
            params[0] = BidiUtils.buildAndPush(getName(), "processname", (String)params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME")
                params[0] = BidiUtils.buildAndPush(getName(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        String processName = getString("PROCESSNAME");
        if(!h.containsKey(processName))
            h.put(processName, processrev);
            wfNodes.buildSubProcessList(h, processName, processrev);
        return wfStopNodes.hasPositiveStop(getString("PROCESSNAME"), getString("processrev"));
        return wfStopNodes.hasNegativeStop(getString("PROCESSNAME"), getString("processrev"));
        getMboSet("$DELACTION", "WFACTION", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELCOND", "WFCONDITION", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELSTART", "WFSTART", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELSTOP", "WFSTOP", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELINPUT", "WFINPUT", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELTASK", "WFTASK", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELSUBPROC", "WFSUBPROCESS", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELWAITLIST", "WFWAITLIST", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELINTERACTION", "WFINTERACTION", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELNOTIFICATION", "WFNOTIFICATION", "processname = :processname and processrev = :processrev").deleteAll(2L);
        if(getMboSet("$COUNTVERSIONS", "WFPROCESS", "processname = :processname").count() <= 1)
            getMboSet("$DELAPPTOOLBAR", "WFAPPTOOLBAR", "processname = :processname").deleteAll(2L);
                getString("PROCESSNAME")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME"), getString("PROCESSREV")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        MboSetRemote actProc = getMboSet("$ACTPROC", "WFPROCESS", "processname = :processname and active = :yes");
                getString("PROCESSNAME"), getString("PROCESSREV"), active.getString("PROCESSREV")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME"), getString("PROCESSREV")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        MboSetRemote maxRev = getMboSet("$MAXREV", "WFREVISION", "mainprocess = :processname");
        String processName = getString("PROCESSNAME");
            rev.setValue("MAINPROCESS", processName, 2L);
            String subProcessName = (String)e.nextElement();
            subProcessRev = (String)h.get(subProcessName);
            rev.setValue("PROCESSNAME", subProcessName, 2L);
                getString("PROCESSNAME")
                param[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)param[0], getUserInfo().getLangCode());
                getString("PROCESSNAME"), getString("OBJECTNAME"), targetObject
                SqlFormat sqf = new SqlFormat(this, "processname = :processname and ownertable = :1 and ownerid = :2 ");
                        getString("PROCESSNAME")
        SqlFormat sqf = new SqlFormat(this, "processname = :processname and active = :yes and ownerid = :1");
                getString("PROCESSNAME")
        instance.setValue("PROCESSNAME", getString("PROCESSNAME"), 2L);
        instance.setValue("REVISION", revSet.getRevision(getString("PROCESSNAME")), 2L);
            getString("PROCESSNAME")
            params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME"), getString("PROCESSREV")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
            getString("PROCESSNAME"), getString("PROCESSREV")
            params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        revision.setValue("PROCESSNAME", getString("PROCESSNAME"), 2L);
            revision.getString("PROCESSNAME"), revision.getString("PROCESSREV")
            params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        if(copyField.equals("PROCESSNAME"))
            getString("PROCESSNAME"), getString("PROCESSREV")
            params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        MboSetRemote revSet = getMboSet("$REVMEMBER", "WFREVISION", "processname = :processname and processrev = :processrev and mainprocess != processname");
        MboSetRemote instSet = getMboSet("$ACTINSTANCE", "WFINSTANCE", "active = 1 and exists (select 1 from wfrevision where wfinstance.processname = mainprocess and wfinstance.revision = revision and processname = :processname and processrev = :processrev)");
            MboSetRemote revisionSet = getMboSet("$REVISONRECS", "WFREVISION", "mainprocess = :processname and revision in (select revision from wfrevision where mainprocess = :processname and processname = :processname and processrev = :processrev)");
            getString("PROCESSNAME"), getString("PROCESSREV")
            params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
            "PROCESSNAME"
                getString("PROCESSNAME"), oldDefault.getString("PROCESSNAME")
                getString("PROCESSNAME")
                getString("PROCESSNAME")
        String updateSql = "update wfinstance set deletable = :deletable where processname = :processname and revision in (select revision from wfrevision     where processname = :processname and mainprocess = processname and processrev = :processrev)";
        setValue("PROCESSNAME", nodeOwner.getString("PROCESSNAME"), 11L);
            return (WFNode)getMboSet("$msnode", "WFNode", "processname = :processname and processrev=:processrev and nodeid=:nodeid").getMbo(0);
        if(copyField.equals("PROCESSNAME"))
        "ACTIONID", "ACTIONVALUE", "PROCESSNAME", "PROCESSREV"
        String processname = getWFInstance().getString("PROCESSNAME");
        String subProcessName = getString("SUBPROCESSNAME");
        return wfProcSet.getWFProcessRevisionByID(processname, revision, subProcessName);
        WFProcessSet wfProcSet = (WFProcessSet)getMboSet("$SUBPROC", "WFPROCESS", "processname = :subprocessname and processrev = (select max(processrev) from wfprocess where processname = :subprocessname and enabled = :yes)");
                getString("SUBPROCESSNAME")
        if(isNull("SUBPROCESSNAME"))
        if(getString("PROCESSNAME").equals(getString("SUBPROCESSNAME")))
        WFProcessSetRemote subProcesses = (WFProcessSetRemote)getMboSet("$SUBPROCESS", "WFPROCESS", "processname = :subprocessname and enabled = 1");
                    nodeMbo.getString("title"), nodeMbo.getString("description"), subProcess.getString("processname"), subProcess.getString("description")
            ag.setValue("PROCESSNAME", getString("PROCESSNAME"), 11L);
            String processName = instance.getString("PROCESSNAME");
                log.fatal((new StringBuilder()).append("Did not create assignments in workflow process ").append(processName).append(", task ").append(taskName).append(", on ").append(instance.getString("OWNERTABLE")).append(" Mbo with key of ").append(instance.getString("OWNERID")).toString());
                taskName, processName
        getMboSet("$DELTASKASGN", "WFASSIGNMENT", "processname = :processname and processrev = :processrev and nodeid=:nodeid").deleteAll(2L);
            xact.setValue("PROCESSNAME", wfAction.getString("PROCESSNAME"), 2L);
            xact.setValue("PROCESSNAME", wfAssignment.getString("PROCESSNAME"), 2L);
            xact.setValue("PROCESSNAME", wfCallStack.getString("PROCESSNAME"), 2L);
                setFieldFlag("PROCESSNAME", 7L, true);
            MboSetRemote fetchActions = getMboSet("$FETCH_ACTIONS", "WFACTION", "processname = :processname and processrev = :processrev");
        hinfo.put(getString("PROCESSNAME"), getString("PROCESSNAME"));
            getString("processname"), getString("description")
            params[0] = BidiUtils.buildAndPush(getName(), "processname", (String)params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME")
                params[0] = BidiUtils.buildAndPush(getName(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        String processName = getString("PROCESSNAME");
        if(!h.containsKey(processName))
            h.put(processName, processrev);
            wfNodes.buildSubProcessList(h, processName, processrev);
        return wfStopNodes.hasPositiveStop(getString("PROCESSNAME"), getString("processrev"));
        return wfStopNodes.hasNegativeStop(getString("PROCESSNAME"), getString("processrev"));
        getMboSet("$DELACTION", "WFACTION", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELCOND", "WFCONDITION", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELSTART", "WFSTART", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELSTOP", "WFSTOP", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELINPUT", "WFINPUT", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELTASK", "WFTASK", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELSUBPROC", "WFSUBPROCESS", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELWAITLIST", "WFWAITLIST", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELINTERACTION", "WFINTERACTION", "processname = :processname and processrev = :processrev").deleteAll(2L);
        getMboSet("$DELNOTIFICATION", "WFNOTIFICATION", "processname = :processname and processrev = :processrev").deleteAll(2L);
        if(getMboSet("$COUNTVERSIONS", "WFPROCESS", "processname = :processname").count() <= 1)
            getMboSet("$DELAPPTOOLBAR", "WFAPPTOOLBAR", "processname = :processname").deleteAll(2L);
                getString("PROCESSNAME")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME"), getString("PROCESSREV")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        MboSetRemote actProc = getMboSet("$ACTPROC", "WFPROCESS", "processname = :processname and active = :yes");
                getString("PROCESSNAME"), getString("PROCESSREV"), active.getString("PROCESSREV")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME"), getString("PROCESSREV")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        MboSetRemote maxRev = getMboSet("$MAXREV", "WFREVISION", "mainprocess = :processname");
        String processName = getString("PROCESSNAME");
            rev.setValue("MAINPROCESS", processName, 2L);
            String subProcessName = (String)e.nextElement();
            subProcessRev = (String)h.get(subProcessName);
            rev.setValue("PROCESSNAME", subProcessName, 2L);
                getString("PROCESSNAME")
                param[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)param[0], getUserInfo().getLangCode());
                getString("PROCESSNAME"), getString("OBJECTNAME"), targetObject
                SqlFormat sqf = new SqlFormat(this, "processname = :processname and ownertable = :1 and ownerid = :2 ");
                        getString("PROCESSNAME")
        SqlFormat sqf = new SqlFormat(this, "processname = :processname and active = :yes and ownerid = :1");
                getString("PROCESSNAME")
        instance.setValue("PROCESSNAME", getString("PROCESSNAME"), 2L);
        instance.setValue("REVISION", revSet.getRevision(getString("PROCESSNAME")), 2L);
            getString("PROCESSNAME")
            params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", params[0], getUserInfo().getLangCode());
                getString("PROCESSNAME"), getString("PROCESSREV")
                params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
            getString("PROCESSNAME"), getString("PROCESSREV")
            params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        revision.setValue("PROCESSNAME", getString("PROCESSNAME"), 2L);
            revision.getString("PROCESSNAME"), revision.getString("PROCESSREV")
            params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        if(copyField.equals("PROCESSNAME"))
            getString("PROCESSNAME"), getString("PROCESSREV")
            params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
        MboSetRemote revSet = getMboSet("$REVMEMBER", "WFREVISION", "processname = :processname and processrev = :processrev and mainprocess != processname");
        MboSetRemote instSet = getMboSet("$ACTINSTANCE", "WFINSTANCE", "active = 1 and exists (select 1 from wfrevision where wfinstance.processname = mainprocess and wfinstance.revision = revision and processname = :processname and processrev = :processrev)");
            MboSetRemote revisionSet = getMboSet("$REVISONRECS", "WFREVISION", "mainprocess = :processname and revision in (select revision from wfrevision where mainprocess = :processname and processname = :processname and processrev = :processrev)");
            getString("PROCESSNAME"), getString("PROCESSREV")
            params[0] = BidiUtils.buildAndPush(getMboSetInfo(), "PROCESSNAME", (String)params[0], getUserInfo().getLangCode());
            "PROCESSNAME"
                getString("PROCESSNAME"), oldDefault.getString("PROCESSNAME")
                getString("PROCESSNAME")
                getString("PROCESSNAME")
        String updateSql = "update wfinstance set deletable = :deletable where processname = :processname and revision in (select revision from wfrevision     where processname = :processname and mainprocess = processname and processrev = :processrev)";

```

### 日志1

```
06 Jan 2016 19:01:46:418 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（WFASSIGNMENT）：select * from wfassignment  where wfid in (select wfid from wfinstance where wfinstance.ownertable =  'WORKORDER'  and wfinstance.ownerid = 777591 and wfinstance.processname =  'WO(GD)' ) and assigncode =  'GAOJUN'  and assignstatus in (select value from synonymdomain where domainid = 'WFASGNSTATUS' and maxvalue = 'ACTIVE')
06 Jan 2016 19:01:46:420 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1148应用程序（null）对象（WFINSTANCE）：select * from wfinstance  where wfid =  5123
06 Jan 2016 19:01:46:438 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1142应用程序（null）对象（WFTASK）：select * from wftask  where processname =  'WH_WO(GD)'  and processrev= 3  and nodeid= 13
06 Jan 2016 19:01:46:457 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（WFACTION）：select * from wfaction  where processname =  'WH_WO(GD)'  and processrev =  3  and ownernodeid =  13 order by ispositive desc
06 Jan 2016 19:01:46:459 [INFO] BMXAA6698I - Mbo 调试：正在从 appfielddefault 表获取关于应用程序：WOTRACK，对象：COMPLETEWF，地点：武汉，用户：GAOJUN，组：WH-SB-SJXX  WH-SB-WXZR  MAXDEFLTREG  MAXEVERYONE  的记录
06 Jan 2016 19:01:46:530 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1148应用程序（null）对象（WFTRANSACTION）：select * from wftransaction  where wfid =  5123  and memo is not null order by transdate desc
06 Jan 2016 19:01:46:806 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（1142应用程序（null）对象（CRONTASKINSTANCE）：select * from crontaskinstance  where reloadreqtime>{ ts '2016-01-06 19:00:46.286' }
06 Jan 2016 19:01:46:810 [INFO] BMXAA6378I - 用户 =（MAXADMIN）SPID =（3387）BMXAA6379I - 应用程序（CrontaskManager）：select taskname, lastrun from taskscheduler where servername =?
06 Jan 2016 19:01:48:294 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（5660应用程序（null）对象（WFASSIGNMENT）：select * from wfassignment  where wfid =  5123  and assignstatus in (select value from synonymdomain where domainid='WFASGNSTATUS' and maxvalue='ACTIVE')
06 Jan 2016 19:01:48:298 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1142应用程序（null）对象（WFCALLSTACK）：select * from wfcallstack  where wfid =  5123
06 Jan 2016 19:01:48:304 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2274应用程序（null）对象（WFNODE）：select * from wfnode  where processname= 'WH_WO(GD)'  and processrev= 3
06 Jan 2016 19:01:48:308 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2259应用程序（null）对象（WFACTION）：select * from wfaction  where processname =  'WH_WO(GD)'  and processrev =  3  and ownernodeid =  13 order by sequence
06 Jan 2016 19:01:48:311 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（WFTASK）：select * from wftask  where processname= 'WH_WO(GD)'  and processrev= 3  and nodeid= 13
06 Jan 2016 19:01:48:315 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（7901应用程序（null）对象（SYNONYMDOMAIN）：select * from synonymdomain  where ((value= '完成'  )  and (domainid =  'WFASGNSTATUS'   )) and (rownum<=1000)
06 Jan 2016 19:01:48:321 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1142应用程序（null）对象（SYNONYMDOMAIN）：select * from synonymdomain  where ((value= '任务'  )  and (domainid =  'WFNODETYPE'   )) and (rownum<=1000)
06 Jan 2016 19:01:48:325 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2259应用程序（null）对象（WFTASK）：select * from wftask  where processname =  'WH_WO(GD)'  and processrev= 3  and nodeid= 13
06 Jan 2016 19:01:48:335 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（SYNONYMDOMAIN）：select * from synonymdomain  where ((value= '不活动'  )  and (domainid =  'WFASGNSTATUS'   )) and (rownum<=1000)
06 Jan 2016 19:01:48:345 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（7901应用程序（null）对象（SYNONYMDOMAIN）：select * from synonymdomain  where ((value= '任务'  )  and (domainid =  'WFNODETYPE'   )) and (rownum<=1000)
06 Jan 2016 19:01:48:357 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（5660应用程序（null）对象（ACTION）：select * from action  where action =  'WO_08'
06 Jan 2016 19:01:48:392 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（2259应用程序（null）对象（LABORAUTH）：select * from laborauth  where groupname in ( 'MAXDEFLTREG' , 'MAXEVERYONE' , 'WH-SB-SJXX' , 'WH-SB-WXZR' ) order by groupname
06 Jan 2016 19:01:48:396 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（LABTRANS）：select * from labtrans  where (refwo= 'WHWO193436'  and siteid= '武汉'  and genapprservreceipt=0) and (1 = 2)
06 Jan 2016 19:01:48:399 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（7901应用程序（null）对象（LABTRANS）：select * from labtrans  where (refwo= 'WHWO193436'  and siteid= '武汉'   and timerstatus in (select value from synonymdomain where domainid = 'TIMERSTATUS' and maxvalue = 'ACTIVE')) and (1 = 2)
06 Jan 2016 19:01:48:436 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（5660应用程序（null）对象（PLUSCWODS）：select * from pluscwods  where wonum =  'WHWO193436'  and siteid =  '武汉'
06 Jan 2016 19:01:48:478 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2274应用程序（null）对象（LABTRANS）：select * from labtrans  where (refwo= 'WHWO193436'  and siteid= '武汉') and (1 = 2)
06 Jan 2016 19:01:48:497 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（INVRESERVE）：select * from invreserve  where wonum= 'WHWO193436'  and siteid= '武汉'   and itemnum in  (select itemnum from wpmaterial where wonum= 'WHWO193436'  and siteid= '武汉' )
06 Jan 2016 19:01:48:499 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（7901应用程序（null）对象（SYNONYMDOMAIN）：select * from synonymdomain  where ((value= '已关闭'  )  and (domainid =  'WOSTATUS'   )) and (rownum<=1000)
06 Jan 2016 19:01:48:515 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（2274应用程序（null）对象（CRONTASKINSTANCE）：select * from crontaskinstance  where crontaskname= 'SendSMS'  and instancename= 'SendSMS'
06 Jan 2016 19:01:48:523 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（7901应用程序（null）对象（CRONTASKPARAM）：select * from crontaskparam  where crontaskname= 'SendSMS'  and instancename= 'SendSMS'
06 Jan 2016 19:01:48:525 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（1142应用程序（null）对象（CRONTASKPARAM）：select * from crontaskparam  where crontaskname= 'SendSMS'  and instancename= 'SendSMS'
06 Jan 2016 19:01:48:527 [INFO] BMXAA6378I - 用户 =（MAXADMIN）SPID =（2274）BMXAA6379I - 应用程序（CrontaskManager）：insert into crontaskhistory (crontaskname,instancename,serverhost,servername,starttime,endtime,activity,sequence,crontaskhistoryid) values( ?,?,?,?,?,?,?, (select NVL(max(sequence), 0)+1 from crontaskhistory where crontaskname=? and instancename=?), crontaskhistoryseq.nextval)
06 Jan 2016 19:01:48:527 [INFO] SendSMS
06 Jan 2016 19:01:48:527 [INFO] SendSMS
06 Jan 2016 19:01:48:527 [INFO] 127.0.0.1
06 Jan 2016 19:01:48:527 [INFO] MXServer
06 Jan 2016 19:01:48:527 [INFO] 2016-01-06 19:01:48.0
06 Jan 2016 19:01:48:527 [INFO] 2016-01-06 19:01:48.0
06 Jan 2016 19:01:48:527 [INFO] ACTION
06 Jan 2016 19:01:48:527 [INFO] SendSMS
06 Jan 2016 19:01:48:528 [INFO] SendSMS
06 Jan 2016 19:01:48:536 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（7901应用程序（null）对象（PM）：select * from pm  where pmnum= 'WHPM1063'  and siteid= '武汉'
06 Jan 2016 19:01:48:549 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（3387应用程序（null）对象（CRONTASKHISTORY）：select * from crontaskhistory  where crontaskhistoryid = (select max(crontaskhistoryid) from crontaskhistory where crontaskname = 'SendSMS' and instancename = 'SendSMS')
06 Jan 2016 19:01:48:549 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1148应用程序（null）对象（PMMETER）：select count(*) from pmmeter  where pmnum= 'WHPM1063'  and siteid= '武汉'
06 Jan 2016 19:01:48:551 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（1142应用程序（null）对象（CRONTASKPARAM）：select count(*) from crontaskparam  where crontaskname= 'SendSMS'  and instancename= 'SendSMS'
06 Jan 2016 19:01:48:553 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（2274应用程序（null）对象（CRONTASKPARAM）：select * from crontaskparam  where crontaskname= 'SendSMS'  and instancename= 'SendSMS'
06 Jan 2016 19:01:48:554 [DEBUG] corpid|118244
06 Jan 2016 19:01:48:554 [DEBUG] loginname|6SDK-EMY-6688-JETPT
06 Jan 2016 19:01:48:554 [DEBUG] password|China0ct0069
06 Jan 2016 19:01:48:555 [DEBUG] siteid:深圳|SZ_JXJH,SZ_PR,SZ_WO(GD),SZ_CDGPR,SZ_WXPR,SZ_ZXSPJH
06 Jan 2016 19:01:48:555 [DEBUG] siteid:武汉|WH_PR,WH_RFQ,WH_PAYMENT,WH_WO(GD),WH_MUR,WH_PO,WH_SRCODE
06 Jan 2016 19:01:48:555 [DEBUG] spacemin|10,60
06 Jan 2016 19:01:48:556 [DEBUG] url|
06 Jan 2016 19:01:48:774 [DEBUG]  SQL = select  t.wfassignmentid id,t.assigncode as personid,(select e.phonenum from phone e where e.personid = t.assigncode and e.isprimary = 1) phone,t.description from wfassignment t，person p  where t.assigncode = p.personid and t.assignstatus = '活动'  and to_char(t.startdate,'yyyy-MM-dd HH24:mi:ss') <= '2016-01-06 18:01:48' and p.locationsite = '深圳' and  ',SZ_JXJH,SZ_PR,SZ_WO(GD),SZ_CDGPR,SZ_WXPR,SZ_ZXSPJH,' like '%,'||t.processname||',%' and t.emailnotification = 1 and t.ISSENDSMS = 0
06 Jan 2016 19:01:48:775 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（ASSIGNMENT）：select * from assignment  where (wonum= 'WHWO193436'  and siteid= '武汉') and (1 = 2)
06 Jan 2016 19:01:48:786 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2274应用程序（null）对象（WORKTYPE）：select * from worktype  where worktype =  '检修计划工单'  and orgid= '武汉欢乐谷'
06 Jan 2016 19:01:48:811 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1148应用程序（null）对象（LOCATIONMETER）：select count(*) from locationmeter  where location =  'HWH0502'  and siteid =  '武汉'
06 Jan 2016 19:01:48:817 [DEBUG]  SQL = select  t.wfassignmentid id,t.assigncode as personid,(select e.phonenum from phone e where e.personid = t.assigncode and e.isprimary = 1) phone,t.description from wfassignment t，person p  where t.assigncode = p.personid and t.assignstatus = '活动'  and to_char(t.startdate,'yyyy-MM-dd HH24:mi:ss') <= '2016-01-06 18:01:48' and p.locationsite = '武汉' and  ',WH_PR,WH_RFQ,WH_PAYMENT,WH_WO(GD),WH_MUR,WH_PO,WH_SRCODE,' like '%,'||t.processname||',%' and t.emailnotification = 1 and t.ISSENDSMS = 0
06 Jan 2016 19:01:48:826 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2259应用程序（null）对象（MULTIASSETLOCCI）：select * from multiassetlocci  where recordkey= 'WHWO193436'  and recordclass= '工单'  and assetnum is not null and worksiteid= '武汉'  and multiid =(select min(multiid) from multiassetlocci multi2 where multi2.recordkey=multiassetlocci.recordkey and multi2.recordclass=multiassetlocci.recordclass  and multi2.worksiteid=multiassetlocci.worksiteid and multi2.assetnum=multiassetlocci.assetnum and multi2.siteid=multiassetlocci.siteid)
06 Jan 2016 19:01:48:839 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1142应用程序（null）对象（WOASSETUSERCUST）：select * from woassetusercust  where exists ( select 1 from multiassetlocci where recordkey= 'WHWO193436'  and recordclass= '工单'  and siteid= '武汉'  and multiid=woassetusercust.multiid)
06 Jan 2016 19:01:48:841 [INFO] 完成: LIANGKAIFU手机号为空？YUANMING手机号为空？LIANGKAIFU手机号为空？LIANGKAIFU手机号为空？LIANGKAIFU手机号为空？LIANGKAIFU手机号为空？WANGPENG手机号为空？LIANGKAIFU手机号为空？JINNA手机号为空？JINNA手机号为空？JINNA手机号为空？JINNA手机号为空？JINNA手机号为空？WANGXIANJUN手机号为空？WANXING手机号为空？
06 Jan 2016 19:01:48:849 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（7901应用程序（null）对象（WOLOCUSERCUST）：select * from wolocusercust  where exists ( select 1 from multiassetlocci where recordkey= 'WHWO193436'  and recordclass= '工单'  and siteid= '武汉'  and multiid=wolocusercust.multiid)
06 Jan 2016 19:01:48:857 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（5660应用程序（null）对象（AUTOATTRUPDATE）：select * from autoattrupdate  where wonum=''  and worksiteid=''
06 Jan 2016 19:01:48:870 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（WPMATERIAL）：select * from wpmaterial  where wonum= 'WHWO193436'  and siteid= '武汉'
06 Jan 2016 19:01:48:877 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2259应用程序（null）对象（INVRESERVE）：select * from invreserve  where wonum= 'WHWO193436'  and siteid= '武汉'   and itemnum in  (select itemnum from wptool where wonum= 'WHWO193436'  and siteid= '武汉' )
06 Jan 2016 19:01:48:880 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1142应用程序（null）对象（WPTOOL）：select * from wptool  where wonum= 'WHWO193436'  and siteid= '武汉'
06 Jan 2016 19:01:48:892 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（7901应用程序（null）对象（INVRESERVE）：select * from invreserve  where wonum =  'WHWO193436'  and siteid = '武汉'
06 Jan 2016 19:01:49:147 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（5660应用程序（null）对象（CRONTASKDEF）：select * from crontaskdef  where crontaskname= 'SendSMS'
06 Jan 2016 19:01:49:300 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（2274应用程序（null）对象（CRONTASKHISTORY）：update crontaskhistory set runtimeerror=? where crontaskhistoryid=? and rowstamp=?
06 Jan 2016 19:01:49:300 [INFO] BMXAA6721I - RUNTIMEERROR = LIANGKAIFU手机号为空？YUANMING手机号为空？LIANGKAIFU手机号为空？LIANGKAIFU手机号为空？LIANGKAIFU手机号为空？LIANGKAIFU手机号为空？WANGPENG手机号为空？LIANGKAIFU手机号为空？JINNA手机号为空？JINNA手机号为空？JINNA手机号为空？JINNA手机号为空？JINNA手机号为空？WANGXIANJUN手机号为空？WANXING手机号为空？的绑定值
06 Jan 2016 19:01:49:300 [INFO] BMXAA6721I - CRONTASKHISTORYID = 595213的绑定值
06 Jan 2016 19:01:49:301 [INFO] BMXAA6721I - rowstamp = 245744007的绑定值
06 Jan 2016 19:01:49:307 [INFO] BMXAA6378I - 用户 =（MAXADMIN）SPID =（3387）BMXAA6379I - 应用程序（CrontaskManager）：update crontaskhistory set endtime=? where crontaskname=? and instancename=? and serverhost=? and servername=? and activity=? and starttime=?
06 Jan 2016 19:01:49:307 [INFO] 2016-01-06 19:01:48.799
06 Jan 2016 19:01:49:307 [INFO] SendSMS
06 Jan 2016 19:01:49:307 [INFO] SendSMS
06 Jan 2016 19:01:49:308 [INFO] 127.0.0.1
06 Jan 2016 19:01:49:308 [INFO] MXServer
06 Jan 2016 19:01:49:308 [INFO] ACTION
06 Jan 2016 19:01:49:308 [INFO] 2016-01-06 19:01:48.0
06 Jan 2016 19:01:49:546 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1142应用程序（null）对象（WORKORDER）：select * from workorder  where (wonum in (select wo1.wonum from woancestor wa, workorder wo1 where (wa.wonum   =  'WHWO193436' ) and (wa.siteid   =  '武汉' ) and (wo1.wonum   = wa.ancestor and (wo1.siteid  =  '武汉' ) and (wo1.parent is null)))) and siteid =  '武汉'
06 Jan 2016 19:01:49:617 [INFO] BMXAA6698I - Mbo 调试：正在从 appfielddefault 表获取关于应用程序：WOTRACK，对象：WOSTATUS，地点：武汉，用户：GAOJUN，组：WH-SB-SJXX  WH-SB-WXZR  MAXDEFLTREG  MAXEVERYONE  的记录
06 Jan 2016 19:01:49:620 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（7901应用程序（null）对象（WORKTYPE）：select * from worktype  where worktype =  '检修计划工单'  and orgid =  '武汉欢乐谷'  and woclass = '工单'
06 Jan 2016 19:01:49:639 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（WFNOTIFICATION）：select * from wfnotification  where processname= 'WH_WO(GD)'  and processrev= 3  and nodeid= 13  and actionid =  12
06 Jan 2016 19:01:49:645 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2259应用程序（null）对象（WFNOTIFICATION）：select * from wfnotification  where processname= 'WH_WO(GD)'  and processrev= 3  and nodeid= 2  and actionid = 0
06 Jan 2016 19:01:49:650 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1142应用程序（null）对象（WFNODE）：select * from wfnode  where processname= 'WO(GD)'  and processrev= 1
06 Jan 2016 19:01:49:653 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（7901应用程序（null）对象（WFACTION）：select * from wfaction  where processname =  'WO(GD)'  and processrev =  1  and ownernodeid =  6 order by sequence
06 Jan 2016 19:01:49:657 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（5660应用程序（null）对象（SYNONYMDOMAIN）：select * from synonymdomain  where ((value= '子进程'  )  and (domainid =  'WFNODETYPE'   )) and (rownum<=1000)
06 Jan 2016 19:01:49:659 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2274应用程序（null）对象（WFNOTIFICATION）：select * from wfnotification  where processname= 'WO(GD)'  and processrev= 1  and nodeid= 6  and actionid =  9
06 Jan 2016 19:01:49:662 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（WFNOTIFICATION）：select * from wfnotification  where processname= 'WO(GD)'  and processrev= 1  and nodeid= 2  and actionid = 0
06 Jan 2016 19:01:49:665 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2259应用程序（null）对象（WFNODE）：select * from wfnode  where processname= 'KAIZENITEM'  and processrev= 1
06 Jan 2016 19:01:49:668 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（1142应用程序（null）对象（WFACTION）：select * from wfaction  where processname =  'KAIZENITEM'  and processrev =  1  and ownernodeid =  5 order by sequence
06 Jan 2016 19:01:49:672 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（7901应用程序（null）对象（SYNONYMDOMAIN）：select * from synonymdomain  where ((value= '任务'  )  and (domainid =  'WFNODETYPE'   )) and (rownum<=1000)
06 Jan 2016 19:01:49:674 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（5660应用程序（null）对象（ACTION）：select * from action  where action =  'KZSELFCOMPGRP1'
06 Jan 2016 19:01:49:683 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（2274应用程序（null）对象（ACTIONGROUP）：select * from actiongroup  where action= 'KZSELFCOMPGRP1'  and  '组'  in (select value from synonymdomain where domainid='ACTIONTYPE' and maxvalue='GROUP') order by sequence
06 Jan 2016 19:01:49:687 [INFO] BMXAA6719I - 用户 =（GAOJUN）SPID =（3387应用程序（null）对象（ACTION）：select * from action  where action= 'KZCOMP'

```

