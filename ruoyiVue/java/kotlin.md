# kotlin

```kotlin
package com.ruoyi.project.base.service.impl

@Service
open class LocationServiceImpl : ILocationService {

    companion object {
        val logger = getLogger(LocationServiceImpl::class.java)
    }


    @Autowired
    private val locationMapper: LocationMapper? = null

    /**
     * 检查是否存在地点类别相同地点
     * @return false 存在类别/地点相同的记录,不应该插入或者修改
     */
    override fun checkLocationUnique(location:Location):Boolean{
        if (location.bitType==null) {
            val count:Int = locationMapper!!.checkLocationUnique(location)
            return count==0
        }

        var unique= true
        var bitTypeTmp=1
        while (bitTypeTmp <= location.bitType) {
            logger.debug("bitTypeTmp={}",bitTypeTmp)
            val count:Int = locationMapper!!.checkLocationUnique(location)
            if(count>0){
               return false
            }
            bitTypeTmp = bitTypeTmp shl 1
        }
        return unique
    }

    /**
     * 新增地点
     *
     * @param location 地点
     * @return 结果
     */
    @Transactional
    override fun insertLocation(location: Location?): Location? {
        setGeoCode(location!!)
        if (!checkLocationUnique(location)) {
           throw MessageVirtualException("类型相同的location已存在:${location.location}")
        }
        val user = TokenUserUtils.getUser()
        BaseEntity.setCreate(location, user.userId, user.userName, DateUtils.getNowDate())
        locationMapper!!.insertLocation(location)
        return locationMapper.selectLocationById(location.locationId)
    }

    /**
     * 修改地点
     *
     * @param location 地点
     * @return 结果
     */
    @Transactional
    override fun updateLocation(location: Location?): Int {
        setGeoCode(location!!)
        if (!checkLocationUnique(location)) {
            throw MessageVirtualException("类型相同的location已存在:${location.location}")
        }
        val user = TokenUserUtils.getUser()
        BaseEntity.setUpdate(location, user.userId, user.userName, DateUtils.getNowDate())
        return locationMapper!!.updateLocation(location)
    }

}
```


## 可变参数

```kotlin
    open fun format(vararg params:Any):MessageVirtualException{
        if (this.message==null) {
            return this
        }
		//可变参数向下传递时加上 *
        this.message=StringUtils.format(super.message,*params)
        return this
    }
```

## 方法默认值
会生成多个方法,可不传有默认值的参数
```
    @JvmStatic
    @JvmOverloads
   fun sum(column: String,alias:String=column): String {
        return "ifnull(sum(${column})) as $alias"
    }
```

### 静态方法默认值
```kotlin
import org.shoukaiseki.aqoeous.builder.AqoeousBuilder.aqoeous
import org.shoukaiseki.aqoeous.builder.RelationshipBuilder.paramName
import org.shoukaiseki.aqoeous.model.CustomQO

object ChildAqoeous {


    @JvmStatic
    @JvmOverloads
    fun inventoryItemQueryObjectChild(resultName:String="item",sourceData:String="itemId"): CustomQO {
        val qo= aqoeous()
            .resultName(resultName)
            .mergeParent(true)
            .listFirstMergeParent(true)
            .relationships(
                paramName("exactQueryUniqueIdList")
                    .sourceDatas(sourceData)
            )
            .build()

        return qo
    }
}
```



## let
https://blog.csdn.net/u013064109/article/details/78786646
```
 //kotlin
 
 fun main(args: Array<String>) {
    val result = "testLet".let {
        println(it.length)
        1000
    }
    println(result)
 }
 
 //java
 
 public final class LetFunctionKt {
   public static final void main(@NotNull String[] args) {
      Intrinsics.checkParameterIsNotNull(args, "args");
      String var2 = "testLet";
      int var4 = var2.length();
      System.out.println(var4);
      int result = 1000;
      System.out.println(result);
   }
}
```


## 编译pom.xml
```xml
    <properties>
        <springboot.version>2.1.18.RELEASE</springboot.version>
        <kotlin.version>1.5.0</kotlin.version>

        <java.version>11</java.version>
        <jdk.version>11</jdk.version>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
    </properties>

        <!--        新版本使用-->
        <dependency>
            <groupId>org.jetbrains.kotlin</groupId>
            <artifactId>kotlin-stdlib</artifactId>
            <version>${kotlin.version}</version>
        </dependency>

        <dependency>
            <groupId>org.jetbrains.kotlin</groupId>
            <artifactId>kotlin-reflect</artifactId>
            <version>${kotlin.version}</version>
        </dependency>

    <build>
        <sourceDirectory>${project.basedir}/src/main/java</sourceDirectory>
        <testSourceDirectory>${project.basedir}/src/test/java</testSourceDirectory>
        <plugins>
            <plugin>
                <artifactId>kotlin-maven-plugin</artifactId>
                <groupId>org.jetbrains.kotlin</groupId>
                <version>${kotlin.version}</version>
                <executions>
                    <execution>
                        <id>compile</id>
                        <goals> <goal>compile</goal> </goals>
                        <configuration>
                            <sourceDirs>
                                <!--                                <sourceDir>${project.basedir}/src/main/kotlin</sourceDir>-->
                                <sourceDir>${project.basedir}/src/main/java</sourceDir>
                            </sourceDirs>
                        </configuration>
                    </execution>
                    <execution>
                        <id>test-compile</id>
                        <goals> <goal>test-compile</goal> </goals>
                        <configuration>
                            <sourceDirs>
                                <!--                                <sourceDir>${project.basedir}/src/test/kotlin</sourceDir>-->
                                <sourceDir>${project.basedir}/src/test/java</sourceDir>
                            </sourceDirs>
                        </configuration>
                    </execution>
                </executions>
                <configuration>
                    <jvmTarget>${java.version}</jvmTarget>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>2.1.1.RELEASE</version>
                <configuration>
                    <fork>true</fork> <!-- 如果没有该配置，devtools不会生效 -->
                    <jvmArguments>
                        -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5000,suspend=n
                    </jvmArguments>
                </configuration>
                <executions>
                    <execution>
                        <goals>
                            <goal>repackage</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.0</version>
                <executions>
                    <!-- 替换会被 maven 特别处理的 default-compile -->
                    <execution>
                        <id>default-compile</id>
                        <phase>none</phase>
                    </execution>
                    <!-- 替换会被 maven 特别处理的 default-testCompile -->
                    <execution>
                        <id>default-testCompile</id>
                        <phase>none</phase>
                    </execution>
                    <execution>
                        <id>java-compile</id>
                        <phase>compile</phase>
                        <goals> <goal>compile</goal> </goals>
                    </execution>
                    <execution>
                        <id>java-test-compile</id>
                        <phase>test-compile</phase>
                        <goals> <goal>testCompile</goal> </goals>
                    </execution>
                </executions>
                <configuration>
                    <source>${jdk.version}</source>
                    <target>${jdk.version}</target>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.1.0</version>
                <configuration>
                    <failOnMissingWebXml>false</failOnMissingWebXml>
                    <warName>${project.artifactId}</warName>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-deploy-plugin</artifactId>
                <version>2.8.2</version>
                <configuration>
                    <skip>true</skip>
                    <!--                    deploy 时忽略此model-->
                </configuration>
            </plugin>

            <!-- JUnit 5 requires Surefire version 2.22.1 or higher -->
            <plugin>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>2.22.1</version>
            </plugin>
            <plugin>
                <artifactId>maven-failsafe-plugin</artifactId>
                <version>2.22.2</version>
            </plugin>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-source-plugin</artifactId>
                <version>3.0.1</version>
                <executions>
                    <execution>
                        <id>attach-sources</id>
                        <goals>
                            <goal>jar</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
        <finalName>${project.artifactId}</finalName>
    </build>

```
