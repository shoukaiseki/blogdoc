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

```vue
            orderByFilterOptionList: [
                {
                    dictValue: 1,
                    dictLabel: '加急靠前'
                },
                {
                    dictValue: 2,
                    dictLabel: '加急靠后'
                },
                // {
                //     dictValue: 3,
                //     dictLabel: '置顶在前'
                // },
                // {
                //     dictValue: 4,
                //     dictLabel: '置顶在后'
                // },
                {
                    dictValue: 5,
                    dictLabel: '新单子在前'
                },
                {
                    dictValue: 6,
                    dictLabel: '新单子在后'
                },
            ],

```

```xml
                <foreach item="temp" collection="virtualOrderByFilterList" open=" order by" separator="," close="">
                    <choose>
                        <when test="temp==1">
                            urgented desc
                        </when>
                        <when test="temp==2">
                            urgented asc
                        </when>
                        <when test="temp==3">
                            sort desc
                        </when>
                        <when test="temp==4">
                            sort asc
                        </when>
                        <when test="temp==5">
                            sale_order_id desc
                        </when>
                        <when test="temp==6">
                            sale_order_id asc
                        </when>
                        <otherwise>
                        </otherwise>

                    </choose>
                </foreach>

```
