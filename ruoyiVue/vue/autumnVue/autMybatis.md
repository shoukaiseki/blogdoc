# autumnMybatis
## 统计查询,分组查询
```java

    public List<GoldCoinHistory> selectGoldCoinHistoryListAggregated(GoldCoinHistoryQO goldCoinHistoryQO);

    public GoldCoinHistory selectGoldCoinHistoryAggregated(GoldCoinHistoryQO goldCoinHistoryQO);

```

```xml
    <select id="selectProSubmitRecordListAggregated" parameterType="ProSubmitRecordQO" resultType="ProSubmitRecord">
        select
        <trim  suffixOverrides=",">
            <!--        <if test="aggregatedQueryColumnList != null ">-->
            <!--   列名必须由后端设置,不允许前端传入后直接使用 -->
            <foreach item="temp" collection="aggregatedQueryColumnList"  separator=",">
                ${temp}
            </foreach>
            <!--        </if>-->
        </trim>
        from pro_submit_record  as t1
        left join pro_procedure_task as ppt on (ppt.proProcedureTaskId=t1.proProcedureTaskId)
        left join production_order as pro on (pro.productionOrderId=t1.productionOrderId)
        left join asset on (ppt.assetId=asset.assetId)
        <where>
            <include refid="mybatisRestrictionWhere"/>

            ${autumnParamsWhereSql}
        </where>
        <if test="aggregatedGroupByColumnList != null">
            <foreach item="temp" collection="aggregatedGroupByColumnList" open="group by"  separator=",">
                ${temp}
            </foreach>
        </if>
        <include refid="orderByProSubmitRecordRef"/>
    </select>

```
