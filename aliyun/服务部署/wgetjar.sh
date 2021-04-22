#!/bin/bash - 
#===============================================================================
#
#          FILE: servicerun.sh
# 
#         USAGE: ./servicerun.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月21日 21时02分07秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
wget http://asus88.vicp.net:8123/008target/wb-after-sale-system.jar
chown -R springboot.springbootgroup ./
