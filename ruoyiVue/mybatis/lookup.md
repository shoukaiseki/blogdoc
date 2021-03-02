# lookup

### 前端排序
```
      queryParams.orderByColumn='create_time'
      queryParams.isAsc='asc'
```


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


## 级联

```xml
        <association property="virtualInventoryItem"     column="item_id" javaType="InventoryItem" select="com.ruoyi.project.inventory.mapper.InventoryItemMapper.selectInventoryItemById" />

```


## 分页
使用了pagehelper插件后,select时如果parameterType中存在pageNum,pageSize属性,而且有值,那么就会进行分页
```java
com.github.pagehelper.util.PageObjectUtil

    public static <T> Page<T> getPageFromObject(Object params, boolean required) {
        if (params == null) {
            throw new PageException("无法获取分页查询参数!");
        }
        if(params instanceof IPage){
            IPage pageParams = (IPage) params;
            Page page = null;
            if(pageParams.getPageNum() != null && pageParams.getPageSize() != null){
                page = new Page(pageParams.getPageNum(), pageParams.getPageSize());
            }
            if (StringUtil.isNotEmpty(pageParams.getOrderBy())) {
                if(page != null){
                    page.setOrderBy(pageParams.getOrderBy());
                } else {
                    page = new Page();
                    page.setOrderBy(pageParams.getOrderBy());
                    page.setOrderByOnly(true);
                }
            }
            return page;
        }
        int pageNum;
        int pageSize;
        MetaObject paramsObject = null;
        if (hasRequest && requestClass.isAssignableFrom(params.getClass())) {
            try {
                paramsObject = MetaObjectUtil.forObject(getParameterMap.invoke(params, new Object[]{}));
            } catch (Exception e) {
                //忽略
            }
        } else {
            paramsObject = MetaObjectUtil.forObject(params);
        }
        if (paramsObject == null) {
            throw new PageException("分页查询参数处理失败!");
        }
        Object orderBy = getParamValue(paramsObject, "orderBy", false);
        boolean hasOrderBy = false;
        if (orderBy != null && orderBy.toString().length() > 0) {
            hasOrderBy = true;
        }
        try {
            Object _pageNum = getParamValue(paramsObject, "pageNum", required);
            Object _pageSize = getParamValue(paramsObject, "pageSize", required);
            if (_pageNum == null || _pageSize == null) {
                if(hasOrderBy){
                    Page page = new Page();
                    page.setOrderBy(orderBy.toString());
                    page.setOrderByOnly(true);
                    return page;
                }
                return null;
            }
            pageNum = Integer.parseInt(String.valueOf(_pageNum));
            pageSize = Integer.parseInt(String.valueOf(_pageSize));
        } catch (NumberFormatException e) {
            throw new PageException("分页参数不是合法的数字类型!", e);
        }
        Page page = new Page(pageNum, pageSize);
        //count查询
        Object _count = getParamValue(paramsObject, "count", false);
        if (_count != null) {
            page.setCount(Boolean.valueOf(String.valueOf(_count)));
        }
        //排序
        if (hasOrderBy) {
            page.setOrderBy(orderBy.toString());
        }
        //分页合理化
        Object reasonable = getParamValue(paramsObject, "reasonable", false);
        if (reasonable != null) {
            page.setReasonable(Boolean.valueOf(String.valueOf(reasonable)));
        }
        //查询全部
        Object pageSizeZero = getParamValue(paramsObject, "pageSizeZero", false);
        if (pageSizeZero != null) {
            page.setPageSizeZero(Boolean.valueOf(String.valueOf(pageSizeZero)));
        }
        return page;
    }
```
