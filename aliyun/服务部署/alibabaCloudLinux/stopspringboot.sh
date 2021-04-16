#!/bin/bash - 
#===============================================================================
#
#          FILE: stopspringboot.sh
# 
#         USAGE: ./stopspringboot.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2021年01月28日 20时57分00秒
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

AppName=wb000-admin.jar
echo "Stop $AppName"

PID=""
query(){
	PID=`ps -ef |grep java|grep $AppName|grep -v grep|awk '{print $2}'`
}

query
if [ x"$PID" != x"" ]; then
	kill -9 $PID
	echo "$AppName (pid:$PID) exiting..."
	while [ x"$PID" != x"" ]
	do
		sleep 1
		query
	done
	echo "$AppName exited."
else
	echo "$AppName already stopped."
fi


