#!/bin/sh
_JDK_VERSION=8
_SERVER_NAME=apiview
_SERVER_PATH=$_SERVER_NAME
_JAR_NAME=$_SERVER_NAME".jar"

PID_NAME=apiview.pid


## shell脚本所在目录
PRG="$0"

# need this for relative symlinks
while [ -h "$PRG" ] ; do
	ls=`ls -ld "$PRG"`
	link=`expr "$ls" : '.*-> \(.*\)$'`
	if expr "$link" : '/.*' > /dev/null; then
		PRG="$link"
	else
		PRG="`dirname "$PRG"`/$link"
	fi
done


SERVERBIN_HOME=`dirname "$PRG"`/..
# make it fully qualified
SERVERBIN_HOME=`cd "$SERVERBIN_HOME" && pwd`

echo SERVERBIN_HOME=$SERVERBIN_HOME
echo source $SERVERBIN_HOME/config/configJdk.sh
#加载jdk,版本号
. $SERVERBIN_HOME/config/configJdk.sh $_JDK_VERSION

#加载 _BASE_WORK_HOME目录
. $SERVERBIN_HOME/config/setenv.sh

#PID存放
_RUNPID=$SERVERBIN_HOME/temp/$PID_NAME
#
WORK_HOME=$_BASE_WORK_HOME/$_SERVER_PATH
#echo WORK_HOME=$WORK_HOME



start()
{
  if [ ! -z "$_RUNPID" ]; then
    if [ -f "$_RUNPID" ]; then
      if [ -s "$_RUNPID" ]; then
        echo "Existing PID file found during start."
        if [ -r "$_RUNPID" ]; then
          PID=`cat "$_RUNPID"`
          ps -p $PID >/dev/null 2>&1
          if [ $? -eq 0 ] ; then
            echo "$_SERVER_NAME appears to still be running with PID $PID. Start aborted."
            echo "If the following process is not a Tomcat process, remove the PID file[$_RUNPID] and try again:"
            ps -f -p $PID
            exit 1
          else
            echo "Removing/clearing stale PID file."
            rm -f "$_RUNPID" >/dev/null 2>&1
            if [ $? != 0 ]; then
              if [ -w "$_RUNPID" ]; then
                cat /dev/null > "$_RUNPID"
              else
                echo "Unable to remove or clear stale PID file. Start aborted."
                exit 1
              fi
            fi
          fi
        else
          echo "Unable to read PID file. Start aborted."
          exit 1
        fi
      else
        rm -f "$_RUNPID" >/dev/null 2>&1
        if [ $? != 0 ]; then
          if [ ! -w "$_RUNPID" ]; then
            echo "Unable to remove or write to empty PID file. Start aborted."
            exit 1
          fi
        fi
      fi
    fi
  fi

  _CONSOLE_LOG=$WORK_HOME/logs/console`date +%Y-%m-%d`.log

  nohup $_RUNJAVA -Duser.home=$WORK_HOME  -jar $WORK_HOME/$_JAR_NAME --spring.config.location=$WORK_HOME/application.yml >> $_CONSOLE_LOG 2>&1 & echo $! > $_RUNPID
  echo "start end,you can command..."
  echo "    tail -f $_CONSOLE_LOG"
}

stop()
{
  shift
  SLEEP=5
  if [ ! -z "$_RUNPID" ]; then
    if [ -f "$_RUNPID" ]; then
      if [ -s "$_RUNPID" ]; then
        kill -0 `cat "$_RUNPID"` >/dev/null 2>&1
        if [ $? -gt 0 ]; then
          echo "PID file found but either no matching process was found or the current user does not have permission to stop the process. Stop aborted."
          exit 1
        fi
      else
        echo "PID file is empty and has been ignored."
      fi
    else
      echo "$_RUNPID was set but the specified file does not exist. Is $_SERVER_NAME running? Stop aborted."
      exit 1
    fi
  fi

  echo "asus....."

  # stop failed. Shutdown port disabled? Try a normal kill.
  if [ ! -z "$_RUNPID" ]; then
	  echo "The stop command failed. Attempting to signal the process to stop through OS signal."
	  kill -15 `cat "$_RUNPID"` >/dev/null 2>&1
	  rm -f "$_RUNPID" >/dev/null 2>&1
  fi
  echo "stop end"
}


if [ "$1" = "start" ] ; then
	start
elif [ "$1" = "stop" ]; then
	stop
elif [ "$1" = "-h" ]; then
  # $0 是脚本名称
  echo "Usage: $0 ( commands ... )"
  echo "commands:"
  echo "  start             启动服务"
  echo "  stop              停止服务"
  exit 1

else
	start
fi	

