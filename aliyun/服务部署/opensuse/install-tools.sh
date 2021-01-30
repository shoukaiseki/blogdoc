#!/bin/bash - 
#===============================================================================
#
#          FILE: install-tools.sh
# 
#         USAGE: ./install-tools.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月30日 16时45分29秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

zypper install ranger -y
