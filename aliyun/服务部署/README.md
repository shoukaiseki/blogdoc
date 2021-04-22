# 服务部署

## 创建用户
```
groupadd springbootgroup
useradd springboot -G springbootgroup
```

## RDS云数据库
#### 参数设置
```
lock_wait_timeout=300
```
锁最长时间,设置为5分钟即可,不然表被锁了不提交要默认31536000秒(1年)才能释放



## ECS Alibaba Cloud Linux  2.1903 LTS 64位
### 安装 ranger
```shell
mkdir /data/usr
cd /data/usr
wget https://ranger.github.io/ranger-stable.tar.gz
tar zxvf ranger-stable.tar.gz
ln -s /data/usr/ranger-1.9.3/ranger.py /bin/ranger
```
之后就能执行ranger运行文件管理了

### 安装nginx
```bash
yum install nginx
```
#### 配置nginx
```bash
vim /etc/nginx/nginx.conf
```

```
worker_processes  1;

events {
	worker_connections  1024;
}

http {
	include       mime.types;
	default_type  application/octet-stream;
	sendfile        on;
	keepalive_timeout  65;

	server {
		fastcgi_intercept_errors on;
		listen       80;
		server_name  localhost;

		location / {
			root /data/server/web/dist;
			try_files $uri $uri/ /index.html;
			index  index.html index.htm;
		}

		location /prod-api/{
			proxy_set_header Host $http_host;
			proxy_set_header X-Real-IP $remote_addr;
			proxy_set_header REMOTE-HOST $remote_addr;
			proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			proxy_pass http://localhost:8080/;
		}

		error_page   500 502 503 504  /50x.html;
		location = /50x.html {
			root   html;
		}
	}
}
```
##### nginx 启动停止
```
systemctl start nginx
systemctl stop nginx
```

### 前端代码
```
mkdir /data/server
mkdir /data/server/web
```
打包成 dist.tar.gz 上传到 /data/server/web

再在服务端解压
```
cd /data/server/web
tar zxvf dist.tar.gz
```

### 安装redis
```
yum install redis
```

### 增加临时开启下载端口服务
```
vim /usr/bin/open_http.sh
```
内容如下
```python
#!/bin/bash - 
#===============================================================================
#
#          FILE: open_http.sh
# 
#         USAGE: ./open_http.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月06日 22时31分37秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
python3 -m http.server 8123
```

```
chmod +x /usr/bin/open_http.sh
```

### 安装jdk
查找yum源的jdk,找到对应版本
```shell
yum search jdk

yum install java-11-openjdk.x86_64
```

```shell
mkdir /data/server
mkdir /data/server/springboot
mkdir /data/server/springboot/temp
cd /data/server
chown -R springboot.springbootgroup springboot
mkdir /home/springboot
chown -R springboot.springbootgroup /home/springboot
```

#### 新增启动脚本
```bash
vim /data/server/springboot/runspringboot.sh
```

内容如下
```shell
#!/bin/bash

APP_HOME=/data/server/springboot
AppName=wb802-admin.jar

#JVM参数
JVM_OPTS="-Dname=$AppName -Duser.home=$APP_HOME -Duser.timezone=Asia/Shanghai -Xms512M -Xmx2048M -XX:+HeapDumpOnOutOfMemoryError  -XX:+PrintGCDetails -XX:NewRatio=1 -XX:SurvivorRatio=30 -XX:+UseParallelGC -XX:+UseParallelOldGC"
SPRING_OPTS=" -Dlogging.path=$APP_HOME/templogs/  --spring.config.location=$APP_HOME/application.yml"
LOG_PATH=$APP_HOME/logs/$AppName.log

echo java $JVM_OPTS -jar $APP_HOME/$AppName $SPRING_OPTS 
su springboot java $JVM_OPTS -jar $APP_HOME/$AppName $SPRING_OPTS > $APP_HOME/spring.log
```

vim /data/server/springboot/servicerun.sh
```shell
su springboot /data/server/springboot/runspringboot.sh
```

#### 新建配置文件
```bash
vim /data/server/springboot/application.yml
```
内容如下
```yaml
# 项目相关配置
ruoyi:
    # 名称
    name: RuoYi
    # 版本
    version: 3.2.1
    # 版权年份
    copyrightYear: 2020
    # 实例演示开关
    demoEnabled: true
    # 文件路径 示例（ Windows配置D:/ruoyi/uploadPath，Linux配置 /home/ruoyi/uploadPath）
    profile: ${user.home}/uploadPath
    # 获取ip地址开关
    addressEnabled: false
    # 验证码类型 math 数组计算 char 字符验证
    captchaType: math
    # 验证码开关 SysLoginService 添加判断
    captchaEnabled: false


# 开发环境配置
server:
    # 服务器的HTTP端口，默认为8080
    port: 8080
    servlet:
        # 应用的访问路径
        context-path: /
    tomcat:
        # tomcat的URI编码
        uri-encoding: UTF-8
        # tomcat最大线程数，默认为200
        max-threads: 800
        # Tomcat启动初始化的线程数，默认值25
        min-spare-threads: 30

# 日志配置
logging:
    level:
        root: warn
        org.shoukaiseki.initdict: debug
        com.ruoyi: debug
        org.springframework: warn
        com.ruoyi.generator.util.GenUtils: debug

# token配置
token:
    # 令牌自定义标识
    header: Authorization
    # 令牌密钥
    secret: abcdefghijklmnopqrstuvwxyz
    # 令牌有效期（默认30分钟）
    expireTime: 3000

# MyBatis配置
mybatis:
    # 搜索指定包别名
    typeAliasesPackage: com.ruoyi.**.domain
    # 配置mapper的扫描，找到所有的mapper.xml映射文件
    mapperLocations: classpath*:mapper/**/*Mapper.xml
    # 加载全局的配置文件
    configLocation: classpath:mybatis/mybatis-config.xml

# PageHelper分页插件
pagehelper:
    helperDialect: mysql
    reasonable: true
    supportMethodsArguments: true
    params: count=countSql

# Swagger配置
swagger:
    # 是否开启swagger
    enabled: true
    # 请求前缀
    pathMapping: /dev-api

# 防止XSS攻击
xss:
    # 过滤开关
    enabled: true
    # 排除链接（多个用逗号分隔）
    excludes: /system/notice/*
    # 匹配链接
    urlPatterns: /system/*,/monitor/*,/tool/*
# 代码生成
gen:
    # 作者
    author: wb
    # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool
    packageName: com.ruoyi.project.wb
    # 自动去除表前缀，默认是true
    autoRemovePre: true
    # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）
    tablePrefix: sys_,wb_

wb:
    inventory:
        addItemInitInventory: true
        defaultLocation:  'default'
        defaultContainer: 'default'

sks:
    process:
        task:
            notification:
                sendPhoneFlag: true
                sendPushFlag: true
                sendMailFlag: true
    aliyun:
        oss:
            token:
                sysEndpoint: 'sts.cn-hangzhou.aliyuncs.com'  #不要带http，sdk最自动会拼接
                endpoint: "oss-cn-hangzhou.aliyuncs.com"
                accessKeyId: 'xxxx'
                secretAccessKey: 'xxxx'
                bucketName: 'xxxx'
                roleArn: 'acs:ram::xxxx'
                roleSessionName: 'sks' #自定义名称
            multipart:
                base:
                    savePath: 'doc' #保存到 bucketName 中的目录名称
# Spring配置
# 数据源配置
spring:
    # 资源信息
    messages:
        # 国际化资源文件路径
        basename: i18n/messages,i18n/process_messages
    profiles:
        active: druid
    # 文件上传
    servlet:
        multipart:
            # 单个文件大小
            max-file-size: 10MB
            # 设置总上传的文件大小
            max-request-size: 20MB
    # 服务模块
    devtools:
        restart:
            # 热部署开关
            enabled: true
    # redis 配置
    redis:
        # 地址
        #        host: localhost
        host:  localhost
       # 端口，默认为6379
        port: 6379
        # 密码
        password:
        database: 10
        # 连接超时时间
        timeout: 10s
        lettuce:
            pool:
                # 连接池中的最小空闲连接
                min-idle: 0
                # 连接池中的最大空闲连接
                max-idle: 8
                # 连接池的最大数据库连接数
                max-active: 8
                # #连接池最大阻塞等待时间（使用负值表示没有限制）
                max-wait: -1ms

    datasource:
        type: com.alibaba.druid.pool.DruidDataSource
        driverClassName: com.mysql.cj.jdbc.Driver
        druid:
            # 主库数据源
            master:
                url: jdbc:mysql://localhost:3306/sks?useUnicode=true&characterEncoding=utf-8&useSSL=false&serverTimezone=GMT%2B8&allowPublicKeyRetrieval=true
                username: root
                password: xxxxxx

            # 从库数据源
            slave:
                # 从数据源开关/默认关闭
                enabled: false
                url:
                username:
                password:
            # 初始连接数
            initialSize: 5
            # 最小连接池数量
            minIdle: 10
            # 最大连接池数量
            maxActive: 20
            # 配置获取连接等待超时的时间
            maxWait: 60000
            # 配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒
            timeBetweenEvictionRunsMillis: 60000
            # 配置一个连接在池中最小生存的时间，单位是毫秒
            minEvictableIdleTimeMillis: 300000
            # 配置一个连接在池中最大生存的时间，单位是毫秒
            maxEvictableIdleTimeMillis: 900000
            # 配置检测连接是否有效
            validationQuery: SELECT 1 FROM DUAL
            testWhileIdle: true
            testOnBorrow: false
            testOnReturn: false
            webStatFilter:
                enabled: true
            statViewServlet:
                enabled: true
                # 设置白名单，不填则允许所有访问
                allow:
                url-pattern: /druid/*
                # 控制台管理用户名和密码
                login-username:
                login-password:
            filter:
                stat:
                    enabled: true
                    # 慢SQL记录
                    log-slow-sql: true
                    slow-sql-millis: 1000
                    merge-sql: true
                wall:
                    config:
                        multi-statement-allow: true
```

### 注册为系统服务
```
sudo vim /lib/systemd/system/springboot.service
```
```
sudo vim /usr/lib/systemd/system/springboot.service
```
##### 查看服务起动日志
```
sudo journalctl -f -u springboot.service
```

内容如下
```
[Unit]
Description=springboot

[Service]
WorkingDirectory=/data/server/springboot/temp/
PrivateTmp=true
Restart=always
Type=simple
ExecStart=/usr/bin/bash /data/server/springboot/servicerun.sh
ExecStop=/usr/bin/kill -9  $MAINPID


[Install]
WantedBy=multi-user.target
```
#### systemctl 管理，让配置生效。若是修改配置文件，需要reload

```shell
sudo systemctl daemon-reload

sudo systemctl enable springboot.service

systemctl start springboot
```


#### 删除服务
https://blog.csdn.net/stpice/article/details/104569146/
禁用服务
```
systemctl disable springboot1.service
```
屏蔽服务
```
systemctl unmask springboot1.service

```
取消屏蔽
```
systemctl unmask springboot1.service
```
