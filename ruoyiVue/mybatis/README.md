# mybatis

## 查询字段声明

```
itemIdGreaterThan
itemIdLessThan


statusAndTrue
statusAndFalse

    /**
     * 包含主键列表
     <pre>
     {@code
		<if test="includeUniqueIdList != null">
			<choose>
				<when test="includeUniqueIdList.length==0">
					and inventory_balance_id is null
				</when>
				<otherwise>
					andinventory_balance_id in
					<foreach item="temp" collection="includeUniqueIdList" open="(" separator="," close=")">
						#{temp}
					</foreach>
				</otherwise>

			</choose>
		</if>
     }
     </pre>
     *
     */
    private Long[] includeUniqueIdList;


    /**
     * 排除主键列表
     <pre>
     {@code
		<if test="includeUniqueIdList != null and includeUniqueIdList.length &gt; 0">
			and inventory_balance_id not in
			<foreach item="temp" collection="includeUniqueIdList" open="(" separator="," close=")">
				#{temp}
			</foreach>
		</if>
     }
     </pre>
     */
    private Long[] excludeUniqueIdList;


    /**
     * <pre>
     *     精确查找主键列表,该值如果不为null时,将会使用主键精确查找,
     *     无视delFlag标识,用于关联查询
     * </pre>
     */
    private Long[] exactQueryUniqueIdList;


//find_in_set(#{proRootIdFindInSetStr},pro_root_id_arr)
private Long proRootIdFindInSetStr;


```

### itemIdExistsBom
```
exists (select 1 from .... itemIdExistsBom)
```
### nameFindLike
```
//name like concat('%',#{temp},'%')
nameFindLike
```

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


                            sale_order_id  is null asc
```

## 选项过滤
```vue
        <el-row>
            <el-col :span="24">
                <p>
                    <el-tabs @input="handleQuery()" v-model="queryParamsTabPaneFilterValue">
                        <el-tab-pane
                            :disabled="loading"
                            v-for="(item, index) in tabPanelFilterOptionList"
                            :label="item.dictLabel"
                            :name="''+item.dictValue">
                        </el-tab-pane>
                    </el-tabs>
                </p>
            </el-col>
        </el-row>



            tabPanelFilterOptionList:[
                {
                    dictValue: 0,
                    dictLabel: '全部'
                },
                {
                    dictValue: 1,
                    dictLabel: '待发货'
                },
                {
                    dictValue: 2,
                    dictLabel: '待送达'
                },
                {
                    dictValue: 3,
                    dictLabel: '已送达'
                },
            ],
            // 查询参数
            queryParamsTabPaneFilterValue: "0",


            switch (Number(this.queryParamsTabPaneFilterValue)) {
                case 0:
                    //全部
                    queryParams.status=""
                    break;
                case 1:
                    //主工单
                    //parent_id =0
                    queryParams.processStatusAndTrue=4
                    break;
                case 2:
                    queryParams.processStatusAndTrue=2
                    //任务订单
                    queryParams.validFlag=0
                    queryParams.status="0"
                    queryParams.showVirtualBitFilter|=1
                    this.showDeliveryColumn=true;
                    break;
                default:
                    //这里是没有找到对应的值处理
                    break
            }

```
