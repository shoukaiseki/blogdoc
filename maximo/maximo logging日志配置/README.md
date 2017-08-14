# maximo logging日志配置

logging.properties

maximo.service.SECURITY
```Properties
# /

# ~~ MAXIMO Log configuration file

#

# MAXIMO Logging is currently based on Log4j logging, which is an 

# open source project developed by Apache Software Foundation as part of the 

# Apache Jakarta Project.

# Use the following url to get additional details on the API

#		http://jakarta.apache.org/log4j/docs/index.html

#

# For the general syntax of property based configuration files see the

# documenation of org.apache.log4j.PropertyConfigurator.



# /

# ~~ Levels supported by the Loggers

#

# FATAL

#	The FATAL level logs very severe errors messages that indicate 

#	application failure.

# ERROR

#	The ERROR level logs error messages that indicate errors 

#	in the application functionality that is processed.

# WARN

#	The WARN level logs warning messages that indicate harmful situations 

#	in the functionality that is processed.

# INFO

#	The INFO level logs informational messages that highlight the progress 

#	of the functionality processed.

# DEBUG

#	The DEBUG level logs extensive messages that are useful to debug.



# /

# ~~ Log4j Root loggers

# Specify the comma separated list of appenders to the root logger.

# for example, to log messages to standard output as well as to a 

# file called maximo.log, set

#   log4j.rootLogger=ERROR, A1, A2

log4j.rootLogger=ERROR, A1,A2



# /

# ~~ Output destinations or appenders

#

# A1 is set to be a ConsoleAppender which outputs to System.out. 

log4j.appender.A1=org.apache.log4j.ConsoleAppender

log4j.appender.A1.layout=org.apache.log4j.PatternLayout

log4j.appender.A1.layout.ConversionPattern=%d{dd MMM yyyy HH:mm:ss:SSS} [%-2p] %m%n



# A2 is set to be a RollingFileAppender which outputs to maximo.log file

log4j.appender.A2=org.apache.log4j.RollingFileAppender

log4j.appender.A2.File=/tmp/win/log/maximo75.log

log4j.appender.A2.MaxFileSize=8MB

log4j.appender.A2.MaxBackupIndex=20

log4j.appender.A2.layout=org.apache.log4j.PatternLayout

log4j.appender.A2.layout.ConversionPattern=%d{dd MMM yyyy HH:mm:ss:SSS} [%-2p] %m%n



# /

# ~~ loggers used by MAXIMO

#

# NOTE: Enable only the loggers that are needed, and use the

# logging information only for debugging purpose. Enabling

# more loggers and setting the log level to DEBUG produces

# lot of messages in the appenders and significantly reduces

# the performance of the application.

# /



# /

# ~~ Fixed MAXIMO Root loggers

#log4j.logger.maximo=INFO

#log4j.logger.maximo.application=ERROR

#log4j.logger.maximo.crontask=ERROR

#log4j.logger.maximo.datadictionary=ERROR

#log4j.logger.maximo.event=ERROR

#log4j.logger.maximo.mail=ERROR

#log4j.logger.maximo.service=ERROR

#log4j.logger.maximo.sql=DEBUG

#log4j.logger.maximo.sql=INFO



# /

# ~~ Dynamic MAXIMO loggers

# 

# MAXIMO loggers are named based on functional grouping.

# MAXIMO business objects are grouped under various services

# which are registered in the database in MAXSERVICE table.

# The SERVICENAME column in MAXSERVICE is used to identify the

# service. The OBJECTNAME column in MAXOBJECT table

# is used to identify the business object.

# /



# ~~ Business Object Service Loggers

# log4j.logger.maximo.service.<business object service>=<level>

# for example:

#   log4j.logger.maximo.service.WORKORDER=INFO



#log4j.logger.maximo.service.CONFIGURE=INFO



# ~~ Business Object Loggers

# log4j.logger.maximo.service.<service name>.<business object name>=<level>

# for example:

#   log4j.logger.maximo.service.WORKORDER.WOSTATUS=INFO



# ~~ Business Object SQL Loggers

# log4j.logger.maximo.sql.<service name>.<business object name>=<level>

# for example:

#   log4j.logger.maximo.sql.WORKORDER.WOSTATUS=INFO



# ~~ Application Loggers (for JSP UI)

# log4j.logger.maximo.application.<application name>=<level>

# for example:

#   log4j.logger.maximo.application.WOTRACK=INFO



# ~~ CRONTASK loggers

# log4j.logger.maximo.crontask.<cron task name>=<level>

# The cron task name is the name of the cron task

# for example:

#   log4j.logger.maximo.crontask.EmailNotification=INFO

#log4j.logger.maximo.crontask.KPICronTask=INFO

#log4j.logger.maximo.crontask.LDAPSYNC=INFO

#log4j.logger.maximo.crontask.EmailListnerCron=INFO

#log4j.logger.maximo.crontask.ReconciliationCronTask=INFO

log4j.logger.maximo.ldap=INFO
#用户登录日志，可以在用户登录失败的时候查看,位于类 psdi.security.SecurityService 中

log4j.logger.maximo.service.SECURITY=INFO

# ~~ CRONTASK SQL loggers

# log4j.logger.maximo.sql.crontask.<cron task name>=<level>

# for example:

#   log4j.logger.maximo.sql.crontask.EmailNotification=INFO

   

# ~~ MEA Integration Logger

#   log4j.logger.maximo.integration=INFO



# ~~ Workflow Logger

#   log4j.logger.maximo.workflow=INFO

#log4j.logger.org.shoukaiseki.webclient.beans.workorder=INFO

log4j.logger.org.shoukaiseki.app.pm=DEBUG

log4j.logger.maximo.crontask=ERROR

log4j.logger.org.shoukaiseki.crontask.rl.CronRldhtzC6C7=DEBUG

log4j.logger.org.shoukaiseki=DEBUG

#log4j.logger.org.shoukaiseki.workflow=INFO

#log4j.logger.org.shoukaiseki.app.invoice=INFO

#log4j.logger.org.shoukaiseki.webclient.beans.invoice=INFO
```
