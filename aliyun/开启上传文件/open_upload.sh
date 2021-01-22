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
#       CREATED: 2021年01月23日 02时40分57秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
su springboot /bin/open_upload_http.sh

