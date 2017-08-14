# maximo 一个新创建的表,在使用表时,在表中新建数据时错误  

```
psdi.util.MXApplicationException: BMXAA7094E - 所输入的值 LYDC 无效。请输入有效的整数值。
 at psdi.util.MXFormat.stringToLong(MXFormat.java:176)
 at psdi.util.MaxType.setValue(MaxType.java:448)
 at psdi.mbo.MboValue._setValue(MboValue.java:1142)
 at psdi.mbo.MboValue.setValue(MboValue.java:1052)
 at psdi.mbo.Mbo.setValue(Mbo.java:1975)
 at psdi.mbo.Mbo.setDefaultSiteOrgSetValues(Mbo.java:4333)
 at psdi.mbo.MboSet.addAtIndex(MboSet.java:3992)
 at psdi.mbo.MboSet.add(MboSet.java:3914)
 at psdi.mbo.MboSet.add(MboSet.java:3796)
 at psdi.webclient.system.beans.DataBean.insert(DataBean.java:3038)
 at psdi.webclient.system.beans.AppBean.insert(AppBean.java:1002)
 at psdi.webclient.system.beans.AppBean.INSERT(AppBean.java:1022)
 at jrockit.reflect.VirtualNativeMethodInvoker.invoke(Ljava.lang.Object;[Ljava.lang.Object;)Ljava.lang.Object;(Unknown Source)
 at java.lang.reflect.Method.invoke(Ljava.lang.Object;[Ljava.lang.Object;I)Ljava.lang.Object;(Unknown Source)
 at psdi.webclient.system.session.WebClientSession.defaultHandler(WebClientSession.java:951)
 at psdi.webclient.system.session.WebClientSession.handleEvent(WebClientSession.java:845)
 at psdi.webclient.system.session.WebClientSession.handleRequest(WebClientSession.java:503)
 at psdi.webclient.system.controller.RequestManager.manageRequest(RequestManager.java:83)
 at psdi.webclient.servlet.WebClientServlet.handleRequest(WebClientServlet.java:131)
 at psdi.webclient.servlet.WebClientServlet.doPost(WebClientServlet.java:45)
 at javax.servlet.http.HttpServlet.service(HttpServlet.java:763)
 at javax.servlet.http.HttpServlet.service(HttpServlet.java:856)
 at weblogic.servlet.internal.StubSecurityHelper$ServletServiceAction.run(StubSecurityHelper.java:225)
 at weblogic.servlet.internal.StubSecurityHelper.invokeServlet(StubSecurityHelper.java:127)
 at weblogic.servlet.internal.ServletStubImpl.execute(ServletStubImpl.java:230)
 at weblogic.servlet.internal.TailFilter.doFilter(TailFilter.java:26)
 at weblogic.servlet.internal.FilterChainImpl.doFilter(FilterChainImpl.java:42)
 at com.shuto.jingqiao.RtxAccessFilter.doFilterInternal(RtxAccessFilter.java:57)
 at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:76)
 at weblogic.servlet.internal.FilterChainImpl.doFilter(FilterChainImpl.java:42)
```
在数据库配置中该表对象当时是设置为SITE(站点)级别
<br />
解决方案:
<br />
把属性中的SITEID的"等同对象"设为'SITE',把"与属性相同"改为'SITEID'
<br />
把属性中的ORGID的"等同对象"设为'ORG',把"与属性相同"改为'ORGID'
