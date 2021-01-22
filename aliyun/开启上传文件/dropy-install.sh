#!/bin/bash - 
#===============================================================================
#
#          FILE: dropy-install.sh
# 
#         USAGE: ./dropy-install.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月22日 18时14分40秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


cd /tmp
wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E5%BC%80%E5%90%AF%E4%B8%8A%E4%BC%A0%E6%96%87%E4%BB%B6/droopy8123 -O droopy8123
cp -f /tmp/droopy8123  /data/server/droopy8123

wget https://gitee.com/shoukaiseki/blogdoc/raw/master/aliyun/%E5%BC%80%E5%90%AF%E4%B8%8A%E4%BC%A0%E6%96%87%E4%BB%B6/open_upload_http.sh -O open_upload_http.sh
chmod +x open_upload_http.sh
cp -f /tmp/open_upload_http.sh  /bin/open_upload_http.sh
chmod +x /bin/open_upload_http.sh

