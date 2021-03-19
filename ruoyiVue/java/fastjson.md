# fastjson

## 时间格式化
```java
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
```
网上说的新版本兼容 JsonFormat 注解是错误的
源代码clone下来,所有文件中都不存在 JsonFormat 字符


## camel-fastjson
dataformats

https://camel.apache.org/components/latest/dataformats/json-fastjson-dataformat.html
```xml
        <dependency>
            <groupId>org.apache.camel</groupId>
            <artifactId>camel-fastjson-starter</artifactId>
            <version>3.0.0-RC3</version>
        </dependency>

```
