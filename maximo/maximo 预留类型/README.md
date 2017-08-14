# maximo 预留类型  

```
APSOFT   自动软预留
APHARD   自动硬预留
```
工单的预留自动作用为是根据物料行中的需求日期判断,比如今日为 2015-12-08,你的需求日期填写为2015-12-12,那么今日工单批准后,预留类型是为 APSOFT,当到了2015-12-12之后后台有个定时任务 psdi.app.inventory.InvReservationResTypeUpdateCronTask 会将到需求时间点的预留物资的预留类型改为 APHARD

自动软预留来源与在工单中新建物料时,由 psdi.app.workorder.WPMaterial 中的 add() 方法自动设置

```Java
setValue("restype", getTranslator().toExternalDefaultValue("DISPLAYRESTYPE", "AUTOMATIC", this), ,MboConstants.NOACCESSCHECK);//获取SYNONYMDOMAIN内部值为AUTOMATIC 对应 siteid的默认值

```
所以即使你将
<br />
WORKORDER 物料子表 WPMATERIAL.REQUIREDATE 默认值设置为"软"也是无效果的,
<br />
写个Mbo和MboSet等类继承它就OK了

```Java
	@Override
	public void add() throws MXException, RemoteException {
		// TODO Auto-generated method stub
		super.add();
		setValue("restype",getTranslator().toExternalDefaultValue("DISPLAYRESTYPE", "SOFT", this),MboConstants.NOACCESSCHECK);
	}
```

