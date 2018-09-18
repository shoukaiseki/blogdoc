set CLASSPATH=%~dp0target\apiview.jar



if exist "C:\usr\java\jdk1.8.0_151" (
	set JAVA_HOME=C:\usr\java\jdk1.8.0_151
) else (
	set JAVA_HOME=D:\usr\java\jdk1.8.0_131
)

set CLASSPATH=%JAVA_HOME%\lib;%JAVA_HOME%\lib\tools.jar;%CLASSPATH%

set CLASSPATH=%JAVA_HOME%\lib\rt.jar;%CLASSPATH%
set CLASSPATH=%CLASSPATH%

echo CLASSPATH=%CLASSPATH%

set JAVA_OPTS=-Xms128m -Xmx512m

echo _JAVA_OPTIONS=%_JAVA_OPTIONS%

set PARAS_OPTS=-Dserver.port=8182
%JAVA_HOME%\bin\java.exe -version

%JAVA_HOME%\bin\java %JAVA_OPTS% %PARAS_OPTS%  -jar %~dp0target\apiview.jar  com.ruoyi.RuoYiApplication
@REM pause