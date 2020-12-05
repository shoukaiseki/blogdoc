# aliyunSetting配置


## 配置阿里云maven仓库
```
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd">
    <localRepository>/home/shoukaiseki/.m2/repository</localRepository>
  <interactiveMode/>
  <usePluginRegistry/>
  <offline/>
  <pluginGroups/>
  <servers/>
  <mirrors>
    <mirror>
     <id>aliyunmaven</id>
     <mirrorOf>central</mirrorOf>
     <name>阿里云公共仓库</name>
     <url>https://maven.aliyun.com/repository/central</url>
    </mirror>
	<mirror>
		<id>aliyunmaven</id>
		<mirrorOf>*</mirrorOf>
		<name>阿里云公共仓库</name>
		<url>https://maven.aliyun.com/repository/public</url>
	</mirror>
    <mirror>
      <id>repo1</id>
      <mirrorOf>central</mirrorOf>
      <name>central repo</name>
      <url>https://repo1.maven.org/maven2/</url>
    </mirror>
  </mirrors>
  <proxies/>
  <activeProfiles/>
  <profiles>
    <profile>
        <repositories>
           <repository>
                <id>aliyunmaven</id>
                <name>aliyunmaven</name>
                <url>https://maven.aliyun.com/repository/public</url>
                <layout>default</layout>
                <releases>
                        <enabled>true</enabled>
                </releases>
                <snapshots>
                        <enabled>false</enabled>
                </snapshots>
            </repository>
            <repository>
                <id>MavenCentral</id>
                <url>https://repo1.maven.org/maven2/</url>
            </repository>
            <repository>
                <id>aliyunmavenApache</id>
                <url>https://maven.aliyun.com/repository/apache-snapshots</url>
            </repository>
			<repository>
				<id>spring</id>
				<url>https://maven.aliyun.com/repository/spring</url>
				<releases>
					<enabled>true</enabled>
				</releases>
				<snapshots>
					<enabled>false</enabled>
				</snapshots>
			</repository>
        </repositories>             
     </profile>
  </profiles>
</settings>
```



# 私有maven-nexus仓库
```
<?xml version="1.0" encoding="UTF-8"?>

<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <servers>
    <server>
      <id>sks-releases</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
    <server>
      <id>sks</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
    <server>
      <id>localRepository</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
    <server>
      <id>sks-snapshots</id>
      <username>admin</username>
      <password>admin123</password>
    </server>
  </servers>

  <mirrors>
    <mirror>
      <id>nexus-public</id>
      <mirrorOf>central</mirrorOf>
      <name>central repository</name>
      <url>http://nexus.shoukaiseki.cn:8081/repository/maven-public/</url>
	   <!--<snapshots>-->
            <!--<enabled>true</enabled>-->
        <!--</snapshots>-->
    </mirror>
    <mirror>
      <id>nexus-snapshots</id>
      <mirrorOf>central</mirrorOf>
      <name>central repository</name>
      <url>http://nexus.shoukaiseki.cn:8081/repository/mypublice-snapshot/</url>
	   <!--<snapshots>-->
            <!--<enabled>true</enabled>-->
        <!--</snapshots>-->
    </mirror>
  </mirrors>

<profiles>
	<profile>     
		<id>nexus</id>
		<repositories>
			<repository>
				<id>central</id>
				<name>Nexus</name>
				<url>http://nexus.shoukaiseki.cn:8081/repository/maven-public/</url>
				<releases><enabled>true</enabled></releases>
				<snapshots>
					<enabled>true</enabled>
					<!-- 这句是关键,需要一直判断快照是否最新 -->
					<updatePolicy>always</updatePolicy>  
					<checksumPolicy>warn</checksumPolicy>  
				</snapshots>
			</repository>
		</repositories>
	</profile>
</profiles>
<!-- 必须添加,不然profiles不生效 -->
<activeProfiles>
	<activeProfile>nexus</activeProfile>
</activeProfiles>

</settings>
```
