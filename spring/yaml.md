# spring中yaml配置

## 配置文件中使用list
```yaml
wb:
    spring:
        security:
            matcherAuthorization:
                list:
                    -   urls: "/app/**"
                        auth: "permitAll"

                    -   urls: "/app1/**,/app2/**"
                        auth: "anonymous"
```
SecurityMatcherProperties
```java
package com.ruoyi.framework.config.properties;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;


@Component
@Configuration
@ConfigurationProperties(prefix="wb.spring.security.matcher-authorization")
public class SecurityMatcherProperties {

    private List<SecurityMatcherAuthorization> list=new ArrayList<>();

    public List<SecurityMatcherAuthorization> getList() {
        return list;
    }

    public void setList(List<SecurityMatcherAuthorization> list) {
        this.list = list;
    }
}
```
SecurityMatcherAuthorization
```java
package com.ruoyi.framework.config.properties;

public class SecurityMatcherAuthorization {

    private String urls;

    /**
     *  权限字符有以下几种
     private static final String permitAll = "permitAll";
     private static final String denyAll = "denyAll";
     private static final String anonymous = "anonymous";
     private static final String authenticated = "authenticated";
     private static final String fullyAuthenticated = "fullyAuthenticated";
     private static final String rememberMe = "rememberMe";
     */
    private String auth;


    public String getAuth() {
        return auth;
    }

    public void setAuth(String auth) {
        this.auth = auth;
    }

    public String getUrls() {
        return urls;
    }

    public void setUrls(String urls) {
        this.urls = urls;
    }
}
```

## 其它地方文档
### springboot-yml内list、map组合写法
```
yml:
myProps:
  varmaplist:
      key11:
        - t1
        - t2
        - t3
      key22:
        - t11
        - t22
        - t33
  list:
    - topic1
    - topic2
    - topic3
  maps: {key1: 'value1', key2: 'value2'}
MyProps:
@Component
@Data
@Configuration
@PropertySource(value = {"classpath:/bootstrap.yml"}, encoding = "utf-8")
@ConfigurationProperties(prefix = "myProps")
public class MyProps {

    private List<String> list;


    private Map<String,String> maps;

    private Map<String,List<String>> varmaplist;
}
 
```
