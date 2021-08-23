#!/bin/bash - 
#===============================================================================
#
#          FILE: wgetjar.sh
# 
#         USAGE: ./wgetjar.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年08月23日 21时10分26秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
webGet http://mvn.shoukaiseki.cn:8123/targetToWin/wb000target/wb000-admin.jar
chown -R springboot.springbootgroup ./


