##


##  数组对象

```yaml
# 代码生成
gen:
    # 作者
    author: shoukaiseki
    # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool
    packageName: com.ruoyi.project.wb010
    # 自动去除表前缀，默认是true
    autoRemovePre: true
    # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）
    tablePrefix: sys_,wb_,tbl_
    columnCamelCaseConvert: true
    resourceConfList:
        - genResourceConfId: '0x10000'
          parentId: '0'
          name: "wb777"
          description: "wb777"
          path: ""
	      #十六进制
        - genResourceConfId: '0x10001'
          parentId: '0x10000'
          name: "wb777"
          description: "wb777"
          path: "/asus"
```

```java
package com.wb.generator.config;

import com.alibaba.fastjson.JSONObject;
import com.wb.generator.domain.GenResourceConf;
import org.shoukaiseki.common.utils.ListUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * 读取代码生成相关配置
 *
 * @author ruoyi
 */
@Component
@Configuration
@ConfigurationProperties(prefix = "gen")
//@PropertySource(value = {"classpath:generator.yml"})
public class GenConfig
{
    /** 作者 */
    public static String author;

    /** 生成包路径 */
    public static String packageName;

    /** 自动去除表前缀，默认是false */
    public static boolean autoRemovePre;

    /** 表前缀(类名不会包含表前缀) */
    public static String tablePrefix;

    //是否进行字段陀峰转换
    public static boolean columnCamelCaseConvert;

    //资源配置
    public static List<GenResourceConf> resourceConfList=new ArrayList<>();


    public static String getAuthor()
    {
        return author;
    }

//    @Value("${author}")
    public void setAuthor(String author)
    {
        GenConfig.author = author;
    }

    public static String getPackageName()
    {
        return packageName;
    }

//    @Value("${packageName}")
    public void setPackageName(String packageName)
    {
        GenConfig.packageName = packageName;
    }

    public static boolean getAutoRemovePre()
    {
        return autoRemovePre;
    }

//    @Value("${autoRemovePre}")
    public void setAutoRemovePre(boolean autoRemovePre)
    {
        GenConfig.autoRemovePre = autoRemovePre;
    }

    public static String getTablePrefix()
    {
        return tablePrefix;
    }

//    @Value("${tablePrefix}")
    public void setTablePrefix(String tablePrefix)
    {
        GenConfig.tablePrefix = tablePrefix;
    }

    public static boolean isColumnCamelCaseConvert() {
        return columnCamelCaseConvert;
    }

//    @Value("${columnCamelCaseConvert:true}")
    public void setColumnCamelCaseConvert(boolean columnCamelCaseConvert) {
        GenConfig.columnCamelCaseConvert = columnCamelCaseConvert;
    }

    //方法上不能加 static
//    @Value("${resourceConfList:[]}")
    public void setResourceConfList(List<GenResourceConf> resourceConfList) {
        System.out.println(JSONObject.toJSONString(ListUtils.emptyIfNull(resourceConfList)));
        GenConfig.resourceConfList = resourceConfList;
    }

    public static List<GenResourceConf> getResourceConfList() {
        return resourceConfList;
    }
}

```

```java
package com.wb.generator.domain;

/**
 *
 **/
public class GenResourceConf {


    private static final long serialVersionUID = 1L;

    public static final String TABLE_NAME = "genResourceConf";

    /** 主键 */
    private int genResourceConfId;

    /** 父级 */
    private int parentId;

    /** 名称 */
    private String name;

    /** 名称 */
    private String description;

    /** 资源路径 */
    private String path;

    /** 创建者 */
    private String createBy;

    /** 创建时间 */
    private String createTime;

    /** 更新者 */
    private String updateBy;

    /** 更新时间 */
    private String updateTime;

    /** 备注 */
    private String remark;

    public int getGenResourceConfId() {
        return genResourceConfId;
    }



    public GenResourceConf setGenResourceConfId(int genResourceConfId) {
        this.genResourceConfId = genResourceConfId;
        return this;
    }

    public int getParentId() {
        return parentId;
    }

    public GenResourceConf setParentId(int parentId) {
        this.parentId = parentId;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public GenResourceConf setDescription(String description) {
        this.description = description;
        return this;
    }

    public String getPath() {
        return path;
    }

    public GenResourceConf setPath(String path) {
        this.path = path;
        return this;
    }

    public String getCreateBy() {
        return createBy;
    }

    public GenResourceConf setCreateBy(String createBy) {
        this.createBy = createBy;
        return this;
    }

    public String getCreateTime() {
        return createTime;
    }

    public GenResourceConf setCreateTime(String createTime) {
        this.createTime = createTime;
        return this;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public GenResourceConf setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
        return this;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public GenResourceConf setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
        return this;
    }

    public String getRemark() {
        return remark;
    }

    public GenResourceConf setRemark(String remark) {
        this.remark = remark;
        return this;
    }

    public String getName() {
        return name;
    }

    public GenResourceConf setName(String name) {
        this.name = name;
        return this;
    }
}
```
