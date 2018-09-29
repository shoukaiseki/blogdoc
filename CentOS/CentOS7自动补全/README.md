# CentOS7自动补全


## 前言
之前使用mvn 命令,没有提示补全命令,很不爽

## 解决方案
安装 bash-completion 插件

因为CentOS官方源并不带有bash-completion的包，所以，为了可用yum安装，增加epel的源，

首先，使用wget下载epel的rpm包，使用rpm指令安装，之后运行yum安装，代码如下：


```Shell
wget http://mirrors.yun-idc.com/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm
sudo rpm -ivh epel-release-7-11.noarch.rpm
sudo yum clean all
sudo yum makecache
sudo yum install -y bash-completion
```



