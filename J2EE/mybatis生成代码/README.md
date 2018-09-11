# mybatis生成代码

## 使用mvn生成

```Shell
mvn mybatis-generator:generate 
```


pom.xml中添加插件

```Xml
    <build>
        <plugins>

            <!-- mybatis 生成Model和xml
                 执行    mvn mybatis-generator:generate  生成
             -->
            <plugin>
                <groupId>org.mybatis.generator</groupId>
                <artifactId>mybatis-generator-maven-plugin</artifactId>
                <version>1.3.7</version>
                <configuration>
                    <verbose>true</verbose>
                    <overwrite>true</overwrite>
                </configuration>
                <dependencies>
                    <dependency>
                        <groupId>mysql</groupId>
                        <artifactId>mysql-connector-java</artifactId>
                        <version>8.0.12</version>
                    </dependency>

                </dependencies>
            </plugin>


        </plugins>
    </build>
```


generatorConfig.xml 内容

```Xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
        PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">
<generatorConfiguration>
    <!--导入属性配置 -->
    <!--<properties resource="generator.properties"></properties>-->

    <!--由于在pom.xml中加入插件时已经配置数据库驱动包，所以此处不必配置了 -->
    <!--<classPathEntry location="/home/sks/.m2/repository/mysql/mysql-connector-java/8.0.12/mysql-connector-java-8.0.12.jar"/>-->

    <context id="default" targetRuntime="MyBatis3">


        <!-- optional，旨在创建class时，对注释进行控制 -->
        <commentGenerator>
            <!--<property name="suppressDate" value="false" />-->

            <!-- 去掉注释 -->
            <property name="suppressDate" value="true"/>
            <property name="suppressAllComments" value="true" />

        </commentGenerator>


        <!--jdbc的数据库连接 -->
        <jdbcConnection driverClass="com.mysql.cj.jdbc.Driver" connectionURL="jdbc:mysql://sys.db.hkedou.com:3307/yuanhuo?serverTimezone=GMT%2B8" userId="root" password="H666777kd">
        </jdbcConnection>



        <!-- 非必需，类型处理器，在数据库类型和java类型之间的转换控制-->
        <javaTypeResolver >
            <property name="forceBigDecimals" value="false" />
        </javaTypeResolver>

        <!-- Model模型生成器,用来生成含有主键key的类，记录类 以及查询Example类
            targetPackage     指定生成的model生成所在的包名
            targetProject     指定在该项目下所在的路径
        -->
        <javaModelGenerator targetPackage="com.hkedou.yuanhuo.config.cache.model" targetProject="src/main/java">
            <!-- 是否对model添加 构造函数 -->
            <property name="constructorBased" value="true"/>

            <!-- 是否允许子包，即targetPackage.schemaName.tableName -->
            <property name="enableSubPackages" value="false"/>

            <!-- 建立的Model对象是否 不可改变  即生成的Model对象不会有 setter方法，只有构造方法 -->
            <property name="immutable" value="false"/>

            <!-- 给Model添加一个父类 -->
            <!-- <property name="rootClass" value="com.foo.louis.Hello"/> -->

            <!-- 是否对类CHAR类型的列的数据进行trim操作 -->
            <property name="trimStrings" value="true"/>
        </javaModelGenerator>

        <!--Mapper映射文件生成所在的目录 为每一个数据库的表生成对应的SqlMap文件 -->
        <sqlMapGenerator targetPackage="mybatis.viplevel" targetProject="src/main/resources">
            <property name="enableSubPackages" value="false"/>
        </sqlMapGenerator>


        <!-- 客户端代码，生成易于使用的针对Model对象和XML配置文件 的代码
                type="ANNOTATEDMAPPER",生成Java Model 和基于注解的Mapper对象
                type="MIXEDMAPPER",生成基于注解的Java Model 和相应的Mapper对象
                type="XMLMAPPER",生成SQLMap XML文件和独立的Mapper接口
        -->
        <javaClientGenerator targetPackage="com.hkedou.yuanhuo.config.cache.mapper" targetProject="src/main/java" type="MIXEDMAPPER">
            <property name="enableSubPackages" value=""/>
            <!--
                    定义Maper.java 源代码中的ByExample() 方法的可视性，可选的值有：
                    public;
                    private;
                    protected;
                    default
                    注意：如果 targetRuntime="MyBatis3",此参数被忽略
             -->
            <property name="exampleMethodVisibility" value=""/>
            <!--
                                           方法名计数器
              Important note: this property is ignored if the target runtime is MyBatis3.
             -->
            <property name="methodNameCalculator" value=""/>

            <!--
                                                为生成的接口添加父接口
             -->
            <property name="rootInterface" value=""/>

        </javaClientGenerator>
        <table tableName="buyer_vip_level_config" domainObjectName="BuyerVipLevelConfig"
               enableCountByExample="false" enableUpdateByExample="false"
               enableDeleteByExample="false" enableSelectByExample="false"
               selectByExampleQueryId="false">
        </table>
    </context>
</generatorConfiguration>
```

