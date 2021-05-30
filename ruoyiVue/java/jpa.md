# jpa/hibernate

## 自定义查询
### 方案1
```
String sql = "select "+ MysqlUtils.sum("plan_quantity")+","+ MysqlUtils.sum("success_quantity")+","+ MysqlUtils.sum("fail_quantity")+ " from t_production_task t " +
" where t.product_order_id = ? and del_flag = 0";
ProductionTask productionTask = jdbcTemplate.queryForObject(sql , new BeanPropertyRowMapper<ProductionTask>(ProductionTask.class),productOrderId);
```
### 方案2
```
String sql = "select "+ MysqlUtils.sum("plan_quantity")+","+ MysqlUtils.sum("success_quantity")+","+ MysqlUtils.sum("fail_quantity")+ " from t_production_task t " +
" where t.product_order_id = '11' and del_flag = 0";
ProductionTask productionTask = jdbcTemplate.queryForObject(sql , new BeanPropertyRowMapper<ProductionTask>(ProductionTask.class));
```

### dao 查询
```
findById
```

## 自定义查询

```java
	//实体类中
    @ApiModelProperty(value = "存储文件名")
    private String fKey;

//Dao 中
    File findByfKey(String fKey);

//Dao 中 如果使用这个会报错,会被解析为 _FKey
    File findByFKey(String fKey);
```
