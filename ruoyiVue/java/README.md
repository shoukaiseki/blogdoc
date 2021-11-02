# java

## maven
```xml
    <properties>
<!--        <kotlin.version>1.2.71</kotlin.version>-->
        <kotlin.version>1.5.0</kotlin.version>

        <java.version>11</java.version>
        <jdk.version>11</jdk.version>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
    </properties>
```

##问题
### IDEA2021.1启动SpringBoot项目出现java程序包:xxx不存在
https://blog.csdn.net/lzzdhhhh/article/details/105907772




## 排序

```java
  //重新排序
    @Override
    public void resetSortOrderByList(List<ProductionOrder> productionOrderList){
        ProductionOrder previousNode=null;
        List<ProductionOrder> updateList=new ArrayList<>();
        for (ProductionOrder productionOrder : productionOrderList) {
            String id = productionOrder.getId();
            productionOrder.setNextNodeId("");
            productionOrder.setPreviousNodeId("");
            if(previousNode!=null){
               previousNode.setNextNodeId(id);
                productionOrder.setPreviousNodeId(previousNode.getId());
            }
            previousNode=productionOrder;
            updateList.add(productionOrder);
        }

        for (ProductionOrder productionOrder : updateList) {
            ProductionOrder productionOrderTmp = get(productionOrder.getId());
            productionOrderTmp.setNextNodeId(productionOrder.getNextNodeId());
            productionOrderTmp.setPreviousNodeId(productionOrder.getPreviousNodeId());
            productionOrderTmp.setSortOrder(productionOrder.getSortOrder());
            update(productionOrderTmp);
        }

    }
```

## 获取参数类型,json转化为参数所需对象
### SyncActionUtils
```
        Method method = BusinessEntityManager.getMethod(businessEntityService.getTableName(), beanName);

        Type[] genericParameterTypes = method.getGenericParameterTypes();
//        Class<?>[] parameterTypes = method.getParameterTypes();
        if (genericParameterTypes.length!=1) {
            throw new RuntimeException(syncActionRequest.getOwnerName()+"["+syncActionRequest.getBeanName()+"]调用的方法需要多个参数,请修改 syncAction 方法");
        }
        Type genericParameterType = genericParameterTypes[0];
//        Class<?> parameterType = parameterTypes[0];
//        if (parameterType.equals(List.class)) {
//            Type genericSuperclass = parameterType.getGenericSuperclass();
//
//        }
        Object obj = domainToJavaBeanForType(syncActionRequest.getDomain(), genericParameterType);
        try {
            Object invoke = method.invoke(businessEntityService, obj);
            return (T) invoke;
        } catch (Exception e) {
            throw new RuntimeException(businessEntityService.getTableName()+"["+beanName+"]方法调用出错",e);
        }
		
```


#### 参考自
```
org.springframework.http.converter.json.AbstractJackson2HttpMessageConverter
	public Object read(Type type, @Nullable Class<?> contextClass, HttpInputMessage inputMessage)

```


## PathVariable，URL中带有斜线
### 例如链接
http://test7.shoukaiseki.cn/anon/filePreview/sys_notice/b74446ca00274b178be3ca2910d7302b.png
#### 原方式
会有问题,无法匹配该Controller
```
 @RequestMapping(value = "/anon/filePreview/{ossname}", method = RequestMethod.GET)
    public void view(@PathVariable String ossname,
                     @RequestParam(required = false, defaultValue = "true") Boolean preview,
                     @RequestParam(required = false, defaultValue = "UTF-8") String charset,
                     HttpServletResponse response) throws Exception {
	}

```

#### 可用方式
```
    @RequestMapping(value = "/anon/filePreview/**", method = RequestMethod.GET)
    public void view(
                     @RequestParam(required = false, defaultValue = "true") Boolean preview,
                     @RequestParam(required = false, defaultValue = "UTF-8") String charset,
                     HttpServletRequest request,
                     HttpServletResponse response) throws Exception {

        String path = request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE).toString();
        String bestMatchingPattern = request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE).toString();

        //** 的内容
        String ossname = new AntPathMatcher().extractPathWithinPattern(bestMatchingPattern, path);
   }

```
### 手动回滚
```
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();

```

#### 获取下个ID
```
        List<Long> data=new ArrayList<>();
        Workshop workshop = new Workshop();
        workshop.setName(""+RandomUtils.nextLong(0x00,0xffff));
        workshopService.insertWorkshop(workshop);
        workshopService.deleteWorkshopByIds(workshop.getWorkshopId());
        data.add(workshop.getWorkshopId());
		TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		return AjaxResult.successData("出错了:"+data);
```
