# maximo 配库之后启动错误

这个问题是使用一种第三方的迁移工具迁移视图导致的,因为迁移工具不会插入 MAXVIEW,MAXVIEWCFG,MAXVIEWCOLUMN,MAXVIEWCOLUMNCFG 这4张表的数据

执行以下语句
```Sql
select * from maxobject  where isview=1;

select * from MAXVIEW
```


比较两个结果集的行数是否一致,如果MAXOBJECT有的,而MAXVIEW没有,则启动MAXIMO应用将会报以下错误,因为获取mbosetinfo时,获取的数据将于 MAXVIEW,MAXVIEWCFG,MAXVIEWCOLUMN,MAXVIEWCOLUMNCFG 4张表有关,获取不到就会出错,

将这几张表的数据也迁移过来,如果视图无法正常查看,则需要修改视图对应的maxobject标志位,使其在配库的时候重建视图即可


```
03 三月 2016 21:51:50:010 [INFO] BMXAA6390I - Database driver: Oracle JDBC driver
03 三月 2016 21:51:50:010 [INFO] BMXAA6391I - Database driver version: 12.1.0.2.0
03 三月 2016 21:51:50:306 [INFO] Connection pool initialized with 8 free connections.
03 三月 2016 21:51:50:322 [INFO] BMXAA6453I - The server is connecting to database version: V7600-218
03 三月 2016 21:51:55:470 [ERROR] system#major
psdi.util.MXSystemException: system#major
	at psdi.mbo.MaximoDD.init(MaximoDD.java:244)
	at psdi.mbo.MaximoDD.reload(MaximoDD.java:282)
	at psdi.mbo.MaximoDDFactory.getCache(MaximoDDFactory.java:167)
	at psdi.mbo.MaximoDDFactory.init(MaximoDDFactory.java:66)
	at psdi.server.MXServer.boot(MXServer.java:1320)
	at psdi.server.MXServer.start(MXServer.java:3413)
	at psdi.servlet.MAXIMOStartupServlet.init(MAXIMOStartupServlet.java:70)
	at weblogic.servlet.internal.StubSecurityHelper$ServletInitAction.run(StubSecurityHelper.java:337)
	at weblogic.servlet.internal.StubSecurityHelper$ServletInitAction.run(StubSecurityHelper.java:288)
	at weblogic.security.acl.internal.AuthenticatedSubject.doAs(AuthenticatedSubject.java:321)
	at weblogic.security.service.SecurityManager.runAs(SecurityManager.java:120)
	at weblogic.servlet.provider.WlsSubjectHandle.run(WlsSubjectHandle.java:57)
	at weblogic.servlet.internal.StubSecurityHelper.initServletInstance(StubSecurityHelper.java:98)
	at weblogic.servlet.internal.StubSecurityHelper.createServlet(StubSecurityHelper.java:86)
	at weblogic.servlet.internal.StubLifecycleHelper.createOneInstance(StubLifecycleHelper.java:71)
	at weblogic.servlet.internal.StubLifecycleHelper.<init>(StubLifecycleHelper.java:57)
	at weblogic.servlet.internal.StubLifecycleHelper.<init>(StubLifecycleHelper.java:31)
	at weblogic.servlet.internal.ServletStubImpl.initStubLifecycleHelper(ServletStubImpl.java:660)
	at weblogic.servlet.internal.ServletStubImpl.prepareServlet(ServletStubImpl.java:600)
	at weblogic.servlet.internal.WebAppServletContext.preloadServlet(WebAppServletContext.java:1979)
	at weblogic.servlet.internal.WebAppServletContext.loadServletsOnStartup(WebAppServletContext.java:1956)
	at weblogic.servlet.internal.WebAppServletContext.preloadResources(WebAppServletContext.java:1846)
	at weblogic.servlet.internal.WebAppServletContext.start(WebAppServletContext.java:2876)
	at weblogic.servlet.internal.WebAppModule.startContexts(WebAppModule.java:1661)
	at weblogic.servlet.internal.WebAppModule.start(WebAppModule.java:823)
	at weblogic.application.internal.ExtensibleModuleWrapper$StartStateChange.next(ExtensibleModuleWrapper.java:360)
	at weblogic.application.internal.ExtensibleModuleWrapper$StartStateChange.next(ExtensibleModuleWrapper.java:356)
	at weblogic.application.utils.StateMachineDriver.nextState(StateMachineDriver.java:42)
	at weblogic.application.internal.ExtensibleModuleWrapper.start(ExtensibleModuleWrapper.java:138)
	at weblogic.application.internal.flow.ModuleListenerInvoker.start(ModuleListenerInvoker.java:124)
	at weblogic.application.internal.flow.ModuleStateDriver$3.next(ModuleStateDriver.java:216)
	at weblogic.application.internal.flow.ModuleStateDriver$3.next(ModuleStateDriver.java:211)
	at weblogic.application.utils.StateMachineDriver.nextState(StateMachineDriver.java:42)
	at weblogic.application.internal.flow.ModuleStateDriver.start(ModuleStateDriver.java:73)
	at weblogic.application.internal.flow.StartModulesFlow.activate(StartModulesFlow.java:24)
	at weblogic.application.internal.BaseDeployment$2.next(BaseDeployment.java:729)
	at weblogic.application.utils.StateMachineDriver.nextState(StateMachineDriver.java:42)
	at weblogic.application.internal.BaseDeployment.activate(BaseDeployment.java:258)
	at weblogic.application.internal.EarDeployment.activate(EarDeployment.java:61)
	at weblogic.application.internal.DeploymentStateChecker.activate(DeploymentStateChecker.java:165)
	at weblogic.deploy.internal.targetserver.AppContainerInvoker.activate(AppContainerInvoker.java:80)
	at weblogic.deploy.internal.targetserver.BasicDeployment.activate(BasicDeployment.java:226)
	at weblogic.deploy.internal.targetserver.BasicDeployment.activateFromServerLifecycle(BasicDeployment.java:418)
	at weblogic.management.deploy.internal.DeploymentAdapter$1.doActivate(DeploymentAdapter.java:51)
	at weblogic.management.deploy.internal.DeploymentAdapter.activate(DeploymentAdapter.java:200)
	at weblogic.management.deploy.internal.AppTransition$2.transitionApp(AppTransition.java:30)
	at weblogic.management.deploy.internal.ConfiguredDeployments.transitionApps(ConfiguredDeployments.java:240)
	at weblogic.management.deploy.internal.ConfiguredDeployments.activate(ConfiguredDeployments.java:169)
	at weblogic.management.deploy.internal.ConfiguredDeployments.deploy(ConfiguredDeployments.java:123)
	at weblogic.management.deploy.internal.DeploymentServerService.resume(DeploymentServerService.java:210)
	at weblogic.management.deploy.internal.DeploymentServerService.start(DeploymentServerService.java:118)
	at weblogic.server.AbstractServerService.postConstruct(AbstractServerService.java:78)
	at sun.reflect.GeneratedMethodAccessor5.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:606)
	at org.glassfish.hk2.utilities.reflection.ReflectionHelper.invoke(ReflectionHelper.java:1017)
	at org.jvnet.hk2.internal.ClazzCreator.postConstructMe(ClazzCreator.java:388)
	at org.jvnet.hk2.internal.ClazzCreator.create(ClazzCreator.java:430)
	at org.jvnet.hk2.internal.SystemDescriptor.create(SystemDescriptor.java:456)
	at org.glassfish.hk2.runlevel.internal.AsyncRunLevelContext.findOrCreate(AsyncRunLevelContext.java:225)
	at org.glassfish.hk2.runlevel.RunLevelContext.findOrCreate(RunLevelContext.java:82)
	at org.jvnet.hk2.internal.Utilities.createService(Utilities.java:2488)
	at org.jvnet.hk2.internal.ServiceHandleImpl.getService(ServiceHandleImpl.java:98)
	at org.jvnet.hk2.internal.ServiceLocatorImpl.getService(ServiceLocatorImpl.java:606)
	at org.jvnet.hk2.internal.ThreeThirtyResolver.resolve(ThreeThirtyResolver.java:77)
	at org.jvnet.hk2.internal.ClazzCreator.resolve(ClazzCreator.java:231)
	at org.jvnet.hk2.internal.ClazzCreator.resolveAllDependencies(ClazzCreator.java:254)
	at org.jvnet.hk2.internal.ClazzCreator.create(ClazzCreator.java:413)
	at org.jvnet.hk2.internal.SystemDescriptor.create(SystemDescriptor.java:456)
	at org.glassfish.hk2.runlevel.internal.AsyncRunLevelContext.findOrCreate(AsyncRunLevelContext.java:225)
	at org.glassfish.hk2.runlevel.RunLevelContext.findOrCreate(RunLevelContext.java:82)
	at org.jvnet.hk2.internal.Utilities.createService(Utilities.java:2488)
	at org.jvnet.hk2.internal.ServiceHandleImpl.getService(ServiceHandleImpl.java:98)
	at org.jvnet.hk2.internal.ServiceLocatorImpl.getService(ServiceLocatorImpl.java:606)
	at org.jvnet.hk2.internal.ThreeThirtyResolver.resolve(ThreeThirtyResolver.java:77)
	at org.jvnet.hk2.internal.ClazzCreator.resolve(ClazzCreator.java:231)
	at org.jvnet.hk2.internal.ClazzCreator.resolveAllDependencies(ClazzCreator.java:254)
	at org.jvnet.hk2.internal.ClazzCreator.create(ClazzCreator.java:413)
	at org.jvnet.hk2.internal.SystemDescriptor.create(SystemDescriptor.java:456)
	at org.glassfish.hk2.runlevel.internal.AsyncRunLevelContext.findOrCreate(AsyncRunLevelContext.java:225)
	at org.glassfish.hk2.runlevel.RunLevelContext.findOrCreate(RunLevelContext.java:82)
	at org.jvnet.hk2.internal.Utilities.createService(Utilities.java:2488)
	at org.jvnet.hk2.internal.ServiceHandleImpl.getService(ServiceHandleImpl.java:98)
	at org.jvnet.hk2.internal.ServiceHandleImpl.getService(ServiceHandleImpl.java:87)
	at org.glassfish.hk2.runlevel.internal.CurrentTaskFuture$QueueRunner.oneJob(CurrentTaskFuture.java:1162)
	at org.glassfish.hk2.runlevel.internal.CurrentTaskFuture$QueueRunner.run(CurrentTaskFuture.java:1147)
	at org.glassfish.hk2.runlevel.internal.CurrentTaskFuture$UpOneLevel.run(CurrentTaskFuture.java:753)
	at weblogic.work.SelfTuningWorkManagerImpl$WorkAdapterImpl.run(SelfTuningWorkManagerImpl.java:548)
	at weblogic.work.ExecuteThread.execute(ExecuteThread.java:311)
	at weblogic.work.ExecuteThread.run(ExecuteThread.java:263)
Caused by: java.lang.NullPointerException
	at psdi.mbo.MaximoDD.getTablesFromHierarchyList(MaximoDD.java:1666)
	at psdi.mbo.MaximoDD.loadMboSetsInfo(MaximoDD.java:1334)
	at psdi.mbo.MaximoDD.loadMboSetsInfo(MaximoDD.java:1148)
	at psdi.mbo.MaximoDD.loadDataDictionary(MaximoDD.java:635)
	at psdi.mbo.MaximoDD.init(MaximoDD.java:234)
	... 89 more
```
