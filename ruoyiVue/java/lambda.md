# lambda表达式



### 数组中是否存在元素
if (!virtualCompanyProcedureConfList.stream().filter((o) -> o.getProcedureConfId().equals(procedureConf.getProcedureConfId())).findFirst().isPresent()) {
	//不存在
}

### 过滤
productionOrder.setVirtualTargetBomList(inventoryBomList.stream().filter((bom) -> ProductionOrder.BOM_TYPE_TARGET.equals(bom.getBomType())).collect(Collectors.toList()));
productionOrder.setVirtualSourceBomList(inventoryBomList.stream().filter((bom) -> ProductionOrder.BOM_TYPE_SOURCE.equals(bom.getBomType())).collect(Collectors.toList()));


##### 数组对象中某列的值转换为数组

```java
Long[] userIds = userList.stream().map(SysUser::getUserId).toArray(Long[]::new);

Long[] userIds = userList.stream().map((obj) -> obj.getUserId()).toArray(Long[]::new);
```


## 数据转换



### Long数组转换为String数组
```java
List<Long> list=new ArrayList();
list.add(1L);
list.add(2L);
list.add(3L);
list.add(33333333L);
Stream<Long> stream = list.stream();
Stream<String> stringStream = stream.map(Object::toString);
String[] objects = stringStream.toArray(String[]::new);
logger.debug(JSON.toJSONString(objects));
objects= list.stream().map(Object::toString).toArray(String[]::new);
logger.debug(JSON.toJSONString(objects));

```

### 对象转map(JSONObject)
collect 执行后才会 执行表达式中的[JSONObject o = (JSONObject) JSONObject.toJSON(obj);]转换方法
```java
static class TestModel{
	private String a;
	private String b;

	public String getA() {
		return a;
	}

	public void setA(String a) {
		this.a = a;
	}

	public String getB() {
		return b;
	}

	public void setB(String b) {
		this.b = b;
	}
}

private static void test007() {
	List<TestModel> list=new ArrayList<TestModel>();
	TestModel testModel=new TestModel();
	testModel.setA("a1");
	testModel.setB("b1");
	list.add(testModel);
	testModel=new TestModel();
	testModel.setA("a2");
	testModel.setB("b2");
	list.add(testModel);

	Stream<JSONObject> jsonObjectStream = list.stream().map((obj) -> {
			JSONObject o = (JSONObject) JSONObject.toJSON(obj);
			o.put("C", "CC");
			return o;
			});
	System.out.println(JSONObject.toJSONString(jsonObjectStream));
	List<JSONObject> collect = jsonObjectStream.collect(Collectors.toList());
	System.out.println(JSONObject.toJSONString(collect));

}

```

### 获取map中的第一个value值

```java
        Map<String,TestModel> map=new HashMap<>();
        TestModel testModel=new TestModel();
        testModel.setA("a1");
        testModel.setB("b1");
        map.put("1",testModel);
        testModel=new TestModel();
        testModel.setA("a2");
        testModel.setB("b2");
        map.put("2",testModel);

        System.out.println("map="+JSONObject.toJSONString(map));

//        map=new HashMap<>();
        TestModel obj = map.values().stream().findFirst().orElse(null);
        System.out.println(JSONObject.toJSONString(obj));
```
