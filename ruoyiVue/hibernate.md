# hibernate

```java
	//实体类中
    @ApiModelProperty(value = "存储文件名")
    private String fKey;

//Dao 中
    File findByfKey(String fKey);

//Dao 中 如果使用这个会报错,会被解析为 _FKey
    File findByFKey(String fKey);
```
