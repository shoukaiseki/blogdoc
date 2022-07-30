# jxls excel模板

合并单元格有效
```xml
	<properties>
		<poi-ooxml.version>5.0.0</poi-ooxml.version>
		<jxls.version>2.10.0</jxls.version>
		<jxls-jexcel.version>1.0.9</jxls-jexcel.version>
		<jxls-poi.version>2.10.0</jxls-poi.version>
	</properties>
	

        <!-- excel工具 -->
        <dependency>
            <groupId>org.apache.poi</groupId>
            <artifactId>poi-ooxml</artifactId>
            <version>${poi-ooxml.version}</version>
        </dependency>
        <dependency>
            <groupId>org.jxls</groupId>
            <artifactId>jxls</artifactId>
            <version>${jxls.version}</version>
        </dependency>
        <dependency>
            <groupId>org.jxls</groupId>
            <artifactId>jxls-poi</artifactId>
            <version>${jxls-poi.version}</version>
        </dependency>
        <dependency>
            <groupId>org.jxls</groupId>
            <artifactId>jxls-jexcel</artifactId>
            <version>${jxls-jexcel.version}</version>
            <exclusions>
                <exclusion>
                    <artifactId>log4j</artifactId>
                    <groupId>log4j</groupId>
                </exclusion>
            </exclusions>
        </dependency>
        <dependency>
            <groupId>net.sf.jxls</groupId>
            <artifactId>jxls-core</artifactId>
            <version>1.0.5</version>
        </dependency>

        <dependency>
            <groupId>org.apache.poi</groupId>
            <artifactId>poi-scratchpad</artifactId>
            <!--                <version>5.0.0</version>-->
            <version>3.17</version>
        </dependency>
	
```
## xls文件作为模板
```
jx:area(lastCell="E3")
```

```
jx:each(items="data" var="item" lastCell="E3")

jx:mergeCells(lastCell="A3" rows="item.mposList.size()")
```

```
jx:each(items="item.mposList" var="mpo" lastCell="E3")
```
![image](https://gitee.com/shoukaiseki/blogdoc/raw/master/ruoyiVue/java/img/jxls001.png)

[excel文件1](https://gitee.com/shoukaiseki/blogdoc/raw/master/ruoyiVue/java/img/jxls001.xls "附件1")
[excel文件2](https://gitee.com/shoukaiseki/blogdoc/raw/master/ruoyiVue/java/img/jxls002.xls "附件2")


