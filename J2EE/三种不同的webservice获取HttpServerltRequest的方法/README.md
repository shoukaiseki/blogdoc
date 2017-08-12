# 三种不同的webservice获取HttpServerltRequest的方法

转自  http://blog.csdn.net/u013262276/article/details/50956146

##一. 基于xfire实现的WebService
```
HttpServletRequest request = XFireServletController.getRequest();
```

##二. 基于axis实现的WebService
```
MessageContext mc = MessageContext.getCurrentMessageContext();
HttpServletRequest request = (HttpServletRequest)mc.getProperty(HTTPConstants.MC_HTTP_SERVLETREQUEST);
```

##三. 基于jax-ws实现的WebService
```
@Resource
private WebServiceContext wsContext;
MessageContext mc = wsContext.getMessageContext();
HttpServletRequest request = (HttpServletRequest)mc.get(MessageContext.SERVLET_REQUEST);
```
