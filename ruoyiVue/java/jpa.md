# jpa

## 自定义查询
```
        String sql = "select "+ MysqlUtils.sum("plan_quantity")+","+ MysqlUtils.sum("success_quantity")+","+ MysqlUtils.sum("fail_quantity")+ " from t_production_task t " +
                " where t.product_order_id = ? and del_flag = 0";

        ProductionTask productionTask = jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<ProductionTask>(ProductionTask.class),productOrderId);

//该方式未测试
        List<ProductionTask> productionTaskList = jdbcTemplate.query(sql,new Object[]{productOrderId}, new BeanPropertyRowMapper<ProductionTask>(ProductionTask.class));


```
