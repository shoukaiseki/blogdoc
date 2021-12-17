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


### 调用方法
https://blog.csdn.net/weixin_30133813/article/details/114122333

https://www.136.la/java/show-31106.html
#### mybatis
```xml
        select
            needs.*,
            product.code productCode,
            ${@SqlUtils@formatRelationshipSql("supplier","needs.supplierId")},
            ( select name from tbl_supplier where supplierId=needs.supplierId ) as supplierName2,

            product.category productCategory,
            (select sum(amount) from tbl_produce_receive where marketNeedId=needs.marketNeedId) as receiveAmount,
            (select sum(amount) from tbl_product_record where productId=needs.productId) as stockAmount
        from tbl_market_needs needs
			

```
#### java
```java
import org.shoukaiseki.common.utils.StringUtils;

import java.util.Objects;

/**
 *
 **/
public class SqlUtils {

	//只能为静态方法
    public static String formatRelationshipSql(String tableName, String tableColumn) {
        return formatRelationshipSql(tableName, tableColumn, "supplierName");
    }
    public static String formatRelationshipSql(String businessName, String tableColumn, String aliasName){
        if(Objects.equals("supplier",businessName)){
            return StringUtils.format("( select name from tbl_supplier where supplierId={} ) as {}",tableColumn,aliasName);
        }
        return StringUtils.format("未知的 businessName={} ，请查看 BaseDomain.getFormatRelationshipSql 是否存在",businessName);
    }
}
```



### mybatisLog插件无sql输出
#### 首先需要开启日志输出
#### 还需要指定日志输出格式,以下配置可用
```
# 日志配置
logging:
    pattern:
        console: '%d{YYYY-MM-dd HH:mm:ss.SSS} [%thread] %-5level %logger{20} - [%method,%line] - %msg%n'
        #    logger[35] 类名包名长度为35
#        console: "%d{yyyy-MM-dd HH:mm:ss.SSS} %-4relative [%thread] %-5level [%logger{80}]: %msg %n"
    level:
        root: warn
        org.shoukaiseki.inittable: debug
        org.shoukaiseki.autumn: debug
        com.wb: debug
```


## 表达式ognl
### 调用方法
```xml
<!-- 属性中不能 ${} -->
            <foreach item="temp" collection='@MybatisXmlUtils@convertAutumnParamsSearchValueList(autumnParams,"appSearchValueListCustomize")'>
                and (pro.itemName like concat('%',#{temp},'%')
                    or pro.itemNum like concat('%',#{temp},'%')
                )
            </foreach>
```

### 调试表达式
https://www.cnblogs.com/cenyu/p/6233942.html


```java
package test;

import org.apache.ibatis.ognl.Ognl;
import org.apache.ibatis.ognl.OgnlContext;
import org.apache.ibatis.ognl.OgnlException;
import org.apache.ibatis.scripting.xmltags.OgnlCache;
import org.apache.ibatis.scripting.xmltags.OgnlClassResolver;
import org.junit.jupiter.api.Test;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


/**
 * **/ public class TestOgnl {

    private static final OgnlClassResolver CLASS_RESOLVER = new OgnlClassResolver();
    private static final Map<String, Object> expressionCache = new ConcurrentHashMap<>();

    @Test
    void test001() throws OgnlException {
        Object root=Map.of("id",1,"autumnParams",Map.of("appSearchValueListCustomize","asus linux fedora"));
        String expression="${MybatisXmlUtils}'asus'";
        expression="@MybatisXmlUtils@convertAutumnParamsSearchValueList(autumnParams,\"appSearchValueListCustomize\")";
//        expression="@MybatisXmlUtils@asus()";
        Object value = OgnlCache.getValue(expression, root);
        System.out.println(value);
    }

    private static Object parseExpression(String expression) throws OgnlException {
        Object node = expressionCache.get(expression);
        if (node == null) {
            node = Ognl.parseExpression(expression);
            expressionCache.put(expression, node);
        }
        return node;
    }

}
```
