# fastjson获取Bean属性值转map

```Java
    @Test
    public void test005() throws Exception {
        TestModel testModel=new TestModel();
        testModel.setId(1L);
        testModel.setName("linux");

        JavaBeanSerializer javaBeanSerializer=new JavaBeanSerializer(testModel.getClass());
        Object name = javaBeanSerializer.getFieldValue(testModel, "name");
        System.out.println("name="+name);
        Map<String, Object> fieldValuesMap = javaBeanSerializer.getFieldValuesMap(testModel);
        List<Object> fieldValues = javaBeanSerializer.getFieldValues(testModel);
        System.out.println("fieldValues="+fieldValues);
        System.out.println("fieldValuesMap="+fieldValuesMap);

        //JavaBeanSerializer不支持map
//        ImmutableMap<String, String> map = ImmutableMap.of("name", "linux");
//        javaBeanSerializer=new JavaBeanSerializer(map.getClass());
//        System.out.println("fieldValues="+fieldValues);
    }
```
