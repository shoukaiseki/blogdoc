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

#set -o nounset                              # Treat unset variables as an error

if [ ! -n "$1" ]; then
  echo "请输入服务名称"
  echo "sh install-springboot.sh 服务名"
  exit 1
fi

CRTDIR=$(pwd)


echo projectName=$1
projectName=$1



if [ ! -d "/data/server/springboot" ]; then
	mkdir /data
	mkdir /data/server
	mkdir /data/server/springboot
fi
mkdir /data/server/springboot/$projectName
mkdir /data/server/springboot/$projectName/logs
mkdir /data/server/springboot/$projectName/templogs
mkdir /data/server/springboot/$projectName/temp
if [ ! -d "/data/server/web" ]; then
	mkdir /data/server/web
fi
mkdir /data/server/web/$projectName



groupadd springbootgroup
useradd springboot -G springbootgroup

cd /data/server
chown -R springboot.springbootgroup springboot
mkdir /home/springboot
chown -R springboot.springbootgroup /home/springboot

#如果文件夹不存在，下载jdk解压
if [ ! -d "/data/usr/jdk-11.0.9" ]; then
	mkdir /data/usr
	cd /data/usr
	wget http://asus88.vicp.net:9000/jdk/jdk-11.0.9_linux-x64_bin.tar.gz
	tar zxvf jdk-11.0.9_linux-x64_bin.tar.gz
else
	echo 'jdk已存在'
fi

cd $CRTDIR
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/alibabaCloudLinux/wb000.service
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/alibabaCloudLinux/stopspringboot.sh
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/alibabaCloudLinux/servicerun.sh
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/alibabaCloudLinux/runspringboot.sh
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/alibabaCloudLinux/nginx-wb000.conf

sed -i "s/wb000/${projectName}/g" stopspringboot.sh
sed -i "s/wb000/${projectName}/g" servicerun.sh
sed -i "s/wb000/${projectName}/g" runspringboot.sh
sed -i "s/wb000/${projectName}/g" wb000.service
sed -i "s/wb000/${projectName}/g" nginx-wb000.conf
cp stopspringboot.sh  /data/server/springboot/$projectName/
cp servicerun.sh  /data/server/springboot/$projectName/
cp runspringboot.sh  /data/server/springboot/$projectName/
cp wb000.service /usr/lib/systemd/system/${projectName}.service
chmod 777 /data/server/springboot/$projectName/stopspringboot.sh
chmod 777  /data/server/springboot/$projectName/servicerun.sh
chmod 777  /data/server/springboot/$projectName/runspringboot.sh

cp nginx-wb000.conf /etc/nginx/conf.d/$projectName.conf

systemctl daemon-reload
systemctl enable ${projectName}.service
echo 就会在/etc/systemd/system/multi-user.target.wants/目录下新建一个/usr/lib/systemd/system/nginx.service 文件的链接。

echo '如果systemctl方式起不了服务,则将 /data/server/springboot 777 授权'




