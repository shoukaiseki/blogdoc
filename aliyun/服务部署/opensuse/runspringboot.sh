#!/bin/bash

APP_HOME=/data/server/springboot/wb520
AppName=wb520-admin.jar

#JVM参数
JVM_OPTS="-Dname=$AppName -Duser.home=$APP_HOME -Duser.timezone=Asia/Shanghai -Xms512M -Xmx2048M -XX:+HeapDumpOnOutOfMemoryError  -XX:+PrintGCDetails -XX:NewRatio=1 -XX:SurvivorRatio=30 -XX:+UseParallelGC -XX:+UseParallelOldGC"
SPRING_OPTS=" -Dlogging.path=$APP_HOME/templogs/  --spring.config.location=$APP_HOME/application.yml"
LOG_PATH=$APP_HOME/logs/$AppName.log

echo java $JVM_OPTS -jar $APP_HOME/$AppName $SPRING_OPTS 
/data/usr/jdk-11.0.9/bin/java $JVM_OPTS -jar $APP_HOME/$AppName $SPRING_OPTS > $APP_HOME/spring.log
