# lookup

```xml
            <if test="searchValueList != null and includeItemIdList.length &gt; 0">
                <foreach item="temp" collection="searchValueList">
                    and (comment like concat('%',#{temp},'%')
                    or name like concat('%',#{temp},'%')
                    or description like concat('%',#{temp},'%')
                    or remark like concat('%',#{temp},'%')
                    )
                </foreach>
            </if>
```
