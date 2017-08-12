# ubuntu mate 中 eclipse 的 explorer 插件无法正常使用  

安装 nautilus 目录管理器
sudo apt-get install nautilus

问题处理方案：
先把 eclipse 关了，打开终端
ALT +F2 运行 mate-terminal
再在 终端运行eclipse
eclipse运行后点击项目右键 选择 open in explorer 
就能发现终端有以下错误，就能够它是看到调用了 nautilus 命令打开对应目录的
```
(Eclipse:14100): Gtk-WARNING **: Allocating size to GtkBox 0x7f2616ee82c0 without calling gtk_widget_get_preferred_width/height(). How does the code know the size to allocate?
java.io.IOException: Cannot run program "nautilus": error=2, 没有那个文件或目录
	at java.lang.ProcessBuilder.start(ProcessBuilder.java:1048)
	at java.lang.Runtime.exec(Runtime.java:620)
	at java.lang.Runtime.exec(Runtime.java:450)
	at java.lang.Runtime.exec(Runtime.java:347)
	at cn.ieclipse.pde.explorer.ExplorerPlugin.explorer(ExplorerPlugin.java:185)
	at cn.ieclipse.pde.explorer.handlers.OpenExplorerHandler.execute(OpenExplorerHandler.java:103)
	at org.eclipse.ui.internal.handlers.HandlerProxy.execute(HandlerProxy.java:295)
	at org.eclipse.ui.internal.handlers.E4HandlerProxy.execute(E4HandlerProxy.java:90)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.eclipse.e4.core.internal.di.MethodRequestor.execute(MethodRequestor.java:55)
	at org.eclipse.e4.core.internal.di.InjectorImpl.invokeUsingClass(InjectorImpl.java:282)
	at org.eclipse.e4.core.internal.di.InjectorImpl.invoke(InjectorImpl.java:264)
	at org.eclipse.e4.core.contexts.ContextInjectionFactory.invoke(ContextInjectionFactory.java:132)
	at org.eclipse.e4.core.commands.internal.HandlerServiceHandler.execute(HandlerServiceHandler.java:152)
	at org.eclipse.core.commands.Command.executeWithChecks(Command.java:494)
	at org.eclipse.core.commands.ParameterizedCommand.executeWithChecks(ParameterizedCommand.java:488)
	at org.eclipse.e4.core.commands.internal.HandlerServiceImpl.executeHandler(HandlerServiceImpl.java:210)
	at org.eclipse.e4.ui.workbench.renderers.swt.HandledContributionItem.executeItem(HandledContributionItem.java:433)
	at org.eclipse.e4.ui.workbench.renderers.swt.AbstractContributionItem.handleWidgetSelection(AbstractContributionItem.java:454)
	at org.eclipse.e4.ui.workbench.renderers.swt.AbstractContributionItem$3.handleEvent(AbstractContributionItem.java:482)
	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
	at org.eclipse.swt.widgets.Display.sendEvent(Display.java:5227)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1340)
	at org.eclipse.swt.widgets.Display.runDeferredEvents(Display.java:4561)
	at org.eclipse.swt.widgets.Display.readAndDispatch(Display.java:4151)
	at org.eclipse.e4.ui.internal.workbench.swt.PartRenderingEngine$4.run(PartRenderingEngine.java:1121)
	at org.eclipse.core.databinding.observable.Realm.runWithDefault(Realm.java:336)
	at org.eclipse.e4.ui.internal.workbench.swt.PartRenderingEngine.run(PartRenderingEngine.java:1022)
	at org.eclipse.e4.ui.internal.workbench.E4Workbench.createAndRunUI(E4Workbench.java:150)
	at org.eclipse.ui.internal.Workbench$5.run(Workbench.java:693)
	at org.eclipse.core.databinding.observable.Realm.runWithDefault(Realm.java:336)
	at org.eclipse.ui.internal.Workbench.createAndRunWorkbench(Workbench.java:610)
	at org.eclipse.ui.PlatformUI.createAndRunWorkbench(PlatformUI.java:148)
	at org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication.java:138)
	at org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:196)
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(EclipseAppLauncher.java:134)
	at org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAppLauncher.java:104)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:388)
	at org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:243)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:673)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:610)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1519)
	at org.eclipse.equinox.launcher.Main.main(Main.java:1492)
Caused by: java.io.IOException: error=2, 没有那个文件或目录
	at java.lang.UNIXProcess.forkAndExec(Native Method)
	at java.lang.UNIXProcess.<init>(UNIXProcess.java:247)
	at java.lang.ProcessImpl.start(ProcessImpl.java:134)
	at java.lang.ProcessBuilder.start(ProcessBuilder.java:1029)
	... 49 more

```


