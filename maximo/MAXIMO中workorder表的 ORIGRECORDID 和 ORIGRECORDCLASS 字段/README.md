# MAXIMO中workorder表的 ORIGRECORDID 和 ORIGRECORDCLASS 字段  

ORIGRECORDCLASS  原始记录的类
<br />
ORIGRECORDID   原始记录编号
<br />
当ORIGRECORDID 为空时 ORIGRECORDCLASS  也必须为空,否则在变更状态为 CLOSE 的时候,会出现工作流不能关闭,而状态却变更了
<br />
而后台会报以下错误
```
[5/18/16 22:46:58:083 CST] 0000003a SystemErr     R Caused by: java.lang.NullPointerException
[5/18/16 22:46:58:084 CST] 0000003a SystemErr     R 	at psdi.app.workorder.WO.changeOriginatorStatus(WO.java:7300)
[5/18/16 22:46:58:084 CST] 0000003a SystemErr     R 	at psdi.app.workorder.WO.changeStatus(WO.java:7247)
[5/18/16 22:46:58:084 CST] 0000003a SystemErr     R 	at psdi.app.workorder.WO.changeStatus(WO.java:7137)
[5/18/16 22:46:58:084 CST] 0000003a SystemErr     R 	at psdi.common.action.Action.executeChangeStatus(Action.java:529)
[5/18/16 22:46:58:084 CST] 0000003a SystemErr     R 	at psdi.common.action.Action.executeAction(Action.java:323)
[5/18/16 22:46:58:084 CST] 0000003a SystemErr     R 	at psdi.workflow.WFAction.applyWorkflowAction(WFAction.java:175)
[5/18/16 22:46:58:084 CST] 0000003a SystemErr     R 	at psdi.workflow.WFNode.applyWorkflowAction(WFNode.java:181)
[5/18/16 22:46:58:085 CST] 0000003a SystemErr     R 	at psdi.workflow.WFCallStackSet.applyWorkflowAction(WFCallStackSet.java:208)
[5/18/16 22:46:58:085 CST] 0000003a SystemErr     R 	at psdi.workflow.WFCallStackSet.completeWorkflowAssignment(WFCallStackSet.java:156)
[5/18/16 22:46:58:085 CST] 0000003a SystemErr     R 	at psdi.workflow.WFInstance.completeWorkflowAssignment(WFInstance.java:172)
[5/18/16 22:46:58:085 CST] 0000003a SystemErr     R 	at psdi.workflow.virtual.CompleteWFSet.execute(CompleteWFSet.java:71)
[5/18/16 22:46:58:085 CST] 0000003a SystemErr     R 	at psdi.webclient.system.beans.WorkflowBean.execute(WorkflowBean.java:85)
[5/18/16 22:46:58:085 CST] 0000003a SystemErr     R 	... 57 more

```

因为在 workorder 变更为已关闭的时候,会将关联的 原始记录也变更为已关闭,在psdi.app.workorder.WO类中的changeOriginatorStatus 方法中写了变更 原始记录 的代码

代码如下:
```Java
/*  7285 */     Translate translator = getMboServer().getMaximoDD().getTranslator();
/*  7286 */     String mboName = translator.toInternalStringNoException("TKCLASS", getString("ORIGRECORDCLASS"), this);
/*       */     
/*       */ 
/*  7289 */     if (mboName == null)
/*       */     {
/*       */ 
/*  7292 */       return;
/*       */     }
/*       */     
/*       */ 
/*  7296 */     MboSetRemote origSet = getMboSet("$ORIGSET", mboName, "ticketid=:origrecordid");
/*  7297 */     Ticket originator = (Ticket)origSet.getMbo(0);
/*       */     
/*       */ 
/*  7300 */     if (!originator.getBoolean("InheritStatus"))
/*       */     {
/*       */ 
/*  7303 */       return;
/*       */     }
```

