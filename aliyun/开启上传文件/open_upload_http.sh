#!/bin/bash - 
#===============================================================================
#
#          FILE: open_upload_http.sh
# 
#         USAGE: ./open_upload_http.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月22日 18时11分59秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
python /data/server/droopy -m '来上传文件啊'

