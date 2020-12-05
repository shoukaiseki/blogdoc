# springboot热加载



1、一个SpringBoot项目，点击启动类管理按钮，也可以通过菜单Run -> Edit Configurations...
2、找到springboot配置，可以看到有个Running Application Update Policies
3、设置为 update classes and resources 就可以了


## pom.xml
```xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <optional>true</optional>
            <scope>runtime</scope>
        </dependency>


            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <fork>true</fork> <!-- 如果没有该配置，devtools不会生效 -->
<!--                    <jvmArguments>-->
<!--                        -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5000,suspend=n-->
<!--                    </jvmArguments>-->
                    <addResources>true</addResources>
                </configuration>
            </plugin>
```


## 配置

```java
System.setProperty("spring.devtools.restart.enabled", "false");
```
