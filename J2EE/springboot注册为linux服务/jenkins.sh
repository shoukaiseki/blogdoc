#!/bin/bash -
#===============================================================================
#
#          FILE: jenkins.sh
#
#         USAGE: ./jenkins.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年09月19日 20时26分07秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
#mvn clean
mvn package -Dmaven.test.skip=true

webserver=/disk1/webserver
basepath=$(cd `dirname $0`; pwd)
service eureka-server stop
cp -r -f $basepath/eureka-server/target/eureka-server.jar $webserver/eureka-server/eureka-server.jar
service eureka-server start

service eureka-center stop
cp -r -f $basepath/eureka-center/target/eureka-center.jar $webserver/eureka-center/eureka-center.jar
service eureka-center start
