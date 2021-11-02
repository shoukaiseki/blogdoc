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


### HttpClient提交文件,参数

```
    public static void main(String[] args) throws Exception {
        LogbackLevelSetting.debugLevel("com.test");

        String uri = "http://127.0.0.1:10000/anon/testFile";

        String imgUrl = "http://127.0.0.1:20000/static/img/logo.d5c869a6.png";

        HashMap<String, Object> params = new HashMap<>();
        params.put("asus","linux");
        params.put("fileName",RandomUtils.nextLong()+".png");
//        uri = uri+"?"+formatUrlParam(params);
        logger.debug("uri={}",uri);


        DefaultHttpClient httpClient = new DefaultHttpClient();
        HttpPost httpPost ;
        httpPost = new HttpPost(uri);
        ContentType contentType = ContentType.IMAGE_PNG;

        Charset charset = Charset.forName("UTF-8");

        Map<String, ContentBody> reqParam = new HashMap<String,ContentBody>();
        
        ContentType multipartFormData = ContentType.MULTIPART_FORM_DATA;
        //不加字符集会乱码
        reqParam.put("fileName", new StringBody(RandomUtils.nextLong()+ "是打开父级"+".png",charset));
//        reqParam.put("lepUrlc", new InputStreamBody(inputstream,"asus.png"));
        String filename = FileHttpUtils.getFileName(imgUrl);
        logger.debug("filename={}",filename);
        reqParam.put("lepUrlc", new ByteArrayBody(readUrlBytes(imgUrl), filename));


        MultipartEntityBuilder multipartEntityBuilder = MultipartEntityBuilder.create();
        multipartEntityBuilder.setCharset(charset);
        for(Map.Entry<String,ContentBody> param : reqParam.entrySet()){
            multipartEntityBuilder.addPart(param.getKey(), param.getValue());
        }
        multipartEntityBuilder.addTextBody("param1","asus");
        httpPost.setEntity(multipartEntityBuilder.build());
        HttpResponse response = httpClient.execute(httpPost);
        // 打印执行结果
        String x = EntityUtils.toString(response.getEntity(), "UTF-8");
        logger.debug("reString={}", x);
    }



    public static byte[] readUrlBytes(String imgUrl){
        boolean error=false;
        InputStream inputstream=null;
        HttpURLConnection uc=null;
        byte[] bytes=null;
        try{
            URL url = new URL(imgUrl);
            uc = (HttpURLConnection) url.openConnection();
            uc.setDoInput(true);//设置是否要从 URL 连接读取数据,默认为true
            uc.connect();
            inputstream = uc.getInputStream();
            bytes = inputstream.readAllBytes();
        }catch (Throwable t){
            logger.error("imgUrl="+imgUrl,t);
        }finally {
            if (inputstream!=null) {
                try {
                    inputstream.close();
                } catch (IOException e) {
                }
                if (uc!=null) {
                    uc.disconnect();
                }
            }
        }
        if(error){
            throw new RuntimeException("读取文件出错"+imgUrl);
        }
        return bytes;
    }
	

    /**
     * 获取的文件名,没有路径名
     * @param fileName           文件名
     * @param fileNameMaxLength  60
     * @return
     */
    public static final String getFileName(String fileName){
        String fileNameTmp=fileName;
        fileNameTmp=fileNameTmp.replaceAll("\\\\","/");
        if(fileNameTmp.indexOf("/")>-1){
            if(fileNameTmp.lastIndexOf("/")+1<fileNameTmp.length()){
                fileNameTmp=fileNameTmp.substring(fileNameTmp.lastIndexOf("/")+1);
            }
        }
        return fileNameTmp;
    }
	
```

