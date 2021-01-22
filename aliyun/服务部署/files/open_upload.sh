#!/bin/bash - 
#===============================================================================
#
#          FILE: open_upload.sh
# 
#         USAGE: ./open_upload.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月22日 18时35分08秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
su springboot /bin/open_upload_http.sh

