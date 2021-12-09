#!/bin/bash - 
#===============================================================================
#
#          FILE: wgetweb.sh
# 
#         USAGE: ./wgetweb.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年12月09日 14时06分17秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

webGet http://mvn.shoukaiseki.cn:8123/wb780dist.tar.gz
tar zxvf wb780dist.tar.gz
