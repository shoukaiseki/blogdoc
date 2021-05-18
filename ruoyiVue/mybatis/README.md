# mybatis

## 某个查询不使用缓存,则加上此句
flushCache="true" useCache="false"

```java
//获取条数,匿名的ISelect.doSelect()调用的必须是查询方法,里面不要写其它代码,一行查询就好
long total = PageHelper.count(() -> {
		assStoreContentMapper.selectAssStoreContentVOList(assStoreContent);
});
```


### 排序
```xml
                <foreach item="temp" collection="virtualOrderByFilterList" open=" order by" separator="," close="">
                    <choose>
                        <when test="temp==1">
                            urgented asc
                        </when>
                        <when test="temp==2">
                            urgented desc
                        </when>
                        <when test="temp==3">
                            sort asc
                        </when>
                        <when test="temp==4">
                            sort desc
                        </when>
                        <when test="temp==5">
                            production_order_id is null
                        </when>
                        <when test="temp==6">
                            production_order_id desc is null
                        </when>
                        <otherwise>
                        </otherwise>

                    </choose>
                </foreach>

```
