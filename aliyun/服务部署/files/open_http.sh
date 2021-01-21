#!/bin/bash - 
#===============================================================================
#
#          FILE: open_http.sh
# 
#         USAGE: ./open_http.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月06日 22时31分37秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
python3 -m http.server 8123

