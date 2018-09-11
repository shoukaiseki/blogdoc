# spring扫描jar包中的Mapperxml

mybatis 扫描xml是根据spring资源管理器去检索的

spring获取资源只要在 classpath后面加个 * 就会扫描jar包

```
classpath*:mybatis/**/*Mapper.xml
```

下面是一个查看spring资源扫描的例子

```Java
    public static final String MAPPER_LOCATION = "${hkedou.multiple.mapperLocations:classpath*:mybatis/**/*Mapper.xml}";

	@Value(MAPPER_LOCATION)
    String mapperLocation;

    @RequestMapping(value = "/resource",produces="application/json;charset=UTF-8")
    @ResponseBody
    public String list() throws IOException {
        Resource[] resources = new PathMatchingResourcePatternResolver().getResources(mapperLocation);
        String[] fs=new String[resources.length];
        Map<String,Object> resultMap=new HashMap<>();
        int i=0;
        for (Resource resource:resources ) {
           fs[i++]=resource.getFilename();
        }
        resultMap.put("mapperLocation",mapperLocation);
        resultMap.put("filenames",fs);

        return JSON.toJSONString(resultMap, SerializerFeature.PrettyFormat);
    }
```
