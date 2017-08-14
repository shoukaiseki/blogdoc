# maximo工具栏工作流图标丢失  

前几天碰到个费解的问题,进入询价单时,点击保存发送工作流图标丢失
<br />
当时该问题只存在我同事本机的测试库和现在正式库中,而我在用的测试库却没有问题,这就纳闷了,然而我用我的测试库连同事的数据库,问题依旧,感觉代码不会有问题,应该是数据库内部某些配置出问题了


那就从头开查吧,先从jsp下手

#### toolbarbutton.jsp  中输出信息,发现询价单应用中工具栏按钮都少了 发送工作流的按钮
```Java
		String itemText = control.getProperty("text");
		String itemValue = control.getProperty("key");
		String itemPos = control.getProperty("position");
		String itemSubpos = control.getProperty("subposition");
		String itemActionKey = control.getProperty("accesskey");
		String type = control.getProperty("elementtype");
		String url = control.getProperty("url");
		String image = control.getProperty("image");
		String text = control.getProperty("text");
		String mxevent = control.getProperty("mxevent");
			System.out.print("key="+itemValue+",text="+itemText);
			System.out.print(",position="+itemPos+",subposition="+itemSubpos);
			System.out.print(",accesskey="+itemActionKey+",elementtype="+type);
			System.out.print(",url="+url+",image="+image);
			System.out.print(",text="+text+",mxevent="+mxevent);
			System.out.println();

```

那就查了下图标是怎么来的,查找到了两个相关的类,最后代码中的两个类(psdi.webclient.controls.DynamicToolbar和psdi.workflow.virtual.WFToolBarSet) 查出了因为appname获取为空,则无法正常执行
<br />
既然是获取不到appname,那么我就在appbean中的SAVE()中测试了下

#### com.shuto.mam.webclient.beans.rfq.FYRFQAppBean 类中方法
```Java
  public int SAVE() throws MXException, RemoteException {	 
          System.out.println("appname="+appName);//获取到的为空	  System.out.println("appname="+app.getApp());//获取到正确的名称 RFQ
    return super.SAVE();
  }
```


那么问题就简单了,找下appName是怎么赋值的就明白了,是在AppBean.initialize()方法中赋值的
<br />
找了下原来是在这里面获取了Mbo,没有判断空指针
<br />
我就无语了,2014年改动后应该就存在的问题,现在都快2016年了,才有人提起
<br />
最后回想了一下,我在我的测试库中因为设置了默认保存查询,所以进入应用时不会出现

```Java
  protected void initialize()
    throws MXException, RemoteException
  {
		
    MboRemote thisMbo = getMbo();
    String status = thisMbo.getString("status");

		// 2014-03-26 新增只在填写报价单状态QBBECAUSE （签报说明）可填
    if (status.equals("填写报价单")) {
      thisMbo.setFieldFlag("QBBECAUSE", 7L, false);
      thisMbo.setFieldFlag("QBBECAUSE", 11L, true);
    } else {
      thisMbo.setFieldFlag("QBBECAUSE", 7L, true);
      thisMbo.setFieldFlag("QBBECAUSE", 11L, false);
    }
    super.initialize();
  }

```






#### psdi.webclient.controls.DynamicToolbar 类中方法

```Java
	private MboSetData getToolbarDefinitionFromNonpersistentSet()
	{
		try
		{
			String npMboName = getProperty("npmboname");

			if (!WebClientRuntime.isNull(npMboName))
			{
				
				String[] attributes = { keyAttribute, "toolbaricon", "description", "toolbarlocation", "toolbarsequence" };
				MboSetRemote mboSetRemote = null;

				MboRemote mboRemote = getPage().getAppInstance().getAppBean().getMbo();
				if (mboRemote != null)
				{
					mboSetRemote = mboRemote.getMboSet(npMboName);
				}

				if (mboSetRemote != null)
				{
					mboSetRemote.setQbeExactMatch(true);
					System.out.println("mboname="+mboRemote.getName());
//					System.out.println("keyAttribute="+keyAttribute);
					
					
					MboValueInfoStatic mboStatic = mboSetRemote.getMboValueInfoStatic(keyAttribute);
//					System.out.println("mboStatic="+mboStatic);
					if (mboStatic != null)
					{
						
						System.out.println("npMboName333="+npMboName);
						MboSetData mboSetData = mboSetRemote.getMboSetData(0, 50, attributes);
						//经测试,无工作流图标时未获取有效数据
						System.out.println("count="+mboSetRemote.count());
						
						for(MboData mbodata:mboSetData.getMboData()){
							for (String string : attributes) {
								MboValueData mvd = mbodata.getMboValueData(string);
//								System.out.print(string+"="+mvd.getData()+"\t");
							}
//							System.out.println();
						}
						mboSetData = mboSetRemote.getMboSetData(0, 50, attributes);
						return mboSetData;
					}


					System.out.println("Invalid keyattribute: '" + keyAttribute + "' specified in control:" + getId());
				}
			}
		}
		catch (Exception e) {}



		return null;
	}
```


#### psdi.workflow.virtual.WFToolBarSet 类中方法


```Java

   public MboRemote getMbo(int index)
     throws MXException, RemoteException
   {
     MXLogger log = ((WorkFlowServiceRemote)MXServer.getMXServer().lookup("WORKFLOW")).getWFLogger();
     log.debug("WFToolBarSet: getMbo(index =" + index + "), setBuilt = " + setBuilt);
     
     System.out.println("*********************WFToolBarSet.getMbo("+index+") setBuilt="+setBuilt);
     
     if (!setBuilt)
     {
       buildSet();
     }
     
     return super.getMbo(index);
   }
   
 
   public void reset()
     throws MXException, RemoteException
   {
     MXLogger log = ((WorkFlowServiceRemote)MXServer.getMXServer().lookup("WORKFLOW")).getWFLogger();
     log.debug("WFToolBarSet: reset ");
     setBuilt = false;
     super.reset();
   }
   
 
 
 
   private void buildSet()
     throws MXException, RemoteException
   {
     System.out.println("buildSet");
     setBuilt = true;
     MboRemote owner = getOwner();
     
     String app = owner.getThisMboSet().getApp();
     MXLogger log = ((WorkFlowServiceRemote)MXServer.getMXServer().lookup("WORKFLOW")).getWFLogger();
     log.debug("WFToolBarSet: app is " + app);
     
 
 
     System.out.println("buildSet1111");
     SqlFormat sqf = new SqlFormat(owner, "appname = :1");
     //经测试,无工作流图标时,输出app为空
     System.out.println("buildSet2222");
     System.out.println("app="+app);
     sqf.setObject(1, "WFAPPTOOLBAR", "APPNAME", app);
     System.out.println("buildSet2222aaa");
     MboSetRemote appButtons = owner.getMboSet("$APPBUTTONS", "WFAPPTOOLBAR", sqf.format());
     System.out.println("buildSet3333");
     appButtons.setOrderBy("TOOLBARSEQUENCE");
     
     System.out.println("sqf="+sqf.format());
     
//     if(true)
//    	 throw new MXApplicationException("", "asussss");
 
 
     ProfileRemote p = getMboServer().getProfile(getUserInfo());
     if (p.sysLevelApp(app))
     {
       if (p.getAppOptionAuth(app, "ROUTEWF", null)) {}
 
 
 
 
     }
     else if (p.siteLevelApp(app))
     {
       if (p.getAppOptionAuth(app, "ROUTEWF", owner.getString("siteid"))) {}
 
 
 
 
     }
     else if (!p.getAppOptionAuth(app, "ROUTEWF", owner.getString("orgid")))
     {
       return;
     }
     
 
     MboSetEnumeration mse = new MboSetEnumeration(appButtons);
     while (mse.hasMoreElements())
     {
       log.debug("WFToolBarSet: adding a button");
       MboRemote appToolbarButton = mse.nextMbo();
       MboRemote toolbarButton = addAtEnd();
       toolbarButton.setValue("PROCESSNAME", appToolbarButton.getString("PROCESSNAME"), 2L);
       log.debug("WFToolBarSet: processname is " + appToolbarButton.getString("PROCESSNAME"));
       toolbarButton.setValue("TOOLBARLOCATION", appToolbarButton.getString("TOOLBARLOCATION"), 2L);
       log.debug("WFToolBarSet: toolbarlocation is " + appToolbarButton.getString("TOOLBARLOCATION"));
       
       toolbarButton.setValue("ICON", appToolbarButton.getString("TOOLBARICON"), 2L);
       toolbarButton.setValue("TOOLBARICON", appToolbarButton.getString("TOOLBARICON"), 2L);
       toolbarButton.setValue("ACTIVEICON", appToolbarButton.getString("TOOLBARICONACTIVE"), 2L);
       
       if (toolbarButton.isNull("PROCESSNAME"))
       {
         generalButton = toolbarButton;
       }
       else
       {
         processButtonMap.put(toolbarButton.getString("PROCESSNAME"), toolbarButton);
       }
       
       toolbarButton.setValue("TOOLBARSEQUENCE", appToolbarButton.getString("TOOLBARSEQUENCE"), 2L);
       log.debug("WFToolBarSet: sequence is " + appToolbarButton.getString("TOOLBARSEQUENCE"));
       toolbarButton.setValue("DESCRIPTION", appToolbarButton.getString("DESCRIPTION"), 2L);
       log.debug("WFToolBarSet: description is " + appToolbarButton.getString("DESCRIPTION"));
     }
     
     log.debug("WFToolBarSet: get active processes on current Mbo");
     
     SqlFormat sqfActive = null;
     
     sqfActive = new SqlFormat(owner, "active = :yes and ownertable = :1 and ownerid = :2");
     sqfActive.setObject(1, "WFINSTANCE", "OWNERTABLE", owner.getName());
     sqfActive.setLong(2, owner.getUniqueIDValue());
     MboSetRemote activeOnOwner = owner.getMboSet("$PROCESSACTIVE", "WFINSTANCE", sqfActive.format());
     MboSetEnumeration actives = new MboSetEnumeration(activeOnOwner);
     while (actives.hasMoreElements())
     {
       updateProcessStatus(actives.nextMbo().getString("PROCESSNAME"), true);
     }
     
     log.debug("WFToolBarSet: done building set");
     
     close();
   }
   
```
 
