#!/bin/bash - 
#===============================================================================
#
#          FILE: start_install.sh
# 
#         USAGE: ./start_install.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月22日 18时35分40秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

zypper install ranger -y

mkdir /data
mkdir /data/server
mkdir /data/server/springboot
mkdir /data/server/web
mkdir /data/server/springboot/wb520
mkdir /data/server/springboot/wb520/logs
mkdir /data/server/springboot/wb520/templogs

groupadd springbootgroup
useradd springboot -G springbootgroup

cd /data/server
chown -R springboot.springbootgroup springboot
mkdir /home/springboot
chown -R springboot.springbootgroup /home/springboot

mkdir /data/usr
cd /data/usr
wget http://asus88.vicp.net:9000/jdk/jdk-11.0.9_linux-x64_bin.tar.gz
tar zxvf jdk-11.0.9_linux-x64_bin.tar.gz

cd /usr/lib/systemd/system
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/opensuse/redis.service

cd /etc
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/opensuse/redis.conf

systemctl daemon-reload
systemctl enable redis.service
systemctl start redis


echo '如果systemctl方式起不了服务,则将 /data/server/springboot 777 授权'
