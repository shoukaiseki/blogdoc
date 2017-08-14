# maximo 发票错误 BMXAA2013E BMXAA1974E 不能批准发票  


变更发票状态已批准时候出现以下错误 
```
        BMXAA1974E 不能批准发票 {0} ，因为出现预料之外的错误。 请将服务器的堆栈跟踪日志发送给支持人员。
```
该错误来源出自 throw new MXApplicationException("invoice", "InvoiceApproval");  
<br />
是在 psdi.app.invoice.Invoice 类中的 validateForApproval() 方法 和 approve() 方法中抛出错误,
<br />
这个情况可以在maximo.ear/properties/logging.properties 日志配置文件中添加以下信息
```Properties
  log4j.logger.maximo.application.INVOICE=DEBUG  
```

重启服务后发现日志如下
```
19 八月 2015 10:46:08:177 [DEBUG] InvoiceStatusHandler::changeStatus()
19 八月 2015 10:46:08:179 [DEBUG] InvoiceStatusHandler::approve()
```
 在 InvoiceStatusHandler 类中了 approve() 方法中看到调用的是 Invoice.validateForApproval()方法,然后我们反编译 Invoice类,修改该方法
```
    	e.printStackTrace();//添加打印日志输出
      throw new MXApplicationException("invoice", "InvoiceApproval"); 
```

把类替换原有的系统类(主要备份系统原有类),然后重启服务再做操作,可以看到日志如下
```
19 八月 2015 10:56:00:732 [DEBUG] InvoiceStatusHandler::changeStatus()
19 八月 2015 10:56:00:740 [DEBUG] InvoiceStatusHandler::approve()
java.lang.ArrayIndexOutOfBoundsException: 1 >= 0
	at java.util.Vector.elementAt(Vector.java:427)
	at psdi.app.invoice.Invoice.setFinancialPeriod(Invoice.java:3266)
	at psdi.app.invoice.Invoice.validateForApproval(Invoice.java:393)
	at psdi.app.invoice.InvoiceStatusHandler.approve(InvoiceStatusHandler.java:450)
	at psdi.app.invoice.InvoiceStatusHandler.changeStatus(InvoiceStatusHandler.java:373)
```

经过查看,setFinancialPeriod()方法中有这两句
```Java
 FinancialServiceRemote finService = (FinancialServiceRemote)MXServer.getMXServer().lookup("FINANCIAL");
Vector fpVector = finService.getActiveFinancialPeriodInfo(getUserInfo(), getDate("glpostdate"), getString("orgid"));
```
由此可以发现原因是没有找到发票中  glpostdate(G/L 发布日期)字段 对应的财务周期条目

解决方法如下:进入" 科目表"应用,选中指定地点的行,"选择操作"->"财务周期", 添加一个财务周期 时间设置为 2010年-2088年1条就可以,具体按照需求进行
 
 
