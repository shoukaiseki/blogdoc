#!/bin/bash

APP_HOME=/data/server/springboot
AppName=wb802-admin.jar
CATALINA_TMPDIR=$APP_HOME/temp

#JVM参数
JVM_OPTS="-Dname=$AppName -Duser.home=$APP_HOME -Duser.timezone=Asia/Shanghai -Xms512M -Xmx2048M -XX:+HeapDumpOnOutOfMemoryError  -XX:+PrintGCDetails -XX:NewRatio=1 -XX:SurvivorRatio=30 -XX:+UseParallelGC -XX:+UseParallelOldGC"
SPRING_OPTS=" -Dlogging.path=$APP_HOME/templogs/  --spring.config.location=$APP_HOME/application.yml"
LOG_PATH=$APP_HOME/logs/$AppName.log

echo java $JVM_OPTS -jar $APP_HOME/$AppName $SPRING_OPTS 
java $JVM_OPTS -jar $APP_HOME/$AppName $SPRING_OPTS > $APP_HOME/spring.log
