# javadoc

## 换行
 pre 里面的会乱码 @code 中文都会乱码
推荐使用  <br> 换行
```java
    /**
     * <pre>
     * </pre>
     * {@code
     * 变更标志,桉位判断,用于主子表同时修改提交表单时子表修改/删除,新增处理时对无变更的数据不走处理
     *    &1:  新增 toBeAdd()    判断 true:需新增
     *    &2:  修改 toBeModify() 判断 true:需更新
     *    &4:  修改 toBeDelete() 判断 true:需删除
	 * }
     */

```

## xml源码显示

{@code xml/html内容}
```java
    /**
     * <pre>
     * 搜索值列表
		 </pre>
     * {@code
     <if test="searchValueList != null and searchValueList.length &gt; 0">
		 <foreach item="temp" collection="searchValueList">
		 and (item_name like concat('%',#{temp},'%')
		 or var01 like concat('%',#{temp},'%')
		 )
		 </foreach>
     </if>
      }
     */
```

