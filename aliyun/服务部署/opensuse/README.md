# opensuse安装服务

### 安装nginx
```shell
zypper install nginx
```
### 安装redis
```
zypper install redis
```
### 安装 ranger
```
zypper install ranger
```
### 安装springboot项目为服务
```shell
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/opensuse/install-springboot.sh
sh install-springboot.sh 项目名称
例如:
sh install-springboot.sh wangbao
```
安装完成后修改 /etc/nginx/conf.d 文件


