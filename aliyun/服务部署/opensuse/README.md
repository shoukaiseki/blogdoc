# opensuse安装服务

### 安装字体配置
```shell
zypper install fontconfig -y
```

### 安装nginx
```shell
zypper install nginx
```
安装完修改配置
```shell
vim /etc/nginx/nginx.conf
```
```nginx
    include vhosts.d/*.conf;
#后面添加以下语句
    include conf.d/*.conf;
```
### 安装redis
```
zypper install redis

mkdir /tmp/win
cd /tmp/win
https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/opensuse/install-redis.sh
sh install-redis.sh
```
### 安装 ranger
```
zypper install ranger
```
### 安装springboot项目为服务
```shell
mkdir /tmp/win
cd /tmp/win
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/opensuse/install-springboot.sh
sh install-springboot.sh 项目名称
例如:
sh install-springboot.sh wangbao
```
安装完成后修改 /etc/nginx/conf.d 文件


