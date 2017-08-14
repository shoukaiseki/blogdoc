# Maximo输入密码后登录错误  

```
12 十二月 2011 01:51:55:257 [INFO] BMXAA6719I - 用户 =（MAXADMIN）SPID =（132应
用程序（null）对象（MAXPRESENTATION）：select * from maxpresentation  where (app
 = 'LOOKUPS')
org.xml.sax.SAXParseException: The element type "systemlib" must be terminated b
y the matching end-tag "</systemlib>".
        at org.apache.xerces.framework.XMLParser.reportError(XMLParser.java:1213
)
        at org.apache.xerces.framework.XMLDocumentScanner.reportFatalXMLError(XM
LDocumentScanner.java:579)
        at org.apache.xerces.framework.XMLDocumentScanner.abortMarkup(XMLDocumen
tScanner.java:628)
        at org.apache.xerces.framework.XMLDocumentScanner$ContentDispatcher.disp
atch(XMLDocumentScanner.java:1136)
        at org.apache.xerces.framework.XMLDocumentScanner.parseSome(XMLDocumentS
canner.java:381)
        at org.apache.xerces.framework.XMLParser.parse(XMLParser.java:1098)
        at psdi.webclient.system.runtime.WebClientRuntime.loadDOM(WebClientRunti
me.java:240)
        at psdi.webclient.system.runtime.AppDescriptor.parseXML(AppDescriptor.ja
va:145)
        at psdi.webclient.system.runtime.LibraryDescriptor.<init>(LibraryDescrip
tor.java:47)
        at psdi.webclient.system.runtime.WebClientRuntime.getLibraryDescriptor(W
ebClientRuntime.java:498)
        at psdi.webclient.system.runtime.WebClientRuntime.getAppDescriptor(WebCl
ientRuntime.java:382)
        at psdi.webclient.system.controller.SystemEventHandler.instantiateapp(Sy
stemEventHandler.java:428)
        at psdi.webclient.system.controller.SystemEventHandler.loadapp(SystemEve
ntHandler.java:217)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.
java:39)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAcces
sorImpl.java:25)
        at java.lang.reflect.Method.invoke(Method.java:585)
        at psdi.webclient.system.controller.BaseInstance.handleEvent(BaseInstanc
e.java:376)
        at psdi.webclient.system.controller.BaseInstance.handleEvent(BaseInstanc
e.java:364)
        at psdi.webclient.system.session.WebClientSession.handleEvent(WebClientS
ession.java:798)
        at psdi.webclient.system.session.WebClientSession.handleRequest(WebClien
tSession.java:503)
        at psdi.webclient.system.controller.RequestManager.manageRequest(Request
Manager.java:83)
        at psdi.webclient.servlet.WebClientServlet.handleRequest(WebClientServle
t.java:131)
        at psdi.webclient.servlet.WebClientServlet.doPost(WebClientServlet.java:
45)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:763)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:856)
        at weblogic.servlet.internal.StubSecurityHelper$ServletServiceAction.run
(StubSecurityHelper.java:225)
        at weblogic.servlet.internal.StubSecurityHelper.invokeServlet(StubSecuri
tyHelper.java:127)
        at weblogic.servlet.internal.ServletStubImpl.execute(ServletStubImpl.jav
a:283)
        at weblogic.servlet.internal.TailFilter.doFilter(TailFilter.java:26)
        at weblogic.servlet.internal.FilterChainImpl.doFilter(FilterChainImpl.ja
va:42)
        at com.shuto.jingqiao.RtxAccessFilter.doFilterInternal(RtxAccessFilter.j
ava:57)
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerR
equestFilter.java:76)
        at weblogic.servlet.internal.FilterChainImpl.doFilter(FilterChainImpl.ja
va:42)
        at weblogic.servlet.internal.WebAppServletContext$ServletInvocationActio
n.run(WebAppServletContext.java:3212)
        at weblogic.security.acl.internal.AuthenticatedSubject.doAs(Authenticate
dSubject.java:321)
        at weblogic.security.service.SecurityManager.runAs(SecurityManager.java:
121)
        at weblogic.servlet.internal.WebAppServletContext.securedExecute(WebAppS
ervletContext.java:1983)
        at weblogic.servlet.internal.WebAppServletContext.execute(WebAppServletC
ontext.java:1890)
        at weblogic.servlet.internal.ServletRequestImpl.run(ServletRequestImpl.j
ava:1344)
        at weblogic.work.ExecuteThread.execute(ExecuteThread.java:209)
        at weblogic.work.ExecuteThread.run(ExecuteThread.java:181)
java.lang.NullPointerException
        at psdi.webclient.system.runtime.AppDescriptor.parseXML(AppDescriptor.ja
va:145)
        at psdi.webclient.system.runtime.LibraryDescriptor.<init>(LibraryDescrip
tor.java:47)
        at psdi.webclient.system.runtime.WebClientRuntime.getLibraryDescriptor(W
ebClientRuntime.java:498)
        at psdi.webclient.system.runtime.WebClientRuntime.getAppDescriptor(WebCl
ientRuntime.java:382)
        at psdi.webclient.system.controller.SystemEventHandler.instantiateapp(Sy
stemEventHandler.java:428)
        at psdi.webclient.system.controller.SystemEventHandler.loadapp(SystemEve
ntHandler.java:217)
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.
java:39)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAcces
sorImpl.java:25)
        at java.lang.reflect.Method.invoke(Method.java:585)
        at psdi.webclient.system.controller.BaseInstance.handleEvent(BaseInstanc
e.java:376)
        at psdi.webclient.system.controller.BaseInstance.handleEvent(BaseInstanc
e.java:364)
        at psdi.webclient.system.session.WebClientSession.handleEvent(WebClientS
ession.java:798)
        at psdi.webclient.system.session.WebClientSession.handleRequest(WebClien
tSession.java:503)
        at psdi.webclient.system.controller.RequestManager.manageRequest(Request
Manager.java:83)
        at psdi.webclient.servlet.WebClientServlet.handleRequest(WebClientServle
t.java:131)
        at psdi.webclient.servlet.WebClientServlet.doPost(WebClientServlet.java:
45)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:763)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:856)
        at weblogic.servlet.internal.StubSecurityHelper$ServletServiceAction.run
(StubSecurityHelper.java:225)
        at weblogic.servlet.internal.StubSecurityHelper.invokeServlet(StubSecuri
tyHelper.java:127)
        at weblogic.servlet.internal.ServletStubImpl.execute(ServletStubImpl.jav
a:283)
        at weblogic.servlet.internal.TailFilter.doFilter(TailFilter.java:26)
        at weblogic.servlet.internal.FilterChainImpl.doFilter(FilterChainImpl.ja
va:42)
        at com.shuto.jingqiao.RtxAccessFilter.doFilterInternal(RtxAccessFilter.j
ava:57)
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerR
equestFilter.java:76)
        at weblogic.servlet.internal.FilterChainImpl.doFilter(FilterChainImpl.ja
va:42)
        at weblogic.servlet.internal.WebAppServletContext$ServletInvocationActio
n.run(WebAppServletContext.java:3212)
        at weblogic.security.acl.internal.AuthenticatedSubject.doAs(Authenticate
dSubject.java:321)
        at weblogic.security.service.SecurityManager.runAs(SecurityManager.java:
121)
        at weblogic.servlet.internal.WebAppServletContext.securedExecute(WebAppS
ervletContext.java:1983)
        at weblogic.servlet.internal.WebAppServletContext.execute(WebAppServletC
ontext.java:1890)
        at weblogic.servlet.internal.ServletRequestImpl.run(ServletRequestImpl.j
ava:1344)
        at weblogic.work.ExecuteThread.execute(ExecuteThread.java:209)
        at weblogic.work.ExecuteThread.run(ExecuteThread.java:181)
java.lang.reflect.InvocationTargetException
        at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
        at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.
java:39)
        at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAcces
sorImpl.java:25)
        at java.lang.reflect.Method.invoke(Method.java:585)
        at psdi.webclient.system.controller.BaseInstance.handleEvent(BaseInstanc
e.java:376)
        at psdi.webclient.system.controller.BaseInstance.handleEvent(BaseInstanc
e.java:364)
        at psdi.webclient.system.session.WebClientSession.handleEvent(WebClientS
ession.java:798)
        at psdi.webclient.system.session.WebClientSession.handleRequest(WebClien
tSession.java:503)
        at psdi.webclient.system.controller.RequestManager.manageRequest(Request
Manager.java:83)
        at psdi.webclient.servlet.WebClientServlet.handleRequest(WebClientServle
t.java:131)
        at psdi.webclient.servlet.WebClientServlet.doPost(WebClientServlet.java:
45)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:763)
        at javax.servlet.http.HttpServlet.service(HttpServlet.java:856)
        at weblogic.servlet.internal.StubSecurityHelper$ServletServiceAction.run
(StubSecurityHelper.java:225)
        at weblogic.servlet.internal.StubSecurityHelper.invokeServlet(StubSecuri
tyHelper.java:127)
        at weblogic.servlet.internal.ServletStubImpl.execute(ServletStubImpl.jav
a:283)
        at weblogic.servlet.internal.TailFilter.doFilter(TailFilter.java:26)
        at weblogic.servlet.internal.FilterChainImpl.doFilter(FilterChainImpl.ja
va:42)
        at com.shuto.jingqiao.RtxAccessFilter.doFilterInternal(RtxAccessFilter.j
ava:57)
        at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerR
equestFilter.java:76)
        at weblogic.servlet.internal.FilterChainImpl.doFilter(FilterChainImpl.ja
va:42)
        at weblogic.servlet.internal.WebAppServletContext$ServletInvocationActio
n.run(WebAppServletContext.java:3212)
        at weblogic.security.acl.internal.AuthenticatedSubject.doAs(Authenticate
dSubject.java:321)
        at weblogic.security.service.SecurityManager.runAs(SecurityManager.java:
121)
        at weblogic.servlet.internal.WebAppServletContext.securedExecute(WebAppS
ervletContext.java:1983)
        at weblogic.servlet.internal.WebAppServletContext.execute(WebAppServletC
ontext.java:1890)
        at weblogic.servlet.internal.ServletRequestImpl.run(ServletRequestImpl.j
ava:1344)
        at weblogic.work.ExecuteThread.execute(ExecuteThread.java:209)
        at weblogic.work.ExecuteThread.run(ExecuteThread.java:181)
Caused by: java.lang.NullPointerException
        at psdi.webclient.system.runtime.AppDescriptor.createPageIndex(AppDescri
ptor.java:248)
        at psdi.webclient.system.runtime.LibraryDescriptor.<init>(LibraryDescrip
tor.java:52)
        at psdi.webclient.system.runtime.WebClientRuntime.getLibraryDescriptor(W
ebClientRuntime.java:498)
        at psdi.webclient.system.runtime.WebClientRuntime.getAppDescriptor(WebCl
ientRuntime.java:382)
        at psdi.webclient.system.controller.SystemEventHandler.instantiateapp(Sy
stemEventHandler.java:428)
        at psdi.webclient.system.controller.SystemEventHandler.loadapp(SystemEve
ntHandler.java:217)
        ... 29 more
Request Parameter Key password = admin
Request Parameter Key allowinsubframe = false
Request Parameter Key login = jsp
Request Parameter Key username = maxadmin
Request Parameter Key loginstamp = 1323654713044
DEBUG:
******
******
NOTHING HANDLED EVENT:  loadapp, target=null, value=startcntr


 ::
```

问题出现前的操作:最后定在该处
 select * from maxpresentation where app  in('LOOKUPS') for  update
多了一个</table>导致的,删除掉这个多余的,然后重启,问题解决
