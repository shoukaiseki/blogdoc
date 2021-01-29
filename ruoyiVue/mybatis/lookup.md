# lookup

```xml
            <if test="searchValueList != null and searchValueList.length &gt; 0">
                <foreach item="temp" collection="searchValueList">
                    and (comment like concat('%',#{temp},'%')
                    or name like concat('%',#{temp},'%')
                    or description like concat('%',#{temp},'%')
                    or remark like concat('%',#{temp},'%')
                    )
                </foreach>
            </if>
			
```

## 位判断

```xml


            <if test="lookupBitFilter != null">
                <if test="lookupBitFilter 	&amp; 1">
                    and leader_user_id  is null
                </if>
                <if test="lookupBitFilter 	&amp; 2">
                    and responsible_user_id  is null
                </if>
            </if>
```
