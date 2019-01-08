#!/bin/bash - 

JAVA_JDK11=/disk1/opt/jdk-11.0.1/
JAVA_JDK8=/usr/java/jdk1.8.0_65
JAVA_HOME=$JAVA_JDK11
_RUNJAVA="$JAVA_JDK11/bin/java"

if [ "$1" = "8" ] ; then
	_RUNJAVA="$JAVA_JDK8/bin/java"
fi	


if [ ! -x "$_RUNJAVA" ] ; then
	echo "JDK11 路径未配置." >&2
	echo "修改 '$SERVERBIN_HOME/config/configJdk.sh' 中的 JDK11 路径" >&2
	#echo "The JAVA_HOME environment variable is not defined correctly" >&2
	#echo "This environment variable is needed to run this program" >&2
	#echo "NB: JAVA_HOME should point to a JDK not a JRE" >&2
	exit 1
fi

export _RUNJAVA



