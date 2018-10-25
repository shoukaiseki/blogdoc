# maven 私有仓库配置


## 下载
nexus下载地址：http://www.sonatype.org/nexus/go


## 安装
解压到 E 盘 maven_nexus 目录

E:\maven_nexus\nexus-3.13.0-01\bin 下创建一个 安装服务.bat 批处理文件

```Bat
E:\maven_nexus\nexus-3.13.0-01\bin\nexus.exe /install
pause
```

右键点击用 管理员打开

就能在系统服务中看到,启动服务


## 配置

http://localhost:8081

默认账户密码为 admin/admin123

登录后进入设置->Repository->Blob Store->Create blob store,

```
Type: File
Name: e
Path:E:\maven_nexus\blobs\e
```


## 配置仓库
Repository->Repositories->Create repository-> maven2(proxy)

将下列几个仓库添加进去

### alfresco-public
```
Name:alfresco-public
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Release

#### Proxy
```
Remote storage:
https://artifacts.alfresco.com/nexus/content/groups/public
```

#### Storage
Blob store: e



### alfresco-public-snapshots
```
Name:alfresco-public-snapshots
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Snapshot

#### Proxy
```
Remote storage:
https://artifacts.alfresco.com/nexus/content/groups/public-snapshots
```

#### Storage
Blob store: e



### aliyungoogle
```
Name:aliyungoogle
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Release

#### Proxy
```
Remote storage:
https://maven.aliyun.com/repository/google
```

#### Storage
Blob store: e


### aliyunpublic
```
Name:aliyunpublic
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Release

#### Proxy
```
Remote storage:
https://maven.aliyun.com/repository/public
```

#### Storage
Blob store: e



### beardedgeeks-releases
```
Name:beardedgeeks-releases
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Release

#### Proxy
```
Remote storage:
http://beardedgeeks.googlecode.com/svn/repository/releases
```

#### Storage
Blob store: e

### central-maven
```
Name:central-maven
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Release

#### Proxy
```
Remote storage:
http://central.maven.org/maven2/
```

#### Storage
Blob store: e

### googlemaven
```
Name:beardedgeeks-releases
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Release

#### Proxy
```
Remote storage:
https://maven.google.com
```

#### Storage
Blob store: e


### jitpack
```
Name:jitpack
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Release

#### Proxy
```
Remote storage:
https://jitpack.io
```

#### Storage
Blob store: e




### spring-milestones
```
Name:spring-milestones
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Release

#### Proxy
```
Remote storage:
https://repo.spring.io/milestone
```

#### Storage
Blob store: e

### spring-public
```
Name:spring-public
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Release

#### Proxy
```
Remote storage:
http://repo.spring.io/release
```

#### Storage
Blob store: e

### spring-snapshots
```
Name:spring-snapshots
Format: maven2
Type: proxy
Onllne: yes
```

#### Maven2

Verslon Pollcy: Snapshot

#### Proxy
```
Remote storage:
https://repo.spring.io/snapshot
```

#### Storage
Blob store: e


### mypublice
```
Name:mypublice
Format: maven2
Type: hosted
Onllne: yes
```

#### Maven2

Verslon Pollcy: Release


#### Storage
Blob store: e
#### Hosted
Deployment pollcy: Allow redeploy


### mypublice-snapshot
```
Name:mypublice-snapshot
Format: maven2
Type: hosted
Onllne: yes
```

#### Maven2

Verslon Pollcy: Snapshot

#### Storage
Blob store: e

#### Hosted
Deployment pollcy: Allow redeploy

## 总仓库地址设置

Repository->Repositories->maven-public


最下面的 Group 将左边的全部添加到右边
