#!/bin/bash - 
#===============================================================================
#
#          FILE: install-redis.sh
# 
#         USAGE: ./install-redis.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月30日 15时24分46秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cd /usr/lib/systemd/system
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/opensuse/redis.service

cd /etc
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E6%9C%8D%E5%8A%A1%E9%83%A8%E7%BD%B2/opensuse/redis.conf

systemctl daemon-reload
systemctl enable redis.service
systemctl start redis
