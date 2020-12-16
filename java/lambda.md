# lambda表达式


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
